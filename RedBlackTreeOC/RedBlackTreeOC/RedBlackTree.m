//
//  RedBlackTree.m
//  RedBlackTreeOC 
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 14-6-27.
//  Copyright (c) 2014年 阳君. All rights reserved.
//

#import "RedBlackTree.h"

@interface RedBlackTree ()
{
@private
    /** 根结点*/
    RedBlakcNode *_root;
}

@end

@implementation RedBlackTree

#pragma mark - 树的大小
- (NSInteger)size
{
    return _root.size;
}

#pragma mark - 查找某个数
- (NSInteger)search:(NSInteger)key
{
    RedBlakcNode *search = [self searchNode:_root key:key];
    return search.key;
}

#pragma mark - 查找某个节点
- (RedBlakcNode *)searchNode:(RedBlakcNode *)x key:(NSInteger)key
{
    while (x && key != x.key)
    {
        if (key < x.key)
            x = x.leftTree;
        else
            x = x.rightTree;
    }
    return x;
}

#pragma mark - 最小数
- (NSInteger)minimum
{
    RedBlakcNode *min = [self minimum:_root];
    return min.key;
}

#pragma mark 节点x下的最小数
- (RedBlakcNode *)minimum:(RedBlakcNode *)x
{
    while (x.leftTree)
    {
        x = x.leftTree;
    }
    return x;
}

#pragma mark - 最大数
- (NSInteger)maxmum
{
    RedBlakcNode *max = [self maxmum:_root];
    return max.key;
}

#pragma mark 节点x下的最大数
- (RedBlakcNode *)maxmum:(RedBlakcNode *)x
{
    while (x.rightTree)
    {
        x = x.rightTree;
    }
    return x;
}


#pragma mark - 中序列输出
- (void)inorder
{
    _array = [NSMutableArray array];
    [self inorder:_root];
}

#pragma mark 节点中序列输出
- (void)inorder:(RedBlakcNode *)p
{
    if (p == nil)
        return;
    // NSLog(@"%li:%li--%li" , p.key, p.size, p.color);
    // 左
    if (p.leftTree)
        [self inorder:p.leftTree];
    // 根
    [_array addObject:p];
    // 右
    if (p.rightTree)
        [self inorder:p.rightTree];
}

#pragma mark - 右旋转
- (void)leftRotate:(RedBlakcNode *)x
{
    RedBlakcNode *y = x.rightTree;
    if (y == nil)
        return;
    
    // 调整右子节点
    x.rightTree = y.leftTree;
    if (y.leftTree)
        y.leftTree.parent = x;

    // 调整父节点
    y.parent = x.parent;
    if (x.parent == nil)
        _root = y;
    else if (x == x.parent.leftTree)
        x.parent.leftTree = y;
    else
        x.parent.rightTree = y;
    
    // 调整自己
    y.leftTree = x;
    x.parent = y;
    // 大小
    y.size = x.size;
    x.size = x.leftTree.size + x.rightTree.size + 1;
    
}

#pragma mark 左旋转
- (void)rightRotate:(RedBlakcNode *)x
{
    RedBlakcNode *y = x.leftTree;
    
    if (y == nil)
        return;
    
    // 调整左子节点
    x.leftTree = y.rightTree;
    if (y.rightTree)
        y.rightTree.parent = x;
    
    // 调整父节点
    y.parent = x.parent;
    if (x.parent == nil)
        _root = y;
    else if (x == x.parent.leftTree)
        x.parent.leftTree = y;
    else
        x.parent.rightTree = y;
    
    // 调整自己
    y.rightTree = x;
    x.parent = y;
    
    // 大小
    y.size = x.size;
    x.size = x.leftTree.size + x.rightTree.size + 1;

}

#pragma mark - 增加
- (void)insert:(NSInteger)key
{
    [self insertNode:[[RedBlakcNode alloc] initWithKey:key]];
}

#pragma mark 增加节点
- (void)insertNode:(RedBlakcNode *)z
{
    RedBlakcNode *y = nil;
    RedBlakcNode *x = _root;
    
    // 找到要插入位置的父节点
    while (x)
    {
        y = x;
        if (z.key < x.key)
            x = x.leftTree;
        else
            x = x.rightTree;
    }
    
    // 找到位置后插入新节点
    z.parent = y;
    if (y == nil)
        _root = z;
    else if (z.key < y.key)
        y.leftTree = z;
    else
        y.rightTree = z;
    
    [self sizeFixup:y];
    // 修正红黑树
    [self insertFixup:z];
}

