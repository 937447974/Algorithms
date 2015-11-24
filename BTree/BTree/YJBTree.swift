//
//  YJBTree.swift
//  BTree
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/23.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Cocoa

/// B树
class YJBTree {

    /// 根结点
    private var root: YJBTreeNode
    /// 度数,除根结点的其他结点最少t-1，最多2t-2个子结点，默认t最小为3
    private let t: Int
    /// b树中包含的元素
    var count = 0

    // MARK: - 初始化B树
    /// 初始化B树
    ///
    /// - parameter t : 度数,除根结点的其他结点最少t-1，
    ///                 最多2t-2个子结点，默认t最小为3
    /// - returns: void
    init(t :Int) {
        self.t = t < 3 ? 3 : t
        root = YJBTreeNode(t: self.t)
    }
    
    // MARK: - 排序
    /// 排序输出
    ///
    /// - returns: [Int]
    func sort() -> [Int] {
        return self.sort(self.root)
    }
    
    private func sort(node: YJBTreeNode) -> [Int] {
        // 当前为叶子结点
        if node.leaf {
            return node.key
        }
        var list:[Int] = []
        let count = node.key.count
        for i in 0..<count {
            list += self.sort(node.child[i])
            list.append(node.key[i])
        }
        list += self.sort(node.child[count])
        return list
    }
    
    // MARK: - 根据key搜索所在的树以及位置
    func search(key: Int) ->(node: YJBTreeNode, keyLocation: Int)? {
        return self.search(self.root, key: key)
    }
    
    private func search(node: YJBTreeNode, key :Int) ->(node: YJBTreeNode, keyLocation: Int)? {
        var i:Int = 0
        while (i < node.key.count && key > node.key[i]) {
            i++
        }
        if (i < node.key.count && key == node.key[i]) {
            return (node, i)
        } else if node.leaf {
            return nil
        } else {
            // 读磁盘node.child[i]对象
            return self.search(node.child[i], key: key)
        }
    }
    
    // MARK: - 插入
    /// 插入key
    ///
    /// - parameter key : 要插入的key值
    ///
    /// - returns: void
    func insert(key: Int) {
        /**
         插入三情况
         1:根结点也为叶子结点，执行情况2。
         2:插入叶子结点，直接插入，叶子满时，分裂并向上抛数。
         3:插入内部节点，向下传递找到要插入的叶子结点执行情况2;
         遇到向上抛的数据后，重新排列节点。如果节点满，分裂节点继续向上抛
         */
        // 情况1:树高为1，直接添加叶子结点
        if root.h == 1 {
            root = self.insertLeaf(self.root, key: key)
        } else {
            if let root = self.insert(self.root, key: key) {
                // 情况3,重定向根结点
                self.root = root
            }
        }
        self.count++
    }
    
    // MARK: node中插入数据key
    private func insert(node: YJBTreeNode, key :Int) -> YJBTreeNode? {
        // 插入算法：每次插入都是插入叶子结点，分裂时，依次向上插入分裂
        // 当前为叶子结点
        if node.leaf {// 情况2:
            let leaf = self.insertLeaf(node, key: key)
            // 有向上分裂
            if leaf.h == 2 {
                return leaf
            }
            return nil
        } else {// 情况3:
            let index = self.insertIndex(node, key: key)
            // 向下继续插入
            if let child = self.insert(node.child[index], key: key) { // 遇到抛数
                // 插入key
                node.key.insert(child.key[0], atIndex: index)
                // 替换并插入child
                node.child[index] = child.child[1]
                node.child.insert(child.child[0], atIndex: index)
                // 如果节点满，分裂节点继续向上抛
                if node.key.count >= 2 * t - 1{
                    return self.splitChild(node)
                }
            }
            return nil
        }
    }

    // MARK: 叶子结点插入数据
    private func insertLeaf(node: YJBTreeNode, key :Int) -> YJBTreeNode {
        let index = self.insertIndex(node, key: key)
        node.key.insert(key, atIndex: index)
        // 判断是否需要分割
        if node.key.count == 2 * t - 1{
            return self.splitChild(node)
        }
        return node
    }
    
    // MARK: 插入辅助方法，寻找要插入的位置
    private func insertIndex(node: YJBTreeNode, key :Int) ->Int {
        // key的个数
        let count = node.key.count
        // 有数据
        if count != 0 {
            if key <= node.key[0] {// 最小
                return 0
            } else if node.key[count-1] <= key {// 最大
                return count
            }
            // 中间
            for i in 1 ..< node.key.count {
                if (node.key[i-1] <= key && key <= node.key[i]) {
                    return i;
                }
            }
        }
        return 0
    }
    
    // MARK: 插入时分割子结点
    private func splitChild(node: YJBTreeNode) -> YJBTreeNode {
        // 分割点
        let split = node.key.count / 2
        // 初始化
        let r = YJBTreeNode(t: t)
        r.leaf = false
        let rLeft = YJBTreeNode(t: t)
        let rRight = YJBTreeNode(t: t)
        // 树高
        r.h = node.h + 1
        rLeft.h = node.h
        rRight.h = node.h
        // 整理r.key
        r.key.append(node.key[split])
        // 整理r.child
        for i in 0..<split {
            rLeft.key.append(node.key[i]) // 左孩子key
        }
        r.child.append(rLeft)
        for i in split+1..<node.key.count {
            rRight.key.append(node.key[i]) // 右孩子key
        }
        r.child.append(rRight)
        // 整理child
        if node.child.count >=  self.t {
            // 有孩子代表是内部结点
            rLeft.leaf = false
            rRight.leaf = false
            // 整理孩子结点的孩子结点
            for i in 0...split {
                rLeft.child.append(node.child[i])
            }
            for i in split+1..<node.child.count {
                rRight.child.append(node.child[i])
            }
        }
        // 返回的r为一棵B树
        return r
    }
    
    
    
}
