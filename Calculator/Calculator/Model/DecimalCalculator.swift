//
//  DecimalCalculator.swift
//  Calculator
//
//  Created by iluxsm on 2020/12/14.
//

import Foundation

struct DecimalCalculator: Containing {
    var formulaStack = Stack<String>()
    
    func add(_ formula: inout [Double]) -> Double {
        let operand1 = formula.popLast() ?? 0
        let operand2 = formula.popLast() ?? operand1
        return operand1 + operand2
    }
    
    func subtract(_ formula: inout [Double]) -> Double {
        let operand1 = formula.popLast() ?? 0
        let operand2 = formula.popLast() ?? operand1
        return operand2 - operand1
    }
    
    func multiply(_ formula: inout [Double]) -> Double {
        let operand1 = formula.popLast() ?? 0
        let operand2 = formula.popLast() ?? operand1
        return operand1 * operand2
    }
    
    func divide(_ formula: inout [Double]) -> Double {
        let operand1 = formula.popLast() ?? 0
        let operand2 = formula.popLast() ?? operand1
        
        return operand1 != 0 ? operand2 / operand1 : Double.infinity
    }
    
    mutating func sum() -> Double {
        return calculatePostfix()
    }
    
    mutating func clear() {
        formulaStack.storage.removeAll()
    }
}

//MARK:- Extensions
extension DecimalCalculator {
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
            if Double(element) != nil {
                postfixFormula.append(element)
            } else {
                checkPrioritize(temporaryStack: &temporaryStorage, formulaStack: &postfixFormula, operator: element)
            }
        }
        while !temporaryStorage.isEmpty {
            postfixFormula.append(temporaryStorage.popLast() ?? "")
        }
        return postfixFormula
    }
    
    private mutating func checkPrioritize(temporaryStack: inout [String], formulaStack: inout [String], `operator`: String) {
        if !temporaryStack.isEmpty && prioritize(temporaryStack.last ?? "") >= prioritize(`operator`) {
            formulaStack.append(temporaryStack.removeLast())
            if prioritize(`operator`) > prioritize(temporaryStack.last ?? "") {
                temporaryStack.append(`operator`)
            } else {
                formulaStack.append(temporaryStack.popLast() ?? "")
                temporaryStack.append(`operator`)
            }
        }
        temporaryStack.append(`operator`)
    }
    
    private mutating func calculatePostfix() -> Double {
        let formula = convertInfixToPostfix()
        var typeConvertedPostfixFormula: [Double] = []
        
        for element in formula {
            if let number = Double(element), Double(element) != nil {
                typeConvertedPostfixFormula.append(number)
            } else {
                switch element {
                case "+":
                    typeConvertedPostfixFormula.append(add(&typeConvertedPostfixFormula))
                case "-":
                    typeConvertedPostfixFormula.append(subtract(&typeConvertedPostfixFormula))
                case "*":
                    typeConvertedPostfixFormula.append(multiply(&typeConvertedPostfixFormula))
                case "/":
                    typeConvertedPostfixFormula.append(divide(&typeConvertedPostfixFormula))
                default:
                    break
                }
            }
        }
        return typeConvertedPostfixFormula.last ?? Double.nan
    }
}
