//
//  KJNoteListTableViewController.swift
//  KJNoteBook
//
//  Created by TigerHu on 2024/8/20.
//

import UIKit

class KJNoteListTableViewController: UITableViewController {
    //数据源数组
   var dataArray = Array<KJNoteModel>()
   //当前分组
   var name:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = name
        installNavigationItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //从数据库中读取记事
        dataArray = KJDataManager.getNote(group: name!)
        self.tableView.reloadData()
    }
    
    func installNavigationItem() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteGroup))
        self.navigationItem.rightBarButtonItems = [addItem,deleteItem]
    }

    @objc func addNote() {
        let infoViewController = KJNoteInfoViewController()
        infoViewController.group = name!
        infoViewController.isNew = true
        self.navigationController?.pushViewController(infoViewController, animated: true)
    }
    @objc func deleteGroup() {
        let alertController = UIAlertController(title: "警告", message: "您确定要删除此分组下所有记事么？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "删除", style: .destructive, handler: {(UIAlertAction) -> Void in
                KJDataManager.deleteGroup(name: self.name!)
                self.navigationController!.popViewController(animated: true)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }

    //设置分区数为1
   override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
   }
   //设置行数为数据源中的数据个数
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dataArray.count
   }
   //进行数据载体cell的设置
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cellID = "noteListCellID"
       var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
       if cell == nil {
           cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
       }
       let model = dataArray[indexPath.row]
       cell?.textLabel?.text = model.title
       cell?.detailTextLabel?.text = model.time
       cell?.accessoryType = .disclosureIndicator
       return cell!
   }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //取消当前cell的选中状态
       tableView.deselectRow(at: indexPath, animated: true)
       let infoViewController = KJNoteInfoViewController()
       infoViewController.group = name!
       infoViewController.isNew = false
       infoViewController.noteModel = dataArray[indexPath.row]
       self.navigationController?.pushViewController(infoViewController, animated: true)
   }
    
}


