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

        let chat = messages[indexPath.row]
        cell.selectionStyle = .none
        //cell.notesLabel?.text = note.text
        return cell
    }
}