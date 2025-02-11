//
// Wire
// Copyright (C) 2019 Wire Swiss GmbH
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

import Foundation

extension ConversationContentViewController {
    
    @objc(scrollToMessage:completion:)
    public func scroll(to messageToShow: ZMConversationMessage, completion: ((UIView)->())? = .none) {
        guard messageToShow.conversation == self.conversation else {
            fatal("Message from the wrong conversation")
        }
        
        showLoadingView = true
        
        dataSource.find(messageToShow) { index in
            self.showLoadingView = false
            
            guard let indexToShow = index else {
                return
            }
            
            self.tableView.scrollToRow(at: indexToShow, at: .top, animated: false)
            if let cell = self.tableView.cellForRow(at: indexToShow) {
                completion?(cell)
            }
        }
    }
    
    @objc public func scrollToBottom() {
        self.dataSource.scrollToBottom()
    }
}
