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

    // MARK: - 删除key
    func delete(key: Int) {
        if self.root.key.count == 0 { // 树为空时，直接返回
            return
        }
        // 根据返回的结点判断是否需要降key操作
        let newRoot = self.delete(self.root, key: key)
        self.root = newRoot.key.count != 0 || newRoot.leaf ? newRoot : newRoot.child.first!
    }
    
    private func delete(node: YJBTreeNode, key: Int) -> YJBTreeNode {
        /**删除思路：
        1. 找到key，合并其左右子节点成新的B树B
        2. 判断B能否替代该key。能够替代，替换key、left、right；不能替换，替换left，删除key和right
        3. 嵌套回调时，遇到key.count==t-2时，做合并当前child对应的key和相邻的child；否则不执行任何操作。
        */
        if node.leaf { // 叶子结点
            for (index, value) in node.key.enumerate() {
                if value == key { // 找到则删除
                    node.key.removeAtIndex(index)
                    break
                }
            }
        } else { // 内部结点
            // 嵌套向下
            var index = -1
            let count = node.key.count
            // 寻找key或child
            if key > node.key.last! { // 这里用到了快速跳跃，先判断是否跳过
                index = count
            } else {
                for i in 0..<count {
                    if node.key[i] == key { // 找到key
                        let bTree = self.mergeChild(node.child[i], right: node.child[i+1])
                        // 先删除后插入
                        self.replaceNode(node, index: i, bTree: bTree)
                        break
                    } else if key < node.key[i] { // 找到child
                        index = i
                        break
                    }
                }
            }
            // 嵌套返回
            if index != -1 {
                var bTree = self.delete(node.child[index], key: key)
                if bTree.key.count == self.t-2 { // 降key操作
                    let keyIndex = index == count ? index-1 : index
                    bTree = self.mergeKeyChild(node.child[keyIndex], key: node.key[keyIndex], right: node.child[keyIndex+1])
                    self.replaceNode(node, index: keyIndex, bTree: bTree)
                }
            }
        }
        return node
    }
    
    // MARK: B树替换结点中right、key、left
    private func replaceNode(var node: YJBTreeNode, index: Int, bTree:YJBTreeNode) {
        if node.h == bTree.h { // 树高相同，替换key、left、right
            node.key[index] = bTree.key[0]
            node.child[index] = bTree.child[0]
            node.child[index+1] = bTree.child[1]
        } else { // 树高不同，替换left，删除key和right
            node.key.removeAtIndex(index)
            node.child[index] = bTree
            node.child.removeAtIndex(index+1)
        }
        // 是否需要合并
        if node.key.count >= 2 * t - 1{
            node = self.splitChild(node)
        }
    }
    
    // MARK: 合并左孩子、key、右孩子
    private func mergeKeyChild(left: YJBTreeNode, key:Int, right: YJBTreeNode) -> YJBTreeNode {
        // key
        left.key.append(key)
        left.key += right.key
        // child
        left.child += right.child
        // 是否需要合并
        if left.key.count >= 2 * t - 1{
            return self.splitChild(left)
        }
        return left
    }
    
    // MARK: 合并左右子结点
    private func mergeChild(left: YJBTreeNode, right: YJBTreeNode) -> YJBTreeNode {
        if left.leaf { // 叶子结点
            left.key += right.key
        } else {
            // 合并首位节点
            let bTree = self.mergeChild(left.child.last!, right: right.child.first!)
            // 去掉左child尾，右child首
            left.child.removeLast()
            right.child.removeAtIndex(0)
            if bTree.h == left.h { // 树高不变时，连key、child
                left.key.append(bTree.key[0])
                left.child += bTree.child
            } else { // 树高变时，新生成的树是当前结点的child
                left.child.append(bTree)
            }
            // 连接right.child
            left.key += right.key
            left.child += right.child
        }
        // 是否需要合并
        if left.key.count >= 2 * t - 1{
            return self.splitChild(left)
        }
        return left
    }
    
    // MARK: - 分裂结点成为一棵B树
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
