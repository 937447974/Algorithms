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
    private var rootItem: YJTreeItem?
    
    // MARK: - 中序遍历
    /// 中序遍历
    ///
    /// - returns: void
    func inorderWalk() {
        self.inorderWalk(self.rootItem)
    }
    
    private func inorderWalk(item: YJTreeItem?) {
        if item != nil {
            self.inorderWalk(item!.leftItem)
            print(item!.key)
            self.inorderWalk(item!.rightItem)
        }
    }
    
    // MARK: - 查找结点
    /// 查找结点
    ///
    /// - parameter key : 要查找的key
    ///
    /// - returns: YJTreeItem
    func search(key: Int) -> YJTreeItem? {
        var item = self.rootItem
        while item != nil && key != item?.key {
            if item?.key > key { // 当前结点大于key时搜索左子结点
                item = item?.leftItem
            } else { // 否则进入右子结点
                item = item?.rightItem
            }
        }
        return item
    }
    
    // MARK: - 获取最小结点
    /// 获取最小结点
    ///
    /// - returns: YJTreeItem
    func minimum() -> YJTreeItem? {
        return self.minimum(self.rootItem)
    }
    
    // MARK: 根据结点获取其最小结点
    private func minimum(var item:YJTreeItem?) -> YJTreeItem? {
        while item?.leftItem != nil {
            item = item?.leftItem
        }
        return item
    }
    
    // MARK: - 获取最大结点
    /// 获取最大结点
    ///
    /// - returns: YJTreeItem
    func maximum() -> YJTreeItem? {
        return self.maximum(self.rootItem)
    }
    
    // MARK: 根据结点获取其最大结点
    private func maximum(var item:YJTreeItem?) -> YJTreeItem? {
        while item?.rightItem != nil {
            item = item?.rightItem
        }
        return item
    }
    
    // MARK: - 插入key
    /// 插入key
    ///
    /// - parameter key : 要插入的关键字
    ///
    /// - returns: void
    func insert(key: Int) {
        /// 临时根结点
        var x = self.rootItem
        /// 插入key的父结点
        var y: YJTreeItem?
        /// 要插入key的z结点
        let z = YJTreeItem()
        z.key = key
        
        // 找到y结点
        while x != nil {
            y = x
            if key < x?.key {
                x = x?.leftItem
            } else {
                x = x?.rightItem
            }
        }
        
        // 设置父结点
        z.parentItem = y
        // 设置子结点
        if y == nil {
            self.rootItem = z
        } else if key < y?.key {
            y?.leftItem = z
        } else {
            y?.rightItem = z
        }
    }
    
    // MARK: - 删除结点
    /// 删除结点
    ///
    /// - parameter key : 要删除的结点
    ///
    /// - returns: void
    func delete(key: Int) {
        let z = self.search(key)
        if z == nil {
            return
        }
        if z!.leftItem == nil {
            self.transplant(z!, v: z!.rightItem)
        } else if z?.rightItem == nil {
            self.transplant(z!, v: z!.leftItem)
        } else {
            let y = self.minimum(z?.rightItem)
            if y!.parentItem != z {
                self.transplant(y!, v: y?.rightItem)
                y?.rightItem = z?.rightItem
                y?.rightItem?.parentItem = y
            }
            self.transplant(z!, v: y)
            y?.leftItem = z?.leftItem
            y?.leftItem?.parentItem = y
        }
    }
    
    // MARK: v替换u的位置
    private func transplant(u: YJTreeItem, v: YJTreeItem?) {
        if u.parentItem == nil {
            self.rootItem = v
        } else if u == u.parentItem?.leftItem {
            u.parentItem!.leftItem = v
        } else {
            u.parentItem!.rightItem = v
        }
        if v != nil {
            v!.parentItem = u.parentItem
        }
    }
    
    
    
   
}