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
    private var list:[Int] = []
    /// 堆长度
    private var heapSize = 0
    
    //MARK: 初始化
    init(list:[Int]) {
        self.list = list
    }
    
    // MARK: - 父节点
    private func parent(i:Int) -> Int {
        return (i + 1) / 2 - 1
    }
    
    // MARK: 左节点
    private func left(i:Int) -> Int {
        return 2 * i + 1
    }
    
    // MARK: 右边节点
    private func right(i:Int) -> Int {
        return 2 * i + 2
    }
    
    // MARK: 交换节点
    private func exchange(i:Int, change:Int) {
        let tempI:Int = self.list[i]
        self.list[i] = self.list[change]
        self.list[change] = tempI
    }
    
    //MARK: - 最大堆排序
    func maxSort() -> [Int]{
        self.buildMaxHeap()
        for(var i = self.heapSize - 1; i > 0; i--) {
            self.exchange(i, change: 0)
            self.heapSize--
            self.maxBase(0)
        }
        return self.list
    }
    
    // MARK: 建立最大堆
    private func buildMaxHeap() {
        self.heapSize = self.list.count
        for(var i = self.list.count / 2; i >= 0; i--) {
            self.maxBase(i)
        }
    }
    
    // MARK: 最大堆的基础算法
    private func maxBase(i:Int) {
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
            self.maxBase(largest)
        }
    }
    
    //MARK: - 最小堆排序
    func miniSort() -> [Int]{
        self.buildMiniHeap()
        for(var i = self.heapSize - 1; i > 0; i--) {
            self.exchange(i, change: 0)
            self.heapSize--
            self.miniBase(0)
        }
        return self.list
    }
    
    // MARK: 建立最小堆
    private func buildMiniHeap() {
        self.heapSize = self.list.count
        for(var i = self.list.count / 2; i >= 0; i--) {
            self.miniBase(i)
        }
    }
    
    // MARK: 最小堆的基础算法
    private func miniBase(i:Int) {
        let l = self.left(i)
        let r = self.right(i)
        var largest = i
        // 找出最小的那个数
        if l < self.heapSize && self.list[l] < self.list[largest] {
            largest = l
        }
        if r < self.heapSize && self.list[r] < self.list[largest] {
            largest = r
        }
        // 是否需要改变
        if largest != i {
            self.exchange(i, change: largest)
            self.miniBase(largest)
        }
    }
    
}
