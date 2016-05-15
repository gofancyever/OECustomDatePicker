//
//  OEPickerView.swift
//  OEPickerView
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 Gaooof. All rights reserved.
//

import UIKit

@objc protocol OEPickerViewDelegate  {
    /** selected row at indexPath */
    optional func pickerView(pickerView: OEPickerTableView? , didSelectPickerViewRowAtIndexPath indexPath: NSIndexPath)
    /** selected date when dataSource is OEDataPicker object */
    optional func pickerView(selectDate date: NSDate)
    
}

@objc protocol OEPickerViewDataSource  {
    /** pickerView have number of colums */
     func pickerViewNumberOfColumns() -> Int
    /** pickerTableView dataSource need an array of data in each row  */
     func pickerViewForColumnSource(indexPath: NSIndexPath) -> Array<AnyObject>
}


struct Theme:OEPickerTableViewThemeDelegate {
    var pickerCellBackgroundColor:UIColor
    var pickerSelectedColor:UIColor
    var pickerCellTextDefaultColor:UIColor
    var pickerCellTextHeighlightColor:UIColor
    var pickercellTextFontSize: CGFloat
    init(pickerCellBackgroundColor:UIColor,pickerSelectedColor:UIColor,pickerCellTextDefaultColor:UIColor,pickerCellTextHeighlightColor:UIColor,pickercellTextFontSize: CGFloat){
        self.pickerCellBackgroundColor = pickerCellBackgroundColor
        self.pickerCellTextDefaultColor = pickerCellTextDefaultColor
        self.pickerCellTextHeighlightColor = pickerCellTextHeighlightColor
        self.pickerSelectedColor = pickerSelectedColor
        self.pickercellTextFontSize = pickercellTextFontSize
    }
}
class OEPickerView: UIView ,UITableViewDelegate,OEPickerTableViewThemeDelegate{
    
    var dataSource: OEPickerViewDataSource?
    var delegate: OEPickerViewDelegate?
    var rowHeight: CGFloat = 60
    
    //default Theme
    var pickerCellBackgroundColor:UIColor = UIColor.whiteColor()
    var pickerSelectedColor:UIColor = UIColor.blueColor()
    var pickerCellTextDefaultColor = UIColor.grayColor()
    var pickerCellTextHeighlightColor = UIColor.blackColor()
    var pickercellTextFontSize: CGFloat = 17
    
    var theme:Theme?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func drawRect(rect: CGRect) {
        var column:CGFloat?
        if (self.dataSource != nil) {
            column = CGFloat((dataSource?.pickerViewNumberOfColumns())!)
        }
        addPickerView(column!)
    }
    
    
    ///创建picker到view
    private func addPickerView (columnValue:CGFloat) {
        let width = self.frame.size.width/columnValue
        let screenWidth = self.frame.size.width
        for i in 0..<Int(columnValue) {
            let pickerTableView = OEPickerTableView()
            pickerTableView.tag = i
            pickerTableView.delegate = self
            pickerTableView.dataSource = pickerTableView
            if theme==nil{
            pickerTableView.theme = self
            }else{
                pickerTableView.theme = self.theme
            }
            let frame = CGRectMake(screenWidth-CGFloat(i+1)*width, 0, width, self.frame.size.height)
            pickerTableView.frame = frame
            pickerTableView.rowHeight = self.rowHeight
            let index = NSIndexPath(forRow: 0, inSection: i)
            let tableViewSourceArr:Array<AnyObject> = (dataSource?.pickerViewForColumnSource(index))!
            pickerTableView.arrValue = tableViewSourceArr
            
            let selectIndex = NSIndexPath(forRow: 0, inSection: 25)
            pickerTableView.scrollToRowAtIndexPath(selectIndex, atScrollPosition: .Middle, animated: false)
            self.addSubview(pickerTableView)
            
        }
    }
    
