//
//  YJBTreeNode.swift
//  BTree
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/23.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Cocoa

/// B树结点
class YJBTreeNode: NSObject {

    /// 度数,除根结点的其他结点最少t-1，最多2t-2个子结点
    var t :Int
    /// 树高
    var h :Int = 1
    /// 是否叶结点，true是，false不是
    var leaf :Bool = true
    /// 关键字
    var key :[Int] = []
    /// 子结点,子节点个数最少t，最多2t-1个子结点
    var child :[YJBTreeNode] = []
    
    
    // MARK: - 初始化
    /// 初始化
    ///
    /// - parameter t : 度数,除根结点的其他结点最少t-1，最多2t-2个子结点
    ///
    /// - returns: void
    init(t :Int) {
        self.t = t
    }
    
}
