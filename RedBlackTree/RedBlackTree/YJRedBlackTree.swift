//
//  YJRedBlackTree.swift
//  RedBlackTree
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/20.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Cocoa

/// 红黑树
class YJRedBlackTree {

    /// 根结点
    var root: YJRedBlackNode?
    /// 哨兵
    private var sentinel = YJRedBlackNode(key: 8888)
    
    init() {
        self.root = self.sentinel
    }
    
    // MARK: - 中序遍历
    /// 中序遍历
    ///
    /// - returns: void
    func inorderWalk() {
        if self.root != nil {
            self.inorderWalk(self.root!, height: 0)
        }
    }
    
    private func inorderWalk(node: YJRedBlackNode, height: Int) {
        if node != self.sentinel {
            // 中序遍历
//            print("\(node.key); color:\(node.color) ; height:\(height)") // 测试
            self.inorderWalk(node.left, height: height+1)
            print(node.key)
            self.inorderWalk(node.right, height: height+1)
        }
    }
    
    // MARK: - 查找结点
    /// 查找结点
    ///
    /// - parameter key : 要查找的key
    ///
    /// - returns: YJRedBlackNode
    func search(key: Int) -> YJRedBlackNode? {
        var node = self.root
        while node != nil && node != self.sentinel && key != node!.key {
            if node!.key > key { // 当前结点大于key时搜索左孩子
                node = node!.left
            } else { // 否则进入右孩子
                node = node?.right
            }
        }
        node = node == self.sentinel ? nil : node
        return node
    }
    
    // MARK: - 左旋
    private func leftRotate(x:YJRedBlackNode) {
        if let y = x.right { // x的右结点存在时执行左旋操作
            // 连接x和y.left
            x.right = y.left
            y.left?.parent = x
            // 连接x.parent和y
            y.parent = x.parent
            if x.parent == nil {
                self.root = y
            } else if x == x.parent?.left {
                x.parent!.left = y
            } else {
                x.parent?.right = y
            }
            // 连接x和y
            y.left = x
            x.parent = y
        }
    }
    
    // MARK: 右旋
    private func rightRotate(y:YJRedBlackNode) {
        if let x = y.left { // y的左结点x存在时执行右旋操作
            // 连接y和x.right
            y.left = x.right
            x.right?.parent = y
            // 连接y.parent和x
            x.parent = y.parent
            if y.parent == nil {
                self.root = x
            } else if y == y.parent!.left {
                y.parent!.left = x
            } else {
                y.parent!.right = x
            }
            // 连接y和x
            x.right = y
            y.parent = x
        }
    }
    
    // MARK: - 插入z
    /// 插入z
    ///
    /// - parameter z : 插入的YJRedBlackNode
    ///
    /// - returns: void
    func insert(z: YJRedBlackNode) {
        var y: YJRedBlackNode?
        // 设置z.parent
        var x = self.root
        while x != nil && x != self.sentinel {
            y = x
            if z.key < x!.key {
                x = x!.left
            } else {
                x = x!.right
            }
        }
        z.parent = y
        // 设置z为root、y.left或y.right
        if y == nil {
            self.root = z
        } else if z.key < y!.key {
            y!.left = z
        } else {
            y!.right = z
        }
        // 设置z的相关属性
        z.color = YJNodeColor.Red
        z.left = self.sentinel
        z.right = self.sentinel
        // 使用insertFixup(z: YJRedBlackNode)维护红黑
        self.insertFixup(z)
        
    }
    
    // MARK: 插入后保持红黑性质
    private func insertFixup(var z: YJRedBlackNode) {
        /* 3种情况:
        1. z的叔结点y是红色的。
        2. z的叔结点y是黑色的且z是一个右孩子。
        3. z的叔结点y是黑色的且z是一个左孩子
        */
        while z.parent?.color == YJNodeColor.Red {
            if z.parent == z.parent!.parent?.left { // z.parent在z的祖父结点的左边
                let y = z.parent!.parent!.right
                if y?.color == YJNodeColor.Red { // case 1
                    z.parent?.color = YJNodeColor.Black
                    y?.color = YJNodeColor.Black
                    z.parent!.parent!.color = YJNodeColor.Red
                    z = z.parent!.parent!
                } else if z == z.parent!.right { // case 2
                    z = z.parent!
                    self.leftRotate(z)
                }
                // case 3
                z.parent?.color = YJNodeColor.Black
                if z.parent?.parent != nil { // 祖父结点存在
                    z.parent!.parent!.color = YJNodeColor.Red
                    self.rightRotate(z.parent!.parent!)
                }
            } else if z.parent == z.parent!.parent?.right { // z.parent在z的祖父结点的右边
                let y = z.parent!.parent!.left
                if y?.color == YJNodeColor.Red { // case 1
                    z.parent!.color = YJNodeColor.Black
                    y!.color = YJNodeColor.Black
                    z.parent!.parent?.color = YJNodeColor.Red
                    z = z.parent!.parent!
                } else if z == z.parent!.left { // case 2
                    z = z.parent!
                    self.rightRotate(z)
                }
                // case 3
                z.parent?.color = YJNodeColor.Black
                if z.parent?.parent != nil { // 祖父结点存在
                    z.parent!.parent!.color = YJNodeColor.Red
                    self.leftRotate(z.parent!.parent!)
                }
            }
        }
        // 设根为黑色
        self.root!.color = YJNodeColor.Black
    }
    
