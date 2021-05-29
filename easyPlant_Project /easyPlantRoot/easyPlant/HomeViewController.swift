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
    
    var ChartEntry : [ChartDataEntry] = []
    
    var dates = ["2021-05-23", "2021-05-24"]
    
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
        
        var value : ChartDataEntry
        value = ChartDataEntry(x: Double(0), y: Double(90))
        ChartEntry.append(value)
        value = ChartDataEntry(x: Double(0), y: Double(10))
        ChartEntry.append(value)
        
        let chartDataset = PieChartDataSet(entries: ChartEntry, label: "행복도")
        let chartData = PieChartData(dataSet: chartDataset)
        
        var circleColors: [NSUIColor] = []           // arrays with circle color definitions

       
        var color = UIColor(red: CGFloat(189.0/255), green: CGFloat(236.0/255), blue: CGFloat(182.0/255), alpha: 1)
        circleColors.append(color)
        color = UIColor(red: CGFloat(255/255), green: CGFloat(255/255), blue: CGFloat(255/255), alpha: 1)
        circleColors.append(color)
        

        // set colors and enable value drawing
        chartDataset.colors = circleColors
        chartDataset.drawValuesEnabled = true
        
        chartDataset.selectionShift = 0
        pieChart.transparentCircleColor = UIColor.clear
        pieChart.data?.setValueTextColor(UIColor.clear)
        pieChart.holeRadiusPercent = 0
        pieChart.transparentCircleRadiusPercent = 0
        pieChart.legend.enabled = false
        pieChart.chartDescription?.enabled = false
        pieChart.minOffset = 0
        //pieChart.draw
        pieChart.drawEntryLabelsEnabled = false

        pieChart.data = chartData
//        chartView.backgroundColor = .white
        pieChart.layer.cornerRadius = 20
        pieChart.layer.masksToBounds = true
        
        /*
        let chartSet = PieChartDataSet(entries: array, label: "")
        let chartData = PieChartData(dataSet: chartSet)
        chartSet.selectionShift = 10
        pieChart.transparentCircleColor = UIColor.clear
        pieChart.data?.setValueTextColor(UIColor.clear)
        pieChart.holeRadiusPercent = 0.65
        pieChart.transparentCircleRadiusPercent = 0
        pieChart.legend.enabled = false
        pieChart.chartDescription?.enabled = false
        pieChart.minOffset = 0
        //pieChart.centerAttributedText = centerText
        pieChart.drawEntryLabelsEnabled = false //Here id what i tried

        let colors = [UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 1)), UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 1))]

        chartSet.colors = colors 

        pieChart.data = chartData
 */
    }
    /*
    func calendar(calendar: FSCalendar!, hasEventForDate date: NSDate!) -> Bool {
        return shouldShowEventDot
    }
 */
    
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
        cell.name.text = item.name
        cell.location.text = item.location
        cell.period.text = "\(item.waterPeriod) 일"
        cell.lastWater.text = item.wateringDay
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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let current_date_string = formatter.string(from: Date())
        if current_date_string != item.wateringDay {
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
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let current_date_string = formatter.string(from: Date())
        userPlants[wateringButton.tag].wateringDay = current_date_string
        
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
        if self.dates.contains(calendarDate) {
            return 5
        } else {
            return 0
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let calendarDate = formatter.string(from: date)
        
        if self.dates.contains(calendarDate) {
            return [UIColor.green]
        }
        return [UIColor.white]
    }
}
