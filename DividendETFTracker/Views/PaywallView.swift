import SwiftUI

struct PaywallView: View {
    @ObservedObject var subscriptionManager = SubscriptionManager.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Image(systemName: "crown.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.yellow)
                        
                        Text("Upgrade to Premium")
                            .font(.title)
                            .bold()
                        
                        Text("Unlock all features and maximize your dividend tracking")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top, 20)
                    
                    // Free vs Premium Comparison
                    HStack(alignment: .top, spacing: 16) {
                        // Free Tier
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Free")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            ForEach(subscriptionManager.freeFeatures, id: \.self) { feature in
                                HStack(alignment: .top, spacing: 8) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                    Text(feature)
                                        .font(.caption)
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        
                        // Premium Tier
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Premium")
                                    .font(.headline)
                                    .bold()
                                Image(systemName: "crown.fill")
                                    .foregroundColor(.yellow)
                                    .font(.caption)
                            }
                            
                            ForEach(subscriptionManager.premiumFeatures, id: \.self) { feature in
                                HStack(alignment: .top, spacing: 8) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.brandGreen)
                                    Text(feature)
                                        .font(.caption)
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                colors: [Color.brandGreen.opacity(0.15), Color.brandLightGreen.opacity(0.15)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.brandGreen, lineWidth: 2)
                        )
                    }
                    .padding(.horizontal)
                    
                    // Pricing
                    VStack(spacing: 16) {
                        VStack(spacing: 8) {
                            Text("$4.99")
                                .font(.system(size: 44, weight: .bold))
                            Text("per month")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Text("or")
                            .foregroundColor(.secondary)
                        
                        VStack(spacing: 8) {
                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                Text("$49.99")
                                    .font(.system(size: 44, weight: .bold))
                                Text("$59.88")
                                    .font(.title3)
                                    .strikethrough()
                                    .foregroundColor(.secondary)
                            }
                            Text("per year (Save 17%)")
                                .font(.subheadline)
                                .foregroundColor(.positiveGreen)
                                .bold()
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(12)
                    }
                    .padding(.vertical)
                    
                    // Subscribe Button
                    Button(action: {
                        subscriptionManager.upgradeToPremium()
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "crown.fill")
                            Text("Start Premium Trial")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [.brandGreen, .brandLightGreen],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    // Fine print
                    VStack(spacing: 8) {
                        Text("7-day free trial, then $4.99/month")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Button("Restore Purchase") {
                            subscriptionManager.restorePurchase()
                        }
                        .font(.caption)
                        .foregroundColor(.brandGreen)
                        
                        Text("Cancel anytime • No commitment")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 20)
                }
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

#Preview {
    PaywallView()
}
