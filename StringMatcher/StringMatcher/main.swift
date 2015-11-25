//
//  main.swift
//  StringMatcher
//
//  Created by yangjun on 15/11/25.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Foundation

/// 目标字符串
let s = "name:阳君;qq:937447974"
/// 匹配字符串
let p = "qq"

let sMatcher = StringMatcher()

print(s.rangeOfString(p))

print(sMatcher.violentSearch(s, p: p))



