//
//  ViewController.swift
//  Algebra Addition
//
//  Created by Ricardo Perez on 1/18/17.
//  Copyright © 2017 Ricardo Perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblTitleOUTLET: UILabel!
    @IBOutlet weak var lblQuestionOUTLET: UILabel!
    @IBOutlet weak var txtInputOUTLET: UITextField!
    @IBOutlet weak var btnCheckAnswerOUTLET: UIButton!
    @IBOutlet weak var lblRightOrWrongOUTLET: UILabel!
    @IBOutlet weak var lblProgressOUTLET: UILabel!
    
    var randomNumber : Int?
    var lastRandomNumber : Int?
    var correctAnswer : Int?
    var progress : Int = 0
    var difficulty : String = "easy"
    var userAnswer : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        chooseQuestionNumbers(difficultyLevel: "easy")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func checkAnswerACTION(_ sender: UIButton) {
        if let _ = Int(txtInputOUTLET.text!){
            userAnswer = Int(txtInputOUTLET.text!)
            checkIfCorrect()
        }
        txtInputOUTLET.text?.removeAll()
    }
    
    //1 + x = rn
    //x = rn -1
    func chooseQuestionNumbers(difficultyLevel: String){
        switch difficultyLevel {
        case "easy":
            randomNumber = 1 + Int(arc4random_uniform(4))
            if(randomNumber == lastRandomNumber){
                chooseQuestionNumbers(difficultyLevel: "easy")
            }
        case "medium":
            randomNumber = 5 + Int(arc4random_uniform(4))
            if(randomNumber == lastRandomNumber){
                chooseQuestionNumbers(difficultyLevel: "medium")
            }
        case "hard":
            randomNumber = 9 + Int(arc4random_uniform(13))
            if(randomNumber == lastRandomNumber){
                chooseQuestionNumbers(difficultyLevel: "hard")
            }
        default:
            break
        }
        
        lastRandomNumber = randomNumber
        correctAnswer = randomNumber! - 1
        lblQuestionOUTLET.text = "1 + x = "+String(randomNumber!)
    }
    
    func checkIfCorrect(){
        if(userAnswer! == correctAnswer!){
            progress += 1
            lblRightOrWrongOUTLET.text = "Correct!"
            lblRightOrWrongOUTLET.backgroundColor = UIColor.green
            if(progress == 4){
                switch difficulty {
                case "easy":
                    difficulty = "medium"
                    lblRightOrWrongOUTLET.text = "Correct! Onto medium questions"
                    progress = 0
                case "medium":
                    difficulty = "hard"
                    lblRightOrWrongOUTLET.text = "Correct! Onto hard questions"
                    progress = 0
                default:
                    break
                }

            }
        }else{
             lblRightOrWrongOUTLET.text = "Incorrect"
            lblRightOrWrongOUTLET.backgroundColor = UIColor.red
        }
        lblProgressOUTLET.text = String(progress)+"/4 - "+difficulty
        chooseQuestionNumbers(difficultyLevel: difficulty)
    }
}

