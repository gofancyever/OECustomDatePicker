 

#simple custom DatePicker
-------------
 
####Language
  [中文](https://github.com/ofEver/OECustomDatePicker/blob/master/README.zh.md)<br>
  
   ![](https://github.com/ofEver/OECustomDatePicker/blob/master/ScreenShots/1.gif)<br>
  ![](https://github.com/ofEver/OECustomDatePicker/blob/master/ScreenShots/2.gif)<br>
  ![](https://github.com/ofEver/OECustomDatePicker/blob/master/ScreenShots/3.gif)<br>
![](https://github.com/ofEver/OECustomDatePicker/blob/master/ScreenShots/4.gif)<br>
  
####Example:  
     
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
        
        //delegate
        func datePickerDelectDate(selectedDate: NSDate?) 


###custom style
- A <br>
    //picker Custom Style<br>
    cellDateTextColor<br>
    cellDateBackgroundColor<br>
    cellDateTextFontSize<br>
    cellSelectViewColor<br>
    cellTextDefaultColor<br>
    cellTextheighlightColor<br>

- B<br>
    YearMonthDayHourMin<br>
    MonthDayHourMin<br>
    HourMin<br>
    Custom <br>
    
### How to use
  Copy and paste OEDatePicker.swift ,OEDateCell.swift folder in your Xcode project.

### Notes
  When users click on Meridian, there will be a wrong time <br>
  It is recommended to use "twenthyFourHourMode"
  
  

###TODO
  update add Custom picker Source



