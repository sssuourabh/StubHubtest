//
//  FilterView.swift
//  StubHubSearch
//
//  Created by HT on 08/08/22.
//

import Foundation
import UIKit

final class FilterView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16.0
        stackView.distribution = .fillEqually
        return stackView
    }()
    internal lazy var cityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search city"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    internal lazy var priceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search price"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubview(stackView)
        stackView.addArrangedSubview(cityTextField)
        stackView.addArrangedSubview(priceTextField)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
