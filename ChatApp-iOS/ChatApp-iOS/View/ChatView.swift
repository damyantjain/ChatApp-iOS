import UIKit

class ChatView: UIView {
    var chatBoxView: UIView!
    var chatTableView: UITableView!
    var chatTextField: UITextField!
    var sendButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUpChatBoxView()
        setUpChatTextField()
        setUpSendButton()
        setUpChatTableView()
        initConstraints()
    }

    func setUpChatBoxView() {
        chatBoxView = UIView()
        chatBoxView.layer.cornerRadius = 10
        chatBoxView.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.4)
        chatBoxView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chatBoxView)
    }

    func setUpChatTextField() {
        chatTextField = UITextField()
        chatTextField.textColor = UIColor.black
        chatTextField.placeholder = "Message"
        chatTextField.font = UIFont(name: "AvenirNext-Medium", size: 15)
        chatTextField.layer.cornerRadius = 8
        chatTextField.clipsToBounds = true
        chatTextField.translatesAutoresizingMaskIntoConstraints = false
        chatBoxView.addSubview(chatTextField)
    }

    func setUpSendButton() {
        sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        chatBoxView.addSubview(sendButton)
    }

    func setUpChatTableView() {
        chatTableView = UITableView()
        chatTableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "chats")
        chatTableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chatTableView)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            // Chat Box View
            chatBoxView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            chatBoxView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            chatBoxView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            chatBoxView.heightAnchor.constraint(equalToConstant: 44),

            // Chat Text Field
            chatTextField.leadingAnchor.constraint(equalTo: chatBoxView.leadingAnchor, constant: 8),
            chatTextField.centerYAnchor.constraint(equalTo: chatBoxView.centerYAnchor),
            chatTextField.heightAnchor.constraint(equalToConstant: 36),
            chatTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8),

            // Send Button
            sendButton.trailingAnchor.constraint(equalTo: chatBoxView.trailingAnchor, constant: -8),
            sendButton.centerYAnchor.constraint(equalTo: chatBoxView.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 50),
            sendButton.heightAnchor.constraint(equalToConstant: 36),

            // Chat Table View
            chatTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            chatTableView.bottomAnchor.constraint(equalTo: chatBoxView.topAnchor, constant: -8),
            chatTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            chatTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
