//
//  View.swift
//  VIPER Design Pattern Example
//
//  Created by DarkBringer on 5.10.2021.
//

import UIKit

// Responsible for UI
// Also Can be a ViewController
// Protocol
// Reference to presenter


class UserViewController: UIViewController, AnyView, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var presenter: AnyPresenter?
    
    private var tableView: UITableView = {
        let temp = UITableView()
        temp.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        temp.isHidden = true
        return temp
    }()
    private let label: UILabel = {
       let temp = UILabel()
        temp.textAlignment = .center
        temp.isHidden = true
        return temp
    }()
    var users: [User] = []
    var pokemons: [Pokemon] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.center = view.center
        view.backgroundColor = .systemTeal
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
    
    func update(with users: [User]) {
        print("Got users")
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
            
        }
    }
    func update(with pokemons: [Pokemon]) {
        print("Got pokemons")
        DispatchQueue.main.async {
            self.pokemons = pokemons
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.users = []
            self.label.isHidden = false
            self.tableView.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = pokemons[indexPath.row].name
        return cell
    }
    
}
