//
//  CalculatorEngine.swift
//  Calculus
//
//  Created by Mehdhi Nawaz on 5/20/17.
//  Copyright © 2017 Mehdhi Nawaz. All rights reserved.
//

import Foundation
import UIKit

class CalculatorEngine :NSObject
{
    
    var operandStack = Array<Double>()
    
    func updateStackWithValue( value: Double )
    {
        self.operandStack.append( value )
    }
    
    func operate( operation: String ) throws -> Double
    {
        switch operation
        {
        case "×":
            if operandStack.count > 1
            {
                return self.operandStack.removeLast() * self.operandStack.removeLast()
            }
        case "÷":
            if operandStack.count > 1
            {
                return try self.divide(divisor: self.operandStack.removeLast(), value: self.operandStack.removeLast())
            }
        case "+":
            if operandStack.count > 1
            {
                return self.operandStack.removeLast() + self.operandStack.removeLast()
            }
        case "−":
            if operandStack.count > 1
            {
                return self.operandStack.removeLast() - self.operandStack.removeLast()
            }
        case "√":
            if operandStack.count >= 1
            {
                return self.operandStack.removeLast().squareRoot()
            }
        case "x2":
            if operandStack.count >= 1
            {
                let x = self.operandStack.removeLast()
                return   x * x
            }
        case "1/x":
            if operandStack.count >= 1
            {
                return try self.divide(divisor: 1, value: self.operandStack.removeLast())
            }
        case "sin":
            if operandStack.count >= 1
            {
                return sin( self.operandStack.removeLast() )
            }
        case "cos":
            if operandStack.count >= 1
            {
                return cos( self.operandStack.removeLast() )
            }
        case "tan":
            if operandStack.count >= 1
            {
                return tan( self.operandStack.removeLast() )
            }
        case "asin":
            if operandStack.count >= 1
            {
                return asin( self.operandStack.removeLast() )
            }
        case "acos":
            if operandStack.count >= 1
            {
                return acos( self.operandStack.removeLast() )
            }
        case "atan":
            if operandStack.count >= 1
            {
                return atan( self.operandStack.removeLast() )
            }
        case "log10":
            if operandStack.count >= 1
            {
                return log( self.operandStack.removeLast() )
            }
        case "loge":
            if operandStack.count > 1
            {
                return ( log( self.operandStack.removeLast() ) / log( self.operandStack.removeLast() ) )
            }
        default: break
            
        }
        
        return 0.0
    }
    
    private func divide( divisor :Double , value :Double ) throws -> Double {
        if divisor != 0 {
            return value / divisor
        }
        throw NSError(domain:"Cannot Divide by 0", code: 1009, userInfo:nil)
    }
    
    func clearStack()
    {
        operandStack.removeAll();
    }
    
}
