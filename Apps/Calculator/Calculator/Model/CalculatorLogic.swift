//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Александр on 22.03.2021.
//

import Foundation

struct CalculatorLogic {
    
    private var currentValue: Double?
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ number:Double) {
        currentValue = number
    }
    
    mutating func calculate(with calcMethod: String) -> Double? {
        
        if let n = currentValue {
            
            switch calcMethod {
            case "+/-":
                return n * -1
            case "AC":
                return  0
            case "%":
                return n / 100
            case "=":
                return performTwoNumCalculation(n2: n)
            default:
                intermediateCalculation = (n1: n, calcMethod: calcMethod)
            }
        }
        
        return nil
    }
    
    private func performTwoNumCalculation(n2: Double) -> Double? {
        
        if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.calcMethod {
            
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "X":
                return n1 * n2
            case "÷":
                return n1 / n2
            default:
                fatalError("The operation passed in does not match any of the cases.")
            }
        }
        
        return nil
    }
}
