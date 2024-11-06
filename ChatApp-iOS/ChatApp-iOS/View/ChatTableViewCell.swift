//
//  ChatTableViewCell.swift
//  ChatApp-iOS
//
//  Created by Damyant Jain on 11/6/24.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    var wrapperCellView: UIView!
    var messageTextLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setUpTextLabel()
        initConstraints()
    }

    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.layer.cornerRadius = 10
        wrapperCellView.layer.shadowColor = UIColor.black.cgColor
        wrapperCellView.layer.shadowOpacity = 0.1
        wrapperCellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        wrapperCellView.layer.shadowRadius = 4

        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }

    func setUpTextLabel() {
        messageTextLabel = UILabel()
        messageTextLabel.translatesAutoresizingMaskIntoConstraints = false
        messageTextLabel.numberOfLines = 0
        messageTextLabel.font = UIFont(name: "AvenirNext-Medium", size: 14)
        wrapperCellView.addSubview(messageTextLabel)
    }

    func configureConstraints(isCurrentUser: Bool) {
        if isCurrentUser {
            NSLayoutConstraint.activate([
                wrapperCellView.trailingAnchor.constraint(
                    equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                    constant: -10)
            ])
        } else {
            NSLayoutConstraint.activate([
                wrapperCellView.leadingAnchor.constraint(
                    equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                    constant: 10)
            ])
        }
    }

    func configureProperties(isCurrentUser: Bool) {
        if isCurrentUser {
            wrapperCellView.backgroundColor = UIColor.systemBlue
                .withAlphaComponent(0.7)
            messageTextLabel.textColor = UIColor.white
        } else {
            wrapperCellView.backgroundColor = UIColor.systemGray5
            messageTextLabel.textColor = UIColor.black
        }
        configureConstraints(isCurrentUser: isCurrentUser)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            wrapperCellView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5
            ),
            wrapperCellView.widthAnchor.constraint(
                lessThanOrEqualTo: self.safeAreaLayoutGuide.widthAnchor,
                multiplier: 0.8
            ),

            messageTextLabel.topAnchor.constraint(
                equalTo: wrapperCellView.topAnchor, constant: 6),
            messageTextLabel.bottomAnchor.constraint(
                equalTo: wrapperCellView.bottomAnchor, constant: -6),
            messageTextLabel.leadingAnchor.constraint(
                equalTo: wrapperCellView.leadingAnchor, constant: 12),
            messageTextLabel.trailingAnchor.constraint(
                equalTo: wrapperCellView.trailingAnchor, constant: -12),
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
