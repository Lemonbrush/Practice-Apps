//
//  ViewController.swift
//  MVPExample
//
//  Created by Александр on 29.05.2021.
//

// View is a dumb object that basically shows information that presenter tells to show
// View constantly asks presenter what to do with user actions and does nothing more other than just displaying information

import UIKit

class UsersViewController: UIViewController {
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let presenter = UserPresenter()
    
    private var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Users"
        
        //Setting up tableView
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        //Setting up presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getUsers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }

}

//MARK: - Presenter

extension UsersViewController: UserPresenterDelegate {
    
    func presentUsers(users: [User]) {
        self.users = users
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - TableView

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter.didTap(user: users[indexPath.row])
    }
}

