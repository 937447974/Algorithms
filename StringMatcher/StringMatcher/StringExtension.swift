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
        if self.startIndex != self.endIndex && self.endIndex < aString.endIndex { // 安全机制
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
            //匹配成功，返回模式串aString在当前文本串中的位置，否则返回nil
            if j == aString.endIndex {
                // i - j
                let start = i.advancedBy(-aString.startIndex.distanceTo(j))
                return start ..< i
            }
        }
        return nil
    }
    
    // MARK: - KMP算法
    /// KMP算法匹配字符串
    ///
    /// - parameter aString : 要匹配的字符串
    ///
    /// - returns: Range?
    func kmpRangeOfString(aString: String) -> Range<Index>? {
        if self.startIndex != self.endIndex && self.endIndex < aString.endIndex { // 安全机制
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
        let length = start.distanceTo(aString.endIndex) // 长度
        var list = Array(count: length, repeatedValue: -1) // 初始化数组
        var k = -1 // -1代表未找到
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
    
    // MARK: - Sunday算法
    /// Sunday算法匹配字符串
    ///
    /// - parameter aString : 要匹配的字符串
    ///
    /// - returns: Range?
    func sundayRangeOfString(aString: String) -> Range<Index>? {
        if self.startIndex != self.endIndex && self.endIndex < aString.endIndex { // 安全机制
            return nil
        }
        let str = self + aString
        var i = str.startIndex
        var j = aString.startIndex
        let aSLength = aString.startIndex.distanceTo(aString.endIndex)
        let sDict = self.getSundayDict(aString)
        while i < self.endIndex && j < aString.endIndex {
            if self[i] == aString[j] {
                // ①如果当前字符匹配成功，都令i++，j++
                i++
                j++
            } else {
                // ②不匹配时关注文本串中参加匹配的最末位字符的下一位字符,即i = i - j + aSLength;
                // i移动到末尾的下一位字符，j归零
                i = i.advancedBy(aSLength).advancedBy(-aString.startIndex.distanceTo(j))
                j = aString.startIndex
//                 下一位字符在aString存在时要调整i的位置
                if i < self.endIndex {
                    let c = self[i]
                    if let ni = sDict[c] {
                        i = i.advancedBy(-ni)
                    }
                }
            }
            //匹配成功，返回模式串aString在当前文本串中的位置，否则返回nil
            if j == aString.endIndex {
                // i - j
                return i.advancedBy(-aSLength) ..< i
            }
        }
        return nil
    }
    
    // MARK: 获取Sunday算法的跳跃表
    private func getSundayDict(aString: String) -> [Character:Int] {
        var dict = [Character:Int]()
        var location = 0
        for i in aString.startIndex..<aString.endIndex {
            dict[aString[i]] = location
            location++
        }
        return dict
    }

}
