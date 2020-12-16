//
//  Protocol.swift
//  Calculator
//
//  Created by iluxsm on 2020/12/14.
//

import Foundation

protocol Containing {
    associatedtype T
    func add(_ formula: inout [T]) -> T
    func subtract(_ formula: inout [T]) -> T
    mutating func sum() -> T
    
    mutating func clear()
}
