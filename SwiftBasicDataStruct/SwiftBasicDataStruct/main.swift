//
//  main.swift
//  SwiftBasicDataStruct
//
//  Created by qingfeng on 2018/8/7.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

import Foundation

//MARK:- 基本操作
let num1 = [2, 1, 3]
let num2 = [Int]()
let num3 = [Int](repeating: 0, count: 5)
print(num1, num2, num3)

var num4 = [3, 2, 1]
num4.append(4)
print(num4)

//升序排序
num4.sort()
print(num4)

//降序排序
num4.sort { (a, b) -> Bool in
    a > b
}
print(num4)

// 将原数部分元素赋值给另一个数组
var num5 = Array(num4[0...2])
print(num5)

// 把下标为0-1的下标位置设置为8，相应的数组元素会变
num5[0...1] = [8]
print(num5)

//MARK:- 使用数组实现栈
class Stack {
    var stack: [AnyObject] = []
    var isEmpty: Bool { return stack.isEmpty }
    
    init() {
        stack = [AnyObject]()
    }
    
    func push(_ object: AnyObject) {
        stack.append(object)
    }
    
    func pop() -> AnyObject? {
        if !isEmpty {
            return stack.removeLast()
        } else {
            return nil
        }
    }
}

let stack = Stack.init()
stack.push("1" as AnyObject)
stack.push("2" as AnyObject)

print(stack.pop() as Any)
print(stack.pop() as Any)
print(stack.pop() as Any)

//MARK:- 字典和集合
var primeNums: Set = [3, 5, 7, 11, 13]
let oddNums: Set = [1, 3, 5, 7, 9]

let primeAndOddNum = primeNums.intersection(oddNums)
let primeOrOddNum = primeNums.formUnion(oddNums)
let oddNotPrimNum = oddNums.subtracting(primeNums)
print(primeAndOddNum, primeOrOddNum, oddNotPrimNum)

// 用字典和高阶函数计算字符串中每个字符的出现频率，结果 [“h”:1, “e”:1, “l”:2, “o”:1]
let dic = Dictionary("hello".map { ($0, 1) }, uniquingKeysWith: +)
print(dic)

//leetCode twoSum 给一个整型数组和一个目标值，判断数组中是否有两个数字之和等于目标值
func twoSum(nums: [Int], _ target: Int) -> Bool {
    var set = Set<Int>()
    
    for num in nums {
        if set.contains(target - num) {
            return true
        }
        
        set.insert(num)
    }
    
    return false
}

print(twoSum(nums: [1, 2, 3, 4, 5, 6], 6))
