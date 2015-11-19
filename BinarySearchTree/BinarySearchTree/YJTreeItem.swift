//
//  YJTreeItem.swift
//  BinarySearchTree
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/19.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Cocoa

/// 树结点
class YJTreeItem: NSObject {

    /// 关键字
    var key: Int!
    /// 父结点
    var parentItem: YJTreeItem?
    /// 左子结点
    var leftItem: YJTreeItem?
    /// 右子结点
    var rightItem: YJTreeItem?
    
}
