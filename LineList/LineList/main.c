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
/**
 线性表的单链表存储结构
 */
typedef struct Node {
    ElementType data;
    struct Node *next;
}Node;
typedef struct Node *LinkList;

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


#pragma mark - 静态链表
/*
 用数组描述的链表叫做静态链表，这种描述方法还有起名叫做游标实现法
 */
#define MSIZE 1000
typedef struct {
    ElementType data;
    int current;//游标，为0的时候表示无指向
} Component,StaticLinkList[MSIZE];

/* 将一维数组space中各分量链成一备用链表， */
Status InitList(StaticLinkList space) {
    int i;
    for (i = 0; i < MSIZE - 1; i++) {
        space[i].current = i + 1;
    }
    //目前静态链表为空，最后一个元素的cur为0
    space[MSIZE - 1].current = 0;
    return OK;
}

/*为了辨明数组中哪些分量未被使用，解决的办法是将所有未被使用过的及已被删除的分量用游标链成一个备用的链表，每当进行插入时，便可以从备用链表上取得第一个结点作为待插入的新结点。
 */

/**
 若备用空间链表非空，则返回分配的节点下标，否则返回0
 */
int Malloc_SLL(StaticLinkList space) {
    //当前数组第一个元素的cur存的值就是要返回的第一个备用空闲的下标
    int i = space[0].current;
    
    //由于要拿出一个分量来使用，所以把它下一个分量用做备用
    if (space[0].current) {
        space[0].current = space[i].current;
    }
    return i;
}

/* 初始条件：静态链表L已存在。操作结果：返回L
  中数据元素个数 */
int ListLength(StaticLinkList L) {
    int j = 0;
    int i = L[MSIZE - 1].current;
    while (i){
        i = L[i].current;
        j++;
    }
    return j;
}

/*在L中的第i个元素之前插入新的元素e*/
Status StaticListInsert(StaticLinkList L, int i, ElementType e) {
    int j, k, l;
    //注意k首先是最后一个元素的下标
    k = MSIZE - 1;
    if (i < 1 || i > ListLength(L) + 1) {//下标非法，无法插入
        return ERROR;
    }
    //获取空闲分量下标的
    j = Malloc_SLL(L);
    if (j) {
        //将数据赋值给这个分量的data
        L[j].data = e;
        //找到第i个元素之前的位置
        for (l = 1; l < i - 1; l++) {
            k = L[k].current;
        }
        L[j].current = L[k].current;
        L[k].current = j;
        return OK;
    }
    
    return ERROR;
}

/* 将下标为k的空闲结点回收到备用链表 */
void Free_SSL(StaticLinkList space, int k) {
    /* 把第一个元素cur值赋给要删除的分量cur */
    space[k].current = space[0].current;
    /* 把要删除的分量下标赋值给第一个元素的cur */
    space[0].current = k;
}

Status StaticListDelete(StaticLinkList L, int i) {
    int j,k;
    if (i < 1 || i > ListLength(L)) {
        return ERROR;
    }
    
    k = MSIZE - 1;
    for (j = 1; j <= i; j++) {
        k = L[k].current;
    }
    j = L[k].current;
    L[k].current = L[j].current;
    Free_SSL(L, j);
    return OK;
}
/*
 总的来说，静态链表其实是为了给没有指针的高级语言设计的一种实现单链表能力的方法。尽管大家不一定会用得上，但这样的思考方式是非常巧妙的，应该理解其思想，以备不时之需。
 */


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
