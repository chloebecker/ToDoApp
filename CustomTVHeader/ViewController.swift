//
//  ViewController.swift
//  CustomTVHeader
//
//  Created by Chloe Becker on 5/24/17.
//  Copyright © 2017 cbecker1. All rights reserved.
//

import UIKit

var categories = [Categories]()
var tasks = [Tasks]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
//    let sections: [String] = ["Section 1", "Section 2", "Section 3"]
//    let s1Data: [String] = ["Row 1.1", "Row 2.1", "Row 3.1", "4.1"]
//    let s2Data: [String] = ["Row 1.2", "Row 2.2", "Row 3.2"]
//    let s3Data: [String] = ["Row 1.3", "Row 2.3", "Row 3.3", "4.3", "5.3"]
    
//    var sectionData: [Int: [String]] = [:]
    
    var sectionData: [String: [String]] = [:]
    
    var rect: UIView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateSectionData()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        sectionData = [0:s1Data, 1:s2Data, 2:s3Data]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func populateSectionData() {
        do {
            categories = try context.fetch(Categories.fetchRequest())
        } catch {
            print("Error connecting/fetching categories.")
        }
        
        do {
            tasks = try context.fetch(Tasks.fetchRequest())
        } catch {
            print("Error connecting/fetching tasks.")
        }
        
        for index in categories {
            sectionData[index] = []
        }
        
        let numSections = sectionData.count
        
        for i in 0...numSections-1 {
            //create task array with task name and date due
            var name = tasks[i].taskName
            var date = tasks[i].taskDate
            var dateStr = dateToStr(date: date as! Date)
            var taskArray : [String] = [name!, dateStr]
            
            //find the correct key (task) to assign value
            var keyCount = 0
            for key in sectionData {
                if (i == keyCount){
                    key.key.append(taskArray)
                    //!!! what if categories have the same name? Can't have duplicates!
                }
            }
            
        }
        
        
    }
    
    func dateToStr (date: Date) -> String {
        let dateFormatter = DateFormatter()
        //set format here:
        dateFormatter.dateFormat = "MMM d, h:mm a"
        //set dateString = formated date
        let dateString = dateFormatter.string(from: Date())
        
        return dateString
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            var numRows = 10
            //loop through dict until key count = section
            var keyCount = 0
            for key in sectionData {
                if (section == keyCount){
                    numRows = (key.value.count)
                } else {
                    print("Error getting number of sections.")
                }
                keyCount += 1
            }
            return
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
        -> String? {
            return categories[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
//        let dimension = CGRect(x: 30, y: 30, width: 75, height: 75)
//        rect = UIView(frame: dimension)
//        rect?.backgroundColor = UIColor.green
//        
//        //add to screen!
//        self.view.addSubview(rect!)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell\(section+1)")
        cell?.textLabel?.text = sections[section]
        
//        //add shape to cell!
//        cell?.addSubview(rect!)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
            }
            
            cell!.textLabel?.text = sectionData[indexPath.section]![indexPath.row]
            
            return cell!
    }


}

