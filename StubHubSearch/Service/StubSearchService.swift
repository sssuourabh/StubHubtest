//
//  StubSearchService.swift
//  StubHubSearch
//
//  Created by HT on 08/08/22.
//

import Foundation
enum CustomError: String, Error {
    case NotParseable
    case NoData
}
protocol StubSearchServiceable: AnyObject {
    func getStubHubData(filter: String?, completion: @escaping (Result<StubHub, Error>) -> Void)
}

final class StubSearchService: StubSearchServiceable {
    func getStubHubData(filter: String?, completion: @escaping (Result<StubHub, Error>) -> Void) {
        guard let loadData = Bundle.main.url(forResource: "StubData", withExtension: "json") else {
            completion(.failure(CustomError.NoData))
            return
        }
        do {
            let data = try Data(contentsOf: loadData)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(StubHub.self, from: data)
            print(jsonData)
            completion(.success(jsonData))
        } catch {
            completion(.failure(CustomError.NotParseable))
            print("error:\(error)")
        }
    }
}
