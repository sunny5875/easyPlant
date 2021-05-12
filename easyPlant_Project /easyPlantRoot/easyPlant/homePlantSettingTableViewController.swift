//
//  homePlantSettingTableViewController.swift
//  easyPlant
//
//  Created by 현수빈 on 2021/05/09.
//

import UIKit

class homePlantSettingTableViewController: UITableViewController {

   
    @IBOutlet weak var redSlider: UISlider!
    
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var calendarColorImageView: UIImageView!
    
    @IBOutlet weak var alramDateLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBOutlet weak var colorChangeStackView: UIStackView!
    
   
    @IBOutlet weak var smallImageVIew: UIImageView!
    
    @IBAction func sliderChanged(_ sender: Any) {
        updateColor()
    }
    
    func updateColor(){
        var red: CGFloat=0
        var green: CGFloat=0
        var blue: CGFloat=0
        
       
        red=CGFloat(redSlider.value)
       
        green=CGFloat(greenSlider.value)
        
        blue=CGFloat(blueSlider.value)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)//1은 불투명도
        
        calendarColorImageView.backgroundColor = color
        smallImageVIew.backgroundColor = color
       
        
        
    }
    
    
    let calendarColorChangeCellIndexPath = IndexPath(row: 0, section: 0)
    let calendarColorChangeSliderCellIndexPath = IndexPath(row: 1, section:0)
    let alarmIndexPath = IndexPath(row: 0, section: 1)
    let datePickerCellIndexPath = IndexPath(row: 1, section:1)
    
    
    
    var isPickerShown: Bool = false {
        didSet {
            datePicker.isHidden = !isPickerShown
        }
    }
    
    var isColorSliderShown: Bool = false {
        didSet {
            colorChangeStackView.isHidden = !isColorSliderShown
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        smallImageVIew.layer.cornerRadius = 22
        calendarColorImageView.layer.cornerRadius = 100
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

  
    @IBAction func pickerValueChanged(_ sender: Any) {
        updateViews()
    }
    
    func updateViews(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        alramDateLabel.text = dateFormatter.string(from:datePicker.date)
    

    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt
    indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case calendarColorChangeSliderCellIndexPath:
            if isColorSliderShown {
                    return 216.0}
            else {return 0.0}
        case datePickerCellIndexPath:
            if isPickerShown {
                return 216.0
            } else {
                return 0.0
            }
        default:
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt
    indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        switch indexPath {
        case calendarColorChangeCellIndexPath:
    
            if isColorSliderShown {
                isColorSliderShown = false //나와있으니까 숨기는 것
            } else {
                isColorSliderShown = true
            }
    
            tableView.beginUpdates()
            tableView.endUpdates()
    
        case alarmIndexPath:
            if isPickerShown {
                isPickerShown = false
            } else {
                isPickerShown = true
            }
    
            tableView.beginUpdates()
            tableView.endUpdates()
    
        default:
            break
         }
     }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
