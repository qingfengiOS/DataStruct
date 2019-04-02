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
    
    private var head = Node<Element>() //表头节点不存储元素,减少边界情况的处理
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
}

var list: LinkList<Int> = LinkList()
list.insertToHead(node: Node(4))
list.insertToHead(node: Node(3))
list.insertTohead(value: 2)
list.insertTohead(value: 1)

print(list.size)

let value1 = list.accessValue(by: 2)
print(value1?.value as Any)

let node1 = list.findNode(by: 3)
print(node1?.value ?? 0)

list.delete(node: node1!)
print(list.size)

list.deleteNode(by: 2)
print(list.size)

