//
//  accountStatemtentViewController.swift
//  CIB
//
//  Created by mac on 05/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit
import DropDown
class accountStatemtentViewController: CommonViewController {
    @IBOutlet weak var profile_imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var accountFld: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var table_view: UITableView!
  //  let interactor = Interactor()
    let dropDown = DropDown()
    var accountsArr:[String] = ["All"]
    var imageArr:[String] = ["a2","p1","s2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDesign()
        self.table_view.register(UINib(nibName: "statementTableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
              self.table_view.register(UINib(nibName: "statHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "header")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    func setUpDesign(){
        dropDown.anchorView = self.accountFld
               dropDown.bottomOffset = CGPoint(x: 0, y:40)
         //      self.accountsArr.append(contentsOf: AppDefaults.shared.userDetails!.accountNumber)
               dropDown.dataSource = self.accountsArr
               dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                   print("Selected item: \(item) at index: \(index)")
                   self.accountFld.text = item
               }
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "down-arrow"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        let container = UIView(frame: button.frame)
        container.backgroundColor = .clear
        container.addSubview(button)
        accountFld.rightView = container
        accountFld.rightView = container
        accountFld.rightViewMode = .always
        accountFld.text = "All"
        
        self.titleView.layer.cornerRadius = 10
        titleView.layer.shadowColor = UIColor.lightGray.cgColor
        titleView.layer.shadowOffset = CGSize(width: 1, height:2)
        titleView.layer.shadowOpacity = 0.6
        titleView.layer.shadowRadius = 2.0
        self.profile_imgView.layer.cornerRadius = self.profile_imgView.frame.height / 2
        self.profile_imgView.layer.masksToBounds = true
    }
    @IBAction func refresh(_ sender: Any) {
         dropDown.show()
     }
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "drawer"), object: self)
    //    sideMenuController?.showLeftView(animated:true, completionHandler:nil)
    }
    /*   @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
           let translation = sender.translation(in: view)

           let progress = MenuHelper.calculateProgress(translationInView: translation, viewBounds: view.bounds, direction: .Right)

           MenuHelper.mapGestureStateToInteractor( gestureState: sender.state, progress: progress,interactor: interactor){
                   self.performSegue(withIdentifier: "showSlidingMenu", sender: nil)
           }
       }
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let destinationViewController = segue.destination as? menuViewController {
               destinationViewController.transitioningDelegate = self
               destinationViewController.interactor = self.interactor
           }
       }*/
}
extension accountStatemtentViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell:statementTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! statementTableViewCell
        cell.but.setImage(UIImage(named: imageArr[indexPath.row]), for: .normal)
//        cell.but.setImage(UIImage(named: imageArr[indexPath.row]), for: .normal)
       //cell.imgView.image = UIImage(named: imageArr[indexPath.row])
        if indexPath.row == 0{
            cell.imgView.backgroundColor = self.hexStringToUIColor(hex: "#4E9C2D", alpha: 1)
            cell.amountLabel.textColor = self.hexStringToUIColor(hex: "#4E9C2D", alpha: 1)
        }else if(indexPath.row == 1){
            cell.imgView.backgroundColor = self.hexStringToUIColor(hex: "#E4E724", alpha: 1)
            cell.amountLabel.textColor = self.hexStringToUIColor(hex: "#E4E724", alpha: 1)
        }else if(indexPath.row == 2){
            cell.imgView.backgroundColor = self.hexStringToUIColor(hex: "#1087EF", alpha: 1)
            cell.amountLabel.textColor = self.hexStringToUIColor(hex: "#1087EF", alpha: 1)
        }
            return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let  headerCell = tableView.dequeueReusableCell(withIdentifier: "header") as! statHeaderTableViewCell
      
      return headerCell
      
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArr.count

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
/*extension accountStatemtentViewController: UIViewControllerTransitioningDelegate {

func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
return PresentMenuAnimator()
}

func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
return DismissMenuAnimator()
}

func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
return interactor.hasStarted ? interactor : nil
}

func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
return interactor.hasStarted ? interactor : nil
}
}

*/
