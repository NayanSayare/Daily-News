//
//  MainViewController.swift
//  TestApp
//
//  Created by Nayan Sayare on 17/06/22.
//

import UIKit


class MainViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        nil
    }
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    private var pageController: UIPageViewController!
    var viewModel = MainViewControllerVM()
    var topNewsVC: NewsListViewController!
    var dailyBriefingNewsVC: NewsListViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        setUI()
    }
    
    func setUI() {
        if let _response = viewModel.response {
            let viewModel : NewsListVM =  NewsListVM(with: _response, type: viewModel.firstNewsType)
            topNewsVC = NewsListViewController.getInstance(with: viewModel)
            
            pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

            pageController.delegate = self
            pageController.dataSource = self
            pageController.view.frame = CGRect(x: 0,y: 0,width: self.containerView.frame.width,height: self.containerView.frame.height)
            containerView.addSubview(self.pageController.view)
            pageController.setViewControllers([topNewsVC], direction: .forward, animated: true, completion: nil)
        } else {
            viewModel.fetchData()
        }
        
        segmentControl.setTitle("Top News", forSegmentAt: 0)
        segmentControl.setTitle("Daily Briefing", forSegmentAt: 1)
    }
    
    @IBAction func didTapOnSegement(_ sender: Any) {
        guard let segmentControl = sender as? UISegmentedControl else { return }
        if segmentControl.selectedSegmentIndex == 1 {
            if dailyBriefingNewsVC == nil {
                let viewModel1 = NewsListVM(with: viewModel.response!, type: .dailyBriefings)
                dailyBriefingNewsVC = NewsListViewController.getInstance(with: viewModel1)
            }
            pageController.setViewControllers([dailyBriefingNewsVC], direction: .forward, animated: true)
        } else if segmentControl.selectedSegmentIndex == 0 {
            if topNewsVC == nil {
                let viewModel : NewsListVM =  NewsListVM(with: viewModel.response!, type: viewModel.firstNewsType)
                topNewsVC = NewsListViewController.getInstance(with: viewModel)
            }
            pageController.setViewControllers([topNewsVC], direction: .reverse, animated: true)
        }
    }
}

extension MainViewController: MainViewControllerVMProtocol {
    func didReceivedData() {
        setUI()
    }
}

extension MainViewController {
    
}
