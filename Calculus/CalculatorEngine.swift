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
    
    var angleInDegree = true;
    
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
                return try self.divide(divisor: self.operandStack.removeLast(), value: 1)
            }
        case "sin":
            if operandStack.count >= 1
            {
                return sin( angle: self.operandStack.removeLast() )
            }
        case "cos":
            if operandStack.count >= 1
            {
                return cos( angle: self.operandStack.removeLast() )
            }
        case "tan":
            if operandStack.count >= 1
            {
                return tan( angle: self.operandStack.removeLast() )
            }
        case "asin":
            if operandStack.count >= 1
            {
                return asin( angle: self.operandStack.removeLast() )
            }
        case "acos":
            if operandStack.count >= 1
            {
                return acos( angle: self.operandStack.removeLast() )
            }
        case "atan":
            if operandStack.count >= 1
            {
                return atan( angle: self.operandStack.removeLast() )
            }
        case "log10":
            if operandStack.count >= 1
            {
                return ( log( self.operandStack.removeLast() ) / log( 10 ) )
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
    
    private func sin( angle :Double ) -> Double {
        return Darwin.sin( getAngleInProperUnit(angle: angle))
    }
    
    private func asin( angle :Double ) -> Double {
        return convertAngleToProperUnits( radian: Darwin.asin( angle ) )
    }
    
    private func cos( angle :Double ) -> Double {
        return Darwin.cos( getAngleInProperUnit(angle: angle))
    }
    
    private func acos( angle :Double ) -> Double {
        return convertAngleToProperUnits( radian: Darwin.acos( angle ) )
    }
    
    private func tan( angle :Double ) -> Double {
        return Darwin.tan( getAngleInProperUnit(angle: angle))
    }
    
    private func atan( angle :Double ) -> Double {
        return convertAngleToProperUnits( radian: Darwin.atan( angle ) )
    }
    
    private func getAngleInProperUnit( angle: Double ) -> Double {
        if angleInDegree {
            return angle * Double.pi / 180
        } else {
            return angle
        }
    }
    
    private func convertAngleToProperUnits( radian :Double ) -> Double {
        if angleInDegree {
            return radian * 180 / Double.pi
        } else {
            return radian
        }
    }
    
    func clearStack()
    {
        operandStack.removeAll();
    }
    
}
