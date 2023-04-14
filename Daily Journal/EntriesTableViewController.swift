//
//  EntriesTableViewController.swift
//  Daily Journal
//
//  Created by Leandro Farias Lourenco on 17/02/23.
//

import UIKit
import CoreData

class EntriesTableViewController: UITableViewController {
    
    var entries: [Entry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getAppDelegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = getAppDelegate()!.persistentContainer.viewContext
        
        let request: NSFetchRequest<Entry> = Entry.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        entries = try! context.fetch(Entry.fetchRequest()) as [Entry]
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell")! as! EntryTableViewCell
        
        let entry = entries[indexPath.row]
        
        cell.entryTextLabel.text = entry.text
        cell.monthLabel.text = entry.month()
        cell.dateLabel.text = entry.day()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EntryIdentifier", sender: entries[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let entryVC = segue.destination as! EntryViewController
        entryVC.entriesVC = self
        if let entry = sender as? Entry {
            entryVC.entry = entry
        }
    }
    
}

