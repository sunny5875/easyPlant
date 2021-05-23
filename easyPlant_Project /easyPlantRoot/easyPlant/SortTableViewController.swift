//
//  SortTableViewController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/04/30.
//

import UIKit


extension UIButton {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
       let border = CALayer()
       border.backgroundColor = color.cgColor
       border.frame = CGRect(x:0 + 10, y:self.frame.size.height - width, width:self.frame.size.width - 20, height:width)
       self.layer.addSublayer(border)
   }
}

class SortTableViewController: UITableViewController {

    @IBOutlet weak var leftOrder: UIButton!
    @IBOutlet weak var rightOrder: UIButton!
    var nowTitle  = ""
    var plantArrayIndex = 0
    var plantArray: [Plant] = []
    var selectOrderIndex = 0
    //일단 가장 먼저 스토리보드의 테이블 뷰 컨트롤러를 클릭한 후 class 칸에 TablViewController를 적어줘야 연결이 됨
    override func viewDidLoad() {
        super.viewDidLoad()
        findArray()
        updateSegControl()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func leftOrderSelect(_ sender: Any) {
        selectOrderIndex = 0
        updateSegControl()
        self.tableView.reloadData()
    }
    
    
    @IBAction func rightOrderSelect(_ sender: Any) {
        selectOrderIndex = 1
        updateSegControl()
        self.tableView.reloadData()
        
    }
    
    
    
    func updateSegControl(){
        let borderWidth: CGFloat = 1.0
        var borderColor : UIColor
        if selectOrderIndex == 0{
            borderColor =  UIColor.lightGray
            leftOrder.addBottomBorderWithColor(color: borderColor, width: borderWidth)
            
            borderColor =  UIColor.white
            rightOrder.addBottomBorderWithColor(color: borderColor, width: borderWidth)
        }
        else{
            borderColor  =  UIColor.lightGray
            rightOrder.addBottomBorderWithColor(color: borderColor, width: borderWidth)
            
            borderColor =  UIColor.white
            leftOrder.addBottomBorderWithColor(color: borderColor, width: borderWidth)
        }
    }
    
    func findArray(){
        
        nowTitle = self.navigationItem.title!
    
        var cnt : Int = 0
        for type in plantType.type {
            if type == nowTitle{ break}
            cnt += 1
        }
        
        plantArrayIndex = cnt
        print(plantArrayIndex)
        plantArray = plantType.plantAll[plantArrayIndex]
           
    }

   
    
      
    //그룹이라고 생각하면됨
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //이거 초기값은0 인데 1로 변경해줘야함
        return 1
    }

        //색션에 몇개의 셀이 있는가
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return plantArray.count%2==0 ? plantArray.count/2 : plantArray.count/2+1
    }

    
    //인덱스 패스에 어떤 셀로 화면 상에 출력 되는지
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("table view change")
        let cell: CellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "plantCell", for: indexPath) as! CellTableViewCell
        //셀 디자인 설정
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.white.cgColor
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        
       
        
        //segment 값에따라 데이터 정렬
        var plants: [Plant] = []
        
        switch selectOrderIndex {
        case 0: plants = plantArray.sorted{ $0.name.lowercased() < $1.name.lowercased()}
        case 1: plants = plantArray.sorted{ $0.like > $1.like}
        default: print("nothing")
            
        }

       
        
        //셀에서 완쪽 항목 불러오기
        let itemLeft = plants[indexPath.row*2]
        //이미지만들어두기
        let leftImage : UIImage? = UIImage(named: itemLeft.name)
        //위의 이미지로 이미지 버튼의 이미지 설정
        if let leftImage = leftImage  {
            cell.leftImageButton?.layer.borderWidth = 0.3
            cell.leftImageButton?.layer.borderColor = UIColor.lightGray.cgColor
            cell.leftImageButton?.setImage(leftImage, for: .normal)
           
        }
        //이미지버튼의 타이틀 설정
        cell.leftImageButton?.setTitle(itemLeft.name, for: .normal)
        //이름버튼의 타이틀 설정
        cell.leftButton?.setTitle(itemLeft.name, for: .normal)
        //각 버튼을 눌렀을 시 호출할 함수 설정
        cell.leftButton?.addTarget(self, action: #selector(SortTableViewController.leftButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        cell.leftImageButton?.addTarget(self, action: #selector(SortTableViewController.leftButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        

        
        
        //셀에서 오른쪽 항목 불러오기. 대신 총 항목의 개수가 홀수였던 경우는 마지막 셀의 오른쪽 항목은 생략
        if (indexPath.row*2+1) < plants.count{
            let itemRight = plants[indexPath.row*2+1]
            //이미지 설정
            let rightImage: UIImage? = UIImage(named: itemRight.name)
            
            if let rightImage = rightImage{
                cell.rightImageButton?.layer.borderWidth = 0.3
                cell.rightImageButton?.layer.borderColor = UIColor.lightGray.cgColor
                cell.rightImageButton?.setImage(rightImage, for: .normal)
            }
            
            //이미지 버튼의 타이틀 설정
            cell.rightImageButton?.setTitle(itemRight.name, for: .normal)
            //이름버튼의 타이틀 설정
            cell.rightButton?.setTitle(itemRight.name, for: .normal)
            
            //각 버튼을 눌렀을 시 호출할 함수 설정
            cell.rightButton?.addTarget(self, action: #selector(SortTableViewController.rightButtonTapped(_:)), for: UIControl.Event.touchUpInside)
            cell.rightImageButton?.addTarget(self, action: #selector(SortTableViewController.rightButtonTapped(_:)), for: UIControl.Event.touchUpInside)
            


        }
            
 
 
        // Configure the cell...

        return cell
    }
     
    
    @objc func leftButtonTapped(_ sender:UIButton!){
        print("leftsegue")
        self.performSegue(withIdentifier: "leftSegue", sender: sender)
    }
    @objc func rightButtonTapped(_ sender:UIButton!){
        print("rightsegue")
        self.performSegue(withIdentifier: "rightSegue", sender: sender)
    }
    //셀을 누르면 화면 전환하고 싶으면 selection segue way에 show 사용

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

    
    // MARK: - Navigation

    //
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let senderBut = sender as! UIButton
        
        if let vc = segue.destination as? PlantDetailViewController {
            vc.detailPlantName = senderBut.title(for: .normal)
            vc.detailPlantType = self.nowTitle
       
        }
        
        
    }
}
