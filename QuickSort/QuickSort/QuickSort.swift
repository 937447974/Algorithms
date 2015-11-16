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
    
    // MARK: 全部排序
    func sort() {
        self.quickSort(0, end: self.list.count-1)
    }
    
    // MARK: 部分排序，包含first、end
    func sort(var first:Int, var end:Int) {
        // 安全机制
        first = first < 0 ? 0:first
        end = end >= self.list.count ? self.list.count-1:end
        self.quickSort(first, end: end)
    }
    
    // MARK: 分解
    private func quickSort(first:Int, end:Int) {
        if first < end {
            // 获取中位点
            let location = self.partition(first, end: end)
            self.quickSort(first, end: location)
            self.quickSort(location+1, end: end)
        }
    }
    
    // MARK: 排序核心算法
    private func partition(var first:Int, end:Int) ->Int {
        let x: Int = self.list[end]
        for(var i = first; i < end; i++) {
            if self.list[i] <= x {
                first++
                self.exchange(i, first)
            }
        }
        self.exchange(first, end)
        return first
    }
    
    // MARK: 交换数据
    private func exchange(p:Int, _ r:Int){
        let temp = self.list[p]
        self.list[p] = self.list[r]
        self.list[r] = temp
    }
    
}
