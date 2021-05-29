//
//  Presenter.swift
//  MVPExample
//
//  Created by Александр on 29.05.2021.

//Presenter is in charge of all the logic , including responding to user actions and updating the UI (via delegate). and the most important is that our presenter will not be UIKit dependent. which means well isolated, hence easily testable

import Foundation

//Declare presenter's functions
protocol UserPresenterDelegate: AnyObject {
    func presentUsers(users: [User])
    func presentAlert(title: String, message: String)
}

class UserPresenter {
    
    weak var delegate: UserPresenterDelegate?
    
    func getUsers() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {return}
        
        //weak self for preventing a retain cycle
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            //Getting, decoding data and passing it to the delegate
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self?.delegate?.presentUsers(users: users)
            } catch {
                print("error")
            }
        }
        
        task.resume()
    }
    
    func setViewDelegate(delegate: UserPresenterDelegate) {
        self.delegate = delegate
    }
    
    func didTap(user: User) {
        delegate?.presentAlert(title: user.name,
                               message: "\(user.name) has an email of \(user.email) & a username of \(user.username)")
    }
}
