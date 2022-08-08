//
//  ListViewModel.swift
//  StubHubSearch
//
//  Created by HT on 07/08/22.
//

import Foundation

protocol ListViewPresenter: AnyObject {
    func showEvents()
    func showError(_ error: String)
}
final class ListViewModel {
    private(set) var dataSource = [PresentableEvents]()
    private(set) var filteredDatasource = [PresentableEvents]()
    private(set) var filterIsOn: Bool = false
    let service: StubSearchServiceable
    weak var presenter: ListViewPresenter?
    required init(service: StubSearchServiceable) {
        self.service = service
    }
}

extension ListViewModel: ListViewModelable {
    func searchData(cityText: String?, pricetext: String?) {
        var citySerachText = ""
        var priceTextSearch = ""
        if let cityText = cityText {
            citySerachText = cityText
        }
        if let pricetext = pricetext {
            priceTextSearch = pricetext
        }
        
        if citySerachText.count > 0 || priceTextSearch.count > 0 {
            filteredDatasource.removeAll()

            dataSource.forEach { event in
                filteredDatasource = dataSource.filter { $0.city.range(of: citySerachText, options: .caseInsensitive) != nil || "\($0.price)".range(of: priceTextSearch, options: .caseInsensitive) != nil}
            }
            if !filteredDatasource.isEmpty {
                filterIsOn = true
                self.presenter?.showEvents()
            }
        } else {
            filterIsOn = false
            self.presenter?.showEvents()
        }
    }
    
    private func createPresentableData(_ data: StubHub) {
        guard let childrens = data.children else { return }
        var childrensArray = [Children]()
        childrensArray.append(contentsOf: childrens.flatMap { $0.children ?? []})
        print(childrensArray)
        var eventsArray = [Events]()
        eventsArray.append(contentsOf: childrensArray.flatMap { $0.events ?? []})
        print(eventsArray)
        eventsArray.forEach { event in
            dataSource.append(
                PresentableEvents(
                    artistName: event.name ?? "",
                    city: event.city ?? "",
                    price: event.price
                )
            )
        }
        self.presenter?.showEvents()
    }

    func searchData(filterStr: String?) {
    }
    
    func viewLoaded() {
        service.getStubHubData(filter: nil) { [self] result in
            switch result {
            case .success(let modelObj):
                // create presentable data
                self.createPresentableData(modelObj)
            case .failure(let error):
                self.presenter?.showError(error.localizedDescription)
            }
        }
    }
}

