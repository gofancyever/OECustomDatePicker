 

#simple custom DatePicker
-------------
 
####Language
  [中文](https://github.com/ofEver/OECustomDatePicker/blob/master/README.zh.md)<br>
  
   ![](https://github.com/ofEver/OECustomDatePicker/blob/master/ScreenShots/1.gif)<br>
  ![](https://github.com/ofEver/OECustomDatePicker/blob/master/ScreenShots/2.gif)<br>
  ![](https://github.com/ofEver/OECustomDatePicker/blob/master/ScreenShots/3.gif)<br>
![](https://github.com/ofEver/OECustomDatePicker/blob/master/ScreenShots/4.gif)<br>
  
####Example: 

##DatePickerView

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

        //delegate
        func pickerView(selectDate date: NSDate) {
        print(date)
        }



##Custom pickerView

        let color = ["red","yellow","blue","green","e..."]
        let num = ["1","2","3","4","5"]
        arr = [color,num]
     
        // 1 creat pickerView
        let pickerView = OEPickerView()

        // 2 set delegate and dataSource
        pickerView.delegate = self

        // 3 set dataSource is self need 
        pickerView.dataSource = self

        
        //dataSource

        func pickerViewNumberOfColumns() -> Int {
        return arr.count
        }

        /** pickerTableView dataSource need an array of data in each row  */
        func pickerViewForColumnSource(indexPath: NSIndexPath) -> Array<AnyObject>{
        return arr[indexPath.section] as! Array<AnyObject>
        }


        
        //delegate
        func pickerView(pickerView: OEPickerTableView?, didSelectPickerViewRowAtIndexPath indexPath: NSIndexPath) {

        }
         


####custom style: Creat Theme()  
####DatePicker : Creat OEDatePicker() 

### How to use
  Copy and paste OEPickerView.swift ,OEDatePicker.swift ,OEPickerCell.swift folder in your Xcode project.


  
  




