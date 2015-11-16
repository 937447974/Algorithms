//
//  QuickSort.swift
//  QuickSort
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/16.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Foundation

/// 快速排序
class QuickSort: NSObject {

    /// 数组
    var list = Array<Int>()
    
    // MARK: - 快速排序
    func quickSort() {
        self.quickSort(0, end: self.list.count-1)
    }
    
    // MARK: 分解
    private func quickSort(first:Int, end:Int) {
        if first < end {
            // 获取中位点
            let location = self.partition(first, end: end)
            self.quickSort(first, end: location-1)
            self.quickSort(location+1, end: end)
        }
    }
    
    // MARK: 排序核心算法
    private func partition(first:Int, end:Int) ->Int {
        var index = first - 1
        for(var i = first; i < end; i++) {
            if self.list[i] < self.list[end] {
                index++
                self.exchange(i, index)
            }
        }
        index++
        self.exchange(index, end)
        return index
    }
    
    // MARK: 交换数据
    private func exchange(p:Int, _ r:Int){
        if p == r {
            return
        }
        let temp = self.list[p]
        self.list[p] = self.list[r]
        self.list[r] = temp
    }
    
    // MARK: - 随机快速排序
    func radomQuickSort() {
        self.radomQuickSort(0, end: self.list.count-1)
    }
    
    // MARK: 开始随机排序
    private func radomQuickSort(first:Int, end:Int) {
        if first < end {
            // 获取中位点
            let location = self.radomPartition(first, end: end)
            self.radomQuickSort(first, end: location-1)
            self.radomQuickSort(location+1, end: end)
        }
    }
    
    // MARK: 获取划分的位置
    private func radomPartition(first:Int, end:Int) ->Int {
        // 随机一个数放到尾部，主要防止遇到最坏排序情况，即数组为倒序
        // 获取first-end的随机数
        let random = arc4random_uniform(UInt32(end-first+1))
        let index = Int(random) + first
        self.exchange(index, end);
        return self.partition(first, end: end)
    }
    
    // MARK: - 多线程快速排序
    func threadQuickSort() {
         self.threadQuickSort(0, end: self.list.count-1)
    }
    
    // MARK: 开始多线程快速排序
    private func threadQuickSort(first:Int, end:Int) {
        // 在随机排序的基础上启用多线程排序
        if first < end {
            // 获取中位点
            let location = self.radomPartition(first, end: end)
            // 分到多个线程排序，并发
            let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            dispatch_async(queue, { () -> Void in
                self.threadQuickSort(first, end: location-1)
            })
            dispatch_async(queue, { () -> Void in
                self.threadQuickSort(location+1, end: end)
            })
        }
    }
    
}
