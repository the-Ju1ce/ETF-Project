import Foundation
import Combine

class SubscriptionManager: ObservableObject {
    @Published var isPremium: Bool = false
    
    static let shared = SubscriptionManager()
    
    // Free tier limitations
    let maxFreeETFs = 3
    let freeFeatures = [
        "View up to 3 ETFs",
        "Basic dividend info",
        "Price and yield data"
    ]
    
    // Premium features
    let premiumFeatures = [
        "Unlimited ETF access",
        "Full dividend calendar",
        "Advanced sorting options",
        "Search functionality",
        "Detailed performance metrics",
        "Export to CSV (coming soon)",
        "Priority updates"
    ]
    
    private init() {
        // Load subscription status from UserDefaults
        isPremium = UserDefaults.standard.bool(forKey: "isPremium")
    }
    
    func upgradeToPremium() {
        isPremium = true
        UserDefaults.standard.set(true, forKey: "isPremium")
    }
    
    func restorePurchase() {
        // Simulate restore - in production, check App Store receipt
        isPremium = UserDefaults.standard.bool(forKey: "isPremium")
    }
    
    func canAccessFeature(_ feature: PremiumFeature) -> Bool {
        if isPremium {
            return true
        }
        
        switch feature {
        case .unlimitedETFs, .calendar, .advancedSort, .search, .detailedMetrics:
            return false
        case .basicView:
            return true
        }
    }
    
    // For testing - toggle premium status
    func togglePremium() {
        isPremium.toggle()
        UserDefaults.standard.set(isPremium, forKey: "isPremium")
    }
}

enum PremiumFeature {
    case basicView
    case unlimitedETFs
    case calendar
    case advancedSort
    case search
    case detailedMetrics
}
