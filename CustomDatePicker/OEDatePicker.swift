//
//  OEDatePicker.swift
//  CustomDatePicker
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 Gaooof. All rights reserved.
//

import UIKit

enum OEDatePickerOption {
    
    case YearMonthDayHourMin
    case MonthDayHourMin
    case HourMin
    case Custom
}

protocol OEDatePickerDelegate {
    func datePickerDelectDate(selectedDate:NSDate?)
}

class OEDatePicker: UIView,UITableViewDataSource,UITableViewDelegate{
    
    //picker Custom Style
    var cellDateTextColor:UIColor?
    var cellDateBackgroundColor:UIColor?
    var cellDateTextFontSize:CGFloat?
    var cellSelectViewColor:UIColor?
    var cellTextDefaultColor:UIColor?
    var cellTextheighlightColor:UIColor?
    
    var delegate:OEDatePickerDelegate?
        /// Custom yearRange
    var yearRange: NSIndexSet?
    
        /// 24 or 12  set before dateModel
    var twenthyFourHourMode: Bool = true
    
        /// Custom column,when use custom need set it
    var columnValue:CGFloat = 5
    
    
    
        /// datePickerModel default is MonthDayHourMin
    var dateFormat:String = "MMddHHmm"
    
    var dateModel:OEDatePickerOption {
        get{return self.theDateModel }
        set{

            self.theDateModel = newValue
            switch newValue {
            case .YearMonthDayHourMin:
                self.columnValue = 6
                dateFormat = "yyyyMMddHHmm"
            case .MonthDayHourMin:
                self.columnValue = 5
                dateFormat = "MMddHHmm"
                
            case .HourMin:
                self.columnValue = 3
                dateFormat = "HHmm"
            default:
                self.columnValue = 5
            }
            if twenthyFourHourMode == false {
                dateFormat = dateFormat.stringByReplacingOccurrencesOfString("HH", withString: "hh", options: NSStringCompareOptions.LiteralSearch, range: nil)
                dateFormat = "\(dateFormat)aa"
            }
        }
    }
    

    private var pickerSource:Array<AnyObject>?
    private var arrYearsText: Array<String> = []
    private var arrMothText: Array<String> = []
    private var arrDaysText: Array<String> = []
    private var arrMinsText: Array<String> = []
    private var arrMeridiansText: Array<String> = ["上午","下午"]
    private var arrHourText: Array<String> = []
        /// default dateModel
    private var theDateModel:OEDatePickerOption = .MonthDayHourMin
    
    
    override func drawRect(rect: CGRect) {
        self.backgroundColor = UIColor.redColor()
        setupDatePicker(self.dateModel)
    }
    

    //MARK: initailizeDateSource
    private func initailizeDays() {
        var arrDays: Array<String>= []
        for i in 1 ... 31 {
            arrDays.append(String(format: "%02d",i))
        }
        self.arrDaysText = arrDays
    }
    private func intializeMinutes() {
        var arrMinutes: Array<String>= []
        for i in 0..<60 {
            arrMinutes.append(String(format: "%02d",i))
        }
        self.arrMinsText = arrMinutes
    }
    private func intializeHours() {
        var arrHours: Array<String> = []
        if (twenthyFourHourMode == true) {
            for i in 0..<24 {
                arrHours.append(String(format: "%02d",i))
            }
        }
        for i in 1...12 {
            arrHours.append(String(format: "%02d",i))
        }

        self.arrHourText = arrHours
    }
    private func initailizeYear() {
        
        var arrYears: Array<String>= []
        if self.yearRange == nil {
            for i in 0..<60 {
                arrYears.append("\(1970+i)")
            }
        }else{
            self.yearRange?.enumerateIndexesUsingBlock({ (i, stop) in
                arrYears.append("\(1970+i)")
            })
        }
        self.arrYearsText = arrYears

    }
    private func initailizeMonth() {
        var arrMonths: Array<String>= []
        for i in 1...12 {
            arrMonths.append(String(format: "%02d",i))
        }
        self.arrMothText = arrMonths
    }
    
      /** load DatePickers */
    func setupDatePicker(dateModel: OEDatePickerOption) {
        intializeMinutes()
        intializeHours()
        initailizeDays()
        initailizeMonth()
        initailizeYear()
        
        pickerSource = [arrMeridiansText, arrMinsText,arrHourText,arrDaysText,arrMothText,arrYearsText]
        
        if dateModel == .Custom{ return }
        let datePickerWidth = self.frame.size.width

        if twenthyFourHourMode{
            pickerSource?.removeFirst()
            self.columnValue = self.columnValue-1
        }

        let width = self.frame.size.width/columnValue
        
        for i in 0..<Int(self.columnValue) {
            let arrValue = pickerSource![i]
            let datePicker = OEPickerTableView(frame: CGRectMake(datePickerWidth-CGFloat(i+1)*width, 0, width, self.frame.size.height), arrValue: arrValue as! [String], delegate: self, dataSource: self)
            datePicker.tag = i
            self.addSubview(datePicker)
        }
    }
    
