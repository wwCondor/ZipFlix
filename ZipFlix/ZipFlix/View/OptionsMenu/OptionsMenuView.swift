//
//  OptionsMenu.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 11/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class OptionsMenu: UIView {
    
    var menuOptions: [MenuOption] = [MenuOption]()
    
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
        createMenuOptions()
    }
    
    func createMenuOptions() {
        menuOptions.append(MenuOption(genre: .action, selected: false))
        menuOptions.append(MenuOption(genre: .adventure, selected: false))
        menuOptions.append(MenuOption(genre: .animation, selected: false))
        menuOptions.append(MenuOption(genre: .children, selected: false))
        menuOptions.append(MenuOption(genre: .christmas, selected: false))
        menuOptions.append(MenuOption(genre: .comedy, selected: false))
        menuOptions.append(MenuOption(genre: .documentary, selected: false))
        menuOptions.append(MenuOption(genre: .drama, selected: false))
        menuOptions.append(MenuOption(genre: .foreign, selected: false))
        menuOptions.append(MenuOption(genre: .horror, selected: false))
        menuOptions.append(MenuOption(genre: .LGBTQ, selected: false))
        menuOptions.append(MenuOption(genre: .music, selected: false))
        menuOptions.append(MenuOption(genre: .romance, selected: false))
        menuOptions.append(MenuOption(genre: .scienceFictionAndFantasy, selected: false))
        menuOptions.append(MenuOption(genre: .thriller, selected: false))
        menuOptions.append(MenuOption(genre: .war, selected: false))
        menuOptions.append(MenuOption(genre: .western, selected: false))
    }
    
    func setupConstraints() {
        
        let padding = 15

        addConstraintsWithFormat("H:|[v0]|", views: options)
        addConstraintsWithFormat("V:|-\(padding)-[v0]-\(padding)-|", views: options)
    }
}

extension OptionsMenu: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let menuOption = menuOptions[indexPath.row]
        
        if menuOption.selected == false {
            menuOptions[indexPath.row].selected = true
        } else if menuOption.selected == true {
            menuOptions[indexPath.row].selected = false
        }
        tableView.reloadData()
        
        print("\(indexPath.row): \(menuOption.selected)")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: optionCellId, for: indexPath)
        cell.selectionStyle = .none // removes cellselect color change
        cell.backgroundColor = UIColor.clear

        let menuOption = menuOptions[indexPath.row]

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



