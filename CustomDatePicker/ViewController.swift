//
//  ViewController.swift
//  CustomDatePicker
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 Gaooof. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,OEDatePickerDelegate{

    @IBOutlet weak var showTimeLab: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.creatDatePicker()
//        self.creatCustomPicker()
        
        
    
    }
    
    
    func creatDatePicker() {
        // 1.caret datePicker
        let datePickerView = OEDatePicker()
        // 2, set twenthyFourHourMode default is True
        datePickerView.twenthyFourHourMode = false
        // 3.set dateModel  if set twenthyFourHourMode， must before dateModel
        datePickerView.dateModel = OEDatePickerOption.YearMonthDayHourMin
        // 4.set pickerView frame
        datePickerView.frame = CGRectMake(0, 300, self.view.bounds.size.width, 200)
        // 5. set delegate
        datePickerView.delegate = self
        // 6. addSubview
        self.view.addSubview(datePickerView)
    }
    func creatCustomPicker() {
        // 1.caret datePicker
        let datePickerView = OEDatePicker()
        //2 set Model
        datePickerView.dateModel = OEDatePickerOption.Custom
        //3 creat Source
        let city = ["北京","天津","太原","郑州","武汉","火星"]
        let cityPicker = OEPickerTableView(arrValue: city)
        
        let province = ["河北","河南","山西","湖北","湖南","太阳系"]
        let provincePicker = OEPickerTableView(arrValue: province)
        
        datePickerView.pickerViews = [cityPicker,provincePicker]
        
        // 4.set pickerView frame
        datePickerView.frame = CGRectMake(0, 300, self.view.bounds.size.width, 200)
        // 5. set delegate
        datePickerView.delegate = self
        // 6. addSubview
        self.view.addSubview(datePickerView)
        
    }
    // return selectedDate when datePicker select all
    func datePickerDelectDate(selectedDict: Dictionary<OEPickerTableView, String?>, selectedDate: NSDate?) {
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MMM-dd hh:mm aa"
        if (selectedDate != nil){
            print( fmt.stringFromDate(selectedDate!))
            self.showTimeLab.text = fmt.stringFromDate(selectedDate!)
            
        }
        
        print(selectedDict)
    }
    
    
    
    
}