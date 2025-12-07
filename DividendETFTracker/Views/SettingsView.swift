import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showContact = false
    @State private var showTerms = false
    @State private var showDisclaimer = false
    
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }
    
    var body: some View {
        NavigationView {
            Form {
                // Appearance Section
                Section(header: Text("Appearance")) {
                    Toggle(isOn: $isDarkMode) {
                        HStack {
                            Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                                .foregroundColor(isDarkMode ? .purple : .orange)
                                .frame(width: 24)
                            Text("Dark Mode")
                        }
                    }
                    .tint(.brandGreen)
                }
                
                // Support Section
                Section(header: Text("Support")) {
                    Button(action: { showContact = true }) {
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.brandGreen)
                                .frame(width: 24)
                            Text("Contact Us")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                // Legal Section
                Section(header: Text("Legal")) {
                    Button(action: { showDisclaimer = true }) {
                        HStack {
                            Image(systemName: "exclamationmark.shield.fill")
                                .foregroundColor(.brandGreen)
                                .frame(width: 24)
                            Text("Disclaimer")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Button(action: { showTerms = true }) {
                        HStack {
                            Image(systemName: "doc.text.fill")
                                .foregroundColor(.brandGreen)
                                .frame(width: 24)
                            Text("Terms of Service")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                // About Section
                Section(header: Text("About")) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.brandGreen)
                            .frame(width: 24)
                        Text("Version")
                        Spacer()
                        Text("\(appVersion) (\(buildNumber))")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Image(systemName: "building.2.fill")
                            .foregroundColor(.brandGreen)
                            .frame(width: 24)
                        Text("Developer")
                        Spacer()
                        Text("Dividend Tracker")
                            .foregroundColor(.secondary)
                    }
                }
                
                // Legal Section
                Section {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("© 2025 Dividend ETF Tracker")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("All rights reserved")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.brandGreen)
                }
            }
            .sheet(isPresented: $showContact) {
                ContactView()
            }
            .sheet(isPresented: $showTerms) {
                TermsOfServiceView()
            }
            .sheet(isPresented: $showDisclaimer) {
                DisclaimerView()
            }
        }
    }
}

#Preview {
    SettingsView()
}
