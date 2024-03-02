//
//  NewsContainerCell.swift
//  TestApp
//
//  Created by Nayan Sayare on 16/06/22.
//

import UIKit

class NewsContainerCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.applyShadow()
        }
    }
    
    @IBOutlet weak var mainContainerView: UIView! {
        didSet {
            mainContainerView.layer.cornerRadius = 12.0
        }
    }
    @IBOutlet weak var imgViewBackground: UIImageView!
    @IBOutlet weak var lblTitleOfNews: UILabel!
    @IBOutlet weak var lblDescOfNews: UILabel!
    @IBOutlet weak var lblAuthorOfNews: UILabel!
    
    func configureCell(with model: NewsContainerCellModel) {
        if let url = model.imageURL {
            imgViewBackground.download(from: url) { [weak self] in
                self?.imgViewBackground.contentMode = .scaleAspectFill
                self?.setLabel(with: model)
            }
        } 
        setLabel(with: model)
    }
    
    func setLabel(with model: NewsContainerCellModel) {
        lblTitleOfNews.text = model.titleOfNews
        lblDescOfNews.text = model.descOfNews
        lblAuthorOfNews.text = model.authorOfNews
    }
}

class NewsContainerCellModel {
    var imageURL: String?
    var titleOfNews: String?
    var descOfNews: String?
    var authorOfNews: String?
    
    init(with dto: SpecialReport?) {
        imageURL = dto?.headlineImageUrl
        titleOfNews = dto?.title
        descOfNews = dto?.description
        authorOfNews = dto?.authors.first?.name
    }
}
