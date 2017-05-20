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
    
    func operate( operation: String ) -> Double
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
                return self.operandStack.removeLast() / self.operandStack.removeLast()
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
        default: break
            
        }
        
        return 0.0
    }
    
    
    
}
