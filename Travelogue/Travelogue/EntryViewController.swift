//
//  EntryViewController.swift
//  Travelogue
//
//  Created by Hayden Harrill on 12/6/18.
//  Copyright © 2018 Hayden Harrill. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var trip: Trip?
    
    @IBAction func saveEntity(_ sender: UIBarButtonItem) {
        let name = nameTextField.text
        let body = bodyTextField.text
        let date = datePicker.date
        
        if let entry = Entry(title: name, body: body, date: date) {
            trip?.addToEntry(entry)
            
            do {
                try entry.managedObjectContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            } catch {
                print("Entry could not be created")
            }
        }
    }
  
    @IBAction func takePhoto(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func choosePhoto(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nameTextField.delegate = self
        //bodyTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        bodyTextField.resignFirstResponder()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EntryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
