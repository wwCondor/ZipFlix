//
//  PersonOptionsMenu.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 17/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class PersonOptionsMenu: OptionsMenu {
                
    var people: [Person] = [Person]() // genres from TheMovieDB
    var leftSideSelectedPeople: [Person] = [Person]() // Left side genre selections
    var rightSideSelectedPeople: [Person] = [Person]() // Right side genre selections
    
    override var cellId: String {
        return super.cellId + "personId"
    }
    
    override func setupView() {
        addSubview(options)
        getPeople()
        addObserver()
    }
    
    override func removeSelection(sender: Notification) {
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
                // Sort people by name
                let sortedPeople = people.sorted(by: { if let firstPersonName = $0.name, let secondPersonName = $1.name {
                    return firstPersonName < secondPersonName
                    }
                    return true
                })
                self.people = sortedPeople
                self.options.reloadData()
                print(self.people)
            }
        }
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

extension PersonOptionsMenu { // }: UITableViewDataSource, UITableViewDelegate {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPerson = people[indexPath.row] // Cell selected
        
        if launchDirection == .fromRight {
            if tableView.cellForRow(at: indexPath)?.textLabel?.textColor == UIColor.black {
                if leftSideSelectedPeople.count <= 0 {
                    leftSideSelectedPeople.append(selectedPerson)
                    print("Total: \(leftSideSelectedPeople.count)")
                    tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.white
                } else {
                    print("Already at max (1) selections")
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
                if rightSideSelectedPeople.count <= 0 {
                    rightSideSelectedPeople.append(selectedPerson)
                    print("Total: \(rightSideSelectedPeople.count)")
                    tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.white
                } else {
                    print("Already at max (1) selections")
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if people.count == 0 {
            return 1
        } else {
            return people.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.selectionStyle = .none // removes cellselect color change
        cell.backgroundColor = UIColor.clear
        
        if people.count == 0 {
            cell.textLabel!.text = "loading genre data..."
        } else {
            let person = people[indexPath.row]
            cell.textLabel!.text = person.name
            if launchDirection == .fromRight {
                if leftSideSelectedPeople.contains(person) {
                    cell.textLabel?.textColor = UIColor.white
                } else {
                    cell.textLabel?.textColor = UIColor.black
                }
            } else if launchDirection == .fromLeft {
                if rightSideSelectedPeople.contains(person) {
                    cell.textLabel?.textColor = UIColor.white
                } else {
                    cell.textLabel?.textColor = UIColor.black
                }
            }
        }
        
        return cell
    }

}
