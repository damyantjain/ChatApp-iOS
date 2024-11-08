//
//  ChatTableViews.swift
//  ChatApp-iOS
//
//  Created by Damyant Jain on 11/6/24.
//

import UIKit

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "chats", for: indexPath)
            as! ChatTableViewCell

        let message = messages[indexPath.row]
        cell.selectionStyle = .none
        cell.messageTextLabel?.text = message.text
        cell.nameLabel?.text = message.senderName
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, HH:mm"
        cell.dateTimeLabel?.text = dateFormatter.string(from: message.timestamp)
        cell.configureProperties(
            isCurrentUser: message.senderId.lowercased()
                == loggedInUser.email.lowercased())
        return cell
    }
}
