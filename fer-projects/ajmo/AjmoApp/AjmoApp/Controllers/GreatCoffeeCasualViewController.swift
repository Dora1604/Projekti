//
//  GreatCoffeeCasualViewController.swift
//  AjmoApp
//
//  Created by Dora Franjic on 26/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import UIKit

class GreatCoffeeCasualViewController: UIViewController {
    @IBAction func closeView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var viewModel: CasualViewModel!
    var filter: String!
        let cellReuseIdentifier = "cellReuseIdentifier"
        
    convenience init(viewModel: CasualViewModel, filter:String) {
            self.init()
            self.viewModel = viewModel
        self.filter = filter
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupTableView()
            bindViewModel()
            self.filterLabel.text = self.filter
        }
        
        func setupTableView() {
               tableView.backgroundColor = UIColor.lightGray
               tableView.delegate = self
               tableView.dataSource = self
               tableView.separatorStyle = .none

               refreshControl = UIRefreshControl()
               refreshControl.addTarget(self, action: #selector(GreatCoffeeCasualViewController.refresh), for: UIControl.Event.valueChanged)
               tableView.refreshControl = refreshControl
               tableView.register(UINib(nibName: "GreatCoffeeCasualTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
           }
        
        func bindViewModel() {
            viewModel.fetchCasual(filter:self.filter) {
            self.refresh()
            }
        }
            
        @objc func refresh() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }

    extension GreatCoffeeCasualViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150.0
        }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 0.0
        }
        
    }

    extension GreatCoffeeCasualViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! GreatCoffeeCasualTableViewCell
            if let casual = viewModel.casual(atIndex: indexPath.row) {
                cell.setup(withCasual: casual)
            }
            return cell
        }
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.numberOfCasuals()
        }
    }
