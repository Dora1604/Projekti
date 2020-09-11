//
//  ViewController.swift
//  TopPop
//
//  Created by Dora Franjic on 19/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import UIKit
import DropDown

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let menu: DropDown = {
        let menu = DropDown()
        menu.dataSource = ["Normal", "Sort ascending", "Sort descending"]
        let images = ["circle.fill", "arrow.up", "arrow.down"]
               menu.cellNib = UINib(nibName: "MyCell", bundle: nil)
               menu.customCellConfiguration = {index, title, cell in
                   guard let cell = cell as? MyCell else {
                       return
                   }
                cell.myImageView.image = UIImage(systemName: images[index])
                cell.myImageView.tintColor = .white
                
               }
        return menu
    }()
  
    @IBAction func showMenu(_ sender: Any) {
        menu.show()
    }
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var list = ["Normal", "Sort asceding", "Sort descending"]
    let cellReuseIdentifier = "cellReuseIdentifier"
    var viewModel: SongsViewModel!
       
    convenience init(viewModel: SongsViewModel) {
           self.init()
           self.viewModel = viewModel
       }

    override func viewDidLoad() {
           super.viewDidLoad()
           setupTableView()
           bindViewModel()
           menu.anchorView = tableView
           menu.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1)
           menu.textColor = UIColor.white
            
           menu.selectionAction = { index, title in
               if index == 0 {
                self.viewModel.songs = self.viewModel.songs?.sorted(by: { $0.number < $1.number })
                self.refresh()
               } else if index == 1 {
                   self.viewModel.songs = self.viewModel.songs?.sorted(by: { $0.duration < $1.duration })
                   self.refresh()
               } else if index == 2 {
                   self.viewModel.songs = self.viewModel.songs?.sorted(by: { $0.duration > $1.duration })
                   self.refresh()
               }
               
           }
       }
    
    
       
    override func viewDidAppear(_ animated: Bool) {
           
       }
    func setupTableView() {
        tableView.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        tableView.register(UINib(nibName: "SongsTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    
    }
    
    func bindViewModel() {
        
        viewModel.fetchSongs {
            self.refresh()
        }
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
  
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/12.5
      }
      
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
          if let viewModel = viewModel.viewModel(atIndex: indexPath.row) {
            
              let singleViewController = SingleSongViewController(viewModel: viewModel)
              navigationController?.pushViewController(singleViewController, animated: true)
          }
      }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! SongsTableViewCell
        if indexPath.row % 3 == 0 {
            cell.backgroundColor = UIColor(red: 44/255, green: 61/255, blue: 79/255, alpha: 1)
        } else if indexPath.row % 3 == 1 {
            cell.backgroundColor = UIColor(red: 40/255, green: 55/255, blue: 71/255, alpha: 1)
        } else {
            cell.backgroundColor = UIColor(red: 36/255, green: 50/255, blue: 64/255, alpha: 1)
        }
        
        if let song = viewModel.song(atIndex: indexPath.row) {
            cell.setup(withSong: song)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSongs()
    }
 
       
}
