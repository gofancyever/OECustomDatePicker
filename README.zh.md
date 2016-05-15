 

#simple custom DatePicker
-------------
  简单可以定制样式的datePicker<br>
  ![](https://github.com/ofEver/OECustomDatePicker/blob/master/ScreenShots/1.gif)<br>
  ![](https://github.com/ofEver/OECustomDatePicker/blob/master/ScreenShots/2.gif)<br>
  ![](https://github.com/ofEver/OECustomDatePicker/blob/master/ScreenShots/3.gif)<br>

  
####Example:  
     
##DatePickerView

        // 1 自定义样式（可选）
        let theme = Theme(pickerCellBackgroundColor: UIColor.whiteColor(), pickerSelectedColor: UIColor.redColor(), pickerCellTextDefaultColor: UIColor.grayColor(), pickerCellTextHeighlightColor: UIColor.yellowColor(), pickercellTextFontSize: 17)

        // 2 创建OEPickerView对象
        let pickerView = OEPickerView()

        // 3 设置样式
        pickerView.theme = theme

        // 4 设置代理和数据源
        pickerView.delegate = self

        // 4.1 使用时间选择器需要先创建 OEDatePicker 对象
        let dateDataSource = OEDatePicker(OEDatePickerModal: OEDatePickerOption.HourMin, twenthyFourHourMode: true)

        // 4.2 设置 OEDatePicker对象 为 pickerView的dataSource
        pickerView.dataSource = dateDataSource

        // 当数据源是OEDatePicker 对象时设个代理用来返回时间
        func pickerView(selectDate date: NSDate) {
            print(date)
        }



##自定义picker数据

        //创建数据
        let color = ["red","yellow","blue","green","e..."]
        let num = ["1","2","3","4","5"]
        arr = [color,num]

        // 1 creat pickerView
        let pickerView = OEPickerView()

        // 2 set delegate and dataSource
        pickerView.delegate = self

        // 3 set dataSource is self need 
        pickerView.dataSource = self


        //自定义数据需要实现这两个dataSource 方法

        func pickerViewNumberOfColumns() -> Int {
        return arr.count
        }

        /** pickerTableView dataSource need an array of data in each row  */
        func pickerViewForColumnSource(indexPath: NSIndexPath) -> Array<AnyObject>{
        return arr[indexPath.section] as! Array<AnyObject>
        }



        //自定义数据 用这个代理接受选择的indexpath
        func pickerView(pickerView: OEPickerTableView?, didSelectPickerViewRowAtIndexPath indexPath: NSIndexPath) {

}


### 可定制的样式
### How to use

  直接将 OEPickerView.swift ,OEDatePicker.swift ,OEPickerCell.swift  复制到你的工程即可

### 更新
   重构使用代理接受自定义数据
### 如遇bug 欢迎反馈帮助我做的更好 and 我的邮箱：pomyven@gmail.com  
  




