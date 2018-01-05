//
//  MainViewController.swift
//  readder
//
//  Created by Fran González on 17/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import UIKit
import SwiftSpinner
import ActionSheetPicker_3_0

class MainViewController : UIViewController {
    // Segmented buttons with the time selected by the user.
    @IBOutlet weak var timeButtons: UISegmentedControl!
    
    // Button that allows the user to select the subreddit from which to pick the post.
    @IBOutlet weak var selectedSubredditButton: UIButton!
    
    // Name of the selected subreddit.
    var selectedSubreddit: String? = nil
    
    // Story (post) we're going to send the StoryViewController.
    var story: Story? = nil
    
    // MARK: Lifecycle events.
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedSubredditButton.setTitle("select subreddit", for: .normal)
        
        // Initialize the Reddit things.
        SwiftSpinner.show("Connecting to Reddit...")
        _ = RedditApi.getAccessToken().subscribe(
            onNext: { _ in SwiftSpinner.hide() },
            onError: { error in print(error) }
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the top bar.
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the top bar again.
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: User interaction.
    @IBAction func goPressed(_ sender: UIButton) {
        SwiftSpinner.show("Loading your story from \(selectedSubreddit!)...")
        
        _ = RedditApi.getStories(from: selectedSubreddit!, time: .day).subscribe(
            onNext: { stories in
                self.story = randomStory(from: stories)
                SwiftSpinner.hide()
                
                self.performSegue(withIdentifier: "showStory", sender: sender)
            },
            onError: { error in print(error) }
        )
    }
    
    @IBAction func selectSubredditPressed(_ sender: UIButton) {
        // Load the subreddits from the saved ones by the user and get its names.
        let subreddits = Database.getSavedSubreddits()
        let subredditsName = subreddits.map { $0.name }
        
        // Show a bottom UIPicker with the subreddits.
        ActionSheetStringPicker.show(
            withTitle: "Select a subreddit",
            rows: subredditsName,
            initialSelection: 0,
            doneBlock: { picker, index, value in
                let pickedSubreddit = value as! String
                self.selectedSubredditButton.setTitle(pickedSubreddit, for: .normal)
                self.selectedSubreddit = pickedSubreddit
            },
            cancel: { _ in return }, origin: sender
        )
    }
    
    // MARK: Segue-related methods.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Show story segue.
        if segue.identifier == "showStory" {
            // Pass the title and post content of the story.
            let storyViewController = segue.destination as! StoryViewController
            storyViewController.story = story
        }
    }
}
