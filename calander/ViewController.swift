//
//  ViewController.swift
//  calander
//
//  Created by Sumit Sharma on 17/11/21.
//

import UIKit
import FSCalendar

class ViewController: UIViewController{
    
    var calander:FSCalendar!
    var displayDays : Int = 24*60*60
    //9 days from currnt date
    var maxDayFromCurrent : Int! = 9
    var formatter = DateFormatter()
    var deleverydate : String = "17-11-21"
    var currentdate = String()
    var allFriday : [String] = []
    var height: CGFloat = 80.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetup()
    }
    
    func initSetup(){
        calander = FSCalendar(frame: CGRect(x: 0, y: 40, width: self.view.frame.size.width, height: 400))
        self.view.addSubview(calander)
        calander.dataSource = self
        calander.delegate = self
        
        //today date
        let date = Date()
        formatter.dateFormat = "dd-MM-YY"
        let dateString = formatter.string(from: date)
        print(dateString)
        currentdate = dateString
        
        //header color
        calander.appearance.headerTitleColor = .white
        calander.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 22)
        
        //weak text Color
        calander.appearance.weekdayTextColor = .white
        calander.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 16)
        
        calander.appearance.todayColor = .clear
        calander.appearance.borderDefaultColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        calander.appearance.borderSelectionColor = #colorLiteral(red: 0.1154224947, green: 0.4895370007, blue: 0.9361801744, alpha: 1)
        calander.appearance.titleTodayColor = #colorLiteral(red: 0.1154224947, green: 0.4895370007, blue: 0.9361801744, alpha: 1)
        
        //default days color
        calander.appearance.titleDefaultColor = .white
        
        //undercell 
        calander.appearance.borderRadius = 0
        calander.appearance.imageOffset.y = -28
        calander.appearance.subtitleOffset.y = -16
        calander.appearance.titleOffset.y = 12
        calander.appearance.borderRadius = 0.5
        
        //register cell here
        calander.register(FSCalendarCell.self, forCellReuseIdentifier: "Cell")
    }
    
}

extension ViewController : FSCalendarDataSource, FSCalendarDelegate {
    
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "Cell", for: date, at: position)
        
        var DayExist:Bool
        
        let calendar =
            NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
        print(calendar?.isDateInToday(date))
        let components = calendar!.components([.weekday], from: date)
        
        if components.weekday == 6{
            print("Friday")
            let dateString = self.formatter.string(from: date)
            formatter.dateFormat = "dd-MM-YY"
            allFriday.append(dateString)
            DayExist = false
        } else{
            print("other fday of week")
            DayExist = true
        }
        
        return cell
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MM-YY"
        print("did select a date == \(formatter.string(from: date))")
    }
    
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        
        
        let dateString = self.formatter.string(from: date)
        formatter.dateFormat = "dd-MM-YY"
        
        if allFriday.contains(dateString) {
            return nil
        }else if self.deleverydate.contains(dateString) {
            return  nil
        }else if self.currentdate.contains(dateString){
            return  nil
        }
        return "Select"
    }
    
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let dateString = self.formatter.string(from: date)
        formatter.dateFormat = "dd-MM-YY"
        
        if self.deleverydate.contains(dateString) {
            return  UIImage(named:"delivery")
        }else if allFriday.contains(dateString) {
            return  UIImage(named:"cancel")
        }else if self.currentdate.contains(dateString){
            return  UIImage(named:"check")
        }
        return  nil
    }
    
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    //displaying on Limited days from currrent month after a current day
    
    //    func maximumDate(for calendar: FSCalendar) -> Date {
    //        return Date().addingTimeInterval(TimeInterval((displayDays*maxDayFromCurrent)))
    //    }
    
}
