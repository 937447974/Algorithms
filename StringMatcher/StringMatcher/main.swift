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
    str += "\(arc4random() % 10)"
}

/// 匹配字符串
let range = str.startIndex.advancedBy(count/2) ..< str.startIndex.advancedBy(count/2+10)
var aString =  str.substringWithRange(range)

print("原生：\(str.rangeOfString(aString))")
print("暴力：\(str.violentRangeOfString(aString))")
print("KMP：\(str.kmpRangeOfString(aString))")




