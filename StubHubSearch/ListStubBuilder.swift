//
//  ListStubBuilder.swift
//  StubHubSearch
//
//  Created by HT on 08/08/22.
//

import Foundation
import UIKit

struct ListStubBuilder {
    func build() -> UIViewController {
        let viewModel = ListViewModel(service: StubSearchService())
        let viewController = ListViewController(viewModel: viewModel)
        
        viewModel.presenter = viewController

        return viewController
    }
}
