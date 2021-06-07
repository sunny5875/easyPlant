//
//  SortTableViewController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/04/30.
//

import UIKit




//버튼에 함수 확장
extension UIButton {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
       let border = CALayer()
       border.backgroundColor = color.cgColor
       border.frame = CGRect(x:0 + 10, y:self.frame.size.height - width, width:self.frame.size.width - 20, height:width)
       self.layer.addSublayer(border)
   }
}


//서치바에서 포커스가 벗어나면 내려가게 할려고 해본건데 효과 없음ㅠ
extension SortTableViewController : UISearchBarDelegate {
    
    func setDelegate(){
        print("setDelegate")
        searchController.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search button click")
        searchController.searchBar.resignFirstResponder()
    }
    
}


class SortTableViewController: UITableViewController, UISearchResultsUpdating {



    @IBOutlet weak var searchBar: UISearchBar!
    var searchController = UISearchController(searchResultsController: nil)
    
    
    var nowTitle  = ""
    var plantArrayIndex = 0
    var plantArray: [Plant] = []
    var resultPlantArray: [Plant] = []

    //이것도 키보드 내려가게 할려고 한건데 실패
    let gesture = UITapGestureRecognizer(target: self, action:  #selector(checkAction))
    //일단 가장 먼저 스토리보드의 테이블 뷰 컨트롤러를 클릭한 후 class 칸에 TablViewController를 적어줘야 연결이 됨
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidload")
        findArray()
        setUI()
        setDelegate()
        //updateSegControl()



    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        print("search view will appear")
        self.navigationItem.largeTitleDisplayMode =  .never
      

    }
    
