//
//  YJBinarySearchTree.swift
//  BinarySearchTree
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/18.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Cocoa

/// 二叉搜索树
class YJBinarySearchTree {

    /// 根结点
    private var rootItem:YJTreeItem?
    
    // MARK: - 中序遍历
    /// 中序遍历
    ///
    /// - returns: void
    func inorderTreeWalk() {
        self.inorderTreeWalk(self.rootItem)
    }
    
    func inorderTreeWalk(item:YJTreeItem?) {
        if item != nil {
            self.inorderTreeWalk(item!.left)
            print(item!.key)
            self.inorderTreeWalk(item!.right)
        }
    }
    
    // MARK: - 查找
    /// 查找
    ///
    /// - parameter key : 要查找的key
    ///
    /// - returns: YJTreeItem
    func treeSearch(key:Int) -> YJTreeItem? {
        var item = self.rootItem
        while item != nil || key != item?.key {
            if item?.key > key { // 当前结点大于key时搜索左子结点
                item = item?.left
            } else { // 否则进入右子结点
                item = item?.right
            }
        }
        return item
    }
   
}