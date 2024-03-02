//
//  NewsListVM.swift
//  TestApp
//
//  Created by Nayan Sayare on 17/06/22.
//

import Foundation

protocol NewsListVMProtocol: AnyObject {
    func reloadTableForDifferentSection()
}

class NewsListVM {
    enum Rows {
        case dailyBriefing(DailyBriefings?)
        case others(SpecialReport?)
    }
    
    init(with response: News, type: NewsType) {
        self.response = response
        self.newsType = type
        setUpDataSource()
    }
    
    var isNilState: Bool = true
    var response: News?
    var dataSource: [Rows] = [Rows]()
    var newsType: NewsType = .breakingNews
    weak var delegate: NewsListVMProtocol?
    
    func setUpDataSource() {
        switch newsType {
        case .breakingNews:
            response?.breakingNews?.forEach({ [weak self] in
                self?.dataSource.append(.others($0))
            })
        case .topNews:
            response?.topNews?.forEach({ [weak self] in
                self?.dataSource.append(.others($0))
            })
        case .specialReport:
            response?.specialReport?.forEach({ [weak self] in
                self?.dataSource.append(.others($0))
            })
        case .technicalAnalysis:
            response?.technicalAnalysis?.forEach({ [weak self] in
                self?.dataSource.append(.others($0))
            })
        case .dailyBriefings:
            dataSource.append(.dailyBriefing(response?.dailyBriefings))
            response?.dailyBriefings?.asia?.forEach({ [weak self] in
                self?.dataSource.append(.others($0))
            })
        }
    }
    
    func reBuildDataSourceForDifferentSectionSelected(with _dataSource: [SpecialReport]?) {
        dataSource.removeAll()
        dataSource.append(.dailyBriefing(response?.dailyBriefings))
        _dataSource?.forEach({ [weak self] in
            self?.dataSource.append(.others($0))
        })
        self.delegate?.reloadTableForDifferentSection()
    }
    
    func getNumberOfRows() -> Int {
        if isNilState {
            return Int.zero
        }
        return dataSource.count
    }
    
    func getRowAt(index: Int) -> Rows? {
        if index < getNumberOfRows() {
            return dataSource[index]
        }
        return nil
    }
    
}
