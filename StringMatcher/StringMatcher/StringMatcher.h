//
//  StringMatcher.h
//  StringMatcher
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/25.
//  Copyright © 2015年 阳君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringMatcher : NSObject

/**
 *  返回模式串p在文本串s中的位置
 *             暴力匹配算法
 *
 *  @param s 文本串s
 *  @param p 模式串p
 *
 *  @return NSInteger 位置－1代表没找到
 */
- (NSInteger)violentSearch:(NSString *)s p:(NSString *)p;

/**
 *  返回模式串p在文本串s中的位置
 *             KMP算法
 *
 *  @param s 文本串s
 *  @param p 模式串p
 *
 *  @return NSInteger 位置－1代表没找到
 */
- (NSInteger)kmpSearch:(NSString *)s p:(NSString *)p;

/**
 *  返回模式串p在文本串s中的位置
 *             sunday算法
 *
 *  @param s 文本串s
 *  @param p 模式串p
 *
 *  @return NSInteger 位置－1代表没找到
 */
- (NSInteger)sundaySearch:(NSString *)s p:(NSString *)p;

@end
