//
//  RedBlakcNode.m
//  RedBlackTreeOC
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 14-6-27.
//  Copyright (c) 2014年 阳君. All rights reserved.
//

#import "RedBlakcNode.h"

@implementation RedBlakcNode

#pragma mark 得到祖父节点
- (RedBlakcNode *)grandparent
{
    return _parent ? _parent.parent : nil;
}

#pragma mark 得到叔父节点
- (RedBlakcNode *)uncle
{
    // 没有祖父节点，则没有叔父节点
    if ([self grandparent] == nil)
        return nil;
    // 父节点为祖父节点的左节点，则返回祖父节点的左节点
    if (_parent == [self grandparent].leftTree)
        return [self grandparent].rightTree;
    // 否则返回祖父节点的左节点
    else
        return [self grandparent].leftTree;
}

#pragma mark 得到兄弟节点
- (RedBlakcNode *)sibling
{
    // 当父节点的左节点为自己时，返回父亲的右节点
    if (_parent.leftTree == self)
        return _parent.rightTree;
    // 否则返回父节点的左节点
    else
        return _parent.leftTree;
}

#pragma mark 初始化
- (id)initWithKey:(NSInteger)key
{
    if (self = [super init])
    {
        // 默认为红色
        _color = RedColor;
        // 填充值
        _key = key;
        _size = 1;
    }
    return self;
}

#pragma mark 交换数据
- (void)exchange:(RedBlakcNode *)u
{
    if (u)
    {
        NSInteger uKey = u.key;
        u.key = _key;
        _key = uKey;
    }
}

// 重写父类的toString方法
- (NSString *)description {
    return [NSString stringWithFormat:@"%ld", self.key];
}

@end
