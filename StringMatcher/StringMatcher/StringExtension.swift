//
//  StringExtension.swift
//  StringMatcher
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/25.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Cocoa

extension String {
    
    // MARK: - 暴力匹配算法
    /// 暴力匹配算法匹配字符串
    ///
    /// - parameter aString : 要匹配的字符串
    ///
    /// - returns: Range?
    func violentRangeOfString(aString: String) -> Range<Index>? {
        if self.endIndex < aString.endIndex { // s<p时返回nil
            return nil
        }
        var i = self.startIndex
        var j = aString.startIndex
        while i < self.endIndex && j < aString.endIndex {
            //①如果当前字符匹配成功（即self[i] == aString[j]），则i++，j++
            if self[i] == aString[j] {
                i++
                j++
            } else { //②如果失配（即S[i]! = P[j]），令i = i - (j - 1)，j = 0
                i = i.advancedBy(1).advancedBy(-aString.startIndex.distanceTo(j))
                j = aString.startIndex
            }
            
        }
        //匹配成功，返回模式串aString在当前文本串中的位置，否则返回nil
        if j == aString.endIndex {
            // i - j
            let start = i.advancedBy(-aString.startIndex.distanceTo(j))
            return start ..< i
        }
        return nil
    }
    
    // MARK: - KMP匹配算法
    /// KMP匹配算法匹配字符串
    ///
    /// - parameter aString : 要匹配的字符串
    ///
    /// - returns: Range?
    func kmpRangeOfString(aString: String) -> Range<Index>? {
        if self.endIndex < aString.endIndex { // s<p时返回nil
            return nil
        }
        let m = startIndex.distanceTo(aString.endIndex) // 要匹配的字符串长度
        let prefixList = self.computePrefixFunction(aString) // 获取前缀
        var q = -1
        for i in self.startIndex ..< self.endIndex {
            while q > -1 && self[i] != aString[startIndex.advancedBy(q+1)] { // 匹配失败，快速移动
                q = prefixList[q]
            }
            if self[i] == aString[startIndex.advancedBy(q+1)] { // 匹配成功
                q++
            }
            if q == m-1 { // 已找到
                return i.advancedBy(1-m)..<i.advancedBy(1)
            }
        }
        return nil
    }
    
    // MARK: 计算前缀
    private func computePrefixFunction(aString: String) -> Array<Int> {
        let start = aString.startIndex
        let length = start.distanceTo(aString.endIndex)
        var list = Array(count: length, repeatedValue: -1)
        var k = -1
        for q in 1..<length {
            // 遇到上一个前缀匹配成功时，要接着匹配
            while k > -1 && aString[start.advancedBy(k+1)] != aString[start.advancedBy(q)] {
                k = list[k]
            }
            // 匹配前缀和后缀首位
            if aString[start.advancedBy(k+1)] == aString[start.advancedBy(q)] {
                k++
            }
            list[q] = k
        }
        return list
    }

}
