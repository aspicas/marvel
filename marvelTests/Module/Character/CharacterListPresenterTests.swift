//
//  CharacterListPresenterTests.swift
//  marvelTests
//
//  Created by David Garcia on 26/09/2020.
//

import XCTest
import Nimble
import Quick
import RxSwift
@testable import marvel

class CharacterListPresenterTests: QuickSpec {

    override func spec() {
        var presenter: CharacterListPresenter!
        let interactor = CharacterListInteractorMock()
        let wireframe = CharacterListWireframeMock()
        var disposeBag: DisposeBag!
        
        beforeEach {
            presenter = CharacterListPresenter(interactor: interactor, wireframe: wireframe)
            disposeBag = DisposeBag()
        }
        
        describe("Get character data") { //1
            context("Characters are fetched successfully") {//1
                it("Use character with data") {
                    interactor.fakeSuccess = true;
                    interactor.successState = .full
                    presenter.getCharacterData()
                    presenter.viewSource
                        .debug("Test full")
                        .drive { result in
                            switch result {
                            case .success(let characters):
                                expect(characters.count).to(beGreaterThan(0))
                            default:
                                expect(false).to(beTrue())
                            }
                        } onCompleted: {
                            print("Completed")
                        }.disposed(by: disposeBag)
                }
                it("Use characters without data") {
                    interactor.fakeSuccess = true;
                    interactor.successState = .empty
                    presenter.getCharacterData()
                    presenter.viewSource
                        .debug("Test empty")
                        .drive { result in
                            switch result {
                            case .success(let characters):
                                expect(characters.count).to(be(0))
                            default:
                                expect(false).to(beTrue())
                            }
                        } onCompleted: {
                            print("Completed")
                        }.disposed(by: disposeBag)
                }
            }//End context 1
            context("Unexpected error") {//2
                it("Handle the error data") {
                    interactor.fakeSuccess = false
                    presenter.getCharacterData()
                    presenter.viewSource
                        .debug("Test error")
                        .drive { result in
                            switch result {
                            case .error(let error):
                                let cast = error as! CharacterListInteractorMock.InteractorError
                                expect(cast == CharacterListInteractorMock.InteractorError.unexpectedError).to(beTrue())
                            default:
                                expect(false).to(beTrue())
                            }
                        } onCompleted: {
                            print("Completed")
                        }.disposed(by: disposeBag)
                }
            }// End context 2
        }//End describe 1
        
        describe("Select a cell") {//2
            context("User select a cell") {
                it("Navigate to other view") {
                    presenter.selectedCell(character: wireframe.characters)
                    expect(wireframe.result).to(beTrue())
                }
            }
        }//End describe 2
        
    }//End function

}
