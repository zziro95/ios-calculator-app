//
//  DecimalCalculator.swift
//  Calculator
//
//  Created by iluxsm on 2020/12/14.
//

import Foundation

struct DecimalCalculator: Containing {
    var formulaStack = Stack<String>()
    var operatorStack = Stack<String>()
    
    private func prioritize(_ operator: String) -> Int {
        switch `operator` {
        case "+", "-":
            return 1
        case "*", "/":
            return 2
        default:
            return 0
        }
    }
    
    private mutating func convertInfixToPostfix() -> [String] {
        var postfixFormula: [String] = []
        var temporaryStorage: [String] = []
        
        for element in formulaStack.storage {
            if Double(element) != nil { // 숫자일 때
                postfixFormula.append(element)
            } else { // 연산자일 때
                if !temporaryStorage.isEmpty && prioritize(temporaryStorage.last ?? "") >= prioritize(element) {
                    postfixFormula.append(temporaryStorage.removeLast())
                    if prioritize(element) >= prioritize(temporaryStorage.last ?? "") {
                        postfixFormula.append(temporaryStorage.removeLast())
                        temporaryStorage.append(element)
                    }
                } else {
                    temporaryStorage.append(element)
                }
            }
        }
        while !temporaryStorage.isEmpty {
            postfixFormula.append(temporaryStorage.removeLast())
        }
        
        formulaStack.storage.removeAll()
        
        return postfixFormula
    }
        
    func multiply() {
        
    }
    
    func divide() {
        
    }

    
    func add() {
        <#code#>
    }
    
    func subtract() {
        <#code#>
    }
    
    func sum() {
        <#code#>
    }
    
    func clear() {
        <#code#>
    }
    
}
