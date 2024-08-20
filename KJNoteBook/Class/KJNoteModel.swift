//
//  KJNoteModel.swift
//  KJNoteBook
//
//  Created by TigerHu on 2024/8/20.
//

import UIKit

class KJNoteModel: NSObject {
    //记事时间
    var time:String?
    //记事标题
    var title:String?
    //记事内容
    var body:String?
    //所在分组
    var group:String?
    //主键
    var noteId:Int?
    
    //这个方法用于将数据模型属性直接转换为字典
    func toDictionary() -> Dictionary<String,Any> {
        var dic:[String:Any] = ["time":time!,"title":title!,"body":body!, "ownGroup":group!]
        if let id = noteId {
            dic["noteId"] = id
        }
        return dic
    }
}

