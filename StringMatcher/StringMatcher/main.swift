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
let s = "name:阳君;qq:937447974"
/// 匹配字符串
let aString = "qq"

print(s.rangeOfString(aString))
print(s.violentRangeOfString(aString))



