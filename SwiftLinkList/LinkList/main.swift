//
//  main.swift
//  LinkList
//
//  Created by qingfengiOS on 2018/8/23.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

import Foundation

class Node<T> {
    var value: T?
    var next: Node?

    init() {}
    
    init(_ value: T) {
        self.value = value
    }
}


/// 单链表
class LinkList<Element: Equatable> {
    
    var head = Node<Element>() //表头节点不存储元素,减少边界情况的处理
    var size:Int {
        var count = 0
        var temp = head.next //表头节点不存储元素,所以从head开始
        while temp != nil {
            count += 1
            temp = temp?.next
        }
        return count
    }
    
    init() {}
    
    
    /// 插入节点到表头
    ///
    /// - Parameter node: 待插入节点
    func insertToHead(node: Node<Element>) {
        node.next = head.next
        head.next = node
    }
    
    
    /// 插入节点的值到表头
    ///
    /// - Parameter value: 节点的值
    func insertTohead(value: Element) {
        let node = Node(value)
        insertToHead(node: node)
    }
    
    
    /// 根据下标获取节点
    ///
    /// - Parameter index: 下标
    func accessValue(by index: Int) -> Node<Element>? {
        var count = 0
        var tempNode = head
        while tempNode.next != nil {
            if count == index {
                return tempNode
            }
            tempNode = tempNode.next!
            count += 1
        }
        return nil
    }

    
    /// 根据值找节点
    ///
    /// - Parameter value: 目标值
    /// - Returns: 节点
    func findNode(by value: Element) -> Node<Element>? {
        var tempNode = head.next
        while tempNode != nil {
            if tempNode?.value == value {
                return tempNode
            }
            tempNode = tempNode?.next
        }
        return nil
    }
    
    
    /// 删除某个节点
    ///
    /// - Parameter node: 目标节点
    func delete(node: Node<Element>) {
        var preNode = head
        var afterNode = head.next
        while afterNode != nil {
            if node === afterNode {
                preNode.next = afterNode?.next
                break
            }
            preNode = afterNode!
            afterNode = afterNode?.next
        }
    }
    
    
    /// 删除指定值的节点
    ///
    /// - Parameter value: 要删除节点的值
    func deleteNode(by value: Element) {
        var preNode = head
        var afterNode = head.next
        while afterNode != nil {
            if afterNode?.value == value {
                preNode.next = afterNode?.next
                break
            }
            preNode = afterNode!
            afterNode = afterNode?.next
        }
    }
    
    
    /// 反转链表
    ///
    /// - Parameter head: 表头节点
    func reverseList(head: Node<Element>) -> Node<Element>? {
        var reversedHead: Node<Element>?
        var currentNode: Node<Element>?
        var preNode: Node<Element>?
        
        currentNode = head
        while currentNode != nil {
            let nextNode = currentNode!.next
            if nextNode == nil {
                reversedHead = currentNode
            }
            currentNode?.next = preNode
            preNode = currentNode
            currentNode = nextNode
        }
        return reversedHead
    }
    
    
    /// 链表环检测
    ///
    /// - Parameter head: 头部节点
    /// - Returns: 是否有环
    func hasCircle(head: Node<Element>) -> Bool {
        var fast: Node<Element>? = head
        var slow: Node<Element>? = head
        
        while fast != nil {
            if fast === slow {
                return true
            }
            fast = fast?.next?.next
            slow = slow?.next!
        }
        return false
    }

    /// 寻找中间节点
    ///
    /// - Parameter head: 表头
    /// - Returns:  中间节点
    func halfNodeInList(head: Node<Element>) -> Node<Element>? {
        var slow: Node<Element>? = head
        var fast: Node<Element>? = head

        while fast?.next != nil && fast?.next?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
        }
        return slow
        
    }
}



var list: LinkList<Int> = LinkList()
list.insertToHead(node: Node(5))
list.insertToHead(node: Node(4))
list.insertToHead(node: Node(3))
list.insertTohead(value: 2)
list.insertTohead(value: 1)

print(list.size)

print(list.halfNodeInList(head: list.head)?.value ?? 0)//中间节点

let value1 = list.accessValue(by: 2)
print(value1?.value as Any)

let node1 = list.findNode(by: 3)
print(node1?.value ?? 0)

list.delete(node: node1!)
print(list.size)

list.deleteNode(by: 2)
print(list.size)

let newHead = list.reverseList(head: list.head)
print(newHead?.value as Any)

