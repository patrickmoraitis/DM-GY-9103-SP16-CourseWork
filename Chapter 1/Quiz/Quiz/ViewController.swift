//
//  ViewController.swift
//  Quiz
//
//  Created by Patrick Moraitis on 2/21/16.
//  Copyright © 2016 Patrick Moraitis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        questionLabel.text = questions[currentQuestionIndex]
    }

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    var currentQuestionIndex: Int = 0;
    
    let questions: [String] = [
        "What is olive oil made of?",
        "What is capital of the USA?",
        "What is lucky 7+7+7?"]
    
    let answers: [String] = [
        "olives",
        "DC",
        "21, blackjack"]
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        
        ++currentQuestionIndex
        
        if currentQuestionIndex == questions.count{
            currentQuestionIndex = 0;
        }
        
        let question: String = questions[currentQuestionIndex]
        questionLabel.text = question
        answerLabel.text = "???"
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }

}

