//
//  ViewController.swift
//
//  Created by Marium Hassan on 09.08.22.
//

import UIKit
import SafariServices

protocol StoryDetailViewProtocol: AnyObject{
    /// Initialises the story data received from previous viewController
    func setStoryDetail(args: StoryDetailModuleArgs)
}

class StoryDetailViewController: UIViewController, StoryDetailViewProtocol {

    //MARK: - Outlets
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    
    //MARK: - Properties
    var presenter: StoryDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.presenter?.navigationTitle
        presenter?.notifyViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    @IBAction func seeMoreTaped(_ sender: Any) {
        if let urlStr = self.presenter?.storyDetail.url,  let url = URL(string: urlStr) {
            let svc = SFSafariViewController(url: url)
            self.present(svc, animated: true)
        }
        
    }
    
    //MARK: - StoryDetailViewProtocol
    func setStoryDetail(args: StoryDetailModuleArgs) {
        titleLbl.text = args.title
        descriptionLbl.text = args.description
        authorLbl.text = args.author
        coverImage?.sd_setImage(with: URL( string: (args.mediaUrl) ?? ""), placeholderImage: nil ,completed: nil)
    }

}




