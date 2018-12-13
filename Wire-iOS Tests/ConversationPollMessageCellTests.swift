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

import XCTest
@testable import Wire

// TODO: Convert to ConversationCellSnapshotTestCase
class ConversationPollMessageCellTests: ConversationCellSnapshotTestCase {

    let pollMessageText = """
    [POLL]{
        "question": "What is your favorite programming language?",
        "options": [
            {
                "name": "Swift",
                "percent": 74.9,
                "color": "rgba(238, 211, 105, 1)",
            },
            {
                "name": "Objective-C",
                "percent": 25.1,
                "color": "rgba(204, 232, 255, 1)",
            }
        ]
    }
    """

    override func setUp() {
        super.setUp()
        // recordMode = true
    }

    func testThatItRendersPoll() {
        // TODO: Render the snapshot
        let mesage = MockMessageFactory.textMessage(withText: pollMessageText)!
        verify(message: message)
    }

}
