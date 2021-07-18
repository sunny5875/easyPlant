//
//  ViewController.swift
//  easyPlantHomeTap
//
//  Created by 차다윤 on 2021/04/30.
//

import UIKit
import FSCalendar
import Charts
import UserNotifications
import Photos
import FirebaseAuth


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var hapinessImage: UIImageView!
    @IBOutlet weak var levelImage: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var plantListTableView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var firstStack: UIStackView!
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    var indexTmp : IndexPath = IndexPath()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.white
        
        //self.plantListTableView.backgroundColor =  UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        self.plantListTableView.backgroundColor = UIColor.clear
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "calendarCell")
      
        // Request notification authentication
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
                })
        
       
        //loadPlantSearchList()
        //print("load plant search list")

        //앱껏다키면 로컬 데이터는 사라져서 매번 원격에서 json 파일 읽어야될 거 같애
        loadPlantData()
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            
            print("this is first launch")
            do {
                try Auth.auth().signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            myUser = User(Date())
            saveUserInfo(user: myUser)
            saveNewUserPlant(plantsList: userPlants, archiveURL: archiveURL)
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            
            deleteLocalData()
            if Auth.auth().currentUser != nil {
                do {
                    try Auth.auth().signOut()
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                }
                
                self.navigationController?.popViewController(animated: true)
            }
            
            

            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: "OnboardingViewController")
            
            present(secondVC, animated: true, completion: nil)
        }
        


        loadUserInfo()
        loadUserPlant()
        myUser.updateUser()
        saveUserInfo(user: myUser)

       
        for (i, plant) in userPlants.enumerated() {
            if Auth.auth().currentUser == nil {
                break
            }
            let notiContent = UNMutableNotificationContent()
            let userNotificationCenter = UNUserNotificationCenter.current()
            userNotificationCenter.delegate = self
            
            //let date = Date(timeIntervalSinceNow: 15)
            notiContent.title = "\(plant.name) 물 줄 시간이예요!"
            notiContent.body = "물 뿌리개를 통해 \(plant.name)에게 물을 주세요."

            //let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            
            var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: plant.wateringDay)
            dateComponents.hour = Calendar.current.component(.hour, from: plant.alarmTime)
            dateComponents.minute = Calendar.current.component(.minute, from: plant.alarmTime)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: "watering_notification\(i)", content: notiContent, trigger: trigger)
                
            userNotificationCenter.add(request) { error in
                if let error = error {
                    print("Notification Error: ", error)
                }
            }
        }
        
        clickedDay = Date()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showLevelView(sender:)))
        userView.addGestureRecognizer(tapGesture)
        
        self.calendar.scope = .week
        calendar.headerHeight = 50

        
        
        self.view.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        
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
        calendar.layer.cornerRadius = 20
        //calendarView.appearance.selectionColor = UICo
        // Do any additional setup after loading the view.
        
        userView.backgroundColor = .white
        userView.layer.cornerRadius = 20
        
        
        //그림자 설정
        firstStack.layer.zPosition = 101
        userView.layer.zPosition = 102
        calendar.layer.zPosition = 102
        plantListTableView.layer.zPosition = 100
        bgView.layer.zPosition = 0
        
        userView.layer.shadowOpacity = 0.2
        userView.layer.shadowOffset = CGSize(width: 0, height: 5)
        userView.layer.shadowRadius = 30
        userView.layer.masksToBounds = false
        
        calendar.layer.shadowOpacity = 0.2
        calendar.layer.shadowOffset = CGSize(width: 0, height: 5)
        calendar.layer.shadowRadius = 30
        calendar.layer.masksToBounds = false
        
        plantListTableView.layer.shadowOpacity = 0.2
        plantListTableView.layer.shadowOffset = CGSize(width: 0, height: 5)
        plantListTableView.layer.shadowRadius = 30
        plantListTableView.layer.masksToBounds = false

    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        for (i, plant) in userPlants.enumerated() {
            let notiContent = UNMutableNotificationContent()
            //let date = Date(timeIntervalSinceNow: 15)
            notiContent.title = "\(plant.name) 물 줄 시간이예요!"
            notiContent.body = "물 뿌리개를 통해 \(plant.name)에게 물을 주세요."

            //let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            
            var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: plant.wateringDay)
            dateComponents.hour = Calendar.current.component(.hour, from: plant.alarmTime)
            dateComponents.minute = Calendar.current.component(.minute, from: plant.alarmTime)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: "watering_notification\(i)", content: notiContent, trigger: trigger)
                
            userNotificationCenter.add(request) { error in
                if let error = error {
                    print("Notification Error: ", error)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.shadowImage = UIImage()
        
        plantListTableView.reloadData()
        
        myUser.updateUser()
        calendar.reloadData()
        
        levelLabel.text = "\(myUser.level.name)"
        levelLabel.textColor = UIColor.black
        levelImage.image = UIImage(named: myUser.level.icon)
        if myUser.level.name != levels[0].name {
            hapinessImage.isHidden = false
            if myUser.hapiness < 70 {
                hapinessImage.image = UIImage(named: "sadPlant")
            } else {
                hapinessImage.image = UIImage(named: "happyPlant")
            }
        } else {
            hapinessImage.isHidden = true
        }
        
        var ChartEntry : [ChartDataEntry] = []
        let value_fill = PieChartDataEntry(value: 0)
        let value_empty = PieChartDataEntry(value: 0)
        
        /*
        pieChart.chartDescription?.text = "행복도"
        pieChart.chartDescription?.font = UIFont.boldSystemFont(ofSize: CGFloat(12))
        pieChart.chartDescription?.textColor = .lightGray
        pieChart.chartDescription?.textAlign = .right
        */
        value_fill.value = Double(myUser.hapiness)
        value_fill.label = ""
        value_empty.value = 100 - value_fill.value
        value_empty.label = ""
        
        ChartEntry.append(value_fill)
        ChartEntry.append(value_empty)
        
        let chartDataSet = PieChartDataSet(entries: ChartEntry, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        var colors: [NSUIColor] = []
        var color = UIColor(red: CGFloat(189.0/255), green: CGFloat(236.0/255), blue: CGFloat(182.0/255), alpha: 1)
        colors.append(color)
        color = UIColor(red: CGFloat(189.0/255), green: CGFloat(236.0/255), blue: CGFloat(182.0/255), alpha: 0.3)
        colors.append(color)
        
        pieChart.highlightPerTapEnabled =  false
        chartDataSet.drawIconsEnabled = false
        pieChart.rotationEnabled = false
        chartDataSet.colors = colors
        chartDataSet.drawValuesEnabled = false
        chartDataSet.selectionShift =  4
        pieChart.transparentCircleRadiusPercent = 0
        pieChart.holeRadiusPercent = 50
        pieChart.legend.enabled = false
        pieChart.chartDescription?.enabled = true
        pieChart.drawHoleEnabled = false
        pieChart.drawCenterTextEnabled = true
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: UIFont.labelFontSize),
            .foregroundColor: UIColor.gray
        ]
        
        let attributedString = NSAttributedString(string: "\(Int(value_fill.value))%", attributes: attributes)
        
        pieChart.centerAttributedText = attributedString
        
        pieChart.minOffset = 0
        pieChart.data = chartData
        pieChart.isHidden = false
    }
    
    
    func loadDummyData(){
        /*
        for type in plantType.plantAll{
            for plant in type {
                
               
                
                uploadDiaryImage(img: UIImage(named : plant.engName)!, title: "\(plant.engName)")
                uploadUserPlantImage(img: UIImage(named : plant.engName)!, title: "\(plant.engName)")
                
 
            }
        }
 */
    }
    
    @objc func showLevelView(sender: UIView) {
        if Auth.auth().currentUser == nil {
            //만약 로그인이 안된 상태라면
            performSegue(withIdentifier: "toLoginPage", sender: nil)
        } else {
            //만약 로그인이 된 상태라면
            myUser.userName = (Auth.auth().currentUser?.displayName) ?? "오류"
            performSegue(withIdentifier: "levelViewSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLoginPage" {
            if let nav = segue.destination as? CustomNavigationController, let detailVC = nav.topViewController as? LoginViewController{
                detailVC.homeView = self
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")

        formatter.dateFormat = "yyyy-MM-dd"
        let clicked_date_string = formatter.string(from: clickedDay)
        let current_date_string = formatter.string(from: Date())
        
        listPlantsIndex = []
        
        for i in 0..<userPlants.count {
            var watering_day_string = formatter.string(from: userPlants[i].wateringDay)
            
            if watering_day_string < current_date_string && userPlants[i].watered == 1 {
               
                userPlants[i].recentWater = formatter.string(from: userPlants[i].wateringDay)
                userPlants[i].wateringDay = Calendar.current.date(byAdding: .day, value: userPlants[i].waterPeriod, to: userPlants[i].wateringDay)!
                
                userPlants[i].totalWaterNum += 1
                userPlants[i].didWaterNum += 1
                
                               
                plantListTableView.reloadData()
                calendar.reloadData()
                userPlants[i].watered = 0

            } else if Calendar.current.compare(userPlants[i].wateringDay, to: Date(), toGranularity: .day) == .orderedAscending {
                userPlants[i].totalWaterNum += 1
                userPlants[i].wateringDay = Date()
            }
            
            if userPlants[i].totalWaterNum == 5 {
                userPlants[i].updateHappiness()
                
                myUser.updateUser()
            }
            //print("watering day : \(plant.wateringDay), compare : \(Calendar.current.compare(userPlants[i].wateringDay, to: Date(), toGranularity: .day) == .orderedSame)")

            watering_day_string = formatter.string(from: userPlants[i].wateringDay)
            
            if watering_day_string == clicked_date_string {
                listPlantsIndex.append(i)
            }
        }
        
        calendar.reloadData()
        saveUserInfo(user: myUser)
        saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
        
        
        if (!listPlantsIndex.isEmpty) {
            return listPlantsIndex.count
        } else {
            return 1
        }
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plantCell", for: indexPath) as! UserPlantTableViewCell
        
        if listPlantsIndex.isEmpty {
            cell.plantImage.isHidden = true
            cell.name.isHidden = true
            cell.location.isHidden = true
            cell.period.isHidden = true
            cell.plantColor.isHidden = true
            cell.noPlantLabel.isHidden = false
            cell.accessoryView?.isHidden = true
            return cell
        }
        
        cell.plantImage.isHidden = false
        cell.name.isHidden = false
        cell.location.isHidden = false
        cell.period.isHidden = false
        cell.plantColor.isHidden = false
        cell.noPlantLabel.isHidden = true
        cell.accessoryView?.isHidden = false
        
        //그림자
        //cell.addShadow()
        
        let item = userPlants[listPlantsIndex[indexPath.row]]
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy.MM.dd"

        let clicked_date_string = formatter.string(from: clickedDay)
        let current_date_string = formatter.string(from: Date())
        
        cell.noPlantLabel.isHidden = true
        cell.name.text = item.name
        cell.location.text = item.location
        cell.period.text = "\(item.waterPeriod) 일"
        cell.plantColor.tintColor = item.color.uiColor
        //cell.plantImage.image = UIImage(named: item.plantImage)
        downloadUserPlantImage(imgview: cell.plantImage, title: "\(item.plantImage)")
        cell.plantImage.layer.cornerRadius = cell.plantImage.frame.height / 2

        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 200
        
        let wateringButton = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        wateringButton.contentMode = .scaleAspectFit
        if (item.watered == 1) {
            wateringButton.image = UIImage(named: "watering_fill")
        }
        else {
            wateringButton.image = UIImage(named: "watering")
        }
        
        wateringButton.tag = indexPath.row
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(watering(sender: )))
        wateringButton.addGestureRecognizer(tapGesture)
        wateringButton.isUserInteractionEnabled = true
        
        cell.accessoryView = wateringButton
        
        if clicked_date_string != current_date_string {
            cell.accessoryView?.isHidden = true
        }
        
        return cell
    }
    
  
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
           if listPlantsIndex.isEmpty {
               return indexPath
           }
        
           let secondStoryboard = UIStoryboard.init(name: "MyPlant", bundle: nil)
           guard let secondVC = secondStoryboard.instantiateViewController(identifier: "myPlantSB") as? MyPlantViewController else {return indexPath}
           secondVC.myPlant = userPlants[listPlantsIndex[indexPath.row]]

        navigationController?.pushViewController(secondVC, animated: true)
           
           return indexPath
       }
 
    @objc func watering(sender: UITapGestureRecognizer){
        //sender.image = UIImage(named: "watering_fill")
        let wateringButton = sender.view as! UIImageView
        
        if userPlants[listPlantsIndex[wateringButton.tag]].watered == 1 {
            userPlants[listPlantsIndex[wateringButton.tag]].watered = 0
            wateringButton.image = UIImage(named: "watering")
        } else {
            userPlants[listPlantsIndex[wateringButton.tag]].watered = 1

            wateringButton.image = UIImage(named: "watering_fill")
        }
        
        saveUserInfo(user: myUser)
        saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
        
        
    }
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        
        plantListTableView.reloadData()
    }
}

extension HomeViewController: FSCalendarDataSource, FSCalendarDelegateAppearance {
    //이벤트 표시 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy-MM-dd"
        let calendarDate = formatter.string(from: date)
        
        var dotNum = 0
        for i in 0..<userPlants.count {
            let wateringDate = formatter.string(from: userPlants[i].wateringDay)
            if wateringDate == calendarDate {
                dotNum += 1
            }
        }
        
        return dotNum
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy-MM-dd"
        let calendarDate = formatter.string(from: date)
        var colors: [UIColor] = []
        for i in 0...userPlants.count-1 {
            let wateringDate = formatter.string(from: userPlants[i].wateringDay)
            
            if wateringDate == calendarDate {
                colors.append(userPlants[i].color.uiColor)
            }
        }
        
        if colors.isEmpty {
            return [UIColor.white]
        } else {
            return colors
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        clickedDay = date
        plantListTableView.reloadData()
    }
    
   
}



extension HomeViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .badge, .sound, .banner])
        //completionHandler([.alert, .badge, .sound])
    }
}


extension UIView {
    func addShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 30
        self.layer.shadowOffset = CGSize(width: 0, height: -10)

        self.layer.masksToBounds = false
        self.clipsToBounds = false
    }
}
