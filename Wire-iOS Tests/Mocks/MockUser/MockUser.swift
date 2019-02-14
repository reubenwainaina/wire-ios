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
import WireSyncEngine

@objcMembers class MockUser: NSObject, UserType, Mockable {

    static var mockSelfUser: UserType! = nil

    var isAccountDeleted: Bool = false
    var displayName: String
    var initials: String?
    var connectionRequestMessage: String?
    var smallProfileImageCacheKey: String?
    var mediumProfileImageCacheKey: String?
    var previewImageData: Data?
    var completeImageData: Data?

    required init!(jsonObject: [AnyHashable : Any]!) {
        displayName = ""

        super.init()

        ///TODO:
//        clients = []
        isTeamMember = true
        for key: String in Array((jsonObject?.keys)!) as! [String] {
            if let value = jsonObject?[key] {
                self.setValue(value, forKey: key)
            } else {
                continue
            }
        }
    }


    func requestPreviewProfileImage() {
        //no op
    }

    func requestCompleteProfileImage() {
        //no op
    }

    func isGuest(in conversation: ZMConversation) -> Bool {
        return isGuestInConversation
    }

    func imageData(for size: ProfileImageSize, queue: DispatchQueue, completion: @escaping (Data?) -> Void) {
        switch size {
        case .preview:
            completion(previewImageData)
        case .complete:
            completion(completeImageData)
        default:
            break
        }

    }

    func refreshData() {
        // no-op
    }

    func connect(message: String) {

    }

    class func mockUser(for user: ZMUser?) -> MockUser {
        return (user as Any as! MockUser)
    }

    @objc
    class func mockUsers() -> [ZMUser] {
        return realMockUsers() as Any as! [ZMUser]
    }

    class func realMockUsers() -> [MockUser] {
        return MockLoader.mockObjects(of: (type(of: self) as! AnyClass), fromFile: "people-01.json") as! [MockUser]
    }

    class func mockSelf() -> MockUser {
        if mockSelfUser == nil {
            let mockUser = mockUsers().last as Any as! MockUser
            mockUser.isSelfUser = true
            mockSelfUser = mockUser
        }

        return mockSelfUser as! MockUser
    }


    class func mockService() -> MockUser? {
        return MockUser(jsonObject: [
        "name": "GitHub",
        "displayName": "GitHub",
        "isSelfUser": NSNumber(value: false),
        "isServiceUser": NSNumber(value: true),
        "isConnected": NSNumber(value: true),
        "accentColorValue": NSNumber(value: 1)
        ])
    }

    class func selfUser(in session: ZMUserSession?) -> (ZMUser & ZMEditableUser)? {
        let selfUser: Any
        if mockSelfUser != nil {
            selfUser = mockSelfUser
        } else {
            selfUser = mockSelf()
        }

        return (selfUser as Any as! (ZMUser & ZMEditableUser))
    }

    class func setMockSelf(_ newMockUser: UserType?) {
        mockSelfUser = newMockUser
    }

    var name: String?
    var emailAddress = ""
    var phoneNumber = ""
    var handle: String?
    var accentColorValue: ZMAccentColor = .undefined
    var isBlocked = false
    var isIgnored = false
    var isPendingApprovalByOtherUser = false
    var isPendingApprovalBySelfUser = false
    var isConnected = false
    var untrusted = false
    var trusted = false
    var totalCommonConnections: Int = 0
    var expiresAfter: TimeInterval = 0.0
    var isSelfUser = false
    var isServiceUser = false
    var isTeamMember = false
    var teamRole: TeamRole = .none
    var isGuestInConversation = false
    var canManageTeam = false
    var hasTeam = false
    var expirationDisplayString = ""
    var isWirelessUser = false

    var usesCompanyLogin = false
    var readReceiptsEnabled = false
    var user: ZMUser?
    ///TODO:
//    var clients: NSSet<UserClientType> = []
    var connection: ZMConnection?
    var contact: ZMAddressBookContact?
    var addressBookEntry: AddressBookEntry?
    var remoteIdentifier: UUID?
    var availability: Availability?
    private(set) var clientsRequiringUserAttention: Set<UserClient> = []

    func displayName(in conversation: MockConversation?) -> String? {
        return displayName
    }

    func fetchUserClients() {
        // no op
    }
}

