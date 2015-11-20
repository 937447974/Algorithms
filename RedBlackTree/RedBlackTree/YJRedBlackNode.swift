//
//  YJRedBlackNode.swift
//  RedBlackTree
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/20.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Cocoa

/// 结点颜色
enum YJNodeColor {
    case Red
    case Black
}

/// 红黑树的结点
class YJRedBlackNode: NSObject {

    /// 值
    var key: Int!
    /// 颜色
    var color: YJNodeColor = YJNodeColor.Black
    /// 父结点
    var parent: YJRedBlackNode?
    /// 左结点
    var left: YJRedBlackNode?
    /// 右结点
    var rigth: YJRedBlackNode?
    
}
