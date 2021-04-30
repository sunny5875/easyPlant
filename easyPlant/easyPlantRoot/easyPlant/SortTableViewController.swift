//
//  SortTableViewController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/04/30.
//

import UIKit

class SortTableViewController: UITableViewController {

    //일단 가장 먼저 스토리보드의 테이블 뷰 컨트롤러를 클릭한 후 class 칸에 TablViewController를 적어줘야 연결이 됨
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    
    //그룹이라고 생각하면됨
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //이거 초기값은0 인데 1로 변경해줘야함
        return 1
    }

        //색션에 몇개의 셀이 있는가
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    //인덱스 패스에 어떤 셀로 화면 상에 출력 되는지
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //화면 스크롤 시키면 사라진걸 재사용하기 위해 설정
        //재생 가능한 셀을 가져옴
        //뭘가져와야될지 identifier로 알려줌
        //여기에 설정한 이름 그대로 story 보드에서 원하는 셀을 클릭한 후 identifier 설정을 해줘야함
        //이거 하면서 테이블 뷰 스타일 basic으로 변경해주기
        let cell: CellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "plantCell", for: indexPath) as! CellTableViewCell
        
        let itemLeft = plants[indexPath.row*2]
        let itemRight = plants[indexPath.row*2+1]
        print(itemLeft)
        print(itemRight)
        
        let leftImage : UIImage? = UIImage(named: itemLeft.name)
        let rightImage: UIImage? = UIImage(named: itemRight.name)
        
        if let leftImage = leftImage , let rightImage = rightImage {
            print("success image")
            cell.leftImageButton?.setImage(leftImage, for: .normal)
            cell.rightImageButton?.setImage(rightImage, for: .normal)
        }
        
        cell.leftImageButton?.setTitle(itemLeft.name, for: .normal)
        cell.rightImageButton?.setTitle(itemRight.name, for: .normal)

        cell.leftButton?.setTitle(itemLeft.name, for: .normal)
        cell.rightButton?.setTitle(itemRight.name, for: .normal)
        
        cell.leftButton?.addTarget(self, action: #selector(SortTableViewController.leftButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        cell.rightButton?.addTarget(self, action: #selector(SortTableViewController.rightButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        cell.leftImageButton?.addTarget(self, action: #selector(SortTableViewController.leftButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        cell.rightImageButton?.addTarget(self, action: #selector(SortTableViewController.rightButtonTapped(_:)), for: UIControl.Event.touchUpInside)
 
 
        // Configure the cell...

        return cell
    }
     
    
    @objc func leftButtonTapped(_ sender:UIButton!){
        self.performSegue(withIdentifier: "leftSegue", sender: sender)
    }
    @objc func rightButtonTapped(_ sender:UIButton!){
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
            vc.data = senderBut.title(for: .normal)
       
        }
        
        
    }
}
