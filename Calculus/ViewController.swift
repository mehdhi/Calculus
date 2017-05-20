//
//  ViewController.swift
//  Calculus
//
//  Created by Mehdhi Nawaz on 5/13/17.
//  Copyright © 2017 Mehdhi Nawaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelDisplay: UILabel!
    
    var calcEngine :CalculatorEngine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if self.calcEngine == nil {
            self.calcEngine = CalculatorEngine()
        }
    }
    
    var userHasStartedTyping = false
    
    @IBAction func digitPressed(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        print("digit pressed = "  + digit )
        if userHasStartedTyping {
            labelDisplay.text = labelDisplay.text! + "\(digit)"
        } else {
            labelDisplay.text = digit
            userHasStartedTyping = true;
        }
        
    }
    
    var displayValue : Double {
        get {
            return ( NumberFormatter().number( from: labelDisplay.text! )?.doubleValue )!
        }
        set ( newValue ){
            labelDisplay.text = "\(newValue)"
        }
    }
    
    @IBAction func operation(_ sender: UIButton) {
        
        let operation = sender.currentTitle!
        
        if userHasStartedTyping {
            enter()
        }
        
        self.displayValue = (self.calcEngine?.operate( operation: operation ))!
        
        enter()
        
        
    }
    
    @IBAction func enter() {
        print( "Pressed Enter")
        self.userHasStartedTyping = false;
        self.calcEngine!.operandStack.append( displayValue )
        
        print( "Operand Stack on engine = \(self.calcEngine!.operandStack)")
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

