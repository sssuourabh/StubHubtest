//
//  FilterViewController.swift
//  StubHubSearch
//
//  Created by Acadly iOS Dev on 08/08/22.
//

import Foundation
import UIKit

protocol FilterAndSearchDelegate: AnyObject {
    func filter(cityText: String?, priceText: String?)
}

class FilterViewController: UIViewController {
    enum Constants {
        static let defaultHeight: CGFloat = 300
        static let maxDimmedAlpha: CGFloat = 0.6
    }
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = Constants.maxDimmedAlpha
        return view
    }()

    private lazy var filterView: FilterView = {
        let filterView = FilterView()
        filterView.translatesAutoresizingMaskIntoConstraints = false
        return filterView
    }()
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?

    weak var filterDelegate: FilterAndSearchDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupView() {
        view.backgroundColor = .clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.numberOfTapsRequired = 1
        dimmedView.addGestureRecognizer(tapGesture)
    }

    @objc func tapped() {
        self.dismiss(animated: true) {
            self.filterDelegate?.filter(
                cityText: nil,
                priceText: nil
            )
        }
    }

    @objc func searchTapped() {
        self.dismiss(animated: true) {
            self.filterDelegate?.filter(
                cityText: self.filterView.cityTextField.text,
                priceText: self.filterView.priceTextField.text
            )
        }
    }

    private func setupConstraints() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        containerView.addSubview(filterView)
        containerView.addSubview(searchButton)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(
            equalToConstant: Constants.defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor, constant: 0)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true

        NSLayoutConstraint.activate([
            filterView.bottomAnchor.constraint(equalTo: searchButton.topAnchor, constant: -50),
            filterView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            filterView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            searchButton.widthAnchor.constraint(equalToConstant: 100),
            searchButton.heightAnchor.constraint(equalToConstant: 55),
            searchButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 8),
            searchButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
