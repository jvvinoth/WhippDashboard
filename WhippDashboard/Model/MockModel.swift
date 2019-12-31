//
//  MockModel.swift
//  WhippDashboard
//
//  Created by Vinoth Varatharajan on 30/12/2019.
//  Copyright © 2019 Vin. All rights reserved.
//

import Foundation

import Foundation

// MARK: - MockResponse
struct MockResponse: Codable {
    let httpStatus: Int
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let analytics: Analytics
}

// MARK: - Analytics
struct Analytics: Codable {
    let job: Job?
    let lineCharts: [[LineChart]]?
    let pieCharts: [PieChart]?
    let rating: Rating?
    let service: Job?
}

// MARK: - Job
struct Job: Codable {
    let jobDescription: String
    let items: [JobItem]
    let title: String

    enum CodingKeys: String, CodingKey {
        case jobDescription = "description"
        case items, title
    }
}

// MARK: - JobItem
struct JobItem: Codable {
    let itemDescription: String
    let growth: Int
    let title: String
    let total: Int?
    let avg: String?

    enum CodingKeys: String, CodingKey {
        case itemDescription = "description"
        case growth, title, total, avg
    }
}

// MARK: - LineChart
struct LineChart: Codable {
    let chartType, lineChartDescription: String
    let items: [LineChartItem]
    let title: String

    enum CodingKeys: String, CodingKey {
        case chartType
        case lineChartDescription = "description"
        case items, title
    }
}

// MARK: - LineChartItem
struct LineChartItem: Codable {
    let key: String
    let value: [ValueElement]
}

// MARK: - ValueElement
struct ValueElement: Codable {
    let key: String
    let value: Double
}

// MARK: - PieChart
struct PieChart: Codable {
    let chartType, pieChartDescription: String
    let items: [ValueElement]
    let title: String

    enum CodingKeys: String, CodingKey {
        case chartType
        case pieChartDescription = "description"
        case items, title
    }
}

// MARK: - Rating
struct Rating: Codable {
    let avg: Int
    let ratingDescription: String
    let items: [String: Int]
    let title: String

    enum CodingKeys: String, CodingKey {
        case avg
        case ratingDescription = "description"
        case items, title
    }
}
