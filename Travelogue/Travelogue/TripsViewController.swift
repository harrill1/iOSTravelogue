//
//  TripsViewController.swift
//  Travelogue
//
//  Created by Hayden Harrill on 12/7/18.
//  Copyright © 2018 Hayden Harrill. All rights reserved.
//

import UIKit

class TripsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var trips: [Trip] = []
    
    @IBOutlet weak var tripsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func deleteTrip(at indexPath: IndexPath) {
        let trip = trips[indexPath.row]
        
        guard let managedContext = trip.managedObjectContext else {
            return
        }
        
        managedContext.delete(trip)
        
        
        do {
            try managedContext.save()
            
            self.trips.remove(at: indexPath.row)
            self.tripsTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print("Could not delete")
            
            self.tripsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        
        return trips.count
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tripsTableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        
        let trip = trips[indexPath.row]
        
        cell.textLabel?.text = trip.title
        if let entryCount = trip.entrys?.count {
            cell.detailTextLabel?.text = String(entryCount)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if (trips[indexPath.row].entrys?.count ?? 0 > 0){
                let alert = UIAlertController(title: "Delete Trip", message: "Are you sure you would like to delete this trip?", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (alertAction) -> Void in return
                }))
                
                alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: { (alertAction) -> Void in self.deleteTrip(at: indexPath)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                deleteTrip(at: indexPath)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? TripEntriesViewController,
            let selectedRow = tripsTableView.indexPathForSelectedRow?.row else {
                return
        }
        
        destination.trip = trips[selectedRow]
    }



}
