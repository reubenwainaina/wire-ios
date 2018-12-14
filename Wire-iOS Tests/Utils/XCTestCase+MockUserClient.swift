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

extension XCTestCase {

    fileprivate static var _accentColor: ZMAccentColor!

    /// If this is set the accent color will be overriden for the tests
    var accentColor: ZMAccentColor {
        set {
            UIColor.accentOverride = newValue
        }
        get {
            return UIColor.accentOverride
        }
    }
}

extension XCTestCase {
    
    fileprivate static var _uiContext: NSManagedObjectContext!

    var uiContext: NSManagedObjectContext! {
        get {
            guard XCTestCase._uiContext == nil else {
                return XCTestCase._uiContext
            }


            var documentsDirectory: URL!

            do {
                documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            } catch {
                XCTAssertNil(error, "Unexpected error \(error)")
            }


            let contextExpectation: XCTestExpectation = expectation(description: "It should create a context")

            StorageStack.shared.createManagedObjectContextDirectory(accountIdentifier: UUID(),
                                                                    applicationContainer: documentsDirectory!,
                                                                    dispatchGroup: nil,
                                                                    startedMigrationCallback: nil,
                                                                    completionHandler: { contextDirectory in
                                                                        XCTestCase._uiContext = contextDirectory.uiContext

                                                                        contextExpectation.fulfill()

            })

            // Wait for the async request to complete
            waitForExpectations(timeout: 2, handler: nil)

            return XCTestCase._uiContext
        }

        set {
            XCTestCase._uiContext = newValue
        }
    }

    func mockUserClient(model: String = "Simulator") -> UserClient! {
        let client = UserClient.insertNewObject(in: uiContext)
        client.remoteIdentifier = "102030405060708090"

        client.user = ZMUser.insertNewObject(in: uiContext)
        client.deviceClass = "tablet"
        client.model = model
        client.label = "Bill's MacBook Pro"

        let fingerprint: Data? = "102030405060708090102030405060708090102030405060708090".data(using: .utf8)

        client.fingerprint = fingerprint

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let activationDate = formatter.date(from: "2016/05/01 14:31")

        client.activationDate = activationDate

        return client
    }

    //MARK: - color

    func resetColorScheme() {
        ColorScheme.default.variant = .light

        NSAttributedString.invalidateMarkdownStyle()
        NSAttributedString.invalidateParagraphStyle()
    }
}
