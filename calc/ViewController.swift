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
    
    @objc var btnSound: AVAudioPlayer!
    @objc var runningNumber = ""
    @objc var leftVal = ""
    @objc var rightVal = ""
    @objc var result = ""
    var currentOperation: Operator = Operator.Empty
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPressed(_ Btn: UIButton!) {
        playSound()
        
        runningNumber += "\(Btn.tag)"
        outputLabel.text = runningNumber
    }
    @IBAction func onDividePressed(_ sender: AnyObject) {
        processOp(Operator.Divide)
    }
    
    @IBAction func onMultPressed(_ sender: AnyObject) {
        processOp(Operator.Multiply)
    }
    
    @IBAction func onSubPressed(_ sender: AnyObject) {
        processOp(Operator.Subtract)
    }
    
    @IBAction func onPlusPressed(_ sender: AnyObject) {
        processOp(Operator.Add)
    }
    
    @IBAction func onEqualPressed(_ sender: AnyObject) {
        processOp(currentOperation)
    }
    
    @IBAction func onClearPressed(_ sender: AnyObject) {
        playSound()
        runningNumber = ""
        leftVal = ""
        rightVal = ""
        result = ""
        currentOperation = Operator.Empty
        outputLabel.text = "0.0"
    }
    
    func processOp(_ op: Operator) {
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
    
    @objc func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
}