#pragma mark 插入完修正红黑树
- (void)insertFixup:(RedBlakcNode *)z
{
    RedBlakcNode *y = nil;
    // 特殊情况下，经过调整后根的左右两边会相差一个黑节点的高度
    // 但针对增加删除修改的运算速度而言影响不大，不做特殊处理。
    while (z.parent && z.parent.color == RedColor)
    {
        // 父节点在祖父节点的左边
        if (z.parent == [z grandparent].leftTree)
        {
            y = [z grandparent].rightTree;
            // 情况1：z的叔节点y是红色的
            if (y && y.color == RedColor)
            {
                y.parent.color = RedColor;
                y.color = BlackColor;
                z.parent.color = BlackColor;
                z = z.parent.parent;
            }
            // 情况2：z的叔节点y是黑色的，且z是一个右孩子
            else if (z == z.parent.rightTree)
            {
                z = z.parent;
                [self leftRotate:z];
            }
            // 情况3:z的叔节点y是黑色的，且z是一个左孩子
            z.parent.color = BlackColor;
            [z grandparent].color = RedColor;
            [self rightRotate:[z grandparent]];
        
        }
        // 父节点在祖父节点的右边
        else
        {
            y = [z grandparent].leftTree;
            if (y && y.color == RedColor)
            {
                y.parent.color = RedColor;
                y.color = BlackColor;
                z.parent.color = BlackColor;
                z = z.parent.parent;
            }
            else if (z == z.parent.leftTree)
            {
                z = z.parent;
                [self rightRotate:z];
            }
            z.parent.color = BlackColor;
            [z grandparent].color = RedColor;
            [self leftRotate:[z grandparent]];
        }
    }
    // 根节点设为黑色
    _root.color = BlackColor;
    
}

#pragma mark - 删除
- (void)deletekey:(NSInteger)key
{
    RedBlakcNode *deldte = [self searchNode:_root key:key];
    [self deleteNode1:deldte];
}

#pragma mark 删除节点
- (void)deleteNode:(RedBlakcNode *)z
{
    // 原理：尽量让将z调整到红色叶节点上，删除
    //NSLog(@"%li", z.key);
    if (z == nil)
        return;
    
    RedBlakcNode *x;
    
    // z为中间结点
    if (z.leftTree || z.rightTree)
    {
        RedBlakcNode *y = z;
        RedBlakcNodeColor yColor = y.color;
        if (z.leftTree == nil)
        {
            x = z.rightTree;
            [self transplant:z v:x];
        }
        else if (z.rightTree == nil)
        {
            x = z.leftTree;
            [self transplant:z v:x];
        }
        else
        {
            // 后驱
            RedBlakcNode *y = [self minimum:z.rightTree];
            yColor = y.color;
            x = y.rightTree;
            // 有的时候x会为空
            if (x)
            {
                if (y.parent == z)
                {
                    x.parent = y;
                }
                else
                {
                    [self transplant:y v:y.rightTree];
                    y.rightTree = z.rightTree;
                    y.rightTree.parent = y;
                }
                [self transplant:z v:y];
                y.leftTree = z.leftTree;
                y.leftTree.parent = y;
                y.color = z.color;
            }
            else
            {
                [z exchange:y];
                [self deleteNode:y];
            }
            
        }
        // 判断是否需要修正红黑树
        if (yColor == BlackColor)
            [self deleteFixup:x];
    }
    // z为叶子结点,或者单一根节点（根节点没有任何子节点）
    else
    {
        // 父结点
        x = z.parent;
        // z为叶节点
        if (x)
        {
            // z的兄弟节点
            RedBlakcNode *y;
            // z在左
            if (z == x.leftTree)
            {
                x.leftTree = nil;
                // z为黑色,则其兄弟节点的size最多为3
                if (z.color == BlackColor)
                {
                    y = x.rightTree;
                    if (y)
                    {
                        if (y.rightTree) { // y存在右子节点
                            [self leftRotate:x];
                            y.color = RedColor;
                            y.rightTree.color = BlackColor;
                            x.color = BlackColor;
                            x.rightTree.color = RedColor;
                        } else if (y.leftTree) { // y存在左子节点
                            [x exchange:y.leftTree];
                            x.leftTree = y.leftTree;
                            y.leftTree.parent = x;
                            y.leftTree = nil;
                            y.size = 1;
                            x.leftTree.size = 1;
                            [self sizeFixup:x];
                        } else { // y没有子节点
                            x.color = BlackColor;
                            y.color = RedColor;
                            [self sizeFixup:x];
                            [self deleteFixup:x];
                        }
                    } else {
                        x.color = BlackColor;
                        [self sizeFixup:x];
                        [self deleteFixup:x];
                    }
                } else {
                    [self sizeFixup:x];
                }
            }
            // z在右
            else
            {
                x.rightTree = nil;
                // z为黑色,则其兄弟节点的size最多为3
                if (z.color == BlackColor)
                {
                    y = x.leftTree;
                    if (y)
                    {
                        if (y.leftTree) { // y存在右子节点
                            [self leftRotate:x];
                            y.color = RedColor;
                            y.leftTree.color = BlackColor;
                            x.color = BlackColor;
                            x.leftTree.color = RedColor;
                        } else if (y.rightTree) { // y存在左子节点
                            [x exchange:y.rightTree];
                            x.rightTree = y.rightTree;
                            y.rightTree.parent = x;
                            y.rightTree = nil;
                            y.size = 1;
                            x.rightTree.size = 1;
                            [self sizeFixup:x];
                        } else { // y没有子节点
                            x.color = BlackColor;
                            y.color = RedColor;
                            [self sizeFixup:x];
                            [self deleteFixup:x];
                        }
                    } else {
                        x.color = BlackColor;
                        [self sizeFixup:x];
                        [self deleteFixup:x];
                    }
                    
                } else {
                    [self sizeFixup:x];
                }
            }
        } else { // z为根节点
            _root = nil;
        }
    }
}

