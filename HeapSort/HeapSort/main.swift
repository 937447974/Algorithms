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
for(var i = 0; i < 10; i+=2) {
    list.append(i)
}
for(var i = 9; i > 0; i-=2) {
    list.append(i)
}
let heap = HeapSort(list: list)

print("堆排序:\(heap.heapSort())")

print("堆最大值:\(heap.maxiMum())")

print("提取堆最大值并删除:\(heap.extractMax())")
print("堆排序:\(heap.heapSort())")

heap.insert(2)// 插入一个元素
print("堆排序:\(heap.heapSort())")

