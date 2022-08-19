//
//  MainStoriesInteractorMock.swift
//
//  Created by Marium Hassan on 09.08.22.
//



@testable import NewYorkTop_Sories
final class MainStoriesInteractorMock:  MainStoriesInteractorProtocol{
    //MARK: - Properties
    private let baseService: BaseServiceProtocol
    private(set) var didCallFetchStories = false
    init(baseService: BaseServiceProtocol) {
        self.baseService = baseService
    }
    
    //MARK: - MainStoriesInteractorProtocol
    func fetchTopStories(completion: @escaping (Result<[Int: [MainStoryListModel]],Error>?) -> Void){
        self.didCallFetchStories = true
            self.baseService.execute(action: "", completionHandler: {
                (result: Result<BaseResponse<EntityModel>,Error>?) -> Void in
                switch result {
                case .success(let response):
                    let list = response.data?.results.map ({
                        MainStoryListModel(url: $0.url, title: $0.title, author: $0.byline, abstract: $0.abstract)
                    })
                    completion(.success([0: list!]))
                case .failure(let error):
                    print(error)
                case .none:
                    print("")
                }
            })
        }
        
    }
    
   









