import SwiftUI

struct ContentView: View {
    @StateObject private var dataManager = ETFDataManager()
    @ObservedObject private var subscriptionManager = SubscriptionManager.shared
    @State private var shares: String = "100"
    @State private var sortOption: SortOption = .score
    @State private var searchText: String = ""
    @State private var showPaywall = false
    @State private var showSettings = false
    
    enum SortOption: String, CaseIterable {
        case score = "Score"
        case yield = "Yield"
        case performance = "Performance"
    }
    
    var filteredETFs: [ETF] {
        var etfs: [ETF]
        
        // Apply search filter
        if searchText.isEmpty || !subscriptionManager.canAccessFeature(.search) {
            etfs = dataManager.etfs
        } else {
            etfs = dataManager.etfs.filter { etf in
                etf.ticker.localizedCaseInsensitiveContains(searchText) ||
                etf.name.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Limit ETFs for free tier
        if !subscriptionManager.isPremium {
            return Array(etfs.prefix(subscriptionManager.maxFreeETFs))
        }
        
        return etfs
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if dataManager.isLoading {
                    ProgressView("Loading ETF data...")
                        .padding()
                } else if let error = dataManager.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 50))
                            .foregroundColor(.orange)
                        Text(error)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            dataManager.loadData()
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding()
                } else {
                    // Header
                    VStack(spacing: 8) {
                        HStack {
                            Text("Shares:")
                                .font(.subheadline)
                            TextField("Shares", text: $shares)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .frame(width: 80)
                            
                            Spacer()
                            
                            Picker("Sort by", selection: $sortOption) {
                                ForEach(SortOption.allCases, id: \.self) { option in
                                    Text(option.rawValue).tag(option)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .frame(width: 200)
                        }
                        .padding(.horizontal)
                        
                        Text("Updated: \(dataManager.analysisDate)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    
                    // Free tier message
                    if !subscriptionManager.isPremium {
                        Button(action: { showPaywall = true }) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Image(systemName: "crown.fill")
                                            .foregroundColor(.yellow)
                                        Text("Upgrade to Premium")
                                            .font(.subheadline)
                                            .bold()
                                    }
                                    Text("View all \(dataManager.etfs.count) ETFs • Unlock calendar • Advanced features")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [Color.brandGreen.opacity(0.15), Color.brandLightGreen.opacity(0.15)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                    .padding(.bottom, 8)
                    }
                    
                    // ETF List
                    List {
                        ForEach(filteredETFs) { etf in
                            NavigationLink(destination: ETFDetailView(etf: etf, shares: Int(shares) ?? 100)) {
                                ETFRowView(etf: etf, shares: Int(shares) ?? 100)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .searchable(
                        text: $searchText,
                        prompt: subscriptionManager.canAccessFeature(.search) ? "Search by ticker or name" : "Search (Premium)"
                    )
                    .disabled(!subscriptionManager.canAccessFeature(.search) && !searchText.isEmpty)
                }
            }
            .navigationTitle("Dividend ETFs")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Toggle for testing - remove in production
                        subscriptionManager.togglePremium()
                    }) {
                        Image(systemName: subscriptionManager.isPremium ? "crown.fill" : "crown")
                            .foregroundColor(subscriptionManager.isPremium ? .yellow : .gray)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if subscriptionManager.canAccessFeature(.calendar) {
                        NavigationLink(destination: CalendarView(etfs: dataManager.etfs)) {
                            Image(systemName: "calendar")
                        }
                    } else {
                        Button(action: { showPaywall = true }) {
                            Image(systemName: "lock.fill")
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showSettings = true }) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.brandGreen)
                    }
                }
            }
            .sheet(isPresented: $showPaywall) {
                PaywallView()
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
        .onChange(of: sortOption) { newValue in
            applySorting(newValue)
        }
        .onChange(of: searchText) { _ in
            // Search filters the list automatically via filteredETFs computed property
        }
    }
    
    private func applySorting(_ option: SortOption) {
        switch option {
        case .score:
            dataManager.sortByScore()
        case .yield:
            dataManager.sortByYield()
        case .performance:
            dataManager.sortByPerformance()
        }
    }
}

struct ETFRowView: View {
    let etf: ETF
    let shares: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(etf.ticker)
                    .font(.headline)
                    .bold()
                
                Spacer()
                
                Text(String(format: "%.2f%%", etf.dividendYield / 100))
                    .font(.headline)
                    .foregroundColor(.brandGreen)
                    .bold()
            }
            
            Text(etf.name)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(String(format: "Price: $%.2f", etf.price))
                        .font(.caption)
                    Text(String(format: "Last Div: $%.4f", etf.lastDividend))
                        .font(.caption)
                    if let exDate = etf.lastExDate {
                        Text("Ex: \(exDate)")
                            .font(.caption2)
                            .foregroundColor(.brandLightGreen)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(etf.paymentFrequency)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if let performance = etf.monthPerformance {
                        Text(String(format: "%@%.2f%%", performance >= 0 ? "+" : "", performance))
                            .font(.caption)
                            .foregroundColor(performance > 0 ? .positiveGreen : (performance < 0 ? .negativeRed : .gray))
                    }
                }
            }
            
            HStack {
                Text(String(format: "Payment: $%.2f", etf.calculateDividendPayment(shares: shares)))
                    .font(.caption)
                    .foregroundColor(.dividendGreen)
                    .bold()
                
                Spacer()
                
                Text(String(format: "Score: %.0f", etf.score))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
}
