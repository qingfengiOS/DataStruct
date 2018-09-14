//
//  main.swift
//  SwiftTree
//
//  Created by liyiping on 2018/9/14.
//  Copyright © 2018年 情风. All rights reserved.
//

import Foundation

public class TreeNode {
    public var value: Int
    public var left: TreeNode?
    public var right: TreeNode?
    
    public init (_ value: Int) {
        self.value = value
    }
}


/// 在二叉树中，节点的层次从根开始定义，根为第一层，树中节点的最大层次为树的深度。
///
/// - Parameter root: 树的根节点
/// - Returns: 树的深度
func maxDepth(tree: TreeNode?) -> Int {
    guard let root = tree else {
        return 0
    }
    return max(maxDepth(tree: root.left), maxDepth(tree: root.right))
}


func isValidBST(_ tree: TreeNode?) -> Bool {
    return helper(node: tree, nil, nil)
}

private func helper(node: TreeNode?, _ min: Int?, _ max:Int?) -> Bool {
    
    guard let node = node else {
        return true
    }
    
    // 所有右子节点都必须大于根节点
    if let min = min, node.value < min {
        return false
    }
    
    // 所有左子节点都必须小于根节点
    if let max = max, node.value > max {
        return false
    }
    
    return helper(node: node.left, min, node.value)  && helper(node: node.right, node.value, max)
    
}






