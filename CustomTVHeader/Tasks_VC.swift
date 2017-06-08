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
var sectionName = ""

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
//    let sections: [String] = ["Section 1", "Section 2", "Section 3"]
//    let s1Data: [String] = ["Row 1.1", "Row 2.1", "Row 3.1", "4.1"]
//    let s2Data: [String] = ["Row 1.2", "Row 2.2", "Row 3.2"]
//    let s3Data: [String] = ["Row 1.3", "Row 2.3", "Row 3.3", "4.3", "5.3"]
    
//    var sectionData: [Int: [String]] = [:]
    
    //dictionary values is an array of arrays
    var sectionData: [String: [[String]] ] = [:]
    
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
    
    
    //
    //  HELPER FUNCTIONS
    //
    
    // !!! need to account for empty entities/attributes!
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
        
        for index in categories {//0...categories.count {
            sectionData[index.catName!] = []
        }
        
        let numSections = sectionData.count
        
        if(numSections != 0) {
            for i in 0...numSections-1 {
                //create task array with task name, date due, and complete bool
                let name = tasks[i].taskName
                let date = tasks[i].taskDate
                let complete = tasks[i].taskComplete
                
                let dateStr = dateToStr(date: date as! Date)
                let completeStr = String(complete)
                let taskArray : [String] = [name!, dateStr, completeStr]
                
                //find the correct key (task) to assign value (if key number = section number)
                //^sections ordered based on order of key/val pairs in dictionary
                //stops after it's gone through each key/val pair in sectionData
                var keyIndex = 0
                for key in sectionData {
                    if (i == keyIndex){
                        var newValue = key.value
                        newValue.append(taskArray)
                        sectionData[key.key] = newValue
                        //!!! what if categories have the same name? Can't have duplicates!
                        break
                    }
                    keyIndex += 1
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
    
    
    //
    //  SECTION functions
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
        -> String? {
            return categories[section].catName
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
//        let dimension = CGRect(x: 30, y: 30, width: 75, height: 75)
//        rect = UIView(frame: dimension)
//        rect?.backgroundColor = UIColor.green
//        
//        //add to screen!
//        self.view.addSubview(rect!)
        
        //??? fix this? don't remember what it does
        //let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell\(section+1)")
        //^using this for now...
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell1")
        cell?.textLabel?.text = categories[section].catName
        
//        //add shape to cell!
//        cell?.addSubview(rect!)
        
        return cell
    }
    

    //
    //  CELL functions
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            var numRows = 10
            //loop through dict until key count = section
            var keyCount = 0
            //!!! is there a way to simplify this? It's used in several functions...
            // ^maybe a global var called "Section"?
            // ^maybe sectionData dictionary needs to have INTs instead of STRINGs as the key
            for key in sectionData {
                if (section == keyCount){
                    numRows = (key.value.count)
                    //??? is this not great code to have?
                    sectionName = key.key
                    break
                } else {
                    print("Error getting number of rows.")
                }
                keyCount += 1
            }
            //!!! need a better way to make sure the correct numRows is returned?
            return numRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
            }
            
            // !!!!! fix this! regular keyIndex won't work properly...
            var taskName = "Empty"
            let key = sectionName as Dictionary.Key
            let taskArray = sectionData[key]
            taskName = (taskArray?[indexPath.row][0])!

            cell!.textLabel?.text = taskName
            
            return cell!
    }


}

