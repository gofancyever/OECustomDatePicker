//
//  OEDatePicker.swift
//  OEPickerView
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 Gaooof. All rights reserved.
//

import UIKit

enum OEDatePickerOption {
    case YearMonthDayHourMin
    case MonthDayHourMin
    case HourMin
}


class OEDatePicker:OEPickerViewDataSource {
    @objc var pickerArrDataSource: [Array<AnyObject>]?
    var twenthyFourHourMode:Bool?
    init(OEDatePickerModal:OEDatePickerOption,twenthyFourHourMode:Bool) {
        self.twenthyFourHourMode = twenthyFourHourMode
        self.pickerArrDataSource = {
            switch OEDatePickerModal {
            case .YearMonthDayHourMin:
                return [minutes,hours,days,monthes,years]
            case .MonthDayHourMin:
                return [minutes,hours,days,monthes]
            case .HourMin:
                return [minutes,hours]
            }
        }()
        if !twenthyFourHourMode {
            self.pickerArrDataSource!.insert(meridians, atIndex: 0)
        }
    }
    
    @objc func pickerViewNumberOfColumns() -> Int {
        return (pickerArrDataSource?.count)!
    }
    
    @objc func pickerViewForColumnSource(indexPath: NSIndexPath) -> Array<AnyObject> {
        return pickerArrDataSource![indexPath.section]
    }

    
    var years:Array<String>{
        return initailizeYear()
    }
    var monthes:Array<String>{
        return initailizeMonth()
    }
    var days:Array<String>{
        return initailizeDays()
    }
    var hours:Array<String>{
        return intializeHours()
    }
    var minutes:Array<String>{
        return intializeMinutes()
    }
    var meridians:Array<String>{
        return ["AM","PM"]
    }
    
    //MARK: initailizeDateSource
    private func initailizeDays() -> Array<String> {
        var arrDays: Array<String>= []
        for i in 1 ... 31 {
            arrDays.append(String(format: "%02d",i))
        }
        return arrDays
    }
    private func intializeMinutes() -> Array<String> {
        var arrMinutes: Array<String>= []
        for i in 0..<60 {
            arrMinutes.append(String(format: "%02d",i))
        }
        return arrMinutes
    }
    private func intializeHours() -> Array<String> {
        var arrHours: Array<String> = []
        if (twenthyFourHourMode == true) {
            for i in 0..<24 {
                arrHours.append(String(format: "%02d",i))
            }
        }else{
            for i in 1...12 {
                arrHours.append(String(format: "%02d",i))
            }
        }
        
        return arrHours
    }
    private func initailizeYear() -> Array<String> {
        var arrYears: Array<String>= []
        for i in 0..<60 {
            arrYears.append("\(1970+i)")
        }
        return arrYears
        
    }
    private func initailizeMonth() -> Array<String> {
        var arrMonths: Array<String>= []
        for i in 1...12 {
            arrMonths.append(String(format: "%02d",i))
        }
        return arrMonths
    }
    
    
}
