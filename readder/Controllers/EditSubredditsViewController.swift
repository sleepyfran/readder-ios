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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "subredditCell")
        tableView.isEditing = true
        
        subreddits = Database.getSavedSubreddits()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: Alerts.
    func showListEmptyAlert() {
        let alertController = simpleModal(
            title: "Subreddits empty",
            message: "The list cannot be empty",
            buttonTitle: "Okay",
            buttonHandler: { self.dismiss(animated: true, completion: nil) })
        
        self.present(alertController, animated: true, completion: nil)
    }
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
