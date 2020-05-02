//
//  ViewController.swift
//  Calulatrice RPN
//
//  Created by David Fahed on 30/06/2018.
//  Copyright © 2018 David Fahed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pile = Array<Double>()
    var pileOld = Array<Double>()
    var sto : Double = 0.0
    var cap : Double = 0.0
    var inter : Double = 0.0
    var t1 : Double = 0.0
    var n: Double = 0.0
    var amort: Double = 0.0
    var nbr1: Double = 0
    var nbr2: Double = 0
   
    @IBOutlet weak var screen: UILabel!
    @IBOutlet weak var screen1: UILabel!
    @IBOutlet weak var screen2: UILabel!
    @IBOutlet weak var screen3: UILabel!
    
    @IBAction func zeroDigit() {
        addScreenDigit(value: "0")
    }
    @IBAction func oneDigit() {
        addScreenDigit(value: "1")
    }
    @IBAction func twoDigit() {
        addScreenDigit(value: "2")
    }
    @IBAction func threeDigit() {
        addScreenDigit(value: "3")
    }
    @IBAction func fourDigit() {
        addScreenDigit(value: "4")
    }
    @IBAction func fiveDigit() {
        addScreenDigit(value: "5")
    }
    @IBAction func sixDigit() {
        addScreenDigit(value: "6")
    }
    
    @IBAction func sevenDigit() {
        addScreenDigit(value: "7")
    }
    @IBAction func heightDigit() {
        addScreenDigit(value: "8")
    }
    
    @IBAction func nineDigit() {
        addScreenDigit(value: "9")
    }
    
    @IBAction func point() {
        addScreenDigit(value: ".")
    }
    
    @IBAction func enterDigit() {
        if screen.text != "" {
            addPile()
           
        } else if pile.count >= 1 {
            pileOld = pile.map {$0}
             pile.append(pile[pile.count - 1])
        }
         affichePile()
    }
    
    @IBAction func deletePile() {
        if screen.text != "" {
            screen.text = ""
            affichePile()
            
        } else {
            if pile.count > 0 {
                pile.remove(at: pile.count - 1)
                nbr1 = 0
                nbr2 = 0
                affichePile()
            } else {
                nbr1 = 0
                nbr2 = 0
                affichePile()
            }
            pileOld = pile.map{$0}
        }
        
    }
    
    
    
    @IBAction func deleteDigit() {
        delScreenDigit()
    }
    @IBAction func plusDigit() {
        calculateValue(op: "+")
        
    }
    
    @IBAction func minusDigit() {
        calculateValue(op: "-")
    }
    
    @IBAction func multipleDigit() {
        calculateValue(op: "*")
    }
    
    @IBAction func swapPile() {
        if pile.count >= 2 {
            (pile[pile.count-1], pile[pile.count-2]) = (pile[pile.count-2], pile[pile.count-1])
            affichePile()
        }
    }
    
    @IBAction func undoPile() {
        pile = pileOld.map {$0}
        affichePile()
    }
    
    @IBAction func divideDigit() {
        calculateValue(op: "/")
    }
    
    @IBAction func storeValue() {
        
        sto = stockPile()
    
    }
    
    @IBAction func recallValue() {
        pile.append(sto)
        affichePile()
    }
    
    @IBAction func capital() {
        if (cap == 0.0 || (amort != 0.0 && inter != 0.0 && n != 0.0)) && screen.text != "" {
            cap = stockPile()
        } else {
            pile.append(cap)
            affichePile()
        }
    }
    
    @IBAction func interest() {
        if (inter == 0.0 || (amort != 0.0 && cap != 0.0 && n != 0.0)) && screen.text != "" {
             inter = stockPile()
        } else {
            pile.append(inter)
            affichePile()
        }
    }
    
    @IBAction func monthNbr() {
        if (n == 0.0 || (amort != 0.0 && cap != 0.0 && inter != 0.0)) && screen.text != "" {
        n = stockPile()
        } else {
            pile.append(n)
            affichePile()
        }
    }
    
    @IBAction func amortissement() {
        if cap != 0.0, inter != 0.0, n != 0.0 {
            t1 = inter / 1200
            amort = (cap * t1) / (1 - pow((1 + t1),-n))
            pile.append(amort)
            affichePile()
        }
        }
    
    @IBAction func resetFinancial() {
        cap = 0.0
        inter = 0.0
        n = 0.0
        amort = 0.0
    }
    
    @IBAction func unOverX() {
        calculateOneParameter(op: "1/x")
    }
    
    @IBAction func yPowerX() {
        calculateValue(op: "y^x")
    }
    
    @IBAction func squareX() {
        calculateOneParameter(op: "sqr")
    }
    
    
    @IBAction func pourcentagePlus() {
        calculateValue(op: "%+")
    }
    
    
    @IBAction func pourcentageMoins() {
        calculateValue(op: "%-")
    }
    
    func calError (errorMsg: String) {
        screen.text = ""
        screen1.text = errorMsg
        
    }
    
    func stockPile() -> Double {
        if screen.text != "" {
            let nbrString1 = screen.text!
            if let nbr1 = Double(nbrString1) {
                pile.append(nbr1)
                affichePile()
                return (nbr1)
            }
        } else if pile.count >= 1 {
            return(pile.last!)
        }
        return (0.0)
    }
    
    func addScreenDigit(value: String) {
        screen.text = screen.text! + value
        
    }
    
    func addPile () {
        if screen.text != "" {
            let nbrString1 = screen.text!
            if let nbr1 = Double(nbrString1) {
                pileOld = pile.map {$0}
                pile.append(nbr1)
                
            }
        }
    }
    
    func calculateValue (op: String) {

        if pile.count >= 1, (screen.text != "" || pileOld.count >= 1) {
                addPile()
                affichePile()
                if pile.count >= 2 {
                    pileOld = pile.map {$0}
                    nbr1 = pile.popLast()!
                    nbr2 = pile.popLast()!
                } else if pileOld.count <= 1 {
                    pileOld = pile.map {$0}
                    pileOld.append(nbr1)
                } else {
                    nbr2 = pile.popLast()!
                    
                }
            
                if op == "+" {
                    pile.append(nbr2+nbr1)
                    affichePile()
                }
                if op == "-" {
                    pile.append(nbr2-nbr1)
                    affichePile()
                }
                if op == "*" {
                    pile.append(nbr2*nbr1)
                    affichePile()
                }
                if op == "/" {
                    pile.append(nbr2/nbr1)
                    affichePile()
                }
                if op == "y^x" {
                    pile.append(pow(nbr2, nbr1))
                    affichePile()
                }
                if op == "%+" {
                    pile.append(nbr2+nbr2*nbr1/100)
                    affichePile()
                }
                if op == "%-" {
                    pile.append(nbr2-nbr2*nbr1/100)
                    affichePile()
                }

        } else {
            calError(errorMsg:"Need two arguments")
        }
    }

    
    func calculateOneParameter (op: String) {
        addPile()
        affichePile()
        pileOld = pile.map {$0}
        let nbr1 = pile.popLast()
        
        if op == "1/x" {
            pile.append(1/nbr1!)
            affichePile()
        }
        
        if op == "sqr" {
            pile.append(pow(nbr1!, 0.5))
            affichePile()
        }
    }
    
    func affichePile() {
        let taillePile = pile.count
        if taillePile >= 3 {
            screen.text = ""
            screen1.text = String(pile[taillePile-1])
            screen2.text = String(pile[taillePile-2])
            screen3.text = String(pile[taillePile-3])
        }
        if taillePile == 2 {
            screen.text = ""
            screen1.text = String(pile[taillePile-1])
            screen2.text = String(pile[taillePile-2])
            screen3.text = ""
        }
        if taillePile == 1 {
            screen.text = ""
            screen1.text = String(pile[taillePile-1])
            screen2.text = ""
            screen3.text = ""
        }
        if taillePile == 0 {
            screen1.text = ""
            screen2.text = ""
            screen3.text = ""
    
        }
        
    }

    func delScreenDigit() {
        if screen.text?.count != 0 {
            screen.text?.removeLast()
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

