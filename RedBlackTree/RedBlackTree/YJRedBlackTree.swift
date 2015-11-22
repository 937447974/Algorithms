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
    
    // MARK: - 中序遍历
    /// 中序遍历
    ///
    /// - returns: void
    func inorderWalk() {
        self.inorderWalk(self.root, height: 0)
    }
    
    private func inorderWalk(node: YJRedBlackNode?, height: Int) {
        if node != nil {
            // 中序遍历
            print("\(node!.key); color:\(node!.color!) ; height:\(height)") // 测试
            self.inorderWalk(node!.left, height: height+1)
//            print(node!.key)
            self.inorderWalk(node!.right, height: height+1)
        }
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
        while x != nil {
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
        // 设z为红色会违反红黑性质，
        z.color = YJNodeColor.Red
        // 故使用insertFixup(z: YJRedBlackNode)维护红黑
        self.insertFixup(z)
        
    }
    
    // MARK: 插入后保持红黑性质
    private func insertFixup(var z: YJRedBlackNode) {
        /* 3种情况:
        1. 插入后的结点z。由于z和它的父结点z.parent都是红色的。
           由于z的叔结点y是红色的，可以应用情况1。结点被重新着色，并且指针z沿树上升。
        2. 再一次z和z的父结点都是红色，但z的叔结点y是黑色的。因为z是z.parent的右结点，应用情况2。
        3. 在执行一次左旋后，现在z是其父结点的左孩子，可以应用情况3。重新着色并执行一次右旋后得一棵合法的红黑树
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
        self.root?.color = YJNodeColor.Black
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
