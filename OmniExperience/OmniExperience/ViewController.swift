//
//  ViewController.swift
//  OmniExperience
//
//  Created by Yalan Bravo Olvera on 05/07/20.
//  Copyright © 2020 Yalan Bravo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ServiceController.shared.getRedditPosts(path: "/all/top.json", limit: 10, after: nil, completion: { [weak self] result in
            switch result{
            case .failure(let error) :
                print(error)
            case .success(let posts) :
                print("hell yeah")
            }
        })
    }


}

