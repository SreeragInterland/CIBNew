//
//  sadadMoiViewController.swift
//  menuDrawer
//
//  Created by mac on 12/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit
import MGSwipeTableCell
class sadadMoiViewController: CommonViewController {
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var tab_bar: UITabBar!
    var dataDicArr:[[String:String]] = [[String:String]]()
     var colorArr:[UIColor] = [UIColor]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        table_view.register(UINib(nibName: "moiTableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
        self.addBtn.layer.cornerRadius = self.addBtn.frame.height / 2
        self.addBtn.layer.masksToBounds = true
        addBtn.layer.shadowColor = UIColor.lightGray.cgColor
              addBtn.layer.shadowOffset = CGSize(width:0, height:0)
              addBtn.layer.shadowOpacity = 1
              addBtn.layer.shadowRadius = 8
        dataDicArr = [["name":"Abdul Latif Jameel United Finance","amount":"100.00 SAR","id":"123424214","type":"Pending Approved","date":"02-Aug-2020"],["name":"Saudi Credit Bureau","amount":"200.00 SAR","id":"123424344","type":"Approved","date":"01-Aug-2020"],["name":"Samba Service Payment","amount":"70.00 SAR","id":"123424534","type":"Pending Approved","date":"20-Jul-2020"],["name":"Samba Service Payment","amount":"70.00 SAR","id":"123424333","type":"Approved","date":"16-Jul-2020"]]
         colorArr = [self.hexStringToUIColor(hex: "#4E9C2D", alpha: 1),self.hexStringToUIColor(hex: "#1087EF", alpha: 1),self.hexStringToUIColor(hex: "#9451e0", alpha: 1),self.hexStringToUIColor(hex: "#e4a724", alpha: 1)]
    }
    @IBAction func menuBtnPrsd(_ sender: UIButton) {
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "drawer"), object: self)
    }
    @IBAction func addBtnPrsd(_ sender: UIButton) {
    }
    
}
extension sadadMoiViewController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:moiTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! moiTableViewCell
        let dic:[String:String] = self.dataDicArr[indexPath.row]
        cell.titleLabel.text = dic["name"]
        cell.amountLabel.text = dic["amount"]
        cell.dateLabel.text = dic["date"]
        cell.idLabel.text = dic["id"]
        cell.statusLabel.text = dic["type"]
        if(dic["type"] == "Approved"){
            cell.downView.backgroundColor = self.hexStringToUIColor(hex: "4d9fe3", alpha: 1)
        }else{
            cell.downView.backgroundColor = self.hexStringToUIColor(hex: "e9a840", alpha: 1)
        }
        cell.frstLtrLbl.text = String(dic["name"]!.prefix(1))
        let i = indexPath.row % self.colorArr.count
        cell.titleView.backgroundColor = colorArr[i]
        cell.amountLabel.textColor = colorArr[i]
        cell.leftButtons = [MGSwipeButton(title: "",icon: UIImage(named:"tick"), backgroundColor: UIColor.clear, callback: {
          (sender: MGSwipeTableCell!) -> Bool in
              print("delete index\(indexPath.row)")
              return true
        }),MGSwipeButton(title: "", icon: UIImage(named:"remove"), backgroundColor: UIColor.clear,callback: {
          (sender: MGSwipeTableCell!) -> Bool in
            print("edit index\(indexPath.row)")
              return true
        }),MGSwipeButton(title: "", icon: UIImage(named:"repair"), backgroundColor: UIColor.clear,callback: {
          (sender: MGSwipeTableCell!) -> Bool in
            print("edit index\(indexPath.row)")
              return true
        })]
        cell.swipeBackgroundColor = UIColor(patternImage: UIImage(named: "gradian")!)
        cell.leftSwipeSettings.transition = .drag
        //cell.leftSwipeSettings.
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDicArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
  /*  func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let closeAction = UIContextualAction(style: .normal, title:  "Close", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                print("OK, marked as Closed")
                success(true)
            })
           // closeAction.image = UIImage(named: "tick")
            closeAction.backgroundColor = UIColor(patternImage: UIImage(named: "cellBg")!)
    let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                  print("OK, marked as Edited")
                  success(true)
              })
          //    editAction.image = UIImage(named: "tick")
              editAction.backgroundColor = UIColor(patternImage: UIImage(named: "cellBg")!)
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                      print("OK, marked as Closed")
                      success(true)
                  })
                 // deleteAction.image = UIImage(named: "tick")
        deleteAction.backgroundColor = UIColor(patternImage: UIImage(named: "cellBg")!)
            return UISwipeActionsConfiguration(actions: [closeAction,editAction,deleteAction])
    
    }*/
}
