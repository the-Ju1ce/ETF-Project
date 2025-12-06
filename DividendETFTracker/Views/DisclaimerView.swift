import SwiftUI

struct DisclaimerView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.shield.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.brandGreen)
                        
                        Text("Important Disclaimer")
                            .font(.title)
                            .bold()
                        
                        Text("Please read carefully before using this app")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    
                    // Main Disclaimer
                    VStack(alignment: .leading, spacing: 16) {
                        DisclaimerSection(
                            title: "Not Financial Advice",
                            icon: "chart.line.uptrend.xyaxis",
                            content: "This app is for informational and educational purposes only. The information provided does NOT constitute financial, investment, tax, or legal advice. We are not registered financial advisors, brokers, or investment professionals."
                        )
                        
                        DisclaimerSection(
                            title: "No Recommendations",
                            icon: "hand.raised.fill",
                            content: "The ETF data, rankings, scores, and any analysis presented in this app should NOT be considered as recommendations to buy, sell, or hold any security. Past performance is not indicative of future results."
                        )
                        
                        DisclaimerSection(
                            title: "Do Your Own Research",
                            icon: "book.fill",
                            content: "Always conduct your own thorough research and due diligence before making any investment decisions. Consider consulting with a qualified financial advisor who understands your specific financial situation and goals."
                        )
                        
                        DisclaimerSection(
                            title: "Data Accuracy",
                            icon: "info.circle.fill",
                            content: "While we strive to provide accurate and up-to-date information, we cannot guarantee the accuracy, completeness, or timeliness of the data. Market data may be delayed or contain errors. Always verify information with official sources."
                        )
                        
                        DisclaimerSection(
                            title: "Investment Risks",
                            icon: "exclamationmark.triangle.fill",
                            content: "All investments carry risk, including the potential loss of principal. Dividend payments are not guaranteed and can be reduced or eliminated at any time. ETF values fluctuate with market conditions."
                        )
                        
                        DisclaimerSection(
                            title: "No Liability",
                            icon: "shield.slash.fill",
                            content: "We shall not be liable for any losses, damages, or consequences arising from your use of this app or reliance on the information provided. You are solely responsible for your investment decisions."
                        )
                        
                        DisclaimerSection(
                            title: "Tax Implications",
                            icon: "doc.text.fill",
                            content: "Dividend income has tax implications that vary by jurisdiction and individual circumstances. Consult with a qualified tax professional regarding your specific situation."
                        )
                    }
                    
                    // Additional Information
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Additional Information")
                            .font(.headline)
                            .foregroundColor(.brandGreen)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("• This app aggregates publicly available data")
                            Text("• Rankings are based on historical metrics only")
                            Text("• Ex-dividend dates shown are historical")
                            Text("• Check official ETF websites for current information")
                            Text("• Securities markets are subject to risks beyond historical analysis")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.brandGreen.opacity(0.08))
                    .cornerRadius(12)
                    
                    // Contact
                    VStack(spacing: 8) {
                        Text("Questions or Concerns?")
                            .font(.subheadline)
                            .bold()
                        
                        Text("Contact us at support@dividendtracker.app")
                            .font(.caption)
                            .foregroundColor(.brandGreen)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct DisclaimerSection: View {
    let title: String
    let icon: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundColor(.brandGreen)
                    .font(.title3)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.brandGreen)
            }
            
            Text(content)
                .font(.subheadline)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    DisclaimerView()
}
