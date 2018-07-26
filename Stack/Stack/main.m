//
//  main.m
//  Stack
//
//  Created by qingfeng on 2018/7/26.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAXSIZE 10
#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0

typedef int Status;
typedef int SElementType;

#pragma mark - 栈的顺序存储结构
typedef struct {
    SElementType data[MAXSIZE];
    int top;//栈顶指针
}SqStack;

/**
 入栈操作
 */
Status Push(SqStack *S, SElementType e) {
    if (S->top == MAXSIZE - 1) {//栈满 则失败
        return ERROR;
    }
    S->top++;//栈顶上移动一个单位
    S->data[S->top] = e;//栈顶就是需要插入的元素
    return OK;
}

/**
 出栈操作
 */
Status PoP(SqStack *S, SElementType *e) {
    if (S->top == -1) {
        return ERROR;
    }
    *e = S->data[S->top];
    S->top--;
    return OK;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        SqStack S = *(SqStack *)malloc(sizeof(SqStack));
        
        SElementType e;
        PoP(&S, &e);
        printf("%d\n",e);
        
        
    }
    return 0;
}
