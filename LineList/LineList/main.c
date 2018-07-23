//
//  main.c
//  LineList
//
//  Created by 李一平 on 2018/7/23.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

#define MAXSIZE 20
#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0
typedef int Status;

typedef int ElementType;

/**
 线性表的顺序存储结构
 */
typedef struct {
    ElementType data[MAXSIZE];
    int length;
} SqList;



/**
 线性表的单链表存储结构
 */
typedef struct Node {
    ElementType data;
    struct Node *next;
}Node;
typedef struct Node *LinkList;

#pragma mark - 线性表的顺序存储
SqList makeList() {
    SqList list;
    list = *(SqList *)malloc(sizeof(SqList));
    return list;
}

Status GetElement(SqList L, int i, ElementType *e) {
    if (L.length == 0 || i < 1) {
        return ERROR;
    } else {
        *e = L.data[i - 1];
        return OK;
    }
    return ERROR;
}

Status ListInsert(SqList *L, int i, ElementType e) {
    int k ;
    if (L->length == MAXSIZE) {//无空间
        return ERROR;
    }
    if (i < 1 || i > L->length + 1) {//位置不合法
        return ERROR;
    }
    
    L->length++;//扩容
    if (i <= L->length) {//插入位置不在表尾
        for (k = L->length - 1; k >= i; k--) {//从插入位置后面元素后移一位
            L->data[k + 1] = L->data[k];
        }
    }
    L->data[i - 1] = e;//插入新元素
    return OK;
}

Status ListDelete(SqList *L, int i, ElementType *e) {
    if (L->length == 0) {
        return ERROR;
    }
    if (i < 1 || i > L->length) {
        return ERROR;
    }
    int k;
    if (i < L->length) {
        for (k = i; k < L->length; k++) {//从插入位置后面元素后移一位
            L->data[i - 1] = L->data[i];
        }
    }
    L->length--;
    return OK;
}


#pragma mark - 线性表的链式存储
//随机产生n个元素的值，建立带表头结点的单链线性表L（头插法）
LinkList CreateLinkListHead(LinkList *L, int n) {
    
    LinkList p;
    int i;
    *L = (LinkList)malloc(sizeof(Node));
    (*L)->next = NULL;
    for (i = 0; i < n; i++) {
        p = (LinkList)malloc(sizeof(Node));//生成随机节点
        p->data = arc4random_uniform(100);
        p->next = (*L)->next;
        (*L)->next = p;
    }
    return *L;
}

//操作结果：用e返回L中第i个数据元素的值
Status GetlinkElement(LinkList L, int i, ElementType *e) {
    
    int j = 1;
    LinkList p = L->next;
    while (p && j < i) {
        p = p->next;
        j++;
    }
    if (p && j == i) {
        *e = p->data;
        return OK;
    } else {
        return ERROR;
    }
    return OK;
}

/*操作结果：在L中第i个结点位置之前插入新的数据元素e，L的长度加1 */
Status InsertLinkList(LinkList *L, int i, ElementType e) {
    
    int j = 1;
    LinkList p, s;
    p = *L;
    while (p && j < i) {
        p = p->next;
        ++j;
    }
    
    if (!p || j > i) {//第一个节点不存在
        return ERROR;
    }
    s = (LinkList)malloc(sizeof(Node));//生成新节点
    s->data = e;//新节点的值域
    s->next = p->next;//新节点的指针域
    p->next = s;
    return OK;
}

/*操作结果：删除L的第i个结点，并用e返回其值，L的长度减1 */
Status DeleteLinkList(LinkList *L, int i, ElementType *e) {
    
    int j = 1;
    LinkList p, q;
    p = *L;
    //遍历寻找第i-1个节点
    while (p->next && j < i) {
        p = p->next;
        ++j;
    }
    if (!(p->next) || j > i) {
        return ERROR;
    }
    q = p->next;
    p->next = q->next;
    *e = q->data;
    free(q);
    return OK;
}

/*
 整表删除
 1.声明一指针p和q；
 2.将第一个结点赋值给p；
 3.循环：
 
 将下一结点赋值给q；
 释放p；
 将q赋值给p。
 */
Status ClearList(LinkList *L) {
    
    LinkList p, q;
    p = (*L)->next;//p指向第一个节点
    while (p) {//没到表尾
        q = p->next;
        free(p);
        p = q;
    }
    (*L)->next = NULL;
    return OK;
}

#pragma mark - main
int main(int argc, const char * argv[]) {
    
    LinkList L;
    L = CreateLinkListHead(&L, 3);//单链表创建
    
    ElementType e = (ElementType)malloc(sizeof(ElementType));
    GetlinkElement(L, 2, &e);//获取单链表的值
    printf("e = %d\n", e);
    
    printf("insert status = %d\n",InsertLinkList(&L, 1, 9999));//插入9999到第二个位置
    
    printf("delete status = %d\n",DeleteLinkList(&L, 1, &e));//删除插入的9999节点
    
    printf("clear status = %d\n",ClearList(&L));//清空表
    
    return 0;
}
/*
 一些经验性的结论：
 
 若线性表需要频繁查找，很少进行插入和删除操作时，宜采用顺序存储结构。若需要频繁插入和删除时，宜采用单链表结构。比如说游戏开发中，对于用户注册的个人信息，除了注册时插入数据外，绝大多数情况都是读取，所以应该考虑用顺序存储结构。而游戏中的玩家的武器或者装备列表，随着玩家的游戏过程中，可能会随时增加或删除，此时再用顺序存储就不太合适了，单链表结构就可以大展拳脚。当然，这只是简单的类比，现实中的软件开发，要考虑的问题会复杂得多。
 
 当线性表中的元素个数变化较大或者根本不知道有多大时，最好用单链表结构，这样可以不需要考虑存储空间的大小问题。而如果事先知道线性表的大致长度，比如一年12个月，一周就是星期一至星期日共七天，这种用顺序存储结构效率会高很多
 */
