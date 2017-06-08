//
//  Add_Category_VC.swift
//  CustomTVHeader
//
//  Created by Chloe Becker on 6/8/17.
//  Copyright © 2017 cbecker1. All rights reserved.
//

import UIKit

class Add_Category_VC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // Outlets
    //

    @IBOutlet weak var txtCategory: UITextField!
    
    @IBAction func btnAddCategory(_ sender: Any) {
        var emptyField = false
        
        if(txtCategory.text! == "" ) {
            emptyField = true
            let alertController = UIAlertController(title: "Section Name Empty", message: "Please enter a name for your section", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            present(alertController, animated: true, completion: nil)
            
            print("Category could not be added because the text box was empty.")
        }
        
        if(!emptyField) {
            
            addCategory(category: txtCategory.text!)
        }
        
        txtCategory.text = ""
    }
    
    
    //
    // Helper Functions
    //
    
    func addCategory (category: String)
    {
        //links to table Accounts from table "context"
        //newAccount will be a new row in the table
        let newCategory = Categories(context: context)
        
        newCategory.catName = category
        
        //save in database
        appDelegate.saveContext()
        
        let alertController = UIAlertController(title: "Category Saved!", message: " ", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        present(alertController, animated: true, completion: nil)
        
        print("\(category) category was added successfully!")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
