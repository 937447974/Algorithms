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
            // 中序遍历
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
            if item?.key > key { // 当前结点大于key时搜索左孩子
                item = item?.leftItem
            } else { // 否则进入右孩子
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
    
    // MARK: 获取最大结点
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
    
    // MARK: - 查找x的前驱
    /// 查找x的前驱
    ///
    /// - parameter x : 要查找的结点
    ///
    /// - returns: YJTreeItem
    func predecessor(var x:YJTreeItem?) -> YJTreeItem? {
        // 1.有左子树，则后继为x左子树中的最右结点
        if x?.leftItem != nil {
            return self.maximum(x!.leftItem)
        }
        // 2.无左子结点，则后继为其有右结点的根结点
        var y = x?.parentItem
        while y != nil && x == y?.leftItem {
            x = y
            y = y?.parentItem
        }
        return y
    }
    
    // MARK: 查找x的后继
    /// 查找x的后继
    ///
    /// - parameter x : 要查找的结点
    ///
    /// - returns: YJTreeItem
    func successor(var x:YJTreeItem?) -> YJTreeItem? {
        // 1.有右子树，则后继为x右子树中的最左结点
        if x?.rightItem != nil {
            return self.minimum(x!.rightItem)
        }
        // 2.无右子结点，则后继为其有左结点的根结点
        var y = x?.parentItem
        while y != nil && x == y?.rightItem {
            x = y
            y = y?.parentItem
        }
        return y
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
            //1 如果z没有左孩子，则用其右孩子代替z
            self.transplant(z!, v: z!.rightItem)
        } else if z?.rightItem == nil {
            //2 如果z没有右孩子，则用其左孩子代替z
            self.transplant(z!, v: z!.leftItem)
        } else {
            //3 z即有左孩子又有右孩子，则用z的后继y替换它
            let y = self.minimum(z?.rightItem)
            //4 如果y是z的右孩子,用y替换z，并仅留下y的右孩子
            if y!.parentItem != z {
                //5 否则，y位于z的右子树中但不是z的右孩子，在这种情况先用y的右孩子替换y。再用y替换z。
                self.transplant(y!, v: y?.rightItem)
                y?.rightItem = z?.rightItem
                y?.rightItem?.parentItem = y
            }
            // y替换z
            self.transplant(z!, v: y)
            y?.leftItem = z?.leftItem
            y?.leftItem?.parentItem = y
        }
    }
    
    // MARK: v替换u的位置
    private func transplant(u: YJTreeItem, v: YJTreeItem?) {
        // 设置u的父结点的子结点为v
        if u.parentItem == nil {
            self.rootItem = v
        } else if u == u.parentItem?.leftItem {
            u.parentItem!.leftItem = v
        } else {
            u.parentItem!.rightItem = v
        }
        // 设置v的父结点为u的父结点
        if v != nil {
            v!.parentItem = u.parentItem
        }
    }
    
}