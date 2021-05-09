//
//  ViewController.swift
//  easyPlantHomeTap
//
//  Created by 차다윤 on 2021/04/30.
//

import UIKit
import FSCalendar

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    @IBOutlet weak var plantListTableView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    
    var events: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.headerHeight = 50
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24)

        calendar.locale = Locale(identifier: "ko_KR")
        calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "토"

        
        calendar.appearance.todayColor = UIColor(red: 147/255, green: 201/255, blue: 115/255, alpha: 1)
        calendar.appearance.selectionColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        //calendarView.appearance.selectionColor = UICo
        // Do any additional setup after loading the view.
      
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //이거 초기값은0 인데 1로 변경해줘야함
        print("section")
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("row")
        return userPlants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plantCell", for: indexPath)
        
        let item = userPlants[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.location
        cell.imageView?.image = UIImage(named: item.plantImage)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? NotificationViewController, let indexPath =  plantListTableView.indexPathForSelectedRow {
            detailVC.myPlant = userPlants[indexPath.row]
        }
    }
    
    func setUpEvents() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        let xmas = formatter.date(from: "2021-05-09")
        let sampledate = formatter.date(from: "2021-05-11")
        events = [xmas!, sampledate!]
    }
    
}

    var datesWithEvent = ["2021-05-23","2020-12-16","2020-12-18","2020-12-14","2020-12-06"]
    var datesWithMultipleEvents = ["2020-12-03","2020-12-13","2020-12-11","2020-10-03","2020-12-06"]
    
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            print("did select date \(self.dateFormatter2.string(from: date))")
            let selectedDates = calendar.selectedDates.map({self.dateFormatter2.string(from: $0)})
            print("selected dates is \(selectedDates)")
            if monthPosition == .next || monthPosition == .previous {
                calendar.setCurrentPage(date, animated: true)
            }
        }
        
        
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            print("\(self.dateFormatter2.string(from: calendar.currentPage))")
        }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {

            let dateString = dateFormatter2.string(from: date)
                    
            if self.datesWithEvent.contains(dateString){
                return 1
            }
            
            if self.datesWithMultipleEvents.contains(dateString) {
                return 2
            }
            
            return 0
        }
        
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
            
            let key = self.dateFormatter2.string(from: date)
            
            if self.datesWithMultipleEvents.contains(key){
                return [UIColor.blue]
            }
            return nil
        }
}
