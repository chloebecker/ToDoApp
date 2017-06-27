//
//  ViewController.swift
//  CustomTVHeader
//
//  Created by Chloe Becker on 5/24/17.
//  Copyright © 2017 cbecker1. All rights reserved.
//

import UIKit

var sectionName = ""

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //
    //  HELPER FUNCTIONS
    //
    func dateToStr (date: Date) -> String {
        let dateFormatter = DateFormatter()
        //set format here:
        dateFormatter.dateFormat = "MMM d, h:mm a"
        //set dateString = formated date
        let dateString = dateFormatter.string(from: Date())
        
        return dateString
    }
    
    
    //
    //  SECTION functions
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 //temp
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
        -> String? {
            return "temp"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell1")
        cell?.textLabel?.text = "temp"
        
        return cell
    }
    

    //
    //  CELL functions
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            
            return 3 //temp
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            cell!.textLabel?.text = "temp"
            
            return cell!
    }


}

