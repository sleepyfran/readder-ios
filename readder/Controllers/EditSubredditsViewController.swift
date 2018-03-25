//
//  EditSubredditsController.swift
//  readder
//
//  Created by Fran González on 22/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import UIKit

class EditSubredditsViewController : UITableViewController {
    // Subreddits loaded from the database.
    var subreddits: [Subreddit] = []
    
    // MARK: Lifecycle events.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure the table view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "subredditCell")
        tableView.isEditing = true
        
        // Hide the table view's separator line.
        tableView.separatorColor = UIColor.clear
        
        subreddits = Database.getSavedSubreddits()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: Alerts.
    
    /**
     Shows an alert indicating that the subreddits list cannot be empty.
    */
    func showListEmptyAlert() {
        self.showPopup(
            title: "Subreddits empty",
            message: "The list cannot be empty",
            buttonTitle: "Okay",
            buttonHandler: { self.dismiss(animated: true, completion: nil) }
        )
    }
    
    // MARK: User interaction.
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        // Show the new subreddit popup dialog.
        self.showInputPopup(
            title: "Add a new subreddit",
            message: "Make sure it's a text subreddit!",
            textFieldPlaceholder: "nosleep",
            buttonTitle: "Add",
            buttonHandler: { subredditName in
                // Add the subreddit to the database.
                Database.add(name: subredditName, time: "day")
                
                DispatchQueue.main.async {
                    self.subreddits = Database.getSavedSubreddits()
                    self.tableView.reloadData()
                }
            }
        )
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Database interaction.
    func removeSubreddit(at index: Int) {
        Database.removeSubreddit(subreddits[index])
        subreddits.remove(at: index)
    }
    
    // MARK: UITableViewDataSource methods.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subreddits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subredditCell", for: indexPath)
        let subreddit = subreddits[indexPath.row]
        
        cell.textLabel?.text = subreddit.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Don't let the list be empty.
            if subreddits.count == 1 {
                showListEmptyAlert()
                return
            }
            
            // Delete the row from the data source and make an animation.
            removeSubreddit(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Insert a new row with the data.
        }
    }
}
