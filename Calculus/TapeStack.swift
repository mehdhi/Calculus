//
//  TapeStack.swift
//  Calculus
//
//  Created by Mehdhi Nawaz on 5/22/17.
//  Copyright © 2017 Mehdhi Nawaz. All rights reserved.
//

import Foundation
import UIKit

class TapeStack : NSObject
{
    private var mainStack = Array<String>()
    private var tempStack = Array<String>()
    
    func clearAll() {
        mainStack.removeAll()
        tempStack.removeAll()
    }
    
    func clear() {
        tempStack.removeAll()
    }
    
    func push( key : String ) {
        mainStack.append( key )
        tempStack.append( key )
    }
    
    func pop() -> String {
        tempStack.removeLast()
        return mainStack.removeLast()
    }
    
    func secondaryTape() -> String {
        var text = ""
        for key in tempStack.suffix(10 ) {
            text.append( key + " " )
        }
        return text
    }
    
    func mainTape() -> String {
        var text = ""
        var separator = " "
        for key in mainStack {
            if key == "AC" {
                separator = "\n"
            } else {
                separator = " "
            }
            text.append( key + separator )
        }
        return text
    }
    
}
