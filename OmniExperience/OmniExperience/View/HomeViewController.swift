//
//  HomeViewController.swift
//  OmniExperience
//
//  Created by Yalan Bravo Olvera on 06/07/20.
//  Copyright © 2020 Yalan Bravo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var postsTableView = UITableView()
    var pullToRefresh = UIRefreshControl()
    var reditPosts : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.configureViews()
        self.loadData()
    }
    
    @objc func loadData(){
        self.reditPosts = []
        self.postsTableView.reloadData()
        
        //Fetch posts
        ServiceController.shared.getRedditPosts(path: Constants.postsUrlPath, limit: 10, after: nil, completion: { [weak self] result in
            switch result{
                case .failure(let error) :
                    DispatchQueue.main.async {
                        print(error)
                        self?.pullToRefresh.endRefreshing()
                }
                case .success(let posts) :
                    DispatchQueue.main.async {
                        self?.reditPosts = posts
                        self?.pullToRefresh.endRefreshing()
                        self?.postsTableView.reloadData()
                }
            }
        })
    }
    
    func registerCells(){
        self.postsTableView.register(PostCell.self, forCellReuseIdentifier: CellReuseIndentifiers.postCell)
    }
    
    func configureViews(){
        //Header
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationItem.title = Constants.homeScreenTitle
        
        //Table
        self.view.addSubview(self.postsTableView)
        self.postsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.postsTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.postsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.postsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.postsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.postsTableView.delegate = self
        self.postsTableView.dataSource = self
        self.postsTableView.backgroundColor = Constants.colorLightGray
        self.postsTableView.separatorStyle = .none
        
        //Pull to refresh
        self.pullToRefresh.addTarget(self, action: #selector(self.loadData), for: .valueChanged)
        postsTableView.addSubview(self.pullToRefresh)
        
    }

}

//Table view functions
extension HomeViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reditPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIndentifiers.postCell, for: indexPath) as! PostCell
        
        cell.prepareCell(withPost: self.reditPosts[indexPath.row])
        
        tableView.estimatedRowHeight = 60
        
        return cell
    }
}
