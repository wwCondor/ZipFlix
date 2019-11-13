//
//  OptionsMenu.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 11/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class OptionsMenu: UIView {
    
    let clearInputNotification = Notification.Name(rawValue: Constants.clearInputNotificaitonKey)
    
    var genreOptions: [MenuOption] = [MenuOption]()
    
    var leftSideSelectedGenres: [MenuOption] = [MenuOption]()
    var rightSideSelectedGenres: [MenuOption] = [MenuOption]()
    
    var launchDirection: LaunchDirection = .fromRight
    
    private let optionCellId = "cellId"
    
    lazy var options: UITableView = {
        let options = UITableView()
        options.register(UITableViewCell.self, forCellReuseIdentifier: optionCellId)
        options.dataSource = self
        options.delegate = self
        options.backgroundColor = UIColor.clear
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
        createGenreOptions()
        addObserver()
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(removeSelection), name: clearInputNotification, object: nil)
    }
    
    @objc func removeSelection(sender: Notification) {
        leftSideSelectedGenres.removeAll()
        rightSideSelectedGenres.removeAll()
        createGenreOptions()
        options.reloadData()
    }
    
    func createGenreOptions() {
        genreOptions.removeAll() // Make sure it's empty before we fill it
        genreOptions.append(MenuOption(genre: .action,           id: 28,     selected: false))
        genreOptions.append(MenuOption(genre: .adventure,        id: 12,     selected: false))
        genreOptions.append(MenuOption(genre: .animation,        id: 16,     selected: false))
        genreOptions.append(MenuOption(genre: .comedy,           id: 35,     selected: false))
        genreOptions.append(MenuOption(genre: .crime,            id: 80,     selected: false))
        genreOptions.append(MenuOption(genre: .documentary,      id: 99,     selected: false))
        genreOptions.append(MenuOption(genre: .drama,            id: 18,     selected: false))
        genreOptions.append(MenuOption(genre: .family,           id: 10751,  selected: false))
        genreOptions.append(MenuOption(genre: .fantasy,          id: 14,     selected: false))
        genreOptions.append(MenuOption(genre: .history,          id: 36,     selected: false))
        genreOptions.append(MenuOption(genre: .horror,           id: 27,     selected: false))
        genreOptions.append(MenuOption(genre: .music,            id: 10402,  selected: false))
        genreOptions.append(MenuOption(genre: .mystery,          id: 9648,   selected: false))
        genreOptions.append(MenuOption(genre: .romance,          id: 10749,  selected: false))
        genreOptions.append(MenuOption(genre: .scienceFiction,   id: 878,    selected: false))
        genreOptions.append(MenuOption(genre: .tvMovie,          id: 10770,  selected: false))
        genreOptions.append(MenuOption(genre: .thriller,         id: 53,     selected: false))
        genreOptions.append(MenuOption(genre: .war,              id: 10752,  selected: false))
        genreOptions.append(MenuOption(genre: .western,          id: 37,     selected: false))
        
    }
    
    func setupConstraints() {
        
        let padding = 15

        addConstraintsWithFormat("H:|[v0]|", views: options)
        addConstraintsWithFormat("V:|-\(padding)-[v0]-\(padding)-|", views: options)
    }

    func findGenre(option searchOption: MenuOption, in array: [MenuOption]) -> Int? {
        for (index, item) in array.enumerated() {
            if item == searchOption {
                return index
            }
        }
        return nil
    }
}

extension OptionsMenu: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let menuOption = genreOptions[indexPath.row]
        
        if launchDirection == .fromRight {
            if menuOption.selected == false {
                if leftSideSelectedGenres.count <= 2 {
                    genreOptions[indexPath.row].selected = true
                    leftSideSelectedGenres.append(menuOption)
                    
                    print("Total: \(leftSideSelectedGenres.count). \(leftSideSelectedGenres)")
                } else {
                    print("Already selected 3 genres selected") // this should throw an error or have some visual/audio feedback
                }
            } else if menuOption.selected == true {
                genreOptions[indexPath.row].selected = false
                
                let itemToRemove = genreOptions[indexPath.row]
                
                guard let index = findGenre(option: itemToRemove, in: leftSideSelectedGenres) else { return }
        
                leftSideSelectedGenres.remove(at: index)
                print("Removed: \(itemToRemove)")
                print("New total: \(leftSideSelectedGenres.count). \(leftSideSelectedGenres)")
            }
            
        } else if launchDirection == .fromLeft {
                if menuOption.selected == false {
                    if rightSideSelectedGenres.count <= 2 {
                        genreOptions[indexPath.row].selected = true
                        rightSideSelectedGenres.append(menuOption)
                        
                        print("Total: \(rightSideSelectedGenres.count). \(rightSideSelectedGenres)")
                    } else {
                        print("Already selected 3 genres selected") // this should throw an error or have some visual/audio feedback
                    }
                } else if menuOption.selected == true {
                    genreOptions[indexPath.row].selected = false
                    
                    let itemToRemove = genreOptions[indexPath.row]
                    
                    guard let index = findGenre(option: itemToRemove, in: rightSideSelectedGenres) else { return }
            
                    rightSideSelectedGenres.remove(at: index)
                    print("Removed: \(itemToRemove)")
                    print("New total: \(rightSideSelectedGenres.count). \(rightSideSelectedGenres)")
                }
        }
        
        
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: optionCellId, for: indexPath)
        cell.selectionStyle = .none // removes cellselect color change
        cell.backgroundColor = UIColor.clear
        
        let sortedMenuOption = genreOptions.sorted(by: { $0.genre.string < $1.genre.string }) // sort alphabetically

        let menuOption = sortedMenuOption[indexPath.row]

        if menuOption.selected == true {
            cell.textLabel?.textColor = UIColor.white
        } else if menuOption.selected == false {
            cell.textLabel?.textColor = UIColor.black
        }
        
        cell.textLabel!.text = menuOption.genre.string
        return cell
    }

}

//class TableCell: UITableViewCell {
//    init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//
//    func setupView() {
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupView()
//    }
//
//}



