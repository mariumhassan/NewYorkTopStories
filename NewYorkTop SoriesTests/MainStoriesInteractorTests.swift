//
//  MainStoriesInteractorTests.swift
//
//  Created by Marium Hassan on 10.08.22.
//

import XCTest
@testable import NewYorkTop_Sories

final class MainStoriesInteractorTests: XCTestCase {
    
    private var sut: MainStoriesInteractorProtocol?
    let serviceMock = BaseServiceMock()
    
    override func setUpWithError() throws {
        sut = MainStoriesInteractor(baseService: serviceMock)
    }

    func testfetchTopStoriesSuccess() {
        //Given
        let mockStory = MockResponse().getResponseStub()
        serviceMock.fetchAnyStub = EntityModel(results: [mockStory])
        var storiesList: [MainStoryListModel]?
        
        //When
        sut?.fetchTopStories(completion: {
            result in
            switch result {
            case .success(let list):
                storiesList = list[0]
            case .failure(let error):
                print(error)
            case .none:
                print("")
            }
        })
        
        //Then
        XCTAssertNotNil(storiesList)
        XCTAssertEqual(mockStory.url, storiesList?[0].url)
        XCTAssertTrue(serviceMock.didCallExecute)
    }
    
    func testfetchTopStoriesFail() {
        //Given
        var storiesList: [MainStoryListModel]?
        
        //When
        sut?.fetchTopStories(completion: {
            result in
            switch result {
            case .success(let list):
                storiesList = list[0]
            case .failure(let error):
                print(error)
            case .none:
                print("")
            }
        })
        
        //Then
        XCTAssertNil(storiesList)
        XCTAssertTrue(serviceMock.didCallExecute)
    }

}

struct MockResponse {
    func getResponseStub() -> StoryModel {
         StoryModel(url: "test_Url", id: 123, published_date: "01/01/2022" ,byline: "Mock", title: "Test Article", abstract: "This is a mock record", media: [Media]())
        
    }
}


