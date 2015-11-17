//
//  YJStack.swift
//  BasicDataStruct
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/17.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Foundation

enum YJStackError: ErrorType {
    /// 上溢
    case Overflow
    /// 下溢
    case Underflow
}

/// 栈
class YJStack {

    /// 栈,10个位置
    private var list = [Int](count: 10, repeatedValue: 0)
    /// 最新元素的位置
    private var top = -1
    
    // MARK: 栈是否为空
    /// 栈是否为空
    ///
    /// - returns: Bool
    func empty() -> Bool {
        return self.top == -1
    }
    
    // MARK: 压入
    /// 压入
    ///
    /// - returns: Int throws YJStackError
    func push(x:Int) throws {
        self.top++
        guard self.top != self.list.count else {
            throw YJStackError.Overflow // 上溢
        }
        list[self.top] = x
    }
    
    // MARK: 弹出
    /// 弹出
    ///
    /// - returns: Int throws YJStackError
    func pop() throws ->Int {
        guard !self.empty() else {
            throw YJStackError.Underflow // 下溢
        }
        self.top--
        return list[self.top+1]
    }
    
}
