//
//  ViewController.swift
//  Test_
//
//  Created by Macbook Pro on 5/14/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var guest: UILabel!

    @IBOutlet weak var home: UILabel!
    @IBOutlet weak var homeStepper: UIStepper!
    @IBOutlet weak var guestStepper: UIStepper!
    @IBOutlet weak var changeServeLbl: UILabel!
    
    var scoreCounter = Int() {
        didSet {
//            guard (guestStepper.value <  20  &&  homeStepper.value <  20 )  else {
//                 changeServ()
//                return
//            }
            if guestStepper.value == 22 {
                self.changeServeLbl.text = "Guest is the Winner"
                changeServ(false)
                return
            }else if homeStepper.value == 22 {
                self.changeServeLbl.text = "Home is the Winner"
                changeServ(false)
                return
            }
            if (guestStepper.value >=  20  &&  homeStepper.value >=  20 ) {
                
                changeServ(true)
                return
            }
            if scoreCounter % 5 == 0 {
            changeServ(true)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        guestStepper.autorepeat = true
//        guestStepper.maximumValue = 22
//        guestStepper.minimumValue = 1.0
        print(guestStepper.value)
        guest.text = "\(Int(guestStepper.value))"
//        homeStepper.autorepeat = true
//        homeStepper.maximumValue = 22
//        homeStepper.minimumValue = 1.0
        print(homeStepper.value)
        home.text = "\(Int(homeStepper.value))"
        homeStepper.isContinuous = true
//        scoreCounter = 1
     }
  
    func changeServ(_ gameNotOver : Bool) {
        //                self.home.text = "\(scoreCounter)"
       
        self.view.backgroundColor = UIColor.random
        self.changeServeLbl.backgroundColor = UIColor.random.withAlphaComponent(0.76)
        self.changeServeLbl.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
         UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            
            self.changeServeLbl.alpha = 1
            self.changeServeLbl.transform = .identity
        }, completion: { (_) in
            if gameNotOver {
            UIView.animate(withDuration: 0.3, delay: 0.2, options: [.curveLinear], animations: {
                
                self.changeServeLbl.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.changeServeLbl.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                self.changeServeLbl.alpha = 0
            }){ (_) in
                self.changeServeLbl.alpha = 0
                self.changeServeLbl.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }
        }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var oldStepperValue1 = 0
    var oldStepperValue2 = 0

    
    @IBAction func addScoreBtnAct(_ sender: UIButton) {
        if changeServeLbl.text != "Change Serve" {
            resetGame(nil)
        }
        if sender.tag == 0 {
            homeStepper.value += 1
            counter(homeStepper)
        }else {
            guestStepper.value += 1
            counter(guestStepper)
        }
        
    }
    
    
    @IBAction func counter(_ sender: UIStepper) {
      
        
        if changeServeLbl.text != "Change Serve" {
            resetGame(nil)
        }
        if sender.tag == 0 {
          
            if(Int(sender.value) > oldStepperValue1){
                print("increasing 1 ")
                oldStepperValue1 += 1
                 home.text = "\(Int(oldStepperValue1))"
                if guestStepper.value > 20 {
                    guestStepper.value -= 1
                    oldStepperValue2 -= 1
                    guest.text = "\(Int(oldStepperValue2))"
                }
            }
            else{
                print("decresing 1 ")
                oldStepperValue1 =  oldStepperValue1 - 1
                 home.text = "\(Int(oldStepperValue1))"

            }
        
            
        }else {
            
            if(Int(sender.value) > oldStepperValue2){
                print("increasing 2 ")
                oldStepperValue2 += 1
                if homeStepper.value > 20 {
                    homeStepper.value -= 1
                    oldStepperValue1 -= 1
                    home.text = "\(Int(oldStepperValue1))"
                }
                 guest.text = "\(Int(oldStepperValue2))"
                
            }
            else{
                print("decresing 2 ")
                oldStepperValue2 =  oldStepperValue2 - 1
                 guest.text = "\(Int(oldStepperValue2))"
            }
    }
        scoreCounter = Int((homeStepper.value + guestStepper.value))
        print("that's the oldStepperValue1 :\(oldStepperValue1), oldStepperValue :\(oldStepperValue2) and that's the counter : \(scoreCounter)")

        
    }
    
    func scoreCounter(_ sender : UIStepper , _ counter : inout Int)   {
        if(Int(sender.value) > counter){
             counter += 1
            scoreCounter  = scoreCounter +  1
         }
        else{
             counter =  counter - 1
            scoreCounter  = scoreCounter -  1
         }
            }
    
    func balance() {
        if homeStepper.value == 20 ||   homeStepper.value == 21 {
            
        }
    }

    @IBAction func resetGame(_ sender: UIButton?) {
        
        homeStepper.value = 0
        guestStepper.value = 0
        scoreCounter = 0
        oldStepperValue1 = 0
        oldStepperValue2 = 0
        guest.text = "\(Int(oldStepperValue2))"
        home.text = "\(Int(oldStepperValue1))"
        self.changeServeLbl.alpha = 0
        self.changeServeLbl.text = "Change Serve"
    }
    
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
}



