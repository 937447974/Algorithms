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

let tree = YJRedBlackTree()
// 测试数据
var list = Array<YJRedBlackNode>()
let count = 1000000
for var i in 1 ..< count {
    let node = YJRedBlackNode(key: Int(arc4random())%count)
    list.append(node)
}

// 插入测试
var date = NSDate()
for node in list {
    tree.insert(node)
}
print("插入耗时:\(-date.timeIntervalSinceNow)")
//tree.inorderWalk()

// 删除测试
date = NSDate()
for node in list {
    if let search = tree.search(node.key) {
        tree.delete(search)
    }
//    print("=========\(node.key)")
//    tree.inorderWalk()
}
print("删除耗时:\(-date.timeIntervalSinceNow)")
tree.inorderWalk()
