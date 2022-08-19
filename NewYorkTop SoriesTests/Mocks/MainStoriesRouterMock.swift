//
//  MainStoriesRouterMock.swift
//
//  Created by Marium Hassan on 09.08.22.
//

import UIKit

@testable import NewYorkTop_Sories
final class MainStoriesRouterMock:  MainStoriesRouterProtocol{
    //MARK: - Properties
    private(set) var didCallNavigateToInitialVC = false
    private(set) var didCallNavigateToDetailScreen = false
    init() {}
    
    //MARK: - MainStoriesRouterProtocol
    func navigateToDetailScreen(story: MainStoryListModel, navigation: UINavigationController?) {
        didCallNavigateToDetailScreen = true
    }
    func navigateToInitialVC() -> UIViewController? {
        didCallNavigateToInitialVC = true
        return nil
    }
    
}
    
   









