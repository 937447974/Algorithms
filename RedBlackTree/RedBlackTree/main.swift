//
//  main.swift
//  RedBlackTree
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/20.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Foundation

print("Hello, World!")

let tree = YJRedBlackTree()
// 插入
for var i in 1 ..< 10 {
    let node = YJRedBlackNode(key: 10-i)
    tree.insert(node)
}

tree.inorderWalk()