    //MARK: TableView Delegate
    var lastIndexPath = NSIndexPath(forRow: 0, inSection: 25)
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath == lastIndexPath { return }
        tableView.deselectRowAtIndexPath(lastIndexPath, animated: true)
        tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .Middle)
        let pickerTableView = tableView as! OEPickerTableView
        let index = NSIndexPath(forRow: indexPath.row, inSection: tableView.tag)
        self.delegate?.pickerView!(tableView as? OEPickerTableView, didSelectPickerViewRowAtIndexPath: index)
        
        // 日期模式
        if self.dataSource is OEDatePicker{
            let date = creatDate(pickerTableView,indexPath:indexPath)
            self.delegate?.pickerView!(selectDate: date)
        }
        lastIndexPath = indexPath
    }
    
    let components = NSDateComponents()
    var hour = 0
    var dayPickerView:OEPickerTableView?
    /// 创建时间
    func creatDate(pickerTableView:OEPickerTableView,indexPath:NSIndexPath) -> NSDate {
        
        //            print(components.year)
        let datePicker = self.dataSource as! OEDatePicker
        if datePicker.twenthyFourHourMode! == false{
            
            if pickerTableView.tag == 0 {
                if components.hour<25{
                    if pickerTableView.arrValue![indexPath.row] as! String == "PM"{
                        hour = 12
                        components.hour = components.hour+hour
                    }else{
                        if hour == 12 {
                            components.hour = components.hour - 12
                            hour =  0
                        }
                    }
                }
            }
            if pickerTableView.tag == 1 {
                components.minute = Int(pickerTableView.arrValue![indexPath.row] as! String)!
            }
            if pickerTableView.tag == 2 {
                components.hour = Int(pickerTableView.arrValue![indexPath.row] as! String)!
                print(Int(pickerTableView.arrValue![indexPath.row] as! String)!)
            }
            if pickerTableView.tag == 3 {
                components.day = Int(pickerTableView.arrValue![indexPath.row] as! String)!
            }
            if pickerTableView.tag == 4 {
                components.month = Int(pickerTableView.arrValue![indexPath.row] as! String)!
                calculateDay(components)
            }
            if pickerTableView.tag == 5 {
                self.components.year = Int(pickerTableView.arrValue![indexPath.row] as! String)!
            }
        }
        if datePicker.twenthyFourHourMode! {
            if pickerTableView.tag == 0 {
                components.minute = Int(pickerTableView.arrValue![indexPath.row] as! String)!
            }
            if pickerTableView.tag == 1 {
                components.hour = Int(pickerTableView.arrValue![indexPath.row] as! String)!
            }
            if pickerTableView.tag == 2 {
                components.day = Int(pickerTableView.arrValue![indexPath.row] as! String)!
            }
            if pickerTableView.tag == 3 {
                components.month = Int(pickerTableView.arrValue![indexPath.row] as! String)!
                calculateDay(components)
            }
            if pickerTableView.tag == 4 {
                components.year = Int(pickerTableView.arrValue![indexPath.row] as! String)!
            }
            
        }
        let timeZone = NSTimeZone(abbreviation: "UTC")
        components.timeZone = timeZone
        let calendar = NSCalendar.currentCalendar()
        return calendar.dateFromComponents(components)!
    }
    /// 精确计算日期
    func calculateDay(components:NSDateComponents) {
        if dayPickerView == nil {
            for pickerView in self.subviews{
                let pickerTableView = pickerView as! OEPickerTableView
                if pickerTableView.arrValue?.count == 31 {
                    dayPickerView = pickerTableView
                }
            }
        }
        //计算月份
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let dateCom = NSDateComponents()
        dateCom.month = components.month
        let twoMonthDate = calendar?.dateFromComponents(dateCom)
        let unitM: NSCalendarUnit = [.Month]
        let dayIndex = calendar!.rangeOfUnit(.Day, inUnit: unitM, forDate: twoMonthDate!)
        var arrDays = Array<String>()
        for i in dayIndex.location...dayIndex.length {
            arrDays.append(String(format: "%02d",i))
        }
        dayPickerView!.arrValue = arrDays
        dayPickerView!.reloadData()
    }
}


//MARK: OEPickerTableView
class OEPickerTableView: UITableView,UITableViewDataSource  {
    var theme: OEPickerTableViewThemeDelegate?
    var arrValue: Array<AnyObject>?
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: UITableViewStyle.Plain)
        self.rowHeight = 60
        self.showsVerticalScrollIndicator = false
        self.scrollEnabled = true
        self.userInteractionEnabled = true
        self.separatorStyle = .None
        self.dataSource = self
    }
    
    private var lastIndexPath:NSIndexPath = NSIndexPath(forRow: 0, inSection: 25)
    override func selectRowAtIndexPath(indexPath: NSIndexPath?, animated: Bool, scrollPosition: UITableViewScrollPosition){
        
        if lastIndexPath == indexPath {return}
        super.selectRowAtIndexPath(indexPath, animated: animated, scrollPosition: scrollPosition)
        self.deselectRowAtIndexPath(lastIndexPath, animated: true)
        lastIndexPath = indexPath!
        self.reloadData()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if self.arrValue?.count == 2 {
            let x = self.frame.origin.x
            let w = self.frame.size.width
            let top = rect.size.height*0.5 - self.rowHeight*0.5
            self.frame = CGRectMake(x, top, w, 120)
            //            self.contentInset = UIEdgeInsetsMake(top, 0, top, 0)
        }
    }
    
    
    //MARK: TableViewDateSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 50
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrValue!.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let ID = "OECell"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID) as? OEPickerCell
        if cell == nil {
            cell = OEPickerCell(style: .Default, reuseIdentifier: ID)
        }
        cell?.configure(self.arrValue![indexPath.row] as! String)
        cell?.configure(theme!)
        return cell!
    }
    
    
    
    
}