#pragma mark 删除节点
- (void)deleteNode1:(RedBlakcNode *)z
{
    // 快速删除，牺牲红黑树的性质，遇到叶子节点直接删除
    //NSLog(@"%li", z.key);
    if (z == nil)
        return;
    
    RedBlakcNode *x;
    RedBlakcNode *y = z;
    RedBlakcNodeColor yColor = y.color;
    
    if (z.leftTree == nil)
    {
        x = z.rightTree;
        [self transplant:z v:x];
    }
    else if (z.rightTree == nil)
    {
        x = z.leftTree;
        [self transplant:z v:x];
    }
    else
    {
        // 后驱
        RedBlakcNode *y = [self minimum:z.rightTree];
        yColor = y.color;
        x = y.rightTree;
        
        if (y.parent == z)
        {
            x.parent = y;
        }
        else
        {
            [self transplant:y v:y.rightTree];
            y.rightTree = z.rightTree;
            y.rightTree.parent = y;
        }
        [self transplant:z v:y];
        y.leftTree = z.leftTree;
        y.leftTree.parent = y;
        y.color = z.color;
    }
    // 判断是否需要修正红黑树
    if (yColor == BlackColor)
        [self deleteFixup:x];
}


#pragma mark 移植，将v移到u的位置
- (void)transplant:(RedBlakcNode *)u v:(RedBlakcNode *)v
{
    // 移动自己
    if (u.parent == nil)
        _root = v;
    else if (u == u.parent.leftTree)
        u.parent.leftTree = v;
    else
        u.parent.rightTree = v;
    // 移动父节点的指向
    v.parent = u.parent;
    // 改变size
    if (v)
        [self sizeFixup:v];
    else
        [self sizeFixup:u.parent];
}

#pragma mark 删除完中间节点修正红黑树
- (void)deleteFixup:(RedBlakcNode *)x
{
    while (x && x.color == BlackColor && x != _root )
    {
        // 兄弟节点
        RedBlakcNode *w;
        // 在父节点的左边
        if (x == x.parent.leftTree)
        {
            w = x.parent.rightTree;
            // 情况1:x的兄弟节点w是红色的
            if (w && w.color == RedColor)
            {
                w.color = BlackColor;
                x.parent.color = RedColor;
                [self leftRotate:x.parent];
                w = x.parent.rightTree;
            }
            // 情况2:x的兄弟结点w是黑色的，而且w的两个子结点都是黑色的
            if (w.leftTree && w.rightTree)
            {
                if (w.leftTree.color == BlackColor && w.rightTree.color == BlackColor)
                {
                    w.color = RedColor;
                    x = x.parent;
                }
                // 情况3:x的兄弟结点w是黑色的，w的左孩子是红色的，w的右孩子是黑色的
                else if (w.rightTree.color == BlackColor)
                {
                    w.leftTree.color = BlackColor;
                    w.color = RedColor;
                    [self rightRotate:w];
                    w = x.parent.rightTree;
                }
            }
            // 情况4:x的兄弟结点w是黑色的，且w的右孩子是红色的
            w.color = x.parent.color;
            x.parent.color = BlackColor;
            w.rightTree.color = BlackColor;
            [self leftRotate:x.parent];
            x = _root;
        }
        // 在父节点的右边
        else
        {
            w = x.parent.leftTree;
            if (w && w.color == RedColor)
            {
                w.color = BlackColor;
                x.parent.color = RedColor;
                [self leftRotate:x.parent];
                w = x.parent.leftTree;
            }
            if (w.leftTree && w.rightTree)
            {
                if (w.leftTree.color == BlackColor && w.rightTree.color == BlackColor)
                {
                    w.color = RedColor;
                    x = x.parent;
                }
                else if (w.leftTree.color == BlackColor)
                {
                    w.rightTree.color = BlackColor;
                    w.color = RedColor;
                    [self leftRotate:w];
                    w = x.parent.leftTree;
                }
            }
            w.color = x.parent.color;
            x.parent.color = BlackColor;
            w.leftTree.color = BlackColor;
            [self rightRotate:x.parent];
            x = _root;
        }
    }
    x.color = BlackColor;
}

#pragma mark - 修正size
- (void)sizeFixup:(RedBlakcNode *)x
{
    while (x)
    {
        // 大小
        x.size = x.leftTree.size + x.rightTree.size + 1;
        x = x.parent;
    }
}

@end
