//
//  MainViewControllerVM.swift
//  TestApp
//
//  Created by Nayan Sayare on 17/06/22.
//

import Foundation

protocol MainViewControllerVMProtocol: AnyObject {
    func didReceivedData()
}
class MainViewControllerVM {
    var response: News?
    var firstNewsType: NewsType = .topNews
    weak var delegate: MainViewControllerVMProtocol?
    
    func fetchData() {
        let request = NetworkRequest()
        request.fetchNews { [weak self] response in
            if let response = response {
                self?.response = response
                if response.breakingNews != nil { self?.firstNewsType = .breakingNews }
                self?.delegate?.didReceivedData()
            }
        }
    }
    
}