    //MARK: Delegate DateSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let oeDatePicker = tableView as! OEPickerTableView
        if oeDatePicker.arrValue![0] == "上午" {
            return 1
        }
        return 100
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let oePickerView = tableView as! OEPickerTableView
        return (oePickerView.arrValue?.count)!
    }
    
    private let id = "cell"
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let id = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(id) as? OEDateCell
        if cell==nil {
            cell = OEDateCell(style: .Default, reuseIdentifier: id)
        }
        if cellDateTextColor != nil {
            cell!.dateLable?.textColor = cellDateTextColor
        }
        if cellDateBackgroundColor != nil {
            cell!.dateLable?.backgroundColor = cellDateBackgroundColor
        }
        if (cellDateTextFontSize != nil){
            cell!.dateLable?.font = UIFont.boldSystemFontOfSize(cellDateTextFontSize!)
        }
        if cellSelectViewColor != nil {
            cell!.selectView?.backgroundColor = cellSelectViewColor
        }
        if cellTextDefaultColor != nil {
            cell!.cellTextDefaultColor = cellTextDefaultColor!
        }
        if cellTextheighlightColor != nil {
            cell!.cellTextHeighlightColor = cellTextheighlightColor!
        }
        
        let OETableView = tableView as! OEPickerTableView
        cell!.dateText = OETableView.arrValue![indexPath.row]
        return cell!
    }
    
    
 
    
        /// mark lastIndexPath
    private var lastIndexPath:NSIndexPath = NSIndexPath(forRow: 0, inSection: 50)
    
    private var dateText:String?
    private var meridian:String = ""
    private var min:String = ""
    private var hour:String = ""
    private var day:String = ""
    private var month:String = ""
    private var year:String = ""
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let oeDatePicker = tableView as! OEPickerTableView
                /// cancel last selected
        oeDatePicker.deselectRowAtIndexPath(lastIndexPath, animated: true)
        oeDatePicker.reloadData()
                /// select cell
        let cell = oeDatePicker.cellForRowAtIndexPath(indexPath) as! OEDateCell
        cell.selected = true
                /// AM or PM Cell
        
        if oeDatePicker.arrValue![0] == "上午" {
            if indexPath.row == 0 {
                let top = self.frame.size.height*0.5 - 30
                oeDatePicker.contentInset = UIEdgeInsetsMake(top, 0, 0, 0)

            }else{
            let top = self.frame.size.height*0.5 - 90
                oeDatePicker.contentInset = UIEdgeInsetsMake(top, 0, 0, 0)
            }
        }
        
        tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
        lastIndexPath = indexPath
        
        let fmt = NSDateFormatter()
        fmt.dateFormat = self.dateFormat
        
        getDate(oeDatePicker.tag, cell: cell)
        
        dateText = "\(year)\(month)\(day)\(hour)\(min)\(meridian)"
//        print(dateText)
        let pickerDate = fmt.dateFromString(dateText!)
        self.delegate?.datePickerDelectDate(pickerDate)
    
        
    }
    
    
    private func getDate(tag:Int,cell:OEDateCell){
        if self.twenthyFourHourMode {
            switch tag {
            case 0:
                min = cell.dateText!
            case 1:
                hour = cell.dateText!
            case 2:
                day = cell.dateText!
            case 3:
                month = cell.dateText!
            case 4:
                year = cell.dateText!
            default:
                break
            }
        }else{
            switch tag {
            case 0:
                meridian = cell.dateText!
            case 1:
                min = cell.dateText!
            case 2:
                hour = cell.dateText!
            case 3:
                day = cell.dateText!
            case 4:
                month = cell.dateText!
            case 5:
                year = cell.dateText!
            default:
                break
            }
        }
    }
}



//MARK: DatePickerView
class OEPickerTableView: UITableView {
    
    var arrValue: Array<String>?
    override func drawRect(rect: CGRect) {
        
    }
    
    convenience init(frame: CGRect,arrValue:[String],delegate: UITableViewDelegate,dataSource:UITableViewDataSource){
        self.init(frame: frame, style: .Plain)
        self.arrValue = arrValue
        self.delegate = delegate
        self.dataSource = dataSource
        if arrValue[0] == "上午" {
            let top = self.frame.size.height*0.5 - 30
            self.contentInset = UIEdgeInsetsMake(top, 0, 0, 0)
            return
        }
        let index = NSIndexPath(forRow: 0, inSection: 50)
        self.selectRowAtIndexPath(index, animated: true, scrollPosition: .Middle)
//        self.scrollToRowAtIndexPath(index, atScrollPosition: .Middle, animated: true)
        

    }
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.rowHeight = 60
        self.showsVerticalScrollIndicator = false
        self.scrollEnabled = true
        self.userInteractionEnabled = true
        self.separatorStyle = .None
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


