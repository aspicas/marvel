//
//  MarvelDataSourceTests.swift
//  marvelTests
//
//  Created by David Garcia on 20/09/2020.
//

import XCTest
import Nimble
import Moya
@testable import marvel

class MarvelDataSourceTests: XCTestCase {

    private var dataSource = MarvelDataSource(marvelAPI: MoyaProvider<MarvelAPI>(stubClosure: MoyaProvider.immediatelyStub, plugins: [NetworkLoggerPlugin(verbose: true)]))
    
    override class func setUp() {

    }

    override func tearDownWithError() throws {
        
    }

    func testDataSource_ServiceCall_GetRightData() throws {
        dataSource.getCharacters(limit: 2, offset: 0) { result in
            switch result {
            case .success(let info):
                expect(info.data.results.count > 0).to(equal(true), description: "Service is full")
            case .failure(let error):
                expect(error.errorCode == 200).to(equal(true), description: error.errorDescription)
            }
        }
    }

}
