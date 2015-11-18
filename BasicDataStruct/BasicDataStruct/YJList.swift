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
    private var lNil = YJListItem()
    
    // MARK: - 初始化
    init() {
        // 自循环
        self.lNil.next = self.lNil
        self.lNil.prev = self.lNil
    }
    
    // MARK: 查找YJListItem
    /// 根据关键字查找YJListItem
    ///
    /// - parameter key : 关键字
    ///
    /// - returns: key
    func search(key:String) -> YJListItem {
        var x = self.lNil.next
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
        item.next = self.lNil.next
        self.lNil.next.prev = item
        self.lNil.next = item
        item.prev = self.lNil
    }
    
    // MARK: 删除
    /// 删除关键字
    ///
    /// - parameter key : 关键字
    ///
    /// - returns: void
    func delete(key:String) {
        let item = self.search(key)
        item.prev.next = item.next
        item.next.prev = item.prev
    }
    
}
