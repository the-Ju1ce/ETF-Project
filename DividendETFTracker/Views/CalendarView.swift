import SwiftUI

struct CalendarView: View {
    let etfs: [ETF]
    
    var sortedByExDate: [ETF] {
        etfs.filter { $0.lastExDate != nil }
            .sorted { etf1, etf2 in
                guard let date1 = etf1.lastExDate, let date2 = etf2.lastExDate else {
                    return false
                }
                return date1 > date2
            }
    }
    
    var body: some View {
        List {
            Section(header: Text("Ex-Dividend Dates").font(.headline)) {
                if sortedByExDate.isEmpty {
                    Text("No ex-dates available")
                        .foregroundColor(.secondary)
                        .italic()
                } else {
                    ForEach(sortedByExDate) { etf in
                        NavigationLink(destination: ETFDetailView(etf: etf, shares: 100)) {
                            CalendarRowView(etf: etf)
                        }
                    }
                }
            }
            
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.brandGreen)
                        Text("About Ex-Dividend Dates")
                            .font(.subheadline)
                            .bold()
                    }
                    
                    Text("The ex-dividend date is when you must own shares to receive the dividend payment. Buy before this date to qualify.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("These are historical dates. Check official sources for upcoming payments.")
                        .font(.caption)
                        .foregroundColor(.brandLightGreen)
                        .padding(.top, 4)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Dividend Calendar")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct CalendarRowView: View {
    let etf: ETF
    
    private var formattedDate: String {
        guard let exDateString = etf.lastExDate else { return "N/A" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: exDateString) else {
            return exDateString
        }
        
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    private var monthDay: String {
        guard let exDateString = etf.lastExDate else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: exDateString) else {
            return ""
        }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "MMM d"
        return displayFormatter.string(from: date)
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // Date badge
            VStack(spacing: 2) {
                Text(monthDay.components(separatedBy: " ").first ?? "")
                    .font(.caption)
                    .foregroundColor(.brandGreen)
                    .bold()
                Text(monthDay.components(separatedBy: " ").last ?? "")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.brandGreen)
            }
            .frame(width: 50)
            .padding(.vertical, 8)
            .background(Color.brandGreen.opacity(0.12))
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(etf.ticker)
                        .font(.headline)
                        .bold()
                    
                    Text(String(format: "%.2f%%", etf.dividendYield / 100))
                        .font(.subheadline)
                        .foregroundColor(.brandGreen)
                        .bold()
                }
                
                Text(etf.name)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                HStack {
                    Text(String(format: "$%.4f", etf.lastDividend))
                        .font(.caption)
                        .foregroundColor(.dividendGreen)
                    
                    Text("•")
                        .foregroundColor(.secondary)
                    
                    Text(etf.paymentFrequency)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationView {
        CalendarView(etfs: [
            ETF(
                ticker: "SCHD",
                name: "Schwab U.S. Dividend Equity ETF",
                price: 26.99,
                dividendYield: 379.0,
                annualDividend: 0.0,
                lastDividend: 0.26,
                lastExDate: "2025-09-24",
                paymentFrequency: "Quarterly",
                officialSource: "https://www.schwabassetmanagement.com/products/schd",
                monthPerformance: -0.55,
                expenseRatio: 0,
                volume: 13348744,
                score: 18970.0
            ),
            ETF(
                ticker: "DIV",
                name: "Global X SuperDividend ETF",
                price: 17.23,
                dividendYield: 670.0,
                annualDividend: 0,
                lastDividend: 0.108,
                lastExDate: "2025-10-03",
                paymentFrequency: "Monthly",
                officialSource: "https://www.globalxetfs.com/funds/div/",
                monthPerformance: -2.0,
                expenseRatio: 0,
                volume: 258089,
                score: 33520.0
            )
        ])
    }
}
