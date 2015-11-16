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

let quickSort = QuickSort()
quickSort.list.append(0)
for(var i = 10; i > 0; i--){
    quickSort.list.append(i)
}
print("原始数组:\(quickSort.list)")
quickSort.sort(3, end: 7)
print("部分排序3-7:\(quickSort.list)")
quickSort.sort()
print("全部排序:\(quickSort.list)")

let formatter = NSDateFormatter()
formatter.dateFormat = "hh:mm:ss"
quickSort.list.removeAll()
for(var i = 100; i > 0; i--){
    quickSort.list.append(i)
}
print("快速排序100,0000个数，开始:\(formatter.stringFromDate(NSDate()))")

quickSort.sort()
print("快速排序100,0000个数，结束:\(formatter.stringFromDate(NSDate()))")

