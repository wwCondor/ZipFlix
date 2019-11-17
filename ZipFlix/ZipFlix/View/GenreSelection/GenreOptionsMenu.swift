//
//  OptionsMenu.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 11/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class GenreOptionMenu: OptionsMenu {
                
    var genres: [Genre] = [Genre]() // genres from TheMovieDB
    var leftSideSelectedGenres: [Genre] = [Genre]() // Left side genre selections
    var rightSideSelectedGenres: [Genre] = [Genre]() // Right side genre selections
        
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
    
    override func setupView() {
        addSubview(options)
        getGenres()
        addObserver()
    }
    
    override func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(removeSelection), name: clearInputNotification, object: nil)
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
        leftSideSelectedGenres.removeAll()
        rightSideSelectedGenres.removeAll()
        options.reloadData()
    }
    
    func getGenres() {
        GenreDataManager.fetchGenres { (genres, error) in
            DispatchQueue.main.async {
                guard let genres = genres else {
                    print("GenreError: Unable to obtain genres") // MARK: Error Alert
                    return
                }
                self.genres = genres
                self.options.reloadData()
                print(self.genres)
            }
        }
    }
    
    override func setupConstraints() {
        let padding = 15

        addConstraintsWithFormat("H:|[v0]|", views: options)
        addConstraintsWithFormat("V:|-\(padding)-[v0]-\(padding)-|", views: options)
    }

    func findIndex(for selected: Genre, in array: [Genre]) -> Int? {
        for (index, item) in array.enumerated() {
            if item == selected {
                return index
            }
        }
        return nil
    }
    
    
}

extension GenreOptionMenu: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGenre = genres[indexPath.row] // Cell selected
        

        
        if launchDirection == .fromRight {
            if tableView.cellForRow(at: indexPath)?.textLabel?.textColor == UIColor.black {
                if leftSideSelectedGenres.count <= 2 {
                    leftSideSelectedGenres.append(selectedGenre)
                    print("Total: \(leftSideSelectedGenres.count)")
                    tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.white
                } else {
                    print("Already at max (3) genres")
                }
            } else if tableView.cellForRow(at: indexPath)?.textLabel?.textColor == UIColor.white {
                let genreToRemove = selectedGenre
                guard let index = findIndex(for: genreToRemove, in: leftSideSelectedGenres) else { return }
                leftSideSelectedGenres.remove(at: index)
                print("Removed: \(genreToRemove)")
                print("Total: \(leftSideSelectedGenres.count)")
                tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.black
            }
            
        } else if launchDirection == .fromLeft {
            if tableView.cellForRow(at: indexPath)?.textLabel?.textColor == UIColor.black {
                if rightSideSelectedGenres.count <= 2 {
                    rightSideSelectedGenres.append(selectedGenre)
                    print("Total: \(rightSideSelectedGenres.count)")
                    tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.white
                } else {
                    print("Already at max (3) genres")
                }
            } else if tableView.cellForRow(at: indexPath)?.textLabel?.textColor == UIColor.white {
                let genreToRemove = selectedGenre
                guard let index = findIndex(for: genreToRemove, in: rightSideSelectedGenres) else { return }
                rightSideSelectedGenres.remove(at: index)
                print("Removed: \(genreToRemove)")
                print("Total: \(rightSideSelectedGenres.count)")
                tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.black
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if genres.count == 0 {
            return 1
        } else {
            return genres.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: optionCellId, for: indexPath)
        cell.selectionStyle = .none // removes cellselect color change
        cell.backgroundColor = UIColor.clear
        
        if genres.count == 0 {
            cell.textLabel!.text = "loading genre data..."
        } else {
            cell.textLabel!.text = genres[indexPath.row].name
        }
        
        return cell
    }

}


class OptionsMenu: UIView {
    
    let clearInputNotification = Notification.Name(rawValue: Constants.clearInputNotificationKey)

    var launchDirection: LaunchDirection = .fromRight
    
    private let optionCellId = "cellId"
    
    //init from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        addObserver()
    }
    
    //init from storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupConstraints()
        addObserver()
    }
    
    func setupView() {}
    
    func setupConstraints() {}
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(removeSelection), name: clearInputNotification, object: nil)
    }
    
    @objc func removeSelection(sender: Notification) {}
    
}


// do we need this?
class CustomCell: UITableViewCell {
    
    func setupCell() {
        textLabel?.textColor = UIColor.black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
}



