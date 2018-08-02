//
//  main.c
//  Queue
//
//  Created by 李一平 on 2018/8/2.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#include <stdio.h>

#define MAXSIZE 10
#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0

typedef int Status;
typedef int QElementType;

//MARK:- 循环队列的顺序存储结构
typedef struct {
    QElementType data[MAXSIZE];
    int front;//头指针
    int rear;//尾指针
} SqQueue;

//初始化空队列
Status InitQueue(SqQueue *Q) {
    Q->front = 0;
    Q->rear = 0;
    return OK;
}

//求循环队列的长度
int QueueLength(SqQueue Q) {
    return (Q.rear - Q.front + MAXSIZE) % MAXSIZE;
}

//队列未满，插入元素e为新队列的对尾元素
Status EnQueue(SqQueue *Q, QElementType e) {
    
    if ((Q->rear + 1) % MAXSIZE == Q->front)  {//队列满
        return ERROR;
    }
    Q->data[Q->rear] = e;
    Q->rear = (Q->rear + 1) % MAXSIZE;
    return OK;
}

/* 若队列不空，则删除Q中队头元素，用e返回其值 */
Status DeQueue(SqQueue *Q, QElementType *e) {
    if (Q->front == Q->rear) {
        return ERROR;
    }
    *e = Q->data[Q->front];
    Q->front = (Q->front + 1) % MAXSIZE;
    return OK;
}


//MARK:- 队列的链式存储结构
typedef struct QNode {
    QElementType data;
    struct QNode *next;
} QNode, *QueuePtr;

typedef struct {
    QueuePtr front, rear;
}LinkQueue;

Status EnLinkQueue(LinkQueue *Q, QElementType e) {
    
    QueuePtr s = (QueuePtr)malloc(sizeof(QNode));
    if (!s) {
        return ERROR;
    }
    s->data = e;
    s->next = NULL;
    //新节点s赋值给原队列队尾后继
    Q->rear->next = s;
    
    //队尾指针指向新增的新节点s
    Q->rear = s;
    return OK;
}

//若队列不空，删除Q的队头元素，用e返回其值，并返回OK，否则返回ERROR
Status DeLinkQueue(LinkQueue *Q, QElementType *e) {
    if (Q->front == Q->rear) {
        return ERROR;
    }
    //暂存欲出队节点
    QueuePtr s = Q->front->next;
    //取出节点的值
    *e = s->data;
    //赋值新的front指针
    Q->front->next = s->next;
    //队尾的处理
    if (Q->rear == s) {
        Q->rear = Q->front;
    }
//    free(s);
    return OK;
}
/*
 对于循环队列与链队列的比较，可以从两方面来考虑，从时间上，其实它们的基本操作都是常数时间，即都为O(1)的，不过循环队列是事先申请好空间，使用期间不释放，而对于链队列，每次申请和释放结点也会存在一些时间开销，如果入队出队频繁，则两者还是有细微差异。对于空间上来说，循环队列必须有一个固定的长度，所以就有了存储元素个数和空间浪费的问题。而链队列不存在这个问题，尽管它需要一个指针域，会产生一些空间上的开销，但也可以接受。所以在空间上，链队列更加灵活。
 
 总的来说，在可以确定队列长度最大值的情况下，建议用循环队列，如果你无法预估队列的长度时，则用链队列。
 */
int main(int argc, const char * argv[]) {
    
    SqQueue queque = *(SqQueue *)malloc(sizeof(SqQueue));
    InitQueue(&queque);
    
    EnQueue(&queque, 9);
    EnQueue(&queque, 6);
    
    QElementType e = malloc(sizeof(QElementType));
    DeQueue(&queque, &e);
    printf("e = %d\n",e);
    
    printf("%d\n",QueueLength(queque));
    
    return 0;
}
