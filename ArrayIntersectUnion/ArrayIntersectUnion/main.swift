//
//  main.swift
//  ArrayIntersectUnion
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/25.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Foundation

print("Hello, World!")

let list1 = ["阳", "君", "阳", "君"]
let list2 = ["君", "937447974"]

let array = ArrayIntersectUnion()

print(array.intersect(list1, list2))
print(array.union(list1, list2))
