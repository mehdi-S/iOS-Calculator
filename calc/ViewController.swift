//
//  ViewController.swift
//  calc
//
//  Created by Mehdi Silini on 20/05/2016.
//  Copyright © 2016 Mehdi Silini. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operator: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftVal = ""
    var rightVal = ""
    var result = ""
    var currentOperation: Operator = Operator.Empty
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPressed(Btn: UIButton!) {
        playSound()
        
        runningNumber += "\(Btn.tag)"
        outputLabel.text = runningNumber
    }
    @IBAction func onDividePressed(sender: AnyObject) {
        processOp(Operator.Divide)
    }
    
    @IBAction func onMultPressed(sender: AnyObject) {
        processOp(Operator.Multiply)
    }
    
    @IBAction func onSubPressed(sender: AnyObject) {
        processOp(Operator.Subtract)
    }
    
    @IBAction func onPlusPressed(sender: AnyObject) {
        processOp(Operator.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOp(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        playSound()
        runningNumber = ""
        leftVal = ""
        rightVal = ""
        result = ""
        currentOperation = Operator.Empty
        outputLabel.text = "0.0"
    }
    
    func processOp(op: Operator) {
        playSound()
        
        if currentOperation != Operator.Empty {
            if runningNumber != "" {
                rightVal = runningNumber
                runningNumber = ""
                if currentOperation == Operator.Multiply {
                    result = "\(Double(leftVal)! * Double(rightVal)!)"
                } else if currentOperation == Operator.Divide {
                    result = "\(Double(leftVal)! / Double(rightVal)!)"
                } else if currentOperation == Operator.Subtract {
                    result = "\(Double(leftVal)! - Double(rightVal)!)"
                } else if currentOperation == Operator.Add {
                    result = "\(Double(leftVal)! + Double(rightVal)!)"
                }
                
                leftVal = result
                outputLabel.text = result
            }
            currentOperation = op
        }
        else {
            leftVal = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
}

