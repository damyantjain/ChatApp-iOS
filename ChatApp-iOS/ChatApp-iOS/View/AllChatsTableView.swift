//
//  ChatsTableView.swift
//  ChatApp-iOS
//
//  Created by Saniya Anklesaria on 11/6/24.
//
import UIKit

class AllChatsTableView: UITableViewCell {

    var wrapperCellView: UIView!
    var senderNameLabel: UILabel!
    var messageTextLabel: UILabel!
    var timestampLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setupSenderNameLabel()
        setupMessageTextLabel()
        setupTimestampLabel()
        initConstraints()
    }

    func setupSenderNameLabel() {
        senderNameLabel = UILabel()
        senderNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        senderNameLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(senderNameLabel)
    }

    func setupMessageTextLabel() {
        messageTextLabel = UILabel()
        messageTextLabel.numberOfLines = 1
        messageTextLabel.font = UIFont(name: "AvenirNext-Medium", size: 14)
        messageTextLabel.textColor = .darkGray
        messageTextLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(messageTextLabel)
    }

    func setupTimestampLabel() {
        timestampLabel = UILabel()
        timestampLabel.font = UIFont.systemFont(ofSize: 12)
        timestampLabel.textColor = .gray
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(timestampLabel)
    }

    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([

            wrapperCellView.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 4),
            wrapperCellView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 6),
            wrapperCellView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -6),
            wrapperCellView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -4),

            senderNameLabel.topAnchor.constraint(
                equalTo: wrapperCellView.topAnchor, constant: 6),
            senderNameLabel.leadingAnchor.constraint(
                equalTo: wrapperCellView.leadingAnchor, constant: 0),

            messageTextLabel.topAnchor.constraint(
                equalTo: senderNameLabel.bottomAnchor, constant: 4),
            messageTextLabel.leadingAnchor.constraint(
                equalTo: wrapperCellView.leadingAnchor, constant: 0),
            messageTextLabel.trailingAnchor.constraint(
                equalTo: wrapperCellView.trailingAnchor, constant: -8),

            timestampLabel.centerYAnchor.constraint(
                equalTo: senderNameLabel.centerYAnchor),
            timestampLabel.trailingAnchor.constraint(
                equalTo: wrapperCellView.trailingAnchor, constant: -6),

            wrapperCellView.heightAnchor.constraint(equalToConstant: 50),

        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
