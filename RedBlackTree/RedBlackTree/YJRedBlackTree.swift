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

    var root: YJRedBlackNode?
    
    // MARK: - 左旋
    private func leftRotate(x:YJRedBlackNode) {
        let y = x.rigth
        x.rigth = y?.left
        if y?.left != self.root {
            y?.left?.parent = x
        }
        y?.parent = x.parent
        if x.parent == self.root {
            self.root = y
        } else if x == x.parent?.left {
            x.parent?.left = y
        } else {
            x.parent?.rigth = y
        }
        x.left = x
        x.parent = y
    }
}
