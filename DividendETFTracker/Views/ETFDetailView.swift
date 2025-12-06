import SwiftUI

struct ETFDetailView: View {
    let etf: ETF
    let shares: Int
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(etf.ticker)
                        .font(.largeTitle)
                        .bold()
                    
                    Text(etf.name)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.brandGreen.opacity(0.15))
                .cornerRadius(12)
                
                // Price & Yield
                GroupBox(label: Label("Price & Yield", systemImage: "dollarsign.circle.fill")) {
                    VStack(spacing: 12) {
                        InfoRow(label: "Current Price", value: String(format: "$%.2f", etf.price))
                        Divider()
                        InfoRow(label: "Dividend Yield", value: String(format: "%.2f%%", etf.dividendYield / 100))
                        Divider()
                        InfoRow(label: "Annual Dividend", value: String(format: "$%.2f", etf.annualDividend))
                    }
                    .padding(.vertical, 8)
                }
                
                // Dividend Payment
                GroupBox(label: Label("Last Dividend", systemImage: "banknote.fill")) {
                    VStack(spacing: 12) {
                        InfoRow(label: "Amount per Share", value: String(format: "$%.4f", etf.lastDividend))
                        Divider()
                        InfoRow(label: "Ex-Date", value: etf.lastExDate ?? "N/A")
                        Divider()
                        InfoRow(label: "Payment Frequency", value: etf.paymentFrequency)
                        Divider()
                        HStack {
                            Text("Payment for \(shares) shares:")
                                .font(.subheadline)
                            Spacer()
                            Text(String(format: "$%.2f", etf.calculateDividendPayment(shares: shares)))
                                .font(.headline)
                                .foregroundColor(.dividendGreen)
                                .bold()
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                // Performance & Metrics
                GroupBox(label: Label("Performance & Metrics", systemImage: "chart.line.uptrend.xyaxis")) {
                    VStack(spacing: 12) {
                        HStack {
                            Text("1-Month Performance:")
                                .font(.subheadline)
                            Spacer()
                            if let performance = etf.monthPerformance {
                                Text(String(format: "%@%.2f%%", performance >= 0 ? "+" : "", performance))
                                    .font(.headline)
                                    .foregroundColor(performance > 0 ? .positiveGreen : (performance < 0 ? .negativeRed : .gray))
                                    .bold()
                            } else {
                                Text("N/A")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }
                        }
                        Divider()
                        InfoRow(label: "Expense Ratio", value: String(format: "%.2f%%", etf.expenseRatio))
                        Divider()
                        InfoRow(label: "Volume", value: formatNumber(etf.volume))
                        Divider()
                        InfoRow(label: "Composite Score", value: String(format: "%.2f", etf.score))
                    }
                    .padding(.vertical, 8)
                }
                
                // Official Source
                GroupBox(label: Label("Official Source", systemImage: "link.circle.fill")) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Check upcoming dividend dates:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Link(etf.officialSource, destination: URL(string: etf.officialSource)!)
                            .font(.footnote)
                            .lineLimit(2)
                    }
                    .padding(.vertical, 8)
                }
                
                // Important Note
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.brandGreen)
                        Text("Important Notes")
                            .font(.headline)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Data shown is historical (last dividend payment)")
                        Text("• For upcoming dates, check the official source link")
                        Text("• Future dividends are announced 2-4 weeks before ex-date")
                        Text("• Check your broker's dividend calendar for confirmed dates")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.brandGreen.opacity(0.08))
                .cornerRadius(12)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
            Spacer()
            Text(value)
                .font(.subheadline)
                .bold()
        }
    }
}

#Preview {
    NavigationView {
        ETFDetailView(
            etf: ETF(
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
            shares: 100
        )
    }
}
