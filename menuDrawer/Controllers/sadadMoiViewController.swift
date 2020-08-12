//
//  sadadMoiViewController.swift
//  menuDrawer
//
//  Created by mac on 12/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class sadadMoiViewController: UIViewController {
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var tab_bar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table_view.register(UINib(nibName: "moiTableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
    }

}
extension sadadMoiViewController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:moiTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! moiTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
}
