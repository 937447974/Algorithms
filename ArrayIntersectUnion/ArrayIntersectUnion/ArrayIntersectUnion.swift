//
//  ArrayIntersectUnion.swift
//  ArrayIntersectUnion
//
//  Created by yangjun on 15/11/25.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Cocoa

class ArrayIntersectUnion {

    
    // MARK: 求交
    /// 两数组求交,并去掉重复数据
    ///
    /// - parameter array1 : 数组1
    /// - parameter array2 : 数组2
    ///
    /// - returns: array
    func intersect(array1: Array<String>, _ array2: Array<String>) -> Array<String> {
        var list = Array<String>()
        var set = Set<String>()
        // 存入数据
        for item in array1 {
            set.insert(item)
        }
        // 判断是否共同数据
        for item in array2 {
            if set.contains(item) {
                list.append(item)
            }
        }
        return list
    }
    
    // MARK: 求并
    /// 两数组求并
    ///
    /// - parameter array1 : 数组1
    /// - parameter array2 : 数组2
    ///
    /// - returns: array
    func union(array1: Array<String>, _ array2: Array<String>) -> Array<String> {
        var list = Array<String>()
        var set = Set<String>()
        // 添加数组1
        for item in array1 {
            if !set.contains(item) { // 已添加数据，不在重复添加
                set.insert(item)
                list.append(item)
            }
        }
        // 添加数组2
        for item in array2 {
            if !set.contains(item) {
                set.insert(item)
                list.append(item)
            }
        }
        return list
    }
    
}
