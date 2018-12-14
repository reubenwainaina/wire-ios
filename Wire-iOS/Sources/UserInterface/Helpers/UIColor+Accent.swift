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

import Foundation

extension UIColor {
    @objc static var accentDarken: UIColor {
        return accent().mix(.black, amount: 0.1).withAlphaComponent(0.32)
    }

    @objc static var accentDimmedFlat: UIColor {
        if ColorScheme.default.variant == .light {
            return accent().withAlphaComponent(0.16).removeAlphaByBlending(with: .white)
        } else {
            return accentDarken
        }
    }

    @objc (accentColor)
    class func accent() -> UIColor {
        return UIColor(fromZMAccentColor: indexedAccent)
    }

    @objc static func buttonEmptyText(variant: ColorSchemeVariant) -> UIColor {
        switch variant {
        case .dark:
            return .white
        case .light:
            return accent()
        }
    }


    private static var overridenAccentColor:ZMAccentColor = .undefined


    /// Set override accent color. Can set to ZMAccentColorUndefined to remove override.
    static var accentOverride: ZMAccentColor {
        get {
            return ZMUser.editableSelf().accentColorValue
        }

        set {
            if (overridenAccentColor == newValue) {
                return
            }

            overridenAccentColor = newValue

        }
    }

    static var indexedAccent: ZMAccentColor {
        // priority 1: overriden color
        guard overridenAccentColor == .undefined else {
            return overridenAccentColor
        }

        // priority 2: color from self user

        if let activeUserSession = SessionManager.shared?.activeUserSession {

            let selfUser = ZMUser.selfUser(inUserSession:  activeUserSession)

            let selfAccentColor: ZMAccentColor = selfUser.accentColorValue

            if selfAccentColor != .undefined {
                return selfAccentColor
            }
        }

        // priority 3: default color
        return .strongBlue
    }

}
