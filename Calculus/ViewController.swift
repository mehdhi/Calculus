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
    
    @IBOutlet weak var labelTapeDisplay: UILabel!
    
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
        
        var digit = sender.currentTitle!
        print("digit pressed = "  + digit )
        if digit == "." && (labelDisplay.text?.contains("."))! {
            return
        }
        if userHasStartedTyping {
            labelDisplay.text = labelDisplay.text! + "\(digit)"
        } else {
            if digit == "." {
                digit = "\(0)."
            }
            labelDisplay.text = digit
            userHasStartedTyping = true;
        }
        
    }
    
    @IBAction func deleteLastCharacter() {
        if (!(labelDisplay.text?.isEmpty)!) {
            let endIndex = labelDisplay.text?.index((labelDisplay.text?.endIndex)!, offsetBy: -1)
            labelDisplay.text = labelDisplay.text?.substring(to: endIndex! )
            if (labelDisplay.text?.isEmpty)! {
                labelDisplay.text = "\(0)"
                userHasStartedTyping = false
            }
        }
    }
    
    @IBAction func clearAll() {
        labelDisplay.text = "\(0)";
        self.calcEngine?.clearStack()
        userHasStartedTyping = false
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
        
        do {
            try self.displayValue = ( self.calcEngine?.operate( operation: operation ))!
        } catch {
            self.labelDisplay.text = "Error"
            userHasStartedTyping = false;
            return
        }
        
        enter()
        
        
    }
    
    @IBAction func inverseValue() {
        if (self.labelDisplay.text?.contains("-"))! {
            self.labelDisplay.text?.remove(at: (self.labelDisplay.text?.startIndex)!)
        } else {
            self.labelDisplay.text = "-" + self.labelDisplay.text!
        }
    }
    
    @IBAction func enter() {
        print( "Pressed Enter")
        self.userHasStartedTyping = false;
        self.calcEngine!.updateStackWithValue(value: displayValue )
        
        print( "Operand Stack on engine = \(self.calcEngine!.operandStack)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

