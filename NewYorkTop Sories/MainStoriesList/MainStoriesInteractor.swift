//
//  MainStoriesInteractor.swift
//
//  Created by Marium Hassan on 09.08.22.
//

import UIKit

protocol MainStoriesInteractorProtocol {
    /// fetch Top Stories from server
    func fetchTopStories(completion: @escaping (Result<[Int: [MainStoryListModel]],Error>?) -> Void)
}

final class MainStoriesInteractor:  MainStoriesInteractorProtocol{
 
    //MARK: - Properties
    private let baseService: BaseServiceProtocol
    
    init(baseService: BaseServiceProtocol) {
        self.baseService = baseService
    }
    
    func processFetchedData(response: EntityModel) -> [MainStoryListModel] {
        return response.results.map({
            MainStoryListModel(url: $0.url, title: $0.title, author: $0.byline, abstract: $0.abstract, media: ($0.media.count > 0 ?  $0.media[0].metaData : nil))
        })
    }
    
    //MARK: - MainStoriesInteractorProtocol
    
    func fetchTopStories(completion: @escaping (Result<[Int: [MainStoryListModel]],Error>?) -> Void){
        let actionCount = (TopStories.allCases.count - 1)
        var storiesList : [Int: [MainStoryListModel]] = [actionCount: [MainStoryListModel]()]
        for story in 0...actionCount {
            self.baseService.execute(action: TopStories.allCases[story].rawValue, completionHandler: {
                (result: Result<BaseResponse<EntityModel>,Error>?) -> Void in
                switch result {
                case .success(let response):
                    guard let response = response.data else { return }
                    storiesList[story] = self.processFetchedData(response: response)
                    completion(.success(storiesList))
                case .failure(let error):
                    completion(.failure(error))
                case .none:
                    print("")
                }
            })
       }
        
    }
    
}

enum TopStories: String, CaseIterable {
    case emailed = "emailed/1.json?"
    case shared = "shared/1/facebook.json?"
    case viewed = "viewed/1.json?"
}






