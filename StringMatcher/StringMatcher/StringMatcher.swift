//
//  StringMatcher.swift
//  StringMatcher
//
//  Created by yangjun on 15/11/25.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Cocoa

/// 字符串匹配
class StringMatcher {

    // MARK: - 暴力匹配算法
    /// 暴力匹配算法匹配字符串
    ///
    /// - parameter s : 源字符串
    /// - parameter p : 要匹配的字符串
    ///
    /// - returns: Range?
    func violentSearch(s: String, p: String) -> Range<String.CharacterView.Index>? {
        let sLIndex = s.endIndex
        let pLIndex = p.endIndex
        // s<p时返回nil
        if sLIndex < pLIndex {
            return nil
        }
        var i = s.startIndex
        var j = p.startIndex
        while i < sLIndex && j < pLIndex {
            //①如果当前字符匹配成功（即S[i] == P[j]），则i++，j++
            if s[i] == p[j] {
                i++
                j++
            } else { //②如果失配（即S[i]! = P[j]），令i = i - (j - 1)，j = 0
                i = i.advancedBy(1).advancedBy(-p.startIndex.distanceTo(j))
               j = p.startIndex
            }
            
        }
        //匹配成功，返回模式串p在文本串s中的位置，否则返回nil
        if j == pLIndex {
            // i - j
            let start = i.advancedBy(-p.startIndex.distanceTo(j))
            return start ..< i
        }
        return nil
    }
    
}
