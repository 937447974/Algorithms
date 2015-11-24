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

// 测试数据
var list = Array<Int>()
let count = 100000
for var i in 1 ..< count {
     list.append(Int(arc4random())%count)
//    list.append(i)
}


let tree: YJBTree = YJBTree(t: 10)
print("插入 begin")
var time = NSDate()
for value in list {
    tree.insert(value)
    //print("插入\(value)\n\t\t\(tree.sort())")
}
print("插入耗时:\(-time.timeIntervalSinceNow)")


print("\n删除 begin")
time = NSDate()
for value in list {
    tree.delete(value)
    //print("删除\(value)\n\t\t\(tree.sort())")
}
print("删除耗时:\(-time.timeIntervalSinceNow)")
