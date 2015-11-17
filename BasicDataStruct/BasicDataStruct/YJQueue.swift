//
//  YJQueue.swift
//  BasicDataStruct
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/17.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Foundation

enum YJQueueError: ErrorType {
    /// 上溢
    case Overflow
    /// 下溢
    case Underflow
}

/// 队列
class YJQueue {

    /// 队列,8个位置
    private var list = [Int](count: 8, repeatedValue: 0)
    /// 队头
    private var head = 0
    /// 队尾
    private var tail = 0
    /// 队列中存在的个数
    private var count = 0
    
    // MARK: 栈是否为空
    /// 栈是否为空
    ///
    /// - returns: Bool
    func empty() -> Bool {
        return self.count == 0
    }
    
    // MARK: 入队
    /// 入对
    ///
    /// - returns: Int throws YJQueueError
    func enqueue(x:Int) throws {
        guard self.count != self.list.count else {
            throw YJQueueError.Overflow // 上溢
        }
        list[self.tail] = x // 存数
        self.count++ // 计数加1
        self.tail++ // 后移动
        self.tail =  self.tail == self.count ? 0 : self.tail // 循环
    }
    
    // MARK: 出队
    /// 出队
    ///
    /// - returns: Int throws YJQueueError
    func dequeue() throws ->Int {
        guard !self.empty() else {
            throw YJQueueError.Underflow // 下溢
        }
        let temp = self.list[self.head]
        self.count--
        self.head++
        self.tail =  self.tail == self.count ? 0 : self.tail
        return temp
    }
    
}
