import SwiftUI

extension Color {
    // Primary brand colors
    static let brandGreen = Color(red: 0.1, green: 0.4, blue: 0.2)      // Dark forest green
    static let brandLightGreen = Color(red: 0.2, green: 0.6, blue: 0.3) // Medium green
    static let brandAccent = Color(red: 0.3, green: 0.7, blue: 0.4)     // Lighter accent green
    
    // Semantic colors
    static let dividendGreen = Color(red: 0.15, green: 0.55, blue: 0.25) // For dividend amounts
    static let positiveGreen = Color(red: 0.2, green: 0.7, blue: 0.3)    // For positive performance
    static let negativeRed = Color(red: 0.8, green: 0.2, blue: 0.2)      // Keep red for losses
    
    // Background colors
    static let backgroundDarkGreen = Color(red: 0.08, green: 0.25, blue: 0.15) // Very dark green
    static let cardBackground = Color.white
}
