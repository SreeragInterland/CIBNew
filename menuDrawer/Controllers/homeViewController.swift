//
//  homeViewController.swift
//  CIB
//
//  Created by mac on 02/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit
import Charts
import DropDown
import Alamofire
import AlamofireImage
class homeViewController: CommonViewController {
    @IBOutlet weak var backGrade: UIImageView!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var tbleHgtCnstrnt: NSLayoutConstraint!
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var chartView: PieChartView!
    @IBOutlet weak var collection_view: UICollectionView!
    @IBOutlet weak var amountColctdToday: UILabel!
    @IBOutlet weak var todaysSpendLabel: UILabel!
    @IBOutlet weak var overDraftLabel: UILabel!
    @IBOutlet weak var availableBalanceLabel: UILabel!
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var sideBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var scroll_View: UIScrollView!
    @IBOutlet weak var fldHgtCnstrnt: NSLayoutConstraint!
    @IBOutlet weak var loadBtn: UIButton!
    @IBOutlet weak var tab_bar: UITabBar!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var loadBtnHgtCnstrnt: NSLayoutConstraint!
    
    var accountsArr:[String] = ["All"]
    var datePicker:UIDatePicker = UIDatePicker()
    var imageArr:[String] = ["menu_icon1","menu_icon4","menu_icon2","menu_icon3"]
    var typeArr:[String] = ["Payments","SADAD Pay","SADAD MOI","SADAD ESAL"]
    let players = ["SADAD Pay", "SADAD MOI", "SARIE", "Payroll", "SWIFT"]
    let goals = [1000, 500, 1000, 3000, 1500]
    let dropDown = DropDown()
    var toolBar = UIToolbar()
    var dateF:String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupDesign()
        tab_bar.selectedItem = tab_bar.items?[0]
    }
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "drawer"), object: self)
   
    }
    func setupDesign(){
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(dateBtnPrsd), name: Notification.Name("dateBtnPrsd"), object: nil)
        self.table_view.register(UINib(nibName: "mainTableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
        self.table_view.register(UINib(nibName: "headerTableViewCell", bundle: nil), forCellReuseIdentifier: "header")
        self.collection_view.register(UINib(nibName: "mainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell1")
        collection_view.dataSource = self
        collection_view.delegate = self
        collection_view.reloadData()
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "down-arrow"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        let container = UIView(frame: button.frame)
        container.backgroundColor = .clear
        container.addSubview(button)
        accountField.rightView = container
        accountField.rightViewMode = .always
        accountField.text = "All"
        dropDown.anchorView = self.accountField
        dropDown.bottomOffset = CGPoint(x: 0, y:fldHgtCnstrnt.constant)
        self.accountsArr.append(contentsOf: AppDefaults.shared.userDetails!.accountNumber)
        dropDown.dataSource = self.accountsArr
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.accountField.text = item
        }
        self.accountField.layer.borderWidth = 1
        self.accountField.layer.borderColor = UIColor.white.cgColor
        guard let prflImageStr:String = AppDefaults.shared.userDetails?.profileImg else{
            return
        }
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2
        self.profileImage.layer.masksToBounds = true
        let prflImageUrl:URL = URL(string: prflImageStr)!
        self.profileImage.af.setImage(withURL: prflImageUrl)
        self.nameLabel.text = AppDefaults.shared.userDetails?.userName
//        self.secondLabel.text = AppDefaults.shared.userDetails.
    //        self.profileImage.af
        
        self.accountView.layer.cornerRadius = 10
        self.accountView.layer.masksToBounds = true
        self.collection_view.layer.cornerRadius = 5
        self.collection_view.layer.masksToBounds = true
        self.table_view.layer.cornerRadius = 5
        self.table_view.layer.masksToBounds = true
        self.sideBtn.layer.cornerRadius = self.sideBtn.frame.height / 2
        self.sideBtn.layer.masksToBounds = true
    }
    @objc func dateBtnPrsd(){
        print("button pressed")
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor.white
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(datePicker)
        self.toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
    }
   @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy,hh:mm a"
        if let date = sender?.date {
            dateF = "\(dateFormatter.string(from: date))"
            self.table_view.reloadData()
            print("Picked the date \(dateFormatter.string(from: date))")
        }
    }
    @objc func onDoneButtonClick() {
        self.table_view.reloadData()
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    @IBAction func refresh(_ sender: Any) {
        dropDown.show()
    }
    override func updateViewConstraints() {
        tableHeightConstraint.constant = table_view.contentSize.height
        super.updateViewConstraints()
    }
    @IBAction func loadBtnPrsd(_ sender: UIButton) {
        tbleHgtCnstrnt.constant = 400
        self.loadBtn.isHidden = true
        loadBtnHgtCnstrnt.constant = 0
        self.scroll_View.flashScrollIndicators()
        self.scroll_View.scrollToBottom(animated: true)
    }
    func customizeChart(dataPoints: [String], values: [Double]) {
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        let chart = PieChartDataSet(entries: dataEntries, label: "")
           chart.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
           chart.sliceSpace = 2
           chart.selectionShift = 5
           chart.xValuePosition = .outsideSlice
           chart.yValuePosition = .outsideSlice
           chart.valueTextColor = .white
           chart.valueLineWidth = 0.5
           chart.valueLinePart1OffsetPercentage = 1.0
           chart.valueLinePart1Length = 0.3
           chart.valueLinePart2Length = 0.3
           chart.valueLineColor = .clear
           chart.drawValuesEnabled = true
           let chartData = PieChartData(dataSet: chart)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
            
        chartData.setValueFormatter(formatter)
        chartData.setValueFont(.systemFont(ofSize: 11, weight: .light))
        chartData.setValueTextColor(.white)
           chartView.data = chartData
            self.setup(pieChartView: chartView)
            chartView.legend.enabled = false
        let longString = "SAR 6500 \n Spend today"
        let longestWord = "SAR 6500"
        let longestWordRange = (longString as NSString).range(of: longestWord)

        let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name:"Roboto-Regular", size: 12), NSAttributedString.Key.foregroundColor : UIColor.white])

        attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "Roboto-Medium", size: 12), NSAttributedString.Key.foregroundColor : UIColor.white], range: longestWordRange)
            
        chartView.centerAttributedText = attributedString
        chartView.holeColor = UIColor(red: 10/255, green: 107/255, blue: 199/255, alpha: 1)
           chartView.setExtraOffsets(left: 30, top: 0, right: 40, bottom: 10)
            
    }
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        self.setDataCount(Int(5))
    }
    func setDataCount(_ count: Int) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<players.count {
            let dataEntry = PieChartDataEntry(value: goals.map{ Double($0) }[i], label: players[i], data: players[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
               
        let set = PieChartDataSet(entries: dataEntries, label: nil)
        set.sliceSpace = 2
        set.colors = ChartColorTemplates.vordiplom()
                   + ChartColorTemplates.joyful()
                   + ChartColorTemplates.colorful()
                   + ChartColorTemplates.liberty()
                   + ChartColorTemplates.pastel()
                   + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
               
        set.valueLinePart1OffsetPercentage = 0.8
        set.valueLinePart1Length = 0.2
        set.valueLinePart2Length = 0.4
        //set.xValuePosition = .outsideSlice
        set.yValuePosition = .outsideSlice
        let data = PieChartData(dataSet: set)
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .none
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.black)
        chartView.transparentCircleColor = UIColor.red
        chartView.data = data
        chartView.highlightValues(nil)
    }
           
    override func optionTapped(_ option: Option) {
        switch option {
            case .toggleXValues:
                   chartView.drawEntryLabelsEnabled = !chartView.drawEntryLabelsEnabled
                   chartView.setNeedsDisplay()
                   
            case .togglePercent:
                   chartView.usePercentValuesEnabled = !chartView.usePercentValuesEnabled
                   chartView.setNeedsDisplay()
                   
            case .toggleHole:
                   chartView.drawHoleEnabled = !chartView.drawHoleEnabled
                   chartView.setNeedsDisplay()
                   
            case .drawCenter:
                   chartView.drawCenterTextEnabled = !chartView.drawCenterTextEnabled
                   chartView.setNeedsDisplay()
                   
            case .animateX:
                   chartView.animate(xAxisDuration: 1.4)
                   
            case .animateY:
                   chartView.animate(yAxisDuration: 1.4)
                   
            case .animateXY:
                   chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4)
                
            case .spin:
                   chartView.spin(duration: 2,
                                  fromAngle: chartView.rotationAngle,
                                  toAngle: chartView.rotationAngle + 360,
                                  easingOption: .easeInCubic)
                   
            default:
                   handleOption(option, forChartView: chartView)
            }
        }
           
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors:[UIColor] = [self.hexStringToUIColor(hex: "#23A79A", alpha: 1),self.hexStringToUIColor(hex: "#2195A6", alpha: 1),self.hexStringToUIColor(hex: "#2CED9A", alpha: 1),self.hexStringToUIColor(hex: "#84F9E2", alpha: 1),self.hexStringToUIColor(hex: "#44E9C7", alpha: 1)]
        return colors
    }
        
    func getCollectionViewData(){
            
            
    }
    
}
extension homeViewController:UITableViewDataSource,UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return imageArr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell:mainTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! mainTableViewCell
                cell.image_view.image = UIImage(named: imageArr[indexPath.row])
            cell.title_label.text = "SADAD Pay"
            let dateFormatter:DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
            cell.desc_label.text = dateFormatter.string(from: Date())
            if(indexPath.row == 3 || indexPath.row == 2){
                cell.amount_label.textColor = self.hexStringToUIColor(hex: "EE2E24", alpha: 1)
            }else{
                 cell.amount_label.textColor = self.hexStringToUIColor(hex: "#00468C", alpha: 1)
            }
                return cell
        }
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let  headerCell = tableView.dequeueReusableCell(withIdentifier: "header") as! headerTableViewCell
            headerCell.but.addTarget(self, action: #selector(dateBtnPrsd), for: .touchUpInside)
            if(dateF != ""){
                headerCell.txtFld.text = dateF
            }
            return headerCell
            
          }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         
                return 80
            }
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
                return 80
        }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 70
        }
    }
    extension UIScrollView {
       func scrollToBottom(animated: Bool) {
         if self.contentSize.height < self.bounds.size.height { return }
         let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
         self.setContentOffset(bottomOffset, animated: animated)
      }
    }

    extension homeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell:mainCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! mainCollectionViewCell
            cell.image_view.image = UIImage(named: imageArr[indexPath.row])
            cell.title.text = self.typeArr[indexPath.row]
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imageArr.count
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 86 , height: 88)
        }
        
    }
extension homeViewController:UITabBarDelegate{
        func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            if(item.tag == 1){
                let vc:accountStatemtentViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "accountStatemtentViewController") as! accountStatemtentViewController
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "change"), object: ["centre":vc])
                      
            }else if(item.tag == 3){
                let vc:chatBotViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "chatBotViewController") as! chatBotViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
