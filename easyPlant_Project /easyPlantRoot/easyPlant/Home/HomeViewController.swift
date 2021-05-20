//
//  ViewController.swift
//  easyPlantHomeTap
//
//  Created by 차다윤 on 2021/04/30.
//

import UIKit
import FSCalendar

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var plantListTableView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    
    var dates: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendar.scope = .week
        calendar.headerHeight = 50
        
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "M월"
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24)
        calendar.locale = Locale(identifier: "ko_KR")
        for i in 0...6 {
            calendar.calendarWeekdayView.weekdayLabels[i].font = UIFont(name:"나눔명조", size: 60.0)
        }
        calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "토"
        
        
        calendar.appearance.todayColor = UIColor(red: 147/255, green: 201/255, blue: 115/255, alpha: 1)
        calendar.appearance.selectionColor = UIColor(red: 147/255, green: 170/255, blue: 147/255, alpha: 1)
        //calendarView.appearance.selectionColor = UICo
        // Do any additional setup after loading the view.
        
        setUpEvents()
        
        plantListTableView.separatorStyle = .none
        
        
      
    }
    /*
    func calendar(calendar: FSCalendar!, hasEventForDate date: NSDate!) -> Bool {
        return shouldShowEventDot
    }
 */

    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //이거 초기값은0 인데 1로 변경해줘야함
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPlants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plantCell", for: indexPath) as! UserPlantTableViewCell
        
        let item = userPlants[indexPath.row]
        cell.name.text = item.name
        cell.location.text = item.location
        cell.period.text = "\(item.waterPeriod) 일"
        cell.lastWater.text = item.wateringDay
        cell.plantImage.image = UIImage(named: item.plantImage)
        cell.plantImage.layer.cornerRadius = cell.plantImage.frame.height / 2
        cell.plantImage.layer.borderWidth = 1
        cell.plantImage.layer.borderColor = CGColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)

        cell.plantCellView.backgroundColor = UIColor(cgColor: CGColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1))
        cell.plantCellView.layer.cornerRadius = cell.plantCellView.frame.height / 3
        
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
        let xmas = formatter.date(from: "2021-05-21")
        let sampledate = formatter.date(from: "2021-05-20")
        dates = [xmas!, sampledate!]
        print(dates)
    }
}
/*
extension HomeViewController: FSCalendarDataSource {
//이벤트 표시 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        print("Hello")
        if self.dates.contains(date) {
            return 1
        } else {
            return 0
        }
    }
}
*/
