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

/// A view for displaying the poll options.
class PollOptionView: UIView {

    let backgroundView = RoundedView()
    let label = UILabel()
    let percentLabel = UILabel()
    let stackView = UIStackView()

    init(option: PollOption) {
        super.init(frame: .zero)

        // backgroundView
        backgroundView.backgroundColor = UIColor.wr_color(from: option.color)
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.shape = .rounded(radius: 8)

        // label
        label.font = UIFont.normalLightFont
        label.textColor = UIColor.from(scheme: .textForeground)
        label.text = option.name
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stackView.addArrangedSubview(label)

        // percentLabel
        percentLabel.font = UIFont.normalLightFont
        percentLabel.textColor = UIColor.from(scheme: .textForeground)
        percentLabel.text = String(option.percent) + " %"
        percentLabel.setContentHuggingPriority(.required, for: .horizontal)
        stackView.addArrangedSubview(percentLabel)

        // stackView
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // backgroundView
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: CGFloat(option.percent / 100)),

            // stackView
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

/// A view for displaying a poll.
class PollView: UIView {

    var poll: Poll?
    var lines: [PollOptionView] = []

    let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        stackView.spacing = 8
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.fitInSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with poll: Poll) {
        self.poll = poll

        // remove the old lines
        lines.forEach(stackView.removeArrangedSubview)
        lines.forEach { $0.removeFromSuperview() }

        // add the new lines
        let options = poll.options.map(PollOptionView.init)
        options.forEach(stackView.addArrangedSubview)
        lines = options
    }

}
