//
//  MainStoriesPresenterTests.swift
//
//  Created by Marium Hassan on 10.08.22.
//

import XCTest
@testable import NewYorkTop_Sories

final class MainStoriesPresenterTests: XCTestCase {
    
    private var sut: MainStoriesPresenterProtocol?
    let serviceMock = BaseServiceMock()
    let routerMock = MainStoriesRouterMock()
    let viewMock = MainStoriesViewMock()
    
    override func setUpWithError() throws {
        let mockStory = MockResponse().getResponseStub()
        serviceMock.fetchAnyStub = EntityModel(results: [mockStory])
    }
    
    func testNotifyViewDidLoad() {
        //Given
        let interactorMock = MainStoriesInteractorMock(baseService: serviceMock)
        sut = MainStoriesPresenter(router: routerMock, interactor: interactorMock)
        sut?.view = viewMock
        //When
        sut?.notifyViewDidLoad()
        
        //Then
        XCTAssertTrue(interactorMock.didCallFetchStories)
        XCTAssertTrue(viewMock.didCallReloadTableView)
        XCTAssertEqual(sut?.storiesList[0]?.count, 1)
    }

    func testUserSelectedStory() {
        //Given
        let interactorMock = MainStoriesInteractorMock(baseService: serviceMock)
        sut = MainStoriesPresenter(router: routerMock, interactor: interactorMock)
        sut?.notifyViewDidLoad()
        
        //When
        sut?.userSelectedStory(inSec: 0, atRow: 0)
        
        //Then
        XCTAssertTrue(routerMock.didCallNavigateToDetailScreen)
    }
}



