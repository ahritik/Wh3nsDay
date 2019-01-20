//
//  SecondViewController.swift
//  Wh3nsDay
//
//  Created by Hritik Arasu on 1/15/19.
//  Copyright © 2019 Hritik Arasu. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    //private var button = _: UIButton
    @IBOutlet weak var first: UIButton?
    @IBOutlet weak var second: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //  let calendarObject = NSCalendar.autoupdatingCurrent
        setup(dayInt: 1, offset: 57*0, numberOfDays: 28)
        
    }
    
    func setup(dayInt: Int, offset: Int, numberOfDays: Int){ //RECURSIVE METHOD
        if dayInt > numberOfDays {
            return
        }
        let offsetX = offset % 399
        let offsetY = Int((offset/399)) * 70
        let dayString =  String(dayInt)
        let btn = UIButton(type: .custom)
        btn.frame = .init(x: 10+offsetX, y: 150 + offsetY, width: 55, height: 60)
        btn.setTitle(dayString, for: .normal)
        btn.backgroundColor = UIColor.blue
        btn.layer.cornerRadius = 15
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        
        // you must call this for rounded corner
        btn.layer.masksToBounds = true
        self.view.addSubview(btn)
        print(offsetX, offsetY, 0%400)
        addTarget(btn: btn, dayInt: dayInt)
        setup(dayInt: dayInt + 1, offset: offset + 57, numberOfDays: numberOfDays        )
    }
    
    @objc func addTarget(btn: UIButton, dayInt: Int) {
        print(btn.titleLabel)
        if dayInt == 1 {
            btn.addTarget(self, action: #selector(pressed1(dayInt: )), for: .touchUpInside)
        }else if dayInt == 2 {
            btn.addTarget(self, action: #selector(pressed2(dayInt: )), for: .touchUpInside)
        }else if dayInt == 3 {
            btn.addTarget(self, action: #selector(pressed3(dayInt: )), for: .touchUpInside)
        }else if dayInt == 4 {
            btn.addTarget(self, action: #selector(pressed4(dayInt: )), for: .touchUpInside)
        }else if dayInt == 5 {
            btn.addTarget(self, action: #selector(pressed5(dayInt: )), for: .touchUpInside)
        }else if dayInt == 6 {
            btn.addTarget(self, action: #selector(pressed6(dayInt: )), for: .touchUpInside)
        }else if dayInt == 7 {
            btn.addTarget(self, action: #selector(pressed7(dayInt: )), for: .touchUpInside)
        }else if dayInt == 8 {
            btn.addTarget(self, action: #selector(pressed8(dayInt: )), for: .touchUpInside)
        }else if dayInt == 9 {
            btn.addTarget(self, action: #selector(pressed9(dayInt: )), for: .touchUpInside)
        }else if dayInt == 10 {
            btn.addTarget(self, action: #selector(pressed10(dayInt: )), for: .touchUpInside)
        }else if dayInt == 11{
            btn.addTarget(self, action: #selector(pressed11(dayInt: )), for: .touchUpInside)
        }else if dayInt == 12 {
            btn.addTarget(self, action: #selector(pressed12(dayInt: )), for: .touchUpInside)
        }else if dayInt == 13 {
            btn.addTarget(self, action: #selector(pressed13(dayInt: )), for: .touchUpInside)
        }else if dayInt == 14 {
            btn.addTarget(self, action: #selector(pressed14(dayInt: )), for: .touchUpInside)
        }else if dayInt == 15 {
            btn.addTarget(self, action: #selector(pressed15(dayInt: )), for: .touchUpInside)
        }else if dayInt == 16 {
            btn.addTarget(self, action: #selector(pressed16(dayInt: )), for: .touchUpInside)
        }else if dayInt == 17 {
            btn.addTarget(self, action: #selector(pressed17(dayInt: )), for: .touchUpInside)
        }else if dayInt == 18 {
            btn.addTarget(self, action: #selector(pressed18(dayInt: )), for: .touchUpInside)
        }else if dayInt == 19 {
            btn.addTarget(self, action: #selector(pressed19(dayInt: )), for: .touchUpInside)
        }else if dayInt == 20 {
            btn.addTarget(self, action: #selector(pressed20(dayInt: )), for: .touchUpInside)
        }else if dayInt == 21 {
            btn.addTarget(self, action: #selector(pressed21(dayInt: )), for: .touchUpInside)
        }else if dayInt == 22 {
            btn.addTarget(self, action: #selector(pressed22(dayInt: )), for: .touchUpInside)
        }else if dayInt == 23 {
            btn.addTarget(self, action: #selector(pressed23(dayInt: )), for: .touchUpInside)
        }else if dayInt == 24 {
            btn.addTarget(self, action: #selector(pressed24(dayInt: )), for: .touchUpInside)
        }else if dayInt == 25 {
            btn.addTarget(self, action: #selector(pressed25(dayInt: )), for: .touchUpInside)
        }else if dayInt == 26 {
            btn.addTarget(self, action: #selector(pressed26(dayInt: )), for: .touchUpInside)
        }else if dayInt == 27 {
            btn.addTarget(self, action: #selector(pressed27(dayInt: )), for: .touchUpInside)
        }else if dayInt == 28 {
            btn.addTarget(self, action: #selector(pressed28(dayInt: )), for: .touchUpInside)
        }else if dayInt == 29 {
            btn.addTarget(self, action: #selector(pressed29(dayInt: )), for: .touchUpInside)
        }else if dayInt == 30 {
            btn.addTarget(self, action: #selector(pressed30(dayInt: )), for: .touchUpInside)
        }else if dayInt == 31 {
            btn.addTarget(self, action: #selector(pressed31(dayInt: )), for: .touchUpInside)
        }
        
    }
    @objc func pressed1(dayInt: Int){openDay(dayInt: 1)}
    @objc func pressed2(dayInt: Int){openDay(dayInt: 2)}
    @objc func pressed3(dayInt: Int){openDay(dayInt: 3)}
    @objc func pressed4(dayInt: Int){openDay(dayInt: 4)}
    @objc func pressed5(dayInt: Int){openDay(dayInt: 5)}
    @objc func pressed6(dayInt: Int){openDay(dayInt: 6)}
    @objc func pressed7(dayInt: Int){openDay(dayInt: 7)}
    @objc func pressed8(dayInt: Int){openDay(dayInt: 8)}
    @objc func pressed9(dayInt: Int){openDay(dayInt: 9)}
    @objc func pressed10(dayInt: Int){openDay(dayInt: 10)}
    @objc func pressed11(dayInt: Int){openDay(dayInt: 11)}
    @objc func pressed12(dayInt: Int){openDay(dayInt: 12)}
    @objc func pressed13(dayInt: Int){openDay(dayInt: 13)}
    @objc func pressed14(dayInt: Int){openDay(dayInt: 14)}
    @objc func pressed15(dayInt: Int){openDay(dayInt: 15)}
    @objc func pressed16(dayInt: Int){openDay(dayInt: 16)}
    @objc func pressed17(dayInt: Int){openDay(dayInt: 17)}
    @objc func pressed18(dayInt: Int){openDay(dayInt: 18)}
    @objc func pressed19(dayInt: Int){openDay(dayInt: 19)}
    @objc func pressed20(dayInt: Int){openDay(dayInt: 20)}
    @objc func pressed21(dayInt: Int){openDay(dayInt: 21)}
    @objc func pressed22(dayInt: Int){openDay(dayInt: 22)}
    @objc func pressed23(dayInt: Int){openDay(dayInt: 23)}
    @objc func pressed24(dayInt: Int){openDay(dayInt: 24)}
    @objc func pressed25(dayInt: Int){openDay(dayInt: 25)}
    @objc func pressed26(dayInt: Int){openDay(dayInt: 26)}
    @objc func pressed27(dayInt: Int){openDay(dayInt: 27)}
    @objc func pressed28(dayInt: Int){openDay(dayInt: 28)}
    @objc func pressed29(dayInt: Int){openDay(dayInt: 29)}
    @objc func pressed30(dayInt: Int){openDay(dayInt: 30)}
    @objc func pressed31(dayInt: Int){openDay(dayInt: 31)}
    func openDay(dayInt: Int){
        print(dayInt)
        //let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EventList") as? EventListViewController
        // self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}

