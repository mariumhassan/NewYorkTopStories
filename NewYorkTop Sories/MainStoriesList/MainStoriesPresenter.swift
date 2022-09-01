//
//  MainStoriesPresenter.swift
//
//  Created by Marium Hassan on 09.08.22.
//

import UIKit

protocol MainStoriesPresenterProtocol {
    /// presenter uses it to interact with ViewController
    var view: MainStoriesViewProtocol? { get set }
    /// list of Strories to display in View
    var storiesList: [Int: [MainStoryListModel]] { get }
    /// viewController  Navigation Title
    var navigationTitle: String { get }
    /// Fetches top stories and reloads the tableView
    func notifyViewDidLoad()
    /// tableview section title
    var sectionTitle: [String] { get }
    /// takes the selected stoy from model and navigates to detail screen
    /// Parameters
    /// - inSec: sepcifies the selected story Section in TableView
    /// - atRow: sepcifies the selected story Row in TableView
    func userSelectedStory(inSec: Int, atRow: Int)
}

final class MainStoriesPresenter: MainStoriesPresenterProtocol {

    //MARK: - Properties
    private let router: MainStoriesRouterProtocol
    private let interactor: MainStoriesInteractorProtocol
    private var storiesModel: [Int: [MainStoryListModel]] = [(TopStories.allCases.count): [MainStoryListModel]()]
    
    init(router: MainStoriesRouterProtocol, interactor: MainStoriesInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }

    // MARK: - MainStoriesPresenterProtocol
    
    weak var view: MainStoriesViewProtocol?
    var storiesList: [Int: [MainStoryListModel]] {
        return storiesModel
    }
    
    var sectionTitle: [String] {
        return TableSectionTitle.allCases.map({ $0.rawValue })
    }
    
    var navigationTitle: String {
        "Top Stories"
    }
    
    func notifyViewDidLoad() {
        self.view?.animateLoadingView(loading: true)
        self.interactor.fetchTopStories(completion: { [weak self]
            result in
            self?.view?.animateLoadingView(loading: false)
            switch result {
            case .success(let response):
                self?.storiesModel  = response
                self?.view?.hideErrorView()
                self?.view?.reloadTableView()
            case .failure(let error):
                self?.view?.showErrorView(errorMsg: error.description)
            case .none:
                print("")
            }
        })
    }
    
    func userSelectedStory(inSec: Int, atRow: Int) {
        if let story = storiesModel[inSec]?[atRow] {
            router.navigateToDetailScreen(story: story, navigation: view?.navigation)
        }
    }
    
}

enum TableSectionTitle: String, CaseIterable {
    case emailed = "Most Emailed Articles"
    case shared = "Most Shared Articles"
    case viewed = "Most Viewed Articles"
}





