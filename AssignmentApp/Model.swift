//
//  Model.swift
//  TestApp
//
//  Created by Nayan Sayare on 17/06/22.
//

import Foundation

struct News: Codable {
    let breakingNews: [SpecialReport]?
    let topNews: [SpecialReport]?
    let dailyBriefings: DailyBriefings?
    let technicalAnalysis: [SpecialReport]?
    let specialReport: [SpecialReport]?
}

// MARK: - DailyBriefings
struct DailyBriefings: Codable {
    let eu, asia, us: [SpecialReport]?
}

struct SpecialReport: Codable {
    let title: String?
    let url: String?
    let description: String?
    let headlineImageUrl: String?
    let authors: [Author]
    let tags, categories: [String]?
}

// MARK: - Author
struct Author: Codable {
    let name, title: String?
    let photo: String?
}

enum NewsType {
    case breakingNews
    case topNews
    case dailyBriefings
    case technicalAnalysis
    case specialReport
}
