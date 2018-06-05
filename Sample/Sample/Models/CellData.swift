//
//  CellData.swift
//  Sample
//
//  Created by 李二狗 on 2018/6/5.
//  Copyright © 2018年 Meniny Lab. All rights reserved.
//

import Foundation
import Boom

struct CellDataLeft: Equatable, Hashable, BoomModel {
    var identifier: Int {
        return id.hashValue
    }
    
    let id: String = NSUUID().uuidString
    
    var avatar: UIImage
    var title: String
    var detail: String?
    
    init(avatar: UIImage, title: String, detail: String?) {
        self.avatar = avatar
        self.title = title
        self.detail = detail
    }
}

struct CellDataRight: Equatable, Hashable, BoomModel {
    var identifier: Int {
        return id.hashValue
    }
    
    let id: String = NSUUID().uuidString
    
    var avatar: UIImage
    var title: String
    var detail: String?
    
    init(avatar: UIImage, title: String, detail: String?) {
        self.avatar = avatar
        self.title = title
        self.detail = detail
    }
}
