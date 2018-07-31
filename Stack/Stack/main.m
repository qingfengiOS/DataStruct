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
    if (S->top == -1 || S->top > MAXSIZE) {
        return ERROR;
    }
    *e = S->data[S->top];
//    S->data[S->top] = NULL;
    S->top--;
    return OK;
}

#pragma mark - 两栈共享空间
/*
 两个栈在数组的两端，top1和top2是栈1和栈2的站定指针，只要他们没有相遇，说明栈未满，可以一直使用
 */

/**
 两栈共享空间结构
 */
typedef struct {
    SElementType data[MAXSIZE];
    int top1;
    int top2;
}SqDoubleStack;

/*
 对于两栈共享空间的push方法，我们除了要插入元素值参数之外，还需啊哟有一个判断是栈1还是栈2的栈号参数stackNumber
 */
Status DoubleStackPush(SqDoubleStack *S, SElementType e, int stackNumber) {
    if (S->top1 + 1 == S->top2) {//两个栈的指针相遇了，栈满
        return ERROR;
    }
    if (stackNumber == 1) {
        S->data[++S->top1] = e;//栈1，先top1指针后移一位，插入数据
    } else {
        S->data[--S->top2] = e;//栈2，先top2指针前移一位，插入数据
    }
    return OK;
}

Status DoubleStackPoP(SqDoubleStack *S, SElementType *e, int stackNumber) {
    
    if (stackNumber == 1) {//栈1
        if (S->top1 == -1) {
            return ERROR;
        }
        *e = S->data[S->top1--];
    } else {//栈2
        if (S->top2 >= MAXSIZE) {
            return ERROR;
        }
        *e = S->data[S->top2++];
    }

    return OK;
}
/*
 事实上，使用这样的数据结构，通常都是当两个栈的空间需求有相反关系时，也就是一个栈增长时另一个栈在缩短的情况。就像买卖股票一样，你买入时，一定是有一个你不知道的人在做卖出操作。有人赚钱，就一定是有人赔钱。这样使用两栈共享空间存储方法才有比较大的意义。否则两个栈都在不停地增长，那很快就会因栈满而溢出了。
 */


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int a[10] = {1,2,3,4,5,6,7,8,9,10};
        SqStack S = *(SqStack *)malloc(sizeof(SqStack));
        for (int i = 10 - 1; i >= 0; i--) {
            S.data[i] = a[i];
        }
        S.top = 9;
        SElementType e;
        PoP(&S, &e);
        printf("%d\n",e);
        PoP(&S, &e);
        printf("%d\n",e);
        Push(&S, 5);
        
        
    }
    return 0;
}
