//
//  NewsListViewController.swift
//  TestApp
//
//  Created by Nayan Sayare on 17/06/22.
//

import UIKit

class NewsListViewController: UIViewController {
    static func getInstance(with viewModel: NewsListVM) -> NewsListViewController {
        let vc: NewsListViewController = UIViewController.loadFromNib(NewsListViewController.self)
        vc.viewModel = viewModel
        return vc
    }

    @IBOutlet weak var newsListTblView: UITableView! {
        didSet {
            newsListTblView.delegate = self
            newsListTblView.dataSource = self
            newsListTblView.register(UINib(nibName: "NewsContainerCell", bundle: nil), forCellReuseIdentifier: "NewsContainerCell")
            newsListTblView.register(UINib(nibName: "NewsContinentCell", bundle: nil), forCellReuseIdentifier: "NewsContinentCell")
        }
    }
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    
    var viewModel: NewsListVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.delegate = self
        setUI()
    }
    
    func setUI() {
        loaderIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.viewModel?.isNilState = false
            self.newsListTblView.reloadData()
            self.loaderIndicator.stopAnimating()
            self.loaderIndicator.isHidden = true
        }
    }

}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        if let row = viewModel?.getRowAt(index: index) {
            switch row {
            case .dailyBriefing(let model):
                let cell: NewsContinentCell = tableView.dequeueReusableCell(withIdentifier: "NewsContinentCell") as! NewsContinentCell
                cell.configureCell(with: model, delegate: self)
                cell.selectionStyle = .none
                return cell
            case .others(let model):
                let cell: NewsContainerCell = tableView.dequeueReusableCell(withIdentifier: "NewsContainerCell") as! NewsContainerCell
                cell.configureCell(with: NewsContainerCellModel(with: model))
                cell.selectionStyle = .none
                return cell
            }
            
        }
        return UITableViewCell()
    }
    
}

extension NewsListViewController: NewsContinentCellProtocol, NewsListVMProtocol {
    func didSelectAnotherSection(with sectionSelected: [SpecialReport]?) {
        newsListTblView.reloadData()
        viewModel?.reBuildDataSourceForDifferentSectionSelected(with: sectionSelected)
    }
    
    func reloadTableForDifferentSection() {
        self.setUI()
    }
}
