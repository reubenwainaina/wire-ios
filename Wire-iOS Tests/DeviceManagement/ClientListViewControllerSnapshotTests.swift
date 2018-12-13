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

import SnapshotTesting
import XCTest
@testable import Wire


final class ClientListViewControllerSnapshotTests: ZMSnapshotTestCase { ///TODO: restore to XCTEst after moving uiMOC
    var sut: ClientListViewController!
    var mockUser: MockUser!
    var client: UserClient!
    var selfClient: UserClient!

    override func setUp() {
        super.setUp()

        let user = MockUser.mockUsers()[0]
        mockUser = MockUser(for: user)

        selfClient = mockUserClient()
        client = mockUserClient()
    }

    override func tearDown() {
        sut = nil
        mockUser = nil
        client = nil
        selfClient = nil

        resetColorScheme()

        super.tearDown()
    }

    func testView() {
        record = true

        prepareSut(variant: .light, numberOfClients: 7)
        let navWrapperController = sut.wrapInNavigationController()
        navWrapperController.navigationBar.tintColor = UIColor.accent()

        assertSnapshot(matching: navWrapperController, as: .image)
    }

    /// Prepare SUT for snapshot tests
    ///
    /// - Parameters:
    ///   - variant: the color cariant
    ///   - numberOfClients: number of clients other than self device. Default: display 3 cells, to show footer in same screen
    func prepareSut(variant: ColorSchemeVariant?, numberOfClients: Int = 3) {
        var clientsList: [UserClient]? = nil

        for _ in 0 ..< numberOfClients {
            if clientsList == nil {
                clientsList = []
            }
            clientsList?.append(client)
        }

        sut = ClientListViewController(clientsList: clientsList,
                                       selfClient: selfClient,
                                       credentials: nil,
                                       detailedView: true,
                                       showTemporary: true,
                                       variant: variant)

        sut.showLoadingView = false
    }
}

