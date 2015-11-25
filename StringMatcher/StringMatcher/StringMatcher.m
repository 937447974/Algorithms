//
//  StringMatcher.m
//  StringMatcher
//
//  Created by yangjun on 15/11/25.
//  Copyright © 2015年 阳君. All rights reserved.
//

#import "StringMatcher.h"

@implementation StringMatcher

#pragma mark - 返回模式串p在文本串s中的位置,暴力匹配算法
- (NSInteger)violentSearch:(NSString *)s p:(NSString *)p {
    NSInteger sLen = s.length;
    NSInteger pLen = p.length;
    // 安全机制
    if (sLen < pLen) {
        return -1;
    }
    NSInteger i = 0;
    NSInteger j = 0;
    while (i < sLen && j < pLen) {
        if ([s characterAtIndex:i] == [p characterAtIndex:j]) {
            //①如果当前字符匹配成功（即S[i] == P[j]），则i++，j++
            i++;
            j++;
        } else {
            //②如果失配（即S[i]! = P[j]），令i = i - (j - 1)，j = 0
            i = i - j + 1;
            j = 0;
        }
    }
    //匹配成功，返回模式串p在文本串s中的位置，否则返回-1
    if (j == pLen)
        return i - j;
    else
        return -1;
}

#pragma mark - 返回模式串p在文本串s中的位置,kmp算法
- (NSInteger)kmpSearch:(NSString *)s p:(NSString *)p {
    NSArray *next = [self getNextval:p];
    NSInteger sLen = s.length;
    NSInteger pLen = p.length;
    // 安全机制
    if (sLen < pLen) {
        return -1;
    }
    NSInteger i = 0;
    NSInteger j = 0;
    while (i < sLen && j < pLen) {
        if (j == -1 || [s characterAtIndex:i] == [p characterAtIndex:j]) {
            // ①如果j = -1，或者当前字符匹配成功（即S[i] == P[j]）
            i++;
            j++;
        } else {
            // ②如果j != -1，且当前字符匹配失败（即S[i] != P[j]）
            j = [next[j] integerValue];
        }
    }
    // 匹配成功，返回模式串p在文本串s中的位置，否则返回-1
    if (j == pLen)
        return i - j;
    else
        return -1;
}

#pragma mark 获取最大长度表next
- (NSArray *)getNextval:(NSString *)p {
    NSInteger pLen = p.length;
    NSMutableArray *next = [NSMutableArray array];
    // 初始化
    for (int i = 0; i < pLen; i++) {
        [next addObject:@"-1"];
    }
    NSInteger k = -1;
    NSInteger j = 0;
    while (j < pLen - 1) {
        //p[k]表示前缀，p[j]表示后缀
        if (k == -1 || [p characterAtIndex:j] == [p characterAtIndex:k]) {
            ++j;
            ++k;
            if ([p characterAtIndex:j] != [p characterAtIndex:k])
                // 之前只有这一行
                next[j] = [NSString stringWithFormat:@"%li", k];
            else
                // 因为不能出现p[j] = p[ next[j ]]，所以当出现时需要继续递归，k = next[k] = next[next[k]]
                next[j] = next[k];
        } else {
            k = [next[k] integerValue];
        }
    }
    return next;
}

#pragma mark - 返回模式串p在文本串s中的位置,sunday算法
- (NSInteger)sundaySearch:(NSString *)s p:(NSString *)p {
    NSDictionary *dict = [self getSundayDict:p];
    NSInteger sLen = s.length;
    NSInteger pLen = p.length;
    // 安全机制
    if (sLen < pLen) {
        return -1;
    }
    NSInteger i = 0;
    NSInteger j = 0;
    while (i < sLen && j < pLen) {
        if ([s characterAtIndex:i] == [p characterAtIndex:j]) {
            // ①如果当前字符匹配成功（即S[i] == P[j]），都令i++，j++
            i++;
            j++;
        } else {
            // ②不匹配时关注文本串中参加匹配的最末位字符的下一位字符
            // i移动到末尾的下一位字符，j归零
            i = i - j + pLen;
            j = 0;
            // 存在时要调整i的位置
            NSRange range = {i, 1};
            // 下一位字符
            NSString *next = [s substringWithRange:range];
            i -= [[dict objectForKey:next] integerValue];
        }
    }
    //匹配成功，返回模式串p在文本串s中的位置，否则返回-1
    if (j == pLen)
        return i - j;
    else
        return -1;
}

#pragma mark 获取跳跃表Dict
- (NSDictionary *)getSundayDict:(NSString *)p {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i = 0; i < p.length; i++) {
        NSRange range = {i, 1};
        NSString *key = [p substringWithRange:range];
        // 存入最后出现的位置
        [dict setObject:[NSString stringWithFormat:@"%i", i] forKey:key];
    }
    return dict;
}

@end
