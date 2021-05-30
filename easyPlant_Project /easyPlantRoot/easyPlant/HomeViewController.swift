//
//  ViewController.swift
//  easyPlantHomeTap
//
//  Created by 차다윤 on 2021/04/30.
//

import UIKit
import FSCalendar
import Charts

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var hapinessImage: UIImageView!
    @IBOutlet weak var levelImage: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var plantListTableView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showLevelView(sender:)))
        userView.addGestureRecognizer(tapGesture)

        
        levelImage.image = UIImage(named: "sprout")
        hapinessImage.image = UIImage(named: "행복한식물")
        
        self.calendar.scope = .week
        calendar.headerHeight = 50

        self.view.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        self.plantListTableView.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "M월"
        calendar.appearance.headerTitleColor = .black
        //calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24)
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
        calendar.layer.cornerRadius = calendar.frame.height / 14
        //calendarView.appearance.selectionColor = UICo
        // Do any additional setup after loading the view.
        
        userView.backgroundColor = .white
        userView.layer.cornerRadius = userView.frame.height / 14
        
        
        let headerView = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 60))
        headerView.text = "식물 목록"
        headerView.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        headerView.textColor = UIColor.white
        headerView.textAlignment = .center
        headerView.contentMode = .scaleAspectFit
        
        headerView.font = UIFont.boldSystemFont(ofSize: CGFloat(20))

        plantListTableView.tableHeaderView = headerView
        
        
    }
    
    var array: [ChartDataEntry] = [ChartDataEntry()]
    override func viewWillAppear(_ animated: Bool) {
        plantListTableView.reloadData()
        calendar.reloadData()
        
        var ChartEntry : [ChartDataEntry] = []
        let value_fill = PieChartDataEntry(value: 0)
        let value_empty = PieChartDataEntry(value: 0)
        
        pieChart.chartDescription?.text = ""
        
        value_fill.value = 70
        value_fill.label = ""
        value_empty.value = 30
        value_empty.label = ""
        
        ChartEntry.append(value_fill)
        ChartEntry.append(value_empty)
        
        let chartDataSet = PieChartDataSet(entries: ChartEntry, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        var colors: [NSUIColor] = []
        var color = UIColor(red: CGFloat(189.0/255), green: CGFloat(236.0/255), blue: CGFloat(182.0/255), alpha: 1)
        colors.append(color)
        color = UIColor(red: CGFloat(255/255), green: CGFloat(255/255), blue: CGFloat(255/255), alpha: 1)
        colors.append(color)
        
        chartDataSet.colors = colors
        chartDataSet.drawValuesEnabled = false
        chartDataSet.selectionShift = 5
        pieChart.transparentCircleRadiusPercent = 0
        //pieChart.holeRadiusPercent = 0
        pieChart.legend.enabled = false
        pieChart.chartDescription?.enabled = false
        pieChart.minOffset = 0
        pieChart.data = chartData

    }
    
    @objc func showLevelView(sender: UIView) {
        performSegue(withIdentifier: "levelViewSegue", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let current_date_string = formatter.string(from: Date())
        let watering_date_string = formatter.string(from: item.wateringDay)
        
        cell.name.text = item.name
        cell.location.text = item.location
        cell.period.text = "\(item.waterPeriod) 일"
        cell.lastWater.text = watering_date_string
        cell.plantImage.image = UIImage(named: item.plantImage)
        cell.plantImage.layer.cornerRadius = cell.plantImage.frame.height / 2

        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = cell.frame.height / 4
        
        // reloadData 하면 다시 새 물뿌리개 이미지 생성함.
        // reload 하는 경우엔 이 부분 실행하지 않도록
        //if (item.watered == false)
        let wateringButton = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        wateringButton.contentMode = .scaleAspectFit
        wateringButton.image = UIImage(named: "watering")
        wateringButton.tag = indexPath.row
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(watering(sender: )))
        wateringButton.addGestureRecognizer(tapGesture)
        wateringButton.isUserInteractionEnabled = true
        
        cell.accessoryView = wateringButton
        
        if current_date_string != watering_date_string {
            cell.accessoryView?.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let secondStoryboard = UIStoryboard.init(name: "MyPlant", bundle: nil)
        guard let secondVC = secondStoryboard.instantiateViewController(identifier: "myPlantSB") as? myPlantViewController else {return indexPath}
        secondVC.myPlant = userPlants[indexPath.row]
        self.navigationController?.pushViewController(secondVC, animated: true)
        
        return indexPath
    }
 
 
    @objc func watering(sender: UITapGestureRecognizer){
        //sender.image = UIImage(named: "watering_fill")
        let wateringButton = sender.view as! UIImageView
        
        wateringButton.image = UIImage(named: "watering_fill")
        
        // TODO need to save
        userPlants[wateringButton.tag].wateringDay = Calendar.current.date(byAdding: .day, value: userPlants[wateringButton.tag].waterPeriod, to: Date())!
        
        plantListTableView.reloadData()
    }
    
    /* MyPlant의 설정으로 이동
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? NotificationViewController, let indexPath =  plantListTableView.indexPathForSelectedRow {
            detailVC.myPlant = userPlants[indexPath.row]
        }
    }*/
}

extension HomeViewController: FSCalendarDataSource, FSCalendarDelegateAppearance {
    //이벤트 표시 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let calendarDate = formatter.string(from: date)
        
        var dotNum = 0
        for i in 0...userPlants.count-1 {
            let wateringDate = formatter.string(from: userPlants[i].wateringDay)
            if wateringDate == calendarDate {
                dotNum += 1
            }
        }
        
        return dotNum
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let calendarDate = formatter.string(from: date)
        
        for i in 0...userPlants.count {
            let wateringDate = formatter.string(from: userPlants[i].wateringDay)
            if wateringDate == calendarDate {
                return [UIColor.green]
            }
        }
        
        return [UIColor.white]
    }
}
