//
//  main.swift
//  SwiftStackAndQueue
//
//  Created by 情风 on 2018/8/30.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

import Foundation

//MARK: - 栈
/**
 栈是后进先出的结构。你可以理解成有好几个盘子要垒成一叠，哪个盘子最后叠上去，下次使用的时候它就最先被抽出去。
 在 iOS 开发中，如果你要在你的 App 中添加撤销操作（比如删除图片，恢复删除图片），那么栈是首选数据结构
 无论在面试还是写 App 中，只关注栈的这几个基本操作：push, pop, isEmpty, peek, size。
 */
protocol Stack {
    associatedtype Element
    
    /// 是否为空
    var isEmpty: Bool { get }
    
    /// 栈大小
    var size: Int { get }
    
    /// 栈顶元素
    var peek: Element? { get }
    
    /// 入栈
    ///
    /// - Parameter newElement: 待入栈元素
    mutating func push(_ newElement: Element)
    
    /// 出栈
    ///
    /// - Returns: 栈顶元素
    mutating func pop() -> Element
}

struct IntegerStack: Stack {
    
    private var stack = [Element]()
    
    var isEmpty: Bool {
        return stack.isEmpty
    }
    
    var size: Int {
        return stack.count
    }
    
    var peek: Int? {
        return stack.last
    }
    
    
    mutating func push(_ newElement: Int) {
        stack.append(newElement)
    }
    
    mutating func pop() -> Int {
        return stack.popLast()!
    }
    
}

var stack = IntegerStack()
stack.push(0)
stack.push(1)
stack.push(2)//入栈

print(stack.isEmpty)//是否为空

let last = stack.pop()//出栈
print(last)

let peek = stack.peek//栈顶元素
print(peek as Any)

//MARK: - 队列

/*
 队列是先进先出的结构。这个正好就像现实生活中排队买票，谁先来排队，谁先买到票。
 iOS 开发中多线程的 GCD 和 NSOperationQueue 就是基于队列实现的。
 关于队列我们只关注这几个操作：enqueue, dequeue, isEmpty, peek, size。
 */
protocol Queue {
    associatedtype Element
    
    var isEmpty: Bool { get }
    
    var size: Int { get }
    
    var peek: Element { get }
    
    mutating func enqueue(_ newElement: Element)
    
    mutating func dequeue() -> Element?
}

struct IntegerQueue: Queue {
    
    typealias Element = Int
    private var  left = [Element]()
    private var  right = [Element]()
    
    var isEmpty: Bool {
        return left.isEmpty && right.isEmpty
    }
    
    var size: Int {
        return left.count + right.count
    }
    
    var peek: Int {
        return (left.isEmpty ? right.first : left.first)!
    }
    
    mutating func enqueue(_ newElement: Int) {
        right.append(newElement)
    }
    
    mutating func dequeue() -> Int? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        
        return left.popLast()
    }
    
}

print("--------------------------")
var queue = IntegerQueue()
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)
queue.enqueue(4)

print(queue.isEmpty)

print(queue.peek)

print(queue.dequeue() ?? Int())
print(queue.dequeue() ?? Int())


//MARK: - 用栈实现队列
struct MyQueue {

    typealias Element = Int
    
    var stackA: IntegerStack
    var stackB: IntegerStack
    
    var isEmpty: Bool {
        return stackA.isEmpty && stackB.isEmpty
    }
    
    var size: Int {
        return stackA.size + stackB.size
    }
    
    fileprivate mutating func shift () {
        if stackB.isEmpty {
            while !stackA.isEmpty {
                stackB.push(stackA.pop())
            }
        }
    }
    
    var peek: Int {
        mutating get {
            shift();
            return stackB.peek!
        }
    }
    
    mutating func enqueue(_ newElement: Element) {
        stackA.push(newElement)
    }
    
    mutating func dequeue() -> Int {
        shift()
        return stackB.pop()
    }
    
    init() {
        stackA = IntegerStack()
        stackB = IntegerStack()
    }
}
print("--------------------------")
var myQueue = MyQueue()
myQueue.enqueue(1)
myQueue.enqueue(2)
myQueue.enqueue(3)
myQueue.enqueue(4)

print(myQueue.isEmpty)

print(myQueue.peek)

print(myQueue.dequeue())
print(myQueue.dequeue())


//MARK: - 用队列实现栈
struct MyStack {
    var queueA: IntegerQueue
    var queueB: IntegerQueue
    
    init() {
        queueA = IntegerQueue()
        queueB = IntegerQueue()
    }
    
    var isEmpty:Bool {
        return queueB.isEmpty && queueA.isEmpty
    }
    
    var size: Int {
        return queueA.size
    }
    
    mutating func push(object: Int) {
        queueA.enqueue(object)
    }
    
    mutating func pop() -> Int {
        shift()
        let popObject = queueA.dequeue()
        swap()
        return popObject!
    }
    
    var peek: Int? {
        mutating get {
            shift()
            let peekObj = queueA.peek
            queueB.enqueue(queueA.dequeue()!)
            swap()
            return peekObj
        }
    }
    
    mutating func shift() {
        while queueA.size != 1 {
            queueB.enqueue(queueA.dequeue()!)
        }
    }
    
    mutating func swap() {
        (queueA, queueB) = (queueB, queueA)
    }
}

var myStack: MyStack = MyStack()
myStack.push(object: 1)
myStack.push(object: 2)
myStack.push(object: 3)
myStack.push(object: 4)
myStack.push(object: 5)

print(myStack.isEmpty)
print(myStack.peek as Any)
print(myStack.pop())
print(myStack.size)



