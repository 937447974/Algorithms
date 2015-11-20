//
//  main.m
//  RedBlackTreeOC
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/20.
//  Copyright © 2015年 阳君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RedBlackTree.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"hh:mm:ss"];
        NSLog(@"红黑树插入100,0000个数，开始：%@", [formatter stringFromDate:[NSDate date]]);
        RedBlackTree *tree = [[RedBlackTree alloc] init];
        for (int i = 10000000; i >= 2; i--) {
            [tree insert:i];
        }
        NSLog(@"增加并排序耗时:%@", [formatter stringFromDate:[NSDate date]]);
        for (int i = 2; i <= 10000000; i++) {
            [tree deletekey:i];
        }
        NSLog(@"删除耗时:%@", [formatter stringFromDate:[NSDate date]]);
        [tree inorder];
        NSLog(@"排序输出结束:%@", [formatter stringFromDate:[NSDate date]]);

    }
    return 0;
}
