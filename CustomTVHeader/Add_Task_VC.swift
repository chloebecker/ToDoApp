//
//  Add_Task_ViewController.swift
//  CustomTVHeader
//
//  Created by Chloe Becker on 6/8/17.
//  Copyright © 2017 cbecker1. All rights reserved.
//

import UIKit

class Add_Task_ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //
    // Outlets and Vars
    //
    var categoryName = "Default"
    
    @IBOutlet weak var txtTask: UITextField!
    
    @IBOutlet weak var pickSection: UIPickerView!
    
    @IBAction func btnAddTask(_ sender: Any) {
        var emptyField = false
        
        if(txtTask.text! == "" ) {
            emptyField = true
            let alertController = UIAlertController(title: "Task Empty", message: "Please enter a name for your task", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            present(alertController, animated: true, completion: nil)
            
            print("Error: could not add task because text box is empty")
        }
        
        let date : NSDate? = nil
        
        if(!emptyField) {
            addNewTask(taskName: txtTask.text!, taskDue:  date!, category: categoryName, complete: false)
        }
        
        txtTask.text = ""

    }
    
    
    //
    // Helper Functions
    //
    
    func addNewTask (taskName: String, taskDue: NSDate, category: String, complete: Bool)
    {
        //links to table Accounts from table "context"
        //newAccount will be a new row in the table
        let newTask = Tasks (context: context)
        
        newTask.taskName = taskName
        //newTask.taskDate = taskDue
        //filler...
        newTask.taskDate = taskDue
        newTask.taskCat = category
        newTask.taskComplete = complete
        
        //save in database
        appDelegate.saveContext()
        
        //print what's in the database!!
        printTasks()
        
        let alertController = UIAlertController(title: "Task Saved", message: "Now available in task list", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func printTasks() {
        do {
            tasks = try context.fetch(Tasks.fetchRequest())
            // each is every row in this case
            for each in tasks {
                // use ! to unwrap text and remove "optional()" from the print statement
                print("name: \(each.taskName!) \n date: \(each.taskDate!)\n category: \(each.taskCat!) \n complete: \(each.taskComplete) \n\n")
            }
        } catch {
            print("Error connecting/fetching.")
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
