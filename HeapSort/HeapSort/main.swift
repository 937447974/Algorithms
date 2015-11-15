//
//  main.swift
//  HeapSort
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/15.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Foundation

var list:[Int] = []
for(var i = 0; i < 5; i++) {
    list.append(i)
}
for(var i = -2; i < 6; i++) {
    list.append(i)
}
let heap = HeapSort(list: list)
print("最大堆排序:\(heap.maxSort())")
print("最小堆排序:\(heap.miniSort())")

