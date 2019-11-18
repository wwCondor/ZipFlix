//
//  OptionsMenu.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 18/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class OptionsMenu: UIView {
    
    let clearInputNotification = Notification.Name(rawValue: Constants.clearInputNotificationKey)

    var launchDirection: LaunchDirection = .fromRight
    
    var cellId: String {
        return ""
    }
    
    lazy var options: UITableView = {
        let options = UITableView()
        options.register(CustomCell.self, forCellReuseIdentifier: cellId)
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
    
    func setupConstraints() {
        let padding = 15

        addConstraintsWithFormat("H:|[v0]|", views: options)
        addConstraintsWithFormat("V:|-\(padding)-[v0]-\(padding)-|", views: options)
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(removeSelection), name: clearInputNotification, object: nil)
    }
    
    @objc func removeSelection(sender: Notification) {}
    
}

extension OptionsMenu: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        return cell
    }

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
