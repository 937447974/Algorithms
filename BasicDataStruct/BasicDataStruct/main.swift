//
//  main.swift
//  BasicDataStruct
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/17.
//  Copyright © 2015年 阳君. All rights reserved.
//

import Foundation

// 栈
do {
    let strack = YJStack()
    print(strack.empty())
    try strack.push(1)
    try print(strack.pop())
    try print(strack.pop()) // 下溢
} catch YJStackError.Underflow {
    print("下溢")
}


