//
//  main.swift
//  BTree
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/23.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Foundation

let tree: YJBTree = YJBTree(t: 3)

var list = Array<Int>()
let count = 20
for var i in 1 ..< count {
    list.append(Int(arc4random())%count)
}

print("插入测试======")
for value in list {
    tree.insert(value)
    print("插入\(value) => \(tree.sort())")
}

//tree.delete(8)
//print(tree.sort())
//
//print("\n删除测试======")
//for i in 0...20 {
//    tree.delete(i)
//    print("删除\(i) => \(tree.sort())")
//}
