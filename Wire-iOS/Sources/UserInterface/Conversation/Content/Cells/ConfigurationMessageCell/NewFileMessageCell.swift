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

import Foundation

//class NewFileMessageCell: MessageCell, ConfigurableCell {
//    
//    typealias Content = DefaultMessageCellDescription
//    typealias Configuration = DefaultMessageCellConfiguration
//    
//    static var mapping : [String : DefaultMessageCellConfiguration] = {
//        var mapping: [String : DefaultMessageCellConfiguration] = [:]
//        
//        for (index, variant) in DefaultMessageCellConfiguration.variants.enumerated() {
//            mapping["\(NSStringFromClass(NewFileMessageCell.self))_\(index)"] = variant
//        }
//        
//        return mapping
//    }()
//    
//    let fileMessageView: FileTransferView
//    
//    required init(from configuration: DefaultMessageCellConfiguration) {
//        fileMessageView = FileTransferView()
//        
//        super.init(from: configuration.configuration, content: fileMessageView)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configure(with content: DefaultMessageCellContent) {
//        super.configure(with: content.message, context: content.context)
//        
//        fileMessageView.configure(for: content.message, isInitial: false)
//    }
//    
//}
