//
//  ViewController.swift
//  A317選擇題作業
//
//  Created by 范博勝 on 2018/5/4.
//  Copyright © 2018年 范博勝. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var questionNumber: UILabel!
    
    @IBOutlet weak var Question: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    
    
    @IBOutlet weak var Next: UIButton!
    
    
    @IBOutlet weak var Playagain: UIButton!
    //下一題按鈕
    @IBAction func next(_ sender: UIButton) {
    Next.isHidden = true
        //顏色初始化
        for i in 0..<buttons.count{
        buttons[i].backgroundColor = UIColor.yellow
            }
        
        showQuestion()
    }
    
    //再玩一次按鈕
    @IBAction func playagain(_ sender: UIButton) {
        initialize()
        
        //hide the play_again button
        Playagain.isHidden = true
    }
    
    
    @IBAction func Speak(_ sender: UIButton) {
      let now = Question.text!
        
        let speechUtterance =  AVSpeechUtterance(string: now)
        let synth = AVSpeechSynthesizer()
        synth.speak(speechUtterance)
        
        //let speechUtterance =  AVSpeechUtterance(string: "In 2045 there’s nowhere left to go, nowhere, except The Oasis.")
        
    }
    
    
    struct QandA
    {
        var question:String
        var choice:[String]=[]
        var answer:String
    }
    
    var number = [0,1,2,3,4,5,6,7,8,9]
    var question_count = 0
    var score = 0
    var right_answer = ""
    
    
    var questions = [QandA(question:"assignment",choice:["影印","印刷品","分配，工作，分派","對講機"],answer:"分配，工作，分派"),
        QandA(question:"bulletin",choice:["接待員","秘書","訂書機","公告，告示，定期報告書"],answer:"公告，告示，定期報告書"),
        QandA(question:"calculator",choice:["文件，證件","計算器","對講機","秘書"],answer:"計算器"),
        QandA(question:"carbon copy",choice:["分機(電話)，延期","用複寫紙複製的副本","接待員","遲緩，遲到的，延遲的"],answer:"用複寫紙複製的副本"),
        QandA(question:"colleague",choice:["影印","同事，同僚","打字員","分機(電話)，延期"],answer:"同事，同僚"),
        QandA(question:"document",choice:["文件，證件","計算器","分配，工作，分派","對講機"],answer:"文件，證件"),
        QandA(question:"extension",choice:["同事，同僚","打字員","分機(電話)，延期","文件，證件"],answer:"分機(電話)，延期"),
        QandA(question:"intercom",choice:["公報，告示，定期報告書","對講機","印刷品","加班的時間"],answer:"對講機"),
        QandA(question:"memo",choice:["接線員","訂書機","用複寫紙複製的副本","便條，便箋，備忘錄"],answer:"便條，便箋，備忘錄"),
        QandA(question:"operator",choice:["接線員","速記，速記法","用複寫紙複製的副本","遲緩，遲到的，延遲的"],answer:"接線員")
    
    ]
    
    
    @IBAction func choose(_ sender: UIButton) {
        //正確答案的選項變成綠色
        for i in 0..<buttons.count{
            if buttons[i].currentTitle == right_answer{
                buttons[i].backgroundColor = UIColor.green
            }
            
        }
        
        if sender.currentTitle == right_answer
        {
            score = score + 10
        }
        
        if question_count == 10
        {
        show_alertController()
            //show out play_again button
        Playagain.isHidden = false
        }
        else
        {
            Next.isHidden = false
            //continue showing question
            
        }
    
    }
    
    
    //顯示題目
    func showQuestion()
    {
        question_count = question_count + 1
     //選出一個number陣列中的位置
        let random_number = Int(arc4random_uniform(UInt32(number.count)))
     //取得陣列中的題號
        let value = number[random_number]
        
        questionNumber.text = "第\(question_count)題"
        Question.text = questions[value].question
        right_answer = questions[value].answer
        
        number.remove(at: random_number)
        //移除number陣列中已經用過的
        
        var choice_index = [0,1,2,3]
        for i in 0..<buttons.count
        {
            let random_number_for_choice_index = Int(arc4random_uniform(UInt32(choice_index.count)))
            let choice_value = choice_index[random_number_for_choice_index]
          
            //1.2.3.4號按鈕輪流設定內容
            buttons[i].setTitle(questions[value].choice[choice_value], for: .normal) //隨機放題重點
            choice_index.remove(at: random_number_for_choice_index)
        }
    }
    //秀出分數
    func show_alertController()
    {
        //make an alertController
        let alertController = UIAlertController(
            title: "測驗結束",
            message: "得分為\(score)分(滿分100)",
            preferredStyle: .alert)
        
        //make[確認]button
        let okAction = UIAlertAction(
            title: "確認",
            style: .default,
            handler:{
                (action: UIAlertAction!) -> Void in
        })
        alertController.addAction(okAction)
        
        //show the alertController
        self.present(alertController, animated: true, completion: nil)
    }
    //按再來一次的初始化
    func initialize()
    {
        number = [0,1,2,3,4,5,6,7,8,9]
        question_count = 0
        score = 0
        //選項顏色轉回黃色
        for i in 0..<buttons.count{
            buttons[i].backgroundColor = UIColor.yellow
        }
        showQuestion()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       showQuestion()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

