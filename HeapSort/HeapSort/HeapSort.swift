//
//  HeapSort.swift
//  HeapSort
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/15.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Foundation

/// 堆排序
class HeapSort: NSObject {
    
    /// 数组
    private var list:Array<Int> = []
    /// 堆长度
    private var heapSize = 0
    
    //MARK: 初始化
    init(list:[Int]) {
        self.list = list
    }
    
    // MARK: - 堆排序
    /// 堆排序
    ///
    /// - returns: [Int]
    func heapSort() -> [Int]{
        // 排序结果为从小到大
        self.buildMaxHeap()
        let heap = self.list // 存储最大堆
        for(var i = self.heapSize - 1; i > 0; i--) {
            // 最后一个位置保存堆最大的数
            self.exchange(i, change: 0)
            self.heapSize--
            self.maxHeapify(0)
        }
        let heapSort = self.list
        self.list = heap // 恢复最大堆
        return heapSort
    }
    
    // MARK: 返回最大值
    /// 返回最大值
    ///
    /// - returns: Int?
    func maxiMum() -> Int? {
        return self.list.first
    }
    
    // MARK: - 返回最大值的同时删除最大值
    /// 返回最大值的同时删除最大值
    ///
    /// - returns: void
    func extractMax() -> Int? {
        let max = self.list.first
        if max != nil {
            // 删除最大值，后重新维护最大堆
            self.list[0] = self.list.last!
            self.list.removeLast()
            self.heapSize = self.list.count
            self.maxHeapify(0)
        }
        return max
    }
    
    // MARK: - 插入一个元素
    /// 插入一个元素
    ///
    /// - parameter x : 要插入的元素
    ///
    /// - returns: void
    func insert(x:Int) {
        self.list.append(x)
        self.buildMaxHeap()
    }
    
    // MARK: - 父节点
    private func parent(i:Int) -> Int {
        return (i + 1) / 2 - 1
    }
    
    // MARK: 左节点
    private func left(i:Int) -> Int {
        return 2 * i + 1
    }
    
    // MARK: 右节点
    private func right(i:Int) -> Int {
        return 2 * i + 2
    }
    
    // MARK: - 建立最大堆
    private func buildMaxHeap() {
        // 时间复杂度O(n)
        self.heapSize = self.list.count
        for(var i = self.list.count / 2; i >= 0; i--) {
            self.maxHeapify(i)
        }
    }
    
    // MARK: 维护最大堆
    private func maxHeapify(i:Int) {
        // 最大堆的基础算法，使用“逐级下降”原理，时间复杂度O(h树高)
        let l = self.left(i)
        let r = self.right(i)
        var largest = i
        // 找出最大的那个数
        if l < heapSize && self.list[l] > self.list[largest] {
            largest = l
        }
        if r < heapSize && self.list[r] > self.list[largest] {
            largest = r
        }
        // 是否需要改变
        if largest != i {
            self.exchange(i, change: largest)
            self.maxHeapify(largest)
        }
    }
    
    // MARK: 交换节点
    private func exchange(i:Int, change:Int) {
        let tempI:Int = self.list[i]
        self.list[i] = self.list[change]
        self.list[change] = tempI
    }
    
}
