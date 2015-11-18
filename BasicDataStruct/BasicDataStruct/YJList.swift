//
//  YJList.swift
//  BasicDataStruct
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/17.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Foundation

/// 链表
class YJList {
    
    /// 哨兵
    private var sentinel = YJListItem()
    
    // MARK: - 初始化
    init() {
        // 哨兵自循环
        self.sentinel.next = self.sentinel
        self.sentinel.prev = self.sentinel
    }
    
    // MARK: 查找YJListItem
    /// 根据关键字查找YJListItem
    ///
    /// - parameter key : 关键字
    ///
    /// - returns: key
    func search(key:String) -> YJListItem {
        var x = self.sentinel.next
        while x.key != nil && x.key != key {
            x = x.next
        }
        return x
    }
    
    // MARK: 插入
    /// 插入关键字
    ///
    /// - parameter key : 关键字
    ///
    /// - returns: void
    func insert(key:String) {
        let item = YJListItem()
        item.key = key
        item.next = self.sentinel.next
        self.sentinel.next.prev = item
        self.sentinel.next = item
        item.prev = self.sentinel
    }
    
    // MARK: 删除
    /// 删除关键字
    ///
    /// - parameter key : 关键字
    ///
    /// - returns: void
    func delete(key:String) {
        // 查找元素
        let item = self.search(key)
        if item.key != nil { // 存在则删除
            item.prev.next = item.next
            item.next.prev = item.prev
        }
    }
    
}
