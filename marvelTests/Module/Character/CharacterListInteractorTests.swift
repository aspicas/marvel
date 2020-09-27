//
//  CharacterListInteractorTests.swift
//  marvelTests
//
//  Created by David Garcia on 26/09/2020.
//

import XCTest
import Quick
import Nimble
@testable import marvel

class CharacterListInteractorTests: QuickSpec {
    
    override func spec() {
        let dataSource = MarvelDataSourceMock()
        var interactor: CharacterListInteractor!
        
        beforeEach {
            interactor = CharacterListInteractor(source: dataSource)
        }
        
        afterEach {
            interactor = nil
        }
        
        describe("Load data") {
            context("Get succesfull response from service") {
                it("Get data") {
                    dataSource.fakeSuccess = true
                    dataSource.successState = .full
                    interactor.loadData(limit: 10, offset: 0) { result in
                        switch result {
                        case .success(let info):
                            expect(info.data.results.count > 0).to(beTrue())
                        default:
                            expect(false).to(beTrue())
                        }
                    }
                }
                it("Get empty data") {
                    dataSource.fakeSuccess = true
                    dataSource.successState = .empty
                    interactor.loadData(limit: 10, offset: 0) { result in
                        switch result {
                        case .success(let info):
                            expect(info.data.results.count == 0).to(beTrue())
                        default:
                            expect(false).to(beTrue())
                        }
                    }
                }
            }// end context 1
            context("Get wrong response from service") {
                it("Get error") {
                    dataSource.fakeSuccess = false
                    interactor.loadData(limit: 10, offset: 0) { result in
                        switch result {
                        case .failure(let error):
                            expect(error is MarvelDataSourceMock.SourceError).to(beTrue())
                        default:
                            expect(false).to(beTruthy())
                        }
                    }
                }
            }// end context 2
        }// end describe 1
    }
}
