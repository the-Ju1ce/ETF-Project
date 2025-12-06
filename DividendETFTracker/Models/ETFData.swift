import Foundation

struct ETFAnalysis: Codable {
    let date: String
    let recommendations: [ETF]
}

struct ETF: Codable, Identifiable {
    let ticker: String
    let name: String
    let price: Double
    let dividendYield: Double
    let annualDividend: Double
    let lastDividend: Double
    let lastExDate: String?
    let paymentFrequency: String
    let officialSource: String
    let monthPerformance: Double?
    let expenseRatio: Double
    let volume: Int
    let score: Double
    
    var id: String { ticker }
    
    enum CodingKeys: String, CodingKey {
        case ticker, name, price, volume, score
        case dividendYield = "dividend_yield"
        case annualDividend = "annual_dividend"
        case lastDividend = "last_dividend"
        case lastExDate = "last_ex_date"
        case paymentFrequency = "payment_frequency"
        case officialSource = "official_source"
        case monthPerformance = "month_performance"
        case expenseRatio = "expense_ratio"
    }
    
    func calculateDividendPayment(shares: Int) -> Double {
        return lastDividend * Double(shares)
    }
    
    var performanceColor: String {
        guard let performance = monthPerformance else { return "gray" }
        if performance > 0 { return "green" }
        if performance < 0 { return "red" }
        return "gray"
    }
}
