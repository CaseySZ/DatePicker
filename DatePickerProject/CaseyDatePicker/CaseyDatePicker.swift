//
//  CaseyDataPicker.swift
//  DatePickerProject
//
//  Created by Casey on 14/11/2018.
//  Copyright © 2018 Casey. All rights reserved.
//

import UIKit
import SnapKit


extension CaseyDatePicker {
    
    var dataArr: (Array<Array<String>>)   {
        
        get{
            
            return _dataArr
            
        }set{
            
            _defaultStyle = false
            _dataArr = newValue
            _pickerView.reloadAllComponents()
        }
        
    }
    
    
    func showDatePicker(_ animation:Bool, completion:@escaping ((Array<String>)->(Void)))  {
        
        self.removeFromSuperview()
        let window = UIApplication.shared.delegate?.window!!
        self.frame = window!.frame
        self.y = 233
        window!.addSubview(self)
        
        if  animation {
            
            UIView.animate(withDuration: 0.4) {
                
                self.y = 0
            }
            
        }else {
            
            self.y = 0
        }
        
        _completionBlock = completion
    }
    
    
    
    
}

class CaseyDatePicker: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    

    fileprivate var _defaultStyle = true
    
    
    fileprivate var _completionBlock:((_ result:Array<String>)->())?
    
    fileprivate var _dataArr = CaseyDateModel.dateArr()
    fileprivate let _pickerView: UIPickerView = CaseyPickerView()
    private let _topMenuView = CaseyPickerViewMenuView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUIProperty()
        initLayoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func initUIProperty()  {
        
        self.backgroundColor = .clear
        
        _topMenuView.cancelButton.addTarget(self, action: #selector(cancelButtonEvent(_:)), for: .touchUpInside)
        _topMenuView.sureButton.addTarget(self, action: #selector(sureButtonEvent(_:)), for: .touchUpInside)
        _topMenuView.backgroundColor = .white
        self.addSubview(_topMenuView)
        
        _pickerView.delegate = self
        _pickerView.dataSource = self
        _pickerView.showsSelectionIndicator = true
        _pickerView.backgroundColor = .white
        self.addSubview(_pickerView)
        
        _pickerView.selectRow(self.dataArr[0].count-1, inComponent: 0, animated: false)
        
    }
    
    private func initLayoutSubview(){
        
        _pickerView.snp.makeConstraints { (make) in
            
            
            make.right.left.equalToSuperview()
            make.height.equalTo(194)
            make.bottom.equalToSuperview()
        }
        
        _topMenuView.snp.makeConstraints { (make) in
            
            
            make.right.left.equalToSuperview()
            make.bottom.equalTo(_pickerView.snp.top)
            make.height.equalTo(36)
        }
    }
    
    
    //MARK: Button 事件
    
    @objc func cancelButtonEvent(_ sender:UIButton) {
        
        self.removeFromSuperview()
        self._completionBlock = nil
    }
    
    @objc func sureButtonEvent(_ sender:UIButton) {
        
        var selectArr = Array<String>()
        
        for index in 0...self.dataArr.count-1 {
            
            
            let selectRow =  _pickerView.selectedRow(inComponent: index)
            selectArr.append(self.dataArr[index][selectRow])
        }
        
        self._completionBlock?(selectArr)
        self._completionBlock = nil
        
        self.removeFromSuperview()
        
    }
    
    //MARK: UIPickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return dataArr.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component < dataArr.count {
            return dataArr[component].count
        }
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 45
    }
    
    let startViewTag = 100000
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        
        let contentLabel = UILabel()
        contentLabel.backgroundColor = .clear
        contentLabel.font = UIFont.systemFont(ofSize: 18)
        contentLabel.textColor = UIColor.init(rgb:0x333333)
        contentLabel.tag = component*startViewTag + row
        contentLabel.textAlignment = .center
        
        contentLabel.x = 0
        contentLabel.y = 0
        contentLabel.width = UIScreen.main.bounds.size.width/CGFloat(dataArr.count)
        contentLabel.heigth = 45
        contentLabel.text = dataArr[component][row]
        
        return contentLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if _defaultStyle && (component == 1 || (component == 0 && pickerView.selectedRow(inComponent: 1) == 1)){
            
            let yearIndex = pickerView.selectedRow(inComponent: 0)
            let years = Int(dataArr[0][yearIndex]  )
            
            let monthIndex = pickerView.selectedRow(inComponent: 1)
            let month = Int(dataArr[1][monthIndex])
            
            let daysArr = CaseyDateModel.daysArrOfMonth(month!, year: years!)
            
            dataArr.removeLast()
            dataArr.append(daysArr)
            
            pickerView.reloadComponent(2)
            
        }
        
    }

    
}


fileprivate class CaseyPickerView: UIPickerView {
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        for view in self.subviews {
            
            if view.heigth == 0.5 {
                
                view.backgroundColor = UIColor.init(rgb: 0xDADADA)
            }
        }
        
    }
    
}


// 顶部菜单view
fileprivate class CaseyPickerViewMenuView: UIView {
    
    
    let cancelButton = UIButton()
    let sureButton = UIButton()
    let _bottomLineView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUIProperty()
        initLayoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func initUIProperty()  {
        
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor.init(rgb: 0x333333), for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(cancelButton)
        
        sureButton.setTitle("确定", for: .normal)
        sureButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        sureButton.setTitleColor(UIColor.init(rgb: 0x333333), for: .normal)
        self.addSubview(sureButton)
        
        _bottomLineView.backgroundColor = UIColor.init(rgb: 0xDADADA)
        self.addSubview(_bottomLineView)
        
    }
    
    private func initLayoutSubview(){
        
        cancelButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(60)
        }
        
        sureButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(60)
        }
        
        _bottomLineView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.right.left.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
}

