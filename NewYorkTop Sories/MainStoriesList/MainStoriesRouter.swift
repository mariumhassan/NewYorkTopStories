//
//  MainStoriesRouter.swift
//
//  Created by Marium Hassan on 09.08.22.
//

import UIKit

protocol MainStoriesRouterProtocol {
    /// Navigates to story details  when user clicks on a stroy
    func navigateToDetailScreen(story: MainStoryListModel, navigation: UINavigationController?)
    /// Navigates to initial viewController which shows stories list
    func navigateToInitialVC() -> UIViewController?
}

final class MainStoriesRouter: MainStoriesRouterProtocol {
    
    //MARK: - MainStoriesRouterProtocol
    func navigateToDetailScreen(story: MainStoryListModel, navigation: UINavigationController?) {
        let args = StoryDetailModuleArgs(url: story.url, title: story.title, author: story.author, description: story.abstract, mediaUrl: story.media?[2].url)
        let presenter = StoryDetailPresenter(moduleArgs: args)
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(identifier: "StoryDetailViewController") as? StoryDetailViewController
        presenter.view = vc
        vc?.presenter = presenter
        if let viewController = vc, let nav = navigation {
            nav.pushViewController(viewController, animated: true)
        }
        
    }
    
    func navigateToInitialVC() -> UIViewController? {
        let interactor = MainStoriesInteractor(baseService: BaseService())
        let presenter = MainStoriesPresenter(router: self, interactor: interactor)
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(identifier: "MainStoriesViewController") as? MainStoriesViewController
        presenter.view = vc
        vc?.presenter = presenter
        
        return vc
    }
}






