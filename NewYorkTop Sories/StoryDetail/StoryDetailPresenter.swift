//
//  MainStoriesPresenter.swift
//
//  Created by Marium Hassan on 09.08.22.
//

import UIKit

protocol StoryDetailPresenterProtocol {
    /// story detail arguments to show on viewController
    var storyDetail: StoryDetailModuleArgs { get }
    /// viewController navigation title
    var navigationTitle: String { get }
    /// presenter uses it to interact with ViewController
    var view: StoryDetailViewProtocol? { set get }
    /// sets the story Detail on ViewController
    func notifyViewDidLoad()
}

final class StoryDetailPresenter: StoryDetailPresenterProtocol {

    //MARK: - Properties
    private var storyModel: StoryDetailModuleArgs?
    
    init(moduleArgs: StoryDetailModuleArgs) {
        self.storyModel = moduleArgs
    }
    
    //MARK: - StoryDetailPresenterProtocol
    
    weak var view: StoryDetailViewProtocol?
    var storyDetail: StoryDetailModuleArgs {
        storyModel!
    }
    var navigationTitle: String {
        "Story Detail"
    }
    
    func notifyViewDidLoad() {
        guard let story = storyModel else { return }
        view?.setStoryDetail(args: story)
    }
    
    
}







