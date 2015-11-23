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

print("插入======")
for i in 0...20 {
    tree.insert(i)
    print("总数：\(tree.count), \(tree.sort())")
}