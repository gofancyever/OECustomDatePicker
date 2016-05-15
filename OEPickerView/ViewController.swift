//
//  ViewController.swift
//  OEPickerView
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 Gaooof. All rights reserved.
//

import UIKit

@objc class ViewController: UIViewController,OEPickerViewDataSource,OEPickerViewDelegate{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        datePicker()
        customPicker()
    }
    
    func datePicker() {
        
        // 1 custom theme
        let theme = Theme(pickerCellBackgroundColor: UIColor.whiteColor(), pickerSelectedColor: UIColor.redColor(), pickerCellTextDefaultColor: UIColor.grayColor(), pickerCellTextHeighlightColor: UIColor.yellowColor(), pickercellTextFontSize: 17)
        
        // 2 creat pickerView
        let pickerView = OEPickerView()
        
        // 3 set theme
        pickerView.theme = theme
        
        // 4 set delegate and dataSource
        pickerView.delegate = self
        
        // 4.1 caret OEDatePicker object
        let dateDataSource = OEDatePicker(OEDatePickerModal: OEDatePickerOption.HourMin, twenthyFourHourMode: true)
        
        // 4.2 set dataSource is OEDatePicker object
        pickerView.dataSource = dateDataSource
        
        // 5 frame
        pickerView.frame = CGRectMake(0, 100, self.view.frame.size.width, 300)
        self.view.addSubview(pickerView)
    }
    
    var arr = Array<AnyObject>()
    func customPicker() {
        let color = ["red","yellow","blue","green","e..."]
        let num = ["1","2","3","4","5"]
        arr = [color,num]
        
        // 1 creat pickerView
        let pickerView = OEPickerView()
        
        // 2 set delegate and dataSource
        pickerView.delegate = self
        
        // 3 set dataSource is self need 
        pickerView.dataSource = self
        
        // 4 frame
        pickerView.frame = CGRectMake(0, 100, self.view.frame.size.width, 300)
        self.view.addSubview(pickerView)
    }
    
    
    //MARK: pickerViewDataSource
    func pickerViewNumberOfColumns() -> Int {
        return arr.count
    }
    
    /** pickerTableView dataSource need an array of data in each row  */
    func pickerViewForColumnSource(indexPath: NSIndexPath) -> Array<AnyObject>{
        return arr[indexPath.section] as! Array<AnyObject>
    }

    
    
    //MARK: pickerViewDelegate
    func pickerView(pickerView: OEPickerTableView?, didSelectPickerViewRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    func pickerView(selectDate date: NSDate) {
        print(date)
    }
    
    
    

}

