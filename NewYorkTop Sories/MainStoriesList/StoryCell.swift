//
//  StoryCell.swift
//
//  Created by Marium Hassan on 09.08.22.
//

import Foundation
import UIKit
import SDWebImage

final class StoryCell: UITableViewCell{
    
    //MARK: - Outlets
    @IBOutlet weak var thumbNailimage: UIImageView!
    @IBOutlet weak var authorView: UILabel!
    @IBOutlet weak var titleView: UILabel!
    
    var cellViewModel: MainStoryListModel? {
        didSet {
            authorView.text = cellViewModel?.author
            titleView.text = cellViewModel?.title
            thumbNailimage?.sd_setImage(with: URL( string: (cellViewModel?.media?[0].url) ?? ""), placeholderImage: nil ,completed: nil)
        }
    }
    
    override func layoutSubviews() {
        setupShadow()
    }
    
    public func setupShadow() {
        self.thumbNailimage.layer.cornerRadius = 0.25
        self.thumbNailimage.clipsToBounds = true
        self.layer.cornerRadius = 0.38
        self.layer.borderWidth = 0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.17
        self.layer.masksToBounds = false
       
       }
    
}

 
