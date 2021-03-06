//
//  ViewController.swift
//  Calculus
//
//  Created by Mehdhi Nawaz on 5/13/17.
//  Copyright © 2017 Mehdhi Nawaz. All rights reserved.
//  Index 2013511
//  IIT Part-Time SE - 2013
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelDisplay: UILabel!
    @IBOutlet weak var labelTapeDisplay: UILabel!
    
    @IBOutlet weak var buttonSin: UIButton!
    @IBOutlet weak var buttonCos: UIButton!
    @IBOutlet weak var buttonTan: UIButton!
    
    @IBOutlet weak var buttonRad: UIButton!
    @IBOutlet weak var buttonDeg: UIButton!
    
    var calcEngine :CalculatorEngine?
    var tapeStack :TapeStack?
    
    var functionMode = false
    var userHasStartedTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if self.calcEngine == nil {
            self.calcEngine = CalculatorEngine()
        }
        if self.tapeStack == nil {
            self.tapeStack = TapeStack()
        }
    }
    
    @IBAction func switchAngle(_ sender: UIButton) {
        let angleType = sender.currentTitle!
        if angleType == "rad" {
            highlightAndDisableButtonRad()
            self.calcEngine?.angleInDegree = false
        } else {
            highlightAndDisableButtonDeg()
            self.calcEngine?.angleInDegree = true
        }
    }
    
    private func highlightAndDisableButtonRad(){
        buttonRad.isEnabled = false
        buttonDeg.isEnabled = true
    }
    
    private func highlightAndDisableButtonDeg(){
        buttonRad.isEnabled = true
        buttonDeg.isEnabled = false
    }
    
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
        self.updateTape(key: "AC")
    }
    
    var displayValue : Double {
        get {
            if labelDisplay.text! == "nan" {
                return 0.0;
            }
            return ( NumberFormatter().number( from: labelDisplay.text! )?.doubleValue )!
        }
        set ( newValue ){
            labelDisplay.text = "\(newValue)"
        }
    }
    
    @IBAction func functionKeyPressed() {
        functionMode = !functionMode;
        self.updateButtonOnFunctionMode();
    }
    
    private func updateButtonOnFunctionMode() {
        if functionMode {
            self.buttonSin.setTitle( "asin", for: UIControlState.normal)
            self.buttonCos.setTitle( "acos", for: UIControlState.normal)
            self.buttonTan.setTitle( "atan", for: UIControlState.normal)
        } else {
            self.buttonSin.setTitle( "sin", for: UIControlState.normal)
            self.buttonCos.setTitle( "cos", for: UIControlState.normal)
            self.buttonTan.setTitle( "tan", for: UIControlState.normal)
            
        }
    }
    
    @IBAction func piPressed() {
        userHasStartedTyping = true
        self.labelDisplay.text = "\(3.14159265)"
    }
    
    @IBAction func operation(_ sender: UIButton) {	
        
        let operation = sender.currentTitle!
        
        if userHasStartedTyping {
            enter()
        }
        
        updateTape(key: operation)
        
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
        updateTape(key: "±")
    }
    
    @IBAction func enter() {
        if userHasStartedTyping {
            var text = self.labelDisplay.text!
            if text == "3.14159265" {
                text = "π"
            }
            updateTape(key: text)
            updateTape(key: "↵")
        }
        self.userHasStartedTyping = false
        self.calcEngine!.updateStackWithValue(value: displayValue )
        
        print( "Operand Stack on engine = \(self.calcEngine!.operandStack)")
        
    }
    
    private func updateTape( key: String ) {
        self.tapeStack?.push( key: key )
        if key == "AC" {
            tapeStack?.clear()
        }
        updateTapeDisplay()
    }
    
    private func updateTapeDisplay() {
        self.labelTapeDisplay.text = self.tapeStack?.secondaryTape()
        if (self.labelTapeDisplay.text?.isEmpty)! {
            self.labelTapeDisplay.text = "|"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

