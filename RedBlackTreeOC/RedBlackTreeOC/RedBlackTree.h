//
//  RedBlackTree.h
//  RedBlackTreeOC
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 14-6-27.
//  Copyright (c) 2014年 阳君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RedBlakcNode.h"

@interface RedBlackTree : NSObject

/** 排序结果*/
@property (nonatomic, strong) NSMutableArray *array;

/**
 *  中序列输出
 *
 *  @return void
 */
- (void)inorder;

/**
 *  最小数
 *
 *  @return NSInteger
 */
- (NSInteger)minimum;

/**
 *  最大数
 *
 *  @return NSInteger
 */
- (NSInteger)maxmum;

/**
 *  树的大小
 *
 *  @return NSInteger
 */
- (NSInteger)size;

/**
 *  查找某个数
 *
 *  @param key 被查找的数
 *
 *  @return 查到的数
 */
- (NSInteger)search:(NSInteger)key;


/**
 *  增加
 *
 *  @param key 要增加的值
 *
 *  @return void
 */
- (void)insert:(NSInteger)key;

/**
 *  删除
 *
 *  @param key 删除某个值
 *
 *  @return void
 */
- (void)deletekey:(NSInteger)key;

@end
