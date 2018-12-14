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


final class ClientListViewControllerSnapshotTests: XCTestCase {
    var sut: ClientListViewController!
    var mockUser: MockUser!
    var selfClient: UserClient!

    override func setUp() {
        super.setUp()

        let user = MockUser.mockUsers()[0]
        mockUser = MockUser(for: user)

        selfClient = mockUserClient()
    }

    override func tearDown() {
        sut = nil
        mockUser = nil
        selfClient = nil

        resetColorScheme()

        super.tearDown()
    }

    func testThatTableViewDoesNotOverlapNavigationBar() {
       // record = true

        let numDevice = 4

        prepareSut(variant: .light, numberOfClients: numDevice)
        let navWrapperController = sut.wrapInNavigationController()
        navWrapperController.navigationBar.tintColor = UIColor.accent()

        // make table view's cells visible
        navWrapperController.view.frame = CGRect(origin: .zero, size: XCTestCase.DeviceSizeIPhone6)
        navWrapperController.view.layoutIfNeeded()


        let tableView = self.sut.clientsTableView!
            tableView.scrollToRow(at: IndexPath(row:numDevice - 1, section: 1), at: .bottom, animated: false)
        assertSnapshot(matching: navWrapperController, as: .image)
    }

    /// Prepare SUT for snapshot tests
    ///
    /// - Parameters:
    ///   - variant: the color cariant
    ///   - numberOfClients: number of clients other than self device. Default: display 3 cells, to show footer in same screen
    func prepareSut(variant: ColorSchemeVariant?, numberOfClients: Int = 3) {
        var clientsList: [UserClient]? = nil

        for i in 0 ..< numberOfClients {
            if clientsList == nil {
                clientsList = []
            }
            let client = mockUserClient(model: "Simulator \(i)")
            clientsList?.append(client!)
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

