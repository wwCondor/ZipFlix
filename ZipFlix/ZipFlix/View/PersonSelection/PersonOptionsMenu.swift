//
//  PersonOptionsMenu.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 17/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class PersonOptionsMenu: UIView {
    
    let clearInputNotification = Notification.Name(rawValue: Constants.clearInputNotificationKey)
            
    var people: [Person] = [Person]() // genres from TheMovieDB
    var leftSideSelectedPeople: [Person] = [Person]() // Left side genre selections
    var rightSideSelectedPeople: [Person] = [Person]() // Right side genre selections
    
    var launchDirection: LaunchDirection = .fromRight
    
    private let optionCellId = "cellId"
    
    lazy var options: UITableView = {
        let options = UITableView()
        options.register(CustomCell.self, forCellReuseIdentifier: optionCellId)
        options.dataSource = self
        options.delegate = self
        options.backgroundColor = UIColor.clear
        options.allowsMultipleSelection = true // Works without this - delete?
        return options
    }()
    
    //init from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    //init from storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        addSubview(options)
        getPeople()
        addObserver()
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(removeSelection), name: clearInputNotification, object: nil)
    }
    
    @objc func removeSelection(sender: Notification) {
        // Remove selected color state
        if let indexes = options.indexPathsForSelectedRows {
            for index in indexes {
                options.deselectRow(at: index, animated: true)
                options.cellForRow(at: index)?.textLabel?.textColor = UIColor.black
            }
            options.reloadData()
        }
        leftSideSelectedPeople.removeAll()
        rightSideSelectedPeople.removeAll()
        options.reloadData()
    }
    
    func getPeople() {
        PeopleDataManager.fetchPopularPeople { (people, error) in
            DispatchQueue.main.async {
                guard let people = people else {
                    print("GenreError: Unable to obtain people") // MARK: Error Alert
                    return
                }
                self.people = people
                self.options.reloadData()
                print(self.people)
            }
        }
    }
    
    func setupConstraints() {
        let padding = 15

        addConstraintsWithFormat("H:|[v0]|", views: options)
        addConstraintsWithFormat("V:|-\(padding)-[v0]-\(padding)-|", views: options)
    }

    func findIndex(for selected: Person, in array: [Person]) -> Int? {
        for (index, item) in array.enumerated() {
            if item == selected {
                return index
            }
        }
        return nil
    }
    
}

extension PersonOptionsMenu: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPerson = people[indexPath.row] // Cell selected
        
        if launchDirection == .fromRight {
            if tableView.cellForRow(at: indexPath)?.textLabel?.textColor == UIColor.black {
                if leftSideSelectedPeople.count <= 2 {
                    leftSideSelectedPeople.append(selectedPerson)
                    print("Total: \(leftSideSelectedPeople.count)")
                    tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.white
                } else {
                    print("Already at max (3) genres")
                }
            } else if tableView.cellForRow(at: indexPath)?.textLabel?.textColor == UIColor.white {
                let genreToRemove = selectedPerson
                guard let index = findIndex(for: genreToRemove, in: leftSideSelectedPeople) else { return }
                leftSideSelectedPeople.remove(at: index)
                print("Removed: \(genreToRemove)")
                print("Total: \(leftSideSelectedPeople.count)")
                tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.black
            }
            
        } else if launchDirection == .fromLeft {
            if tableView.cellForRow(at: indexPath)?.textLabel?.textColor == UIColor.black {
                if rightSideSelectedPeople.count <= 2 {
                    rightSideSelectedPeople.append(selectedPerson)
                    print("Total: \(rightSideSelectedPeople.count)")
                    tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.white
                } else {
                    print("Already at max (3) genres")
                }
            } else if tableView.cellForRow(at: indexPath)?.textLabel?.textColor == UIColor.white {
                let genreToRemove = selectedPerson
                guard let index = findIndex(for: genreToRemove, in: rightSideSelectedPeople) else { return }
                rightSideSelectedPeople.remove(at: index)
                print("Removed: \(genreToRemove)")
                print("Total: \(rightSideSelectedPeople.count)")
                tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.black
            }
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if people.count == 0 {
            return 1
        } else {
            return people.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: optionCellId, for: indexPath)
        cell.selectionStyle = .none // removes cellselect color change
        cell.backgroundColor = UIColor.clear
        
        if people.count == 0 {
            cell.textLabel!.text = "loading genre data..."
        } else {
            cell.textLabel!.text = people[indexPath.row].name
        }
        
        return cell
    }

}
