//
//  ViewController.swift
//  DatePickerProject
//
//  Created by Casey on 14/11/2018.
//  Copyright © 2018 Casey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        // Do any additional setup after loading the view, typically from a nib.
    }


    
    let datePicker = CaseyDatePicker()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
       //  self.navigationController?.pushViewController(DatePickeTestVC(), animated: true)
        
        datePicker.showDatePicker(true) { (make) -> (Void) in
            print(make)
        }
        
//        if datePicker.superview == nil {
//
//
//            self.view.addSubview(datePicker)
//
//            datePicker.snp.makeConstraints { (make) in
//
//                make.right.left.equalToSuperview()
//                make.bottom.equalToSuperview()
//                make.height.equalTo(233)
//
//            }
//        }

    }
}

