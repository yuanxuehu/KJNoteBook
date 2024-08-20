//
//  KJHomeView.swift
//  KJNoteBook
//
//  Created by TigerHu on 2024/8/20.
//

import UIKit

protocol KJHomeButtonDelegate {
    func homeButtonClick(title:String)
}

class KJHomeView: UIScrollView {
   var homeButtonDelegate:KJHomeButtonDelegate?
    //定义列间距
   let interitemSpacing = 15
   //定义行间距
   let lineSpacing = 25
   //用于存放所有分组标题的数据
   var dataArray:Array<String>?
   //用于存放所有分组按钮的数组
   var itemArray:Array<UIButton> = Array<UIButton>()
    
   //提供一个更新布局的方法
   func updateLayout() {
       //根据视图尺寸计算每个按钮的宽度
       let itemWidth = (self.frame.size.width-CGFloat(4*interitemSpacing))/3
       //计算每个按钮的高度
       let itemHeight = itemWidth/3*4
       //先将界面上已有的按钮移除
       itemArray.forEach({ (element) in
           element.removeFromSuperview()
       })
        //移除数组所有元素
       itemArray.removeAll()
       //进行布局
       if dataArray != nil && dataArray!.count>0{
           //遍历数据
           for index in 0..<dataArray!.count {
               let btn = UIButton(type: .system)
               btn.setTitle(dataArray![index], for: .normal)
               //计算按钮位置
               btn.frame = CGRect(x: CGFloat(interitemSpacing)+CGFloat (index%3)*(itemWidth+CGFloat(interitemSpacing)), y: CGFloat(lineSpacing) + CGFloat(index/3) * (itemHeight+CGFloat(lineSpacing)), width: itemWidth, height: itemHeight)
               btn.backgroundColor = UIColor(red: 1, green: 242/255.0, blue: 216/255.0, alpha: 1)
               //设置按钮圆角
               btn.layer.masksToBounds = true
               btn.layer.cornerRadius = 15
               btn.setTitleColor(UIColor.gray, for: .normal)
               btn.tag = index
               btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
               self.addSubview(btn)
               //将按钮实例添加到数组中
               itemArray.append(btn)
           }
           //设置滚动视图内容尺寸
           self.contentSize = CGSize(width: 0, height: itemArray.last!.frame.origin.y+itemArray.last!.frame.size.height+CGFloat(lineSpacing))
       }
       
   }
   //按钮的触发方法
   @objc func btnClick(btn:UIButton) {
       if homeButtonDelegate != nil {
           homeButtonDelegate?.homeButtonClick(title: dataArray![btn.tag])
       }
   }

}
