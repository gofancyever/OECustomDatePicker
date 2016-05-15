//
//  OEPickerCell.swift
//  OEPickerView
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 Gaooof. All rights reserved.
//

import UIKit


protocol OEPickerTableViewThemeDelegate{
    
    var pickerCellBackgroundColor:UIColor {get set}
    var pickerSelectedColor:UIColor {get set}
    var pickerCellTextDefaultColor:UIColor {get set}
    var pickerCellTextHeighlightColor:UIColor {get set}
    var pickercellTextFontSize:CGFloat { get set }
}



class OEPickerCell: UITableViewCell {
 
    var pickerCellTextHeighlightColor:UIColor?
    var pickerCellTextDefaultColor:UIColor?
    
    func configure(cellText:String){
        self.dateLable?.text = cellText
    }
    
    func configure(theme:OEPickerTableViewThemeDelegate){
        dateLable?.backgroundColor = theme.pickerCellBackgroundColor
        dateLable?.textColor = theme.pickerCellTextDefaultColor
        dateLable?.font = UIFont.systemFontOfSize((theme.pickercellTextFontSize))
        selectView?.backgroundColor = theme.pickerSelectedColor
        pickerCellTextHeighlightColor = theme.pickerCellTextHeighlightColor
        pickerCellTextDefaultColor = theme.pickerCellTextDefaultColor
    }
    var dateLable:UILabel?
    var selectView:UIView?
    
        override var selected: Bool {
            didSet{
                super.selected = oldValue
                self.selectView?.hidden = !oldValue
                if oldValue {
                    dateLable?.textColor = self.pickerCellTextHeighlightColor
                }else{
                    dateLable?.textColor = self.pickerCellTextDefaultColor
                }
            }
        }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        dateLable = UILabel()
        selectView = UIView()
        dateLable?.textAlignment = NSTextAlignment.Center
        dateLable?.addSubview(selectView!)
        self.addSubview(dateLable!)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let selectViewH:CGFloat = 2
        let labelW = self.frame.size.width
        let labelH = self.frame.size.height
        dateLable!.frame = CGRectMake(0, 0,labelW,labelH)
        selectView!.frame.size = CGSizeMake(labelW-labelW*0.4, selectViewH)
        selectView?.center = CGPointMake((dateLable?.center.x)!, labelH)
        
    }
    

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)

    }
}


