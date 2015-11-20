//
//  RedBlakcNode.h
//  RedBlackTreeOC
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 14-6-27.
//  Copyright (c) 2014年 阳君. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RedBlakcNodeColor) {
    // 红色
    RedColor,
    // 黑色
    BlackColor
};

@interface RedBlakcNode : NSObject

/** 颜色*/
@property (nonatomic) RedBlakcNodeColor color;

/** 值*/
@property (nonatomic) NSInteger key;
/** 大小也即长度*/
@property (nonatomic) NSInteger size;

/** 左节点*/
@property (nonatomic, strong) RedBlakcNode *leftTree;
/** 右节点*/
@property (nonatomic, strong) RedBlakcNode *rightTree;
/** 父节点*/
@property (nonatomic, strong) RedBlakcNode *parent;

/**
 *  得到祖父节点
 *
 *  @return RedBlakcNode
 */
- (RedBlakcNode *)grandparent;

/**
 *  得到叔父节点
 *
 *  @return RedBlakcNode
 */
- (RedBlakcNode *)uncle;

/**
 *  得到兄弟节点
 *
 *  @return RedBlakcNode
 */
- (RedBlakcNode *)sibling;

/**
 *  初始化
 *
 *  @param key 传入的值
 *
 *  @return RedBlakcNode
 */
- (id)initWithKey:(NSInteger)key;

/**
 *  和节点u交换数据
 *
 *  @param RedBlakcNode 交换的节点
 *
 *  @return void
 */
- (void)exchange:(RedBlakcNode *)u;

@end
