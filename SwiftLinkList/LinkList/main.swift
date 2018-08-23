//
//  main.swift
//  LinkList
//
//  Created by qingfengiOS on 2018/8/23.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

import Foundation


/// 单链表的节点
class ListNode {
    var value: Int
    var next: ListNode?
    
    init(_ value: Int) {
        self.value = value
        self.next = nil
    }
}

/// 链表
class List {
    var head: ListNode?
    var tail: ListNode?
    
    /// 尾插法
    ///
    /// - Parameter vlaue: 待插入数据
    func appendToListTail(_ value: Int) {
        if tail == nil {//表尾为空
            tail = ListNode(value)
            head = tail
        } else {
            tail?.next = ListNode(value)//插入值
            tail = tail?.next//修改表尾指针
        }
    }
    
    /// 头插法
    ///
    /// - Parameter vlaue: 待插入数据
    func appendToListHeader(_ value: Int) {
        if head == nil {
            head = ListNode(value)
            tail = head
        } else {
            let newHead = ListNode(value)
            newHead.next = head
            head = newHead
        }
    }
    
    
    /// 访问链表
    ///
    /// - Parameter index: 第几个节点
    /// - Returns: 第index个节点的值
    func accessList(_ index: Int) -> Int? {
     
        if index == 0 {
            return self.head?.value
        }
       
        var i = index
        
        var node = self.head
        while i > 0 {
            node = node?.next
            i -= 1
        }

        
        return node?.value
    }
}

let list = List()

list.appendToListTail(1)
list.appendToListTail(5)
list.appendToListTail(3)
list.appendToListTail(2)
list.appendToListTail(4)
list.appendToListTail(2)

print(list.accessList(3) as Any)


/*
 给一个链表和一个值 x，要求将链表中所有小于 x 的值放到左边，所有大于等于 x 的值放到右边。原链表的节点顺序不能变。
 
 例：1->5->3->2->4->2，给定x = 3。则我们要返回1->2->2->5->3->4
 */

//MARK:- 方案一
/// 寻找链表中数组小于x的节点，并组成新的链表
func getLeftList(_ originList: List?, _ x: Int) -> List {
    let resList = List()
    
    var node = originList?.head
    while node?.next != nil {
        if let idxValue = node?.value  {
            if idxValue < x {
                resList.appendToListTail(idxValue)
            }
            node = node?.next
        }
    }
    
    if (node?.value)! < x {//最后一个节点
        resList.appendToListTail((node?.value)!)
    }
    
    return resList
}

var leftList = getLeftList(list, 3)//链表的左边为1——>2——>2
print(leftList.accessList(2) as Any)

/// 寻找链表中数组大于x的节点，并组成新的链表
func getRightList(_ originList: List?, _ x: Int) -> List {
    let resList = List()
    
    var node = originList?.head
    while node?.next != nil {
        if let idxValue = node?.value  {
            if idxValue >= x {
                resList.appendToListTail(idxValue)
            }
            node = node?.next
        }
    }
    
    if (node?.value)! >= x {//最后一个节点
        resList.appendToListTail((node?.value)!)
    }
    
    return resList
}

let rightList = getRightList(list, 3)//链表的左边为5——>3——>4
print(rightList.accessList(2) as Any)

/// 拼接两个链表为新的链表
func appendList(_ leftList: inout List, _ rightList:List) -> List {
    var node = rightList.head
    while node?.next != nil {
        node = (node?.next)!
        leftList.appendToListTail((node?.value)!)
    }
    
    leftList.appendToListTail((node?.value)!)
    return leftList
}

let resList = appendList(&leftList, rightList)
print(resList.accessList(5) as Any)


//MARK:- 方案二

//处理左边(采用尾插法，遍历链表，将小于 x 值的节点接入新的链表即可)
func getLeftList(_ head: ListNode?, _ x: Int) -> ListNode? {
    let dummy = ListNode(0)
    var pre = dummy
    var node = head
    while node != nil {
        if node!.value < x {
            pre.next = node
            pre = node!.next!
        }
        node = node?.next
    }
    // 防止构成环
    pre.next = nil
    return dummy.next
}

func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
    // 引入Dummy节点
    let prevDummy = ListNode(0), postDummy = ListNode(0)
    var prev = prevDummy, post = postDummy
    
    var node = head
    
    // 用尾插法处理左边和右边
    while node != nil {
        if node!.value < x {
            prev.next = node
            prev = node!
        } else {
            post.next = node
            post = node!
        }
        node = node!.next
    }
    
    // 防止构成环
    post.next = nil
    // 左右拼接
    prev.next = postDummy.next
    
    return prevDummy.next
}
