//
//  NewTripViewController.swift
//  Travelogue
//
//  Created by Hayden Harrill on 12/6/18.
//  Copyright © 2018 Hayden Harrill. All rights reserved.
//

import UIKit

class NewTripViewController: UIViewController {


    @IBOutlet weak var tripTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tripTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tripTextField.resignFirstResponder()
    }
    
    @IBAction func saveTrip(_ sender: Any) {
        let trip = Trip(title: tripTextField.text ?? "")
        
        do {
            try trip?.managedObjectContext?.save()
            
            self.navigationController?.popViewController(animated: true)
            //self.dismiss(animated: true, completion: nil)
        } catch {
            print("Could not save trip")
        }
    
    }
    
    
}



extension NewTripViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
