//
//  Stack.swift
//  Calculator
//
//  Created by iluxsm on 2020/12/14.
//

import Foundation

struct Stack<T> {
    var storage: [T] = []
    
    mutating func push(_ value: T) {
        storage.append(value)
    }
    mutating func pop() -> T? {
        return storage.popLast()
    }
}
