//
//  SearchBottomSheetView.swift
//
//  Created by Gautam Raju on 11/10/24.
//

import UIKit

class SearchBottomSheetView: UIView {
    var searchBar: UISearchBar!
    var tableViewSearchResults: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white

        tableViewSearchResults = UITableView()
        tableViewSearchResults.register(SearchTableCell.self, forCellReuseIdentifier: Configs.searchTableViewID)
        tableViewSearchResults.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewSearchResults)

        
        NSLayoutConstraint.activate([

            tableViewSearchResults.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewSearchResults.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableViewSearchResults.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            tableViewSearchResults.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