    //서치바 커스텀하는 함수
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 100)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        path.fill()
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    
  
    //서치바에서 키보드 내려갈려고 추가 한건데 실패
    @objc func checkAction(sender : UITapGestureRecognizer) {
        print("checkaction")
        searchController.searchBar.resignFirstResponder()

    }


    //UI 디자인 설정
    func setUI(){

    
        searchController.searchBar.placeholder = ""
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.layer.borderWidth = 1
       // searchController.searchBar.layer.borderColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1)).cgColor
        let image = self.getImageWithColor(color: UIColor.systemGray6, size: CGSize(width: 370, height: 40))
        searchController.searchBar.setSearchFieldBackgroundImage(image, for: .normal)
        self.tableView.tableHeaderView = searchController.searchBar
       

        searchController.searchBar.layer.borderWidth = 1
        searchController.searchBar.layer.borderColor = UIColor.white.cgColor
        searchController.searchBar.tintColor = UIColor.black
    
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true

      

    }
    
    
    
    
    //서치바에서 검색하면 새로 테이블 뷰를 세팅한다
    func updateSearchResults(for searchController: UISearchController) {
        print("result")
        resultSearch(for: searchController.searchBar.text ?? "")
    }
    
    private func resultSearch(for searchText: String) {
        //아직 검색한게 없다면 - 임의의 셀을 추가 -> 그냥 디자인 때문
        if searchText != ""{
            resultPlantArray = plantArray.filter { plant in
            return
                plant.korName.lowercased().contains(searchText.lowercased())
            }
            if resultPlantArray.count == 0{
                resultPlantArray.append(Plant(korName: "", engName: "", from: "", sciName: "", temp: "", light: "", water: "", chara: "", def: "" ))
            }
            tableView.reloadData()
          
        }
        //검색을 완료했다면
        else {
            resultPlantArray = plantArray
            tableView.reloadData()

    

        }
    }
    

    //현재 식물 분류 배열이 뭔지 찾아둔다
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
        resultPlantArray = plantArray
           
    }

   
    
      
    //그룹이라고 생각하면됨
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //이거 초기값은0 인데 1로 변경해줘야함
        return 1
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 265
    }

        //색션에 몇개의 셀이 있는가
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return resultPlantArray.count%2==0 ? resultPlantArray.count/2 : resultPlantArray.count/2+1
    }

    
    //인덱스 패스에 어떤 셀로 화면 상에 출력 되는지
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("table view change")
        let cell: CellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "plantCell", for: indexPath) as! CellTableViewCell
        //셀 디자인 설정
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.contView.addGestureRecognizer(gesture)

        
        
        //segment 값에따라 데이터 정렬
        var plants: [Plant] = []
        plants = resultPlantArray.sorted{ $0.korName.lowercased() < $1.korName.lowercased()}
       
        
        //셀에서 완쪽 항목 불러오기
        let itemLeft = plants[indexPath.row*2]
        //이미지만들어두기
        let leftImage : UIImage? = UIImage(named: itemLeft.engName)
        //위의 이미지로 이미지 버튼의 이미지 설정
        if let leftImage = leftImage  {
            cell.leftImageButton?.setImage(leftImage, for: .normal)
           
        }
        //이미지버튼의 타이틀 설정
        cell.leftImageButton?.setTitle(itemLeft.korName, for: .normal)
        //이름버튼의 타이틀 설정
        cell.leftButton?.setTitle(itemLeft.korName, for: .normal)
        //ui 업데이트
        greenLeftUIUpdate(cell)
        //각 버튼을 눌렀을 시 호출할 함수 설정
        cell.leftButton?.addTarget(self, action: #selector(SortTableViewController.leftButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        cell.leftImageButton?.addTarget(self, action: #selector(SortTableViewController.leftButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        
        if itemLeft.def != "" {
            cell.leftLabel.text = itemLeft.def
        }
        
        //검색결과가 없다면
        if resultPlantArray.count == 1 && resultPlantArray[0].korName == "" {
            //ui 업데이트
            whiteLeftUIUpdate(cell)
            whiteRightUIUpdate(cell)

        }
        
        
        //셀에서 오른쪽 항목 불러오기. 대신 총 항목의 개수가 홀수였던 경우는 마지막 셀의 오른쪽 항목은 생략
        if (indexPath.row*2+1) < plants.count{
            let itemRight = plants[indexPath.row*2+1]
            //이미지 설정
            let rightImage: UIImage? = UIImage(named: itemRight.engName)
            
            if let rightImage = rightImage{
                cell.rightImageButton?.setImage(rightImage, for: .normal)
            }
            
            //이미지 버튼의 타이틀 설정
            cell.rightImageButton?.setTitle(itemRight.korName, for: .normal)
            //이름버튼의 타이틀 설정
            cell.rightButton?.setTitle(itemRight.korName, for: .normal)
            //ui 업데이트
            greenRightUIUpdate(cell)
            
            //각 버튼을 눌렀을 시 호출할 함수 설정
            cell.rightButton?.addTarget(self, action: #selector(SortTableViewController.rightButtonTapped(_:)), for: UIControl.Event.touchUpInside)
            cell.rightImageButton?.addTarget(self, action: #selector(SortTableViewController.rightButtonTapped(_:)), for: UIControl.Event.touchUpInside)
            if itemRight.def != "" {
                cell.rightLabel.text = itemRight.def
            }
                


        }
        else {
            //ui 업데이트
            whiteRightUIUpdate(cell)
            
        }
            
 
 
        // Configure the cell...

        return cell
    }
     
    
    //아래의 함수들은 모두 UI 설정 함수
    func greenRightUIUpdate(_ cell: CellTableViewCell){
        cell.rightCellView.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        cell.rightButton.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
    }
    
    func whiteRightUIUpdate(_ cell : CellTableViewCell) {
        cell.rightImageButton?.setImage(UIImage(), for: .normal)
        cell.rightImageButton?.layer.borderWidth = 0
        cell.rightImageButton?.layer.borderColor = UIColor.white.cgColor
        cell.rightButton?.setTitle(nil, for: .normal)
        
        cell.rightCellView.backgroundColor = UIColor.white
        cell.rightButton.backgroundColor = UIColor.white
        cell.rightLabel.text = ""
        
        //각 버튼을 눌렀을 시 호출할 함수 설정
        cell.rightButton?.removeTarget(self, action: #selector(SortTableViewController.rightButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        cell.rightImageButton?.removeTarget(self, action: #selector(SortTableViewController.rightButtonTapped(_:)), for: UIControl.Event.touchUpInside)
    }
    
    func greenLeftUIUpdate(_ cell: CellTableViewCell){
        cell.leftCellView.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        cell.leftButton.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
    }
    
    func whiteLeftUIUpdate(_ cell : CellTableViewCell) {
        cell.leftImageButton?.setImage(UIImage(), for: .normal)
        cell.leftButton?.setTitle(nil, for: .normal)
        cell.leftImageButton?.layer.borderWidth = 0
        cell.leftImageButton?.layer.borderColor = UIColor.white.cgColor
        
        cell.leftCellView.backgroundColor = UIColor.white
        cell.leftButton.backgroundColor = UIColor.white
        cell.leftLabel.text = ""
        
        //각 버튼을 눌렀을 시 호출할 함수 설정
        cell.leftButton?.removeTarget(self, action: #selector(SortTableViewController.rightButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        cell.leftImageButton?.removeTarget(self, action: #selector(SortTableViewController.rightButtonTapped(_:)), for: UIControl.Event.touchUpInside)
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

  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let senderBut = sender as! UIButton
        
        if let vc = segue.destination as? PlantDetailViewController {
            vc.detailPlantName = senderBut.title(for: .normal)
            vc.detailPlantType = self.nowTitle
            vc.navigationItem.title = senderBut.title(for: .normal)
       
        }
        
        
    }
    
   
}
