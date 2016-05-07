 

#simple custom DatePicker
-------------
  简单可以定制样式的datePicker<br>
  ![](https://github.com/ofEver/OECustomDatePicker/blob/master/ScreenShots/1.gif)<br>
  ![](https://github.com/ofEver/OECustomDatePicker/blob/master/ScreenShots/2.gif)<br>
  ![](https://github.com/ofEver/OECustomDatePicker/blob/master/ScreenShots/3.gif)<br>

  
####Example:  
     
        // 1.创建OEDatePicker对象
        let datePickerView = OEDatePicker()
        // 2, 设置24小时值 默认为24小时
        datePickerView.twenthyFourHourMode = false
        // 3. 设置时间显示模式 设置24小时制需要再次之前设置
        datePickerView.dateModel = OEDatePickerOption.YearMonthDayHourMin
        // 4.set pickerView frame
        datePickerView.frame = CGRectMake(0, 300, self.view.bounds.size.width, 200)
        // 5. set delegate
        datePickerView.delegate = self
        // 6. addSubview
        self.view.addSubview(datePickerView)
        //通过代理返回所选时间 当时间全部选中才会返回
        func datePickerDelectDate(selectedDate: NSDate?) 
      


### 可定制的样式
- A <br>
    //picker Custom Style<br>
    cellDateTextColor<br>
    cellDateBackgroundColor<br>
    cellDateTextFontSize<br>
    cellSelectViewColor<br>
    cellTextDefaultColor<br>
    cellTextheighlightColor<br>

- B<br> 时间显示模式
    YearMonthDayHourMin<br>
    MonthDayHourMin<br>
    HourMin<br>
    Custom // enable <br>
    
### How to use

  直接将 OEDatePicker.swift ,OEDateCell.swift 复制到你的工程即可

### 注意
  当开启上午，下午选择时 如果用户先选择上午下午的datePick 会返回一个错误的时间 
  建议使用24小时制
### 如遇bug 欢迎反馈帮助我做的更好 and 我的邮箱：pomyven@gmail.com  
  




