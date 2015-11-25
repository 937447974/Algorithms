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
        // 预先读取，防止频繁读取
        let sLIndex = self.endIndex
        let pLIndex = aString.endIndex
        // s<p时返回nil
        if sLIndex < pLIndex {
            return nil
        }
        var i = self.startIndex
        var j = aString.startIndex
        while i < sLIndex && j < pLIndex {
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
        if j == pLIndex {
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
        return nil
    }

}
