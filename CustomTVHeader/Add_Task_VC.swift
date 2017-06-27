//
//  Add_Task_ViewController.swift
//  CustomTVHeader
//
//  Created by Chloe Becker on 6/8/17.
//  Copyright © 2017 cbecker1. All rights reserved.
//

import UIKit

class Add_Task_ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickSection.delegate = self
        pickSection.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

        let date = Date()
        //let calendar = Calendar.current
        //let hour = calendar.component(.hour, from: date)
        //let minutes = calendar.component(.minute, from: date)
        
        if(!emptyField) {
            // do stuff
        }
        
        txtTask.text = ""

    }
    
    
    //
    // Category Picker Functions
    //
    func numberOfComponents (in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "temp"
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let name = "temp"
        return name
    }
    
    
    //
    // Helper Functions
    //

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
