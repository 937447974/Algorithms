//
//  main.swift
//  BinarySearchTree
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/18.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Foundation

let tree = YJBinarySearchTree()

// 插入
for n in 0...20 {
    tree.insert(Int(arc4random())%20)
}

print(tree.maximum()?.key)
print(tree.minimum()?.key)
tree.inorderWalk()

print("============")

// 删除
for n in 0...10 {
    tree.insert(Int(arc4random())%20)
}
tree.inorderWalk()