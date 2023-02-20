//
//  CustomViewController.swift
//  BauBuddyTaskList
//
//  Created by Sena Kurtak on 14.02.2023.
//

import UIKit
import SwiftHEXColors

class CustomViewController: UIViewController {
    
    @IBOutlet weak var taskTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel = CustomViewModel()
    var filteredData : [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        viewModel.delegate = self
        viewModel.getTasks()
        configureSearchBar()
    }
    func configureTableView(){
        taskTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        taskTableView.delegate = self
        taskTableView.dataSource = self
        taskTableView.refreshControl = UIRefreshControl()
        taskTableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        viewModel.realmSaveTask(tasks: viewModel.taskList)
    }
    @objc private func didPullToRefresh(){
        viewModel.realmDeleteAllTask()
        print("start refresh")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.getTasks()
            self.taskTableView.refreshControl?.endRefreshing()
        }
        viewModel.realmSaveTask(tasks: viewModel.taskList)
    }
    func configureSearchBar(){
        searchBar.delegate = self
        searchBar.directionalLayoutMargins = .zero
    }
    func filterContentForSearchText(_ searchText: String) {
        filteredData = viewModel.taskList.filter { (data: Task) -> Bool in
            return data.title!.lowercased().contains(searchText.lowercased()) || data.descriptionTask!.lowercased().contains(searchText.lowercased()) || data.task!.lowercased().contains(searchText.lowercased()) || data.colorCode!.lowercased().contains(searchText.lowercased())
        }
        taskTableView.reloadData()
    }
    func isFiltering() -> Bool {
        return !searchBar.text!.isEmpty
    }
}

extension CustomViewController : UITableViewDelegate, UITableViewDataSource, TasksViewModelDelegate, UISearchBarDelegate {
    
    func onSuccessfullTaksLoaded() {
        self.taskTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        225
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.realmTaksList.count == 0 {
            if isFiltering(){
                return filteredData.count
            }
            print("Displaying tableView content from RealmSwift")
            return viewModel.taskList.count
        } else {
            print("Displaying tableView content API")
            return viewModel.taskList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.layer.cornerRadius = 5;
        cell.layer.masksToBounds = true
        var data : [Task] = []
        if viewModel.realmTaksList.count == 0 {
            if isFiltering(){
                data = filteredData
            } else {
                data = viewModel.taskList
            }
        } else {
            data = viewModel.realmTaksList
        }
        cell.taskLabel.text = data[indexPath.row].task
        cell.titleLabel.text = data[indexPath.row].title
        cell.descriptionLabel.text = data[indexPath.row].descriptionTask
        cell.colorCodeLabel.text = data[indexPath.row].colorCode
        if let colorCode = data[indexPath.row].colorCode {
            cell.contentView.backgroundColor = UIColor(hexString: colorCode)
        }
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filterContentForSearchText("")
        searchBar.resignFirstResponder()
    }
    
}
