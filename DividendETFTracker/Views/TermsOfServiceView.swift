import SwiftUI

struct TermsOfServiceView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Terms of Service")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Last Updated: December 2025")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 8)
                    
                    // Acceptance of Terms
                    Section {
                        Text("1. Acceptance of Terms")
                            .font(.headline)
                            .foregroundColor(.brandGreen)
                        
                        Text("By downloading, accessing, or using the Dividend ETF Tracker app (\"the App\"), you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use the App.")
                            .font(.body)
                    }
                    
                    // Use of Service
                    Section {
                        Text("2. Use of Service")
                            .font(.headline)
                            .foregroundColor(.brandGreen)
                        
                        Text("The App provides information about dividend-paying ETFs for informational purposes only. You agree to use the App only for lawful purposes and in accordance with these Terms.")
                            .font(.body)
                    }
                    
                    // Financial Disclaimer
                    Section {
                        Text("3. Financial Disclaimer")
                            .font(.headline)
                            .foregroundColor(.brandGreen)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("The information provided by the App is NOT financial advice and should not be construed as such. We are not licensed financial advisors.")
                            
                            Text("• All data is provided for informational purposes only")
                            Text("• Past performance does not guarantee future results")
                            Text("• Investment decisions are your sole responsibility")
                            Text("• Consult with a qualified financial advisor before making investment decisions")
                        }
                        .font(.body)
                    }
                    
                    // Data Accuracy
                    Section {
                        Text("4. Data Accuracy")
                            .font(.headline)
                            .foregroundColor(.brandGreen)
                        
                        Text("While we strive to provide accurate and up-to-date information, we make no warranties about the completeness, reliability, or accuracy of the data presented. Market data may be delayed and should be verified through official sources.")
                            .font(.body)
                    }
                    
                    // Subscription Terms
                    Section {
                        Text("5. Subscription Terms")
                            .font(.headline)
                            .foregroundColor(.brandGreen)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Premium subscriptions are managed through the App Store:")
                            
                            Text("• Payment is charged to your Apple ID account at confirmation of purchase")
                            Text("• Subscriptions automatically renew unless canceled at least 24 hours before the end of the current period")
                            Text("• You can manage and cancel subscriptions in your App Store account settings")
                            Text("• No refunds for the current subscription period")
                        }
                        .font(.body)
                    }
                    
                    // Intellectual Property
                    Section {
                        Text("6. Intellectual Property")
                            .font(.headline)
                            .foregroundColor(.brandGreen)
                        
                        Text("All content, features, and functionality of the App are owned by Dividend ETF Tracker and are protected by international copyright, trademark, and other intellectual property laws.")
                            .font(.body)
                    }
                    
                    // Limitation of Liability
                    Section {
                        Text("7. Limitation of Liability")
                            .font(.headline)
                            .foregroundColor(.brandGreen)
                        
                        Text("To the maximum extent permitted by law, Dividend ETF Tracker shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses resulting from your use of the App.")
                            .font(.body)
                    }
                    
                    // Privacy
                    Section {
                        Text("8. Privacy")
                            .font(.headline)
                            .foregroundColor(.brandGreen)
                        
                        Text("We respect your privacy. The App does not collect or store personal information. All preferences and settings are stored locally on your device.")
                            .font(.body)
                    }
                    
                    // Changes to Terms
                    Section {
                        Text("9. Changes to Terms")
                            .font(.headline)
                            .foregroundColor(.brandGreen)
                        
                        Text("We reserve the right to modify these Terms at any time. Changes will be effective immediately upon posting within the App. Your continued use of the App after changes constitutes acceptance of the modified Terms.")
                            .font(.body)
                    }
                    
                    // Contact
                    Section {
                        Text("10. Contact Information")
                            .font(.headline)
                            .foregroundColor(.brandGreen)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("For questions about these Terms, please contact us:")
                            
                            HStack {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(.brandGreen)
                                Text("support@dividendtracker.app")
                            }
                            .font(.body)
                        }
                    }
                    
                    // Footer
                    Divider()
                        .padding(.vertical)
                    
                    Text("© 2025 Dividend ETF Tracker. All rights reserved.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 20)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.brandGreen)
                }
            }
        }
    }
}

#Preview {
    TermsOfServiceView()
}
