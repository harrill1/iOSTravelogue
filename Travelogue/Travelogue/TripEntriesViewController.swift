//
//  TripEntriesViewController.swift
//  Travelogue
//
//  Created by Hayden Harrill on 12/7/18.
//  Copyright © 2018 Hayden Harrill. All rights reserved.
//

import UIKit

class TripEntriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var trip: Trip?
    @IBOutlet weak var entriesTableView: UITableView!
    
    
    @IBAction func addEntry(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showEntry", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.entriesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EntryViewController else {
            return
        }
        destination.trip = trip
    }
    
    func deleteEntry(at indexPath: IndexPath) {
        guard let entry = trip?.entrys?[indexPath.row],
            let managedContext = entry.managedObjectContext else {
                return
        }
        
        managedContext.delete(entry)
        
        do {
            try managedContext.save()
            
            entriesTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print("Could not delete expense")
            
            entriesTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip?.entrys?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = entriesTableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath)
        if let entry = trip?.entrys?[indexPath.row] {
            cell.textLabel?.text = entry.title
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteEntry(at: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showExpense", sender: self)
    }

}
