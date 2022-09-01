//
//  MainStoriesRouterMock.swift
//
//  Created by Marium Hassan on 09.08.22.
//

import UIKit

@testable import NewYorkTop_Sories
final class MainStoriesViewMock:  MainStoriesViewProtocol{
    
    //MARK: - Properties
    private(set) var didCallReloadTableView = false
    private(set) var didCallAnimateLoadingView = false
    private(set) var didCallShowErrorView = false
    private(set) var didCallHideErrorView = false
    init() {}
    
    //MARK: - MainStoriesViewProtocol
    
    var navigation: UINavigationController? {
        nil
    }
    
    func reloadTableView() {
        didCallReloadTableView = true
    }
   
    func animateLoadingView(loading: Bool) {
        didCallAnimateLoadingView = true
    }
    
    func showErrorView(errorMsg: String) {
        didCallShowErrorView = true
    }
    
    func hideErrorView() {
        didCallHideErrorView = true
    }
    
}
    
   









