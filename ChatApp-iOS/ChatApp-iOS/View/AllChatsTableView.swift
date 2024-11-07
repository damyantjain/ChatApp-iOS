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
        messageTextLabel.font = UIFont.systemFont(ofSize: 12)
        messageTextLabel.textColor = .darkText
        messageTextLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(messageTextLabel)
    }
    
    func setupTimestampLabel() {
        timestampLabel = UILabel()
        timestampLabel.font = UIFont.systemFont(ofSize: 12)
        timestampLabel.textColor = .lightGray
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(timestampLabel)
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.layer.borderWidth = 1.0  // Set the desired border width
        wrapperCellView.layer.borderColor = UIColor.black.cgColor  // Set the desired border color
        wrapperCellView.layer.cornerRadius = 12.0
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 4),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
                                       
            senderNameLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 6),
            senderNameLabel.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            senderNameLabel.heightAnchor.constraint(equalToConstant: 20),
            senderNameLabel.widthAnchor.constraint(equalTo: wrapperCellView.widthAnchor),
            
            messageTextLabel.topAnchor.constraint(equalTo: senderNameLabel.topAnchor, constant: 18),
            messageTextLabel.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            messageTextLabel.heightAnchor.constraint(equalToConstant: 20),
            messageTextLabel.widthAnchor.constraint(equalTo: wrapperCellView.widthAnchor),
            
            timestampLabel.topAnchor.constraint(equalTo: senderNameLabel.topAnchor, constant: 18),
            timestampLabel.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -10),
            timestampLabel.heightAnchor.constraint(equalToConstant: 20),
            timestampLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
                                       
            wrapperCellView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    


       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
