//
//  main.swift
//  StringMatcher
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/25.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Foundation

/// 目标字符串
var str = ""
let count = 10000
for i in 0 ..< count {
//    str += "\(arc4random() % 10)"
    str += "\(i)"
}

/// 匹配字符串
let range = str.startIndex.advancedBy(count/2+1) ..< str.startIndex.advancedBy(count/2+1000)
let aString =  str.substringWithRange(range)
print("Swift实现")
print("原生:\(str.rangeOfString(aString))")
print("暴力:\(str.violentRangeOfString(aString))")
print("KMP:\(str.kmpRangeOfString(aString))")
print("Sunday:\(str.sundayRangeOfString(aString))")


print("\nObject-c实现")
let match = StringMatcher()
print("暴力:\(match.violentSearch(str, p: aString))")
print("KMP:\(match.kmpSearch(str, p: aString))")
print("Sunday:\(match.sundaySearch(str, p: aString))")

