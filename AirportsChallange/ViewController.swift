//
//  ViewController.swift
//  AirportsChallange
//
//  Created by Sravan Kumar on 16/06/17.
//  Copyright © 2017 com.honeywell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var airportsData: [[String: Any]] = {
        
        let results = AirportDataManager.sharedInstance.selectQuery(tableName: "Apt_info")
        return results as! [[String : Any]]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return airportsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellReuseIdetifiers().airportsCell)
        let dict = airportsData[indexPath.section]
        cell?.textLabel?.text = dict["icao"] as? String
        return cell!
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