    // MARK: - 删除结点
    /// 删除结点
    ///
    /// - parameter z : 要删除的YJRedBlackNode
    ///
    /// - returns: void
    func delete(z: YJRedBlackNode) {
        // 原理：尽量让将z调整到红色叶节点上，删除
        var x: YJRedBlackNode? // 需要调整的点
        var yColor = z.color   // 删除的点的颜色
        if z.left == self.sentinel { // 1 如果z没有左孩子，则用其右孩子代替z
            x = z.right
            self.transplant(z, v: z.right)
        } else if z.right == self.sentinel { // 2 如果z没有右孩子，则用其左孩子代替z
            x = z.left
            self.transplant(z, v: z.left)
        } else { // 3 z即有左孩子又有右孩子，则用z的后继y替换它
            let y = self.minimum(z.right!) // 后驱
            yColor = y.color
            x = y.right
            //4 如果y是z的右孩子,用y替换z，并仅留下y的右孩子
            if y.parent != z{
                //5 否则，y位于z的右子树中但不是z的右孩子，在这种情况先用y的右孩子替换y。再用y替换z。
                self.transplant(y, v: y.right)
                y.right = z.right
                y.right?.parent = y
            }
            // y替换z,即删除z
            self.transplant(z, v: y)
            y.left = z.left
            y.left?.parent = y
            y.color = z.color
        }
        // 删除为黑结点时，破坏了红黑性质，需要使用deleteFixup维护红黑性质
        if yColor == YJNodeColor.Black {
            self.deleteFixup(x!)
        }
    }
    
    // MARK: v替换u
    private func transplant(u: YJRedBlackNode, v: YJRedBlackNode?) {
        // u.parent连接v
        if u.parent == nil {
            self.root = v
        } else if u == u.parent!.left {
            u.parent!.left = v
        } else {
            u.parent!.right = v
        }
        // v连接u.parent
        v?.parent = u.parent
    }
    
    // MARK: 根据结点获取其最小结点
    private func minimum(var node:YJRedBlackNode) -> YJRedBlackNode {
        while node != self.sentinel && node.left != self.sentinel {
            node = node.left!
        }
        return node
    }
    
    
    // MARK: 删除后保持红黑性质
    private func deleteFixup(var x: YJRedBlackNode) {
        /* 4种情况，w = x的兄弟结点
        1. w是红色的
        2. w是黑色的，而且w的两个子结点都是黑色的
        3. w是黑色的，w的左孩子是红色的，w的右孩子是黑色的
        4. w是黑色的，切w的右孩子是红色的
        */
        while x != self.root && x.color == YJNodeColor.Black {
            if x == x.parent!.left { // x是左孩子
                var w = x.parent!.right!
                if w.color == YJNodeColor.Red { // case 1
                    w.color = YJNodeColor.Black
                    x.parent!.color = YJNodeColor.Red
                    self.leftRotate(x.parent!)
                    w = x.parent!.right!
                }
                if w.left?.color == YJNodeColor.Black && w.right?.color == YJNodeColor.Black { // case 2
                    w.color = YJNodeColor.Red
                    x = x.parent!
                } else {
                    if w.right?.color == YJNodeColor.Black { // case 3
                        w.left?.color = YJNodeColor.Black
                        w.color = YJNodeColor.Red
                        self.rightRotate(w)
                        w = x.parent!.right!
                    }
                    // case 4
                    w.color = x.parent!.color
                    x.parent?.color = YJNodeColor.Black
                    w.right?.color = YJNodeColor.Black
                    self.leftRotate(x.parent!)
                    x = self.root!
                }
            } else { // x是右孩子
                var w = x.parent!.left!
                if w.color == YJNodeColor.Red { // case 1
                    w.color = YJNodeColor.Black
                    x.parent!.color = YJNodeColor.Red
                    self.rightRotate(x.parent!)
                    w = x.parent!.left!
                }
                if w.left?.color == YJNodeColor.Black && w.right?.color == YJNodeColor.Black { // case 2
                    w.color = YJNodeColor.Red
                    x = x.parent!
                } else {
                    if w.left?.color == YJNodeColor.Black { // case 3
                        w.right?.color = YJNodeColor.Black
                        w.color = YJNodeColor.Red
                        self.leftRotate(w)
                        w = x.parent!.left!
                    }
                    // case 4
                    w.color = x.parent!.color
                    x.parent?.color = YJNodeColor.Black
                    w.left?.color = YJNodeColor.Black
                    self.rightRotate(x.parent!)
                    x = self.root!
                }
            }
        }
        // 最后x设为黑色
        x.color = YJNodeColor.Black
    }
    
}
