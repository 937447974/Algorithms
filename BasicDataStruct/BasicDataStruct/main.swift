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
//    try print(strack.pop()) // 下溢
} catch YJStackError.Overflow {
    print("上溢")
} catch YJStackError.Underflow {
    print("下溢")
}

// 队列
do {
    let queue = YJQueue()
    print(queue.empty())
    // 入队
    for var item in 1..<10 {
        try queue.enqueue(item)
    }
    // 出队
    try queue.dequeue()
} catch YJQueueError.Overflow {
    print("上溢")
} catch YJQueueError.Underflow {
    print("下溢")
}


// 链表
let list = YJList()
// 增加
list.insert("阳君")
list.insert("937447974")
// 查找
let itme = list.search("阳君")
print(itme.key)
// 删除
list.delete("阳君")


