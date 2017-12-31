//
//  StoryViewController.swift
//  readder
//
//  Created by Fran González on 27/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import UIKit
import Down

class StoryViewController: UIViewController {
    // Story that we will be showing.
    var story: Story!
    
    // MARK: Lifecycle events.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupMarkdownView()
    }
    
    // MARK: UI setup.
    func setupNavigationBar() {
        self.title = story.title
    }
    
    func setupMarkdownView() {
        // Create a DownView and set its AutoLayout properties.
        let markdownView = try! DownView(frame: self.view.bounds, markdownString: story.content)
        self.view.addSubview(markdownView)
        
        markdownView.translatesAutoresizingMaskIntoConstraints = false
        markdownView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        markdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        markdownView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        markdownView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
