//
//  MessageListViewController.swift
//  ChatDemo
//
//  Created by mac on 26/07/21.
//

import UIKit
import StreamChatUI
import UIKit
import StreamChat

//class MessageList: ChatMessageListVC {}
class TypingIndicator: UILabel {
    func resetText() {
        text = "Nobody is typing"
    }
}

class MessageList: ChatMessageListVC {
    var typingIndicator: TypingIndicator!

    override func setUpLayout() {
        super.setUpLayout()

        typingIndicator = TypingIndicator()
        view.addSubview(typingIndicator)

        typingIndicator.backgroundColor = .lightGray
        typingIndicator.translatesAutoresizingMaskIntoConstraints = false
        typingIndicator.resetText()

        NSLayoutConstraint.activate([
            typingIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            typingIndicator.heightAnchor.constraint(equalToConstant: 30),
            typingIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            typingIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.topAnchor.constraint(equalTo: typingIndicator.bottomAnchor)
        ])
    }

    override func channelController(
        _ channelController: ChatChannelController,
        didChangeTypingUsers typingUsers: Set<ChatUser>
    ) {
        let typingUsersWithoutCurrentUser = typingUsers
            .filter { $0.id != self.channelController.client.currentUserId }

        guard let typingUser = typingUsersWithoutCurrentUser.first else {
            typingIndicator.resetText()
            return
        }
        typingIndicator.text = "\(typingUser.name ?? typingUser.id) is typing..."
    }
}

class MessageListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
