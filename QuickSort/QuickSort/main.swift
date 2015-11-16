//
//  main.swift
//  QuickSort
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/16.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Foundation

// 快速排序测试
let quickSort = QuickSort()
quickSort.list.append(0)
for(var i = 10; i > 0; i--){
    quickSort.list.append(i)
}
quickSort.quickSort()
print("快速排序:\(quickSort.list)")


// 速度测试，使用最坏情况测试，也就是原数组为倒序
let count = 10000 // 要排序的元素个数
var source = Array<Int>()
for(var i = count; i > 0; i--){
    source.append(i)
}
print("快排速度测试,总数：\(count)")

// 快速排序
var date = NSDate()
quickSort.list = source
quickSort.quickSort()
print("快速排序耗时:\(-date.timeIntervalSinceNow)")

// 随机快速排序
date = NSDate()
quickSort.list = source
quickSort.radomQuickSort()
print("随机快速排序耗时:\(-date.timeIntervalSinceDate(NSDate()))")

// 多线程快速排序
date = NSDate()
quickSort.list = source
quickSort.threadQuickSort()
print("多线程快速排序耗时:\(-date.timeIntervalSinceNow)")
