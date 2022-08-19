//
//  ViewController.swift
//
//  Created by Marium Hassan on 09.08.22.
//

import UIKit

protocol MainStoriesViewProtocol: AnyObject {
    /// reload TableView Contents
    func reloadTableView()
    var navigation: UINavigationController? { get }
    /// shows a loading indicator while content is loading
    func animateLoadingView(loading: Bool)
}

class MainStoriesViewController: UIViewController, MainStoriesViewProtocol {

    //MARK: - Outlets
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    //MARK: - Properties
    var presenter: MainStoriesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        presenter?.notifyViewDidLoad()
    }
    
    func initView(){
        self.title = self.presenter?.navigationTitle
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.estimatedRowHeight = 180
        mainTableView.rowHeight = UITableView.automaticDimension
    }

    //MARK: - MainStoriesViewProtocol
    var navigation: UINavigationController? {
        return self.navigationController
    }

    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
        
    }
    
    func animateLoadingView(loading: Bool) {
        DispatchQueue.main.async {
            if loading{
                self.loadingView.startAnimating()
                UIView.animate(withDuration: 0.2, animations: {
                    self.mainTableView.alpha = 0.0
                })
            }else{
                self.loadingView?.stopAnimating()
                UIView.animate(withDuration: 0.2, animations: {
                    self.mainTableView.alpha = 1.0
                })
            }
        }
    }

}

//MARK: - Tableview Delegates

extension MainStoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.presenter?.sectionTitle[section]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "storyCellIdentifier", for: indexPath) as? StoryCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = self.presenter?.storiesList[indexPath.section]![indexPath.row]
        cell.cellViewModel = cellVM        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.storiesList[section]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.userSelectedStory(inSec: indexPath.section, atRow: indexPath.row)
    }
    
}




