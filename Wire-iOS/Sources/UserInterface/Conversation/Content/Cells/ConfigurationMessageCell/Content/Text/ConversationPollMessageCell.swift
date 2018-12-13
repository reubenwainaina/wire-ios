//
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import UIKit

// TODO: Implement the poll cell

class ConversationPollMessageCell: UIView, ConversationMessageCell {
    typealias Configuration = Poll

    let pollView = PollView()
    var isSelected: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(pollView)
        pollView.translatesAutoresizingMaskIntoConstraints = false
        pollView.fitInSuperview(withTrailingInsets: -UIView.conversationLayoutMargins.right)
    }

    var selectionView: UIView? {
        return pollView
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with object: Poll, animated: Bool) {
        pollView.configure(with: object)
    }

}

// TODO: Implement the poll cell description

class ConversationPollMessageCellDescription: ConversationMessageCellDescription {
    typealias View = ConversationPollMessageCell
    let configuration: Poll

    weak var message: ZMConversationMessage?
    weak var delegate: ConversationCellDelegate?
    weak var actionController: ConversationMessageActionController?

    var showEphemeralTimer: Bool = false
    var topMargin: Float = 8

    let isFullWidth: Bool  = false
    let supportsActions: Bool = true
    let containsHighlightableContent: Bool = true

    let accessibilityIdentifier: String? = nil
    let accessibilityLabel: String? = nil

    init(poll: Poll) {
        self.configuration = poll
    }

}
