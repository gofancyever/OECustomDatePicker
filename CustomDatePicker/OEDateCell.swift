//
//  OEDateCell.swift
//  CustomDatePicker
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 Gaooof. All rights reserved.
//

import UIKit

class OEDateCell: UITableViewCell {
    var cellTextHeighlightColor = UIColor.blackColor()
    var cellTextDefaultColor = UIColor.grayColor()
    
    var dateText:String? {
        willSet{
            self.dateLable?.text = newValue
        }
    }
    
    
     var dateLable:UILabel?
     var selectView:UIView?
    override var selected: Bool {
        get{
            return super.selected
        }
        set{
            super.selected = newValue
            self.selectView?.hidden = !newValue
            if newValue {
                dateLable?.textColor = cellTextHeighlightColor
            }else{
                dateLable?.textColor = cellTextDefaultColor
            }
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
         dateLable = UILabel()
         selectView = UIView()
        
        dateLable?.backgroundColor = UIColor.whiteColor()
        dateLable?.textAlignment = NSTextAlignment.Center

        dateLable?.font = UIFont.boldSystemFontOfSize(17)
        dateLable?.textColor = cellTextDefaultColor
        
        selectView?.backgroundColor = UIColor.blueColor()
        
        self.addSubview(dateLable!)
        self.addSubview(selectView!)
        self.backgroundColor = UIColor.clearColor()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let selectViewH:CGFloat = 2
        let labelW = self.frame.size.width
        let labelH = self.frame.size.height-selectViewH
        
        dateLable!.frame = CGRectMake(0, 0,labelW,labelH)
        selectView!.frame.size = CGSizeMake(labelW-labelW*0.4, selectViewH)
        selectView?.center = CGPointMake((dateLable?.center.x)!, labelH)

    }
    
    

}
    