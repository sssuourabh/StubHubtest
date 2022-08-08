//
//  StubListCell.swift
//  StubHubSearch
//
//  Created by HT on 08/08/22.
//

import Foundation
import UIKit

protocol StubCellFeedable: AnyObject {
    func configureCell(_ model: PresentableEvents)
}
final class StubListCell: UITableViewCell {

    static var identifier: String {
        return String(describing: self)
    }
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Init Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureViews() {
        contentView.addSubview(cityLabel)
        contentView.addSubview(artistLabel)
        contentView.addSubview(priceLabel)
    }

    private func configureConstraints() {
        let padding: CGFloat = 12

        NSLayoutConstraint.activate([
            artistLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            artistLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            artistLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            
            cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cityLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: padding / 2),

            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            priceLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: padding / 2),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
}

extension StubListCell: StubCellFeedable {
    func configureCell(_ model: PresentableEvents) {
        self.cityLabel.text = model.city
        self.priceLabel.text = "\(model.price)"
        self.artistLabel.text = model.artistName
    }
}
