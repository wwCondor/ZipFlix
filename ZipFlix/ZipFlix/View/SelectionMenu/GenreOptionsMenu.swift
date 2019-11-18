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
        
    override var cellId: String {
        return super.cellId + "genreId"
    }
    
    override func setupView() {
        addSubview(options)
        getGenres()
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

    func findIndex(for selected: Genre, in array: [Genre]) -> Int? {
        for (index, item) in array.enumerated() {
            if item == selected {
                return index
            }
        }
        return nil
    }
    
}

extension GenreOptionMenu { //}: UITableViewDataSource, UITableViewDelegate {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGenre = genres[indexPath.row] // Cell selected
        
        if launchDirection == .fromRight {
            if tableView.cellForRow(at: indexPath)?.textLabel?.textColor == UIColor.black {
                if leftSideSelectedGenres.count <= 2 {
                    leftSideSelectedGenres.append(selectedGenre)
                    print("Total: \(leftSideSelectedGenres.count)")
                    tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.white
                } else {
                    print("Already at max (3) selections") // MARK: Alert
                }
            } else if tableView.cellForRow(at: indexPath)?.textLabel?.textColor == UIColor.white {
                let genreToRemove = selectedGenre
                guard let index = findIndex(for: selectedGenre, in: leftSideSelectedGenres) else { return }
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
                    print("Already at max (3) selections")  // MARK: Alert
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if genres.count == 0 {
            return 1
        } else {
            return genres.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.selectionStyle = .none // removes cellselect color change
        cell.backgroundColor = UIColor.clear
        
        if genres.count == 0 {
            cell.textLabel!.text = "loading genre data..."  // MARK: Alert?
        } else {
            let genre = genres[indexPath.row]
            cell.textLabel!.text = genre.name
            if launchDirection == .fromRight {
                if leftSideSelectedGenres.contains(genre) {
                    cell.textLabel?.textColor = UIColor.white
                } else {
                    cell.textLabel?.textColor = UIColor.black
                }
            } else if launchDirection == .fromLeft {
                if rightSideSelectedGenres.contains(genre) {
                    cell.textLabel?.textColor = UIColor.white
                } else {
                    cell.textLabel?.textColor = UIColor.black
                }
            }
        }
        return cell
    }

}









