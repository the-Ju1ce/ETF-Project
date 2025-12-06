import SwiftUI

struct ContactView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var subject: String = ""
    @State private var message: String = ""
    @State private var selectedCategory: ContactCategory = .general
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    enum ContactCategory: String, CaseIterable {
        case general = "General Inquiry"
        case support = "Technical Support"
        case feature = "Feature Request"
        case bug = "Report a Bug"
        case subscription = "Subscription Issue"
    }
    
    var isFormValid: Bool {
        !name.isEmpty && !email.isEmpty && !message.isEmpty && email.contains("@")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your Information")) {
                    TextField("Name", text: $name)
                        .textContentType(.name)
                    
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                Section(header: Text("Message Details")) {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(ContactCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    
                    TextField("Subject (Optional)", text: $subject)
                    
                    TextEditor(text: $message)
                        .frame(minHeight: 100)
                        .overlay(
                            Group {
                                if message.isEmpty {
                                    Text("Tell us how we can help...")
                                        .foregroundColor(.gray)
                                        .padding(.top, 8)
                                        .padding(.leading, 4)
                                        .allowsHitTesting(false)
                                }
                            },
                            alignment: .topLeading
                        )
                }
                
                Section(header: Text("Contact Information")) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.brandGreen)
                            Text("support@dividendtracker.app")
                                .font(.caption)
                        }
                        
                        HStack {
                            Image(systemName: "clock.fill")
                                .foregroundColor(.brandGreen)
                            Text("Response time: 24-48 hours")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section {
                    Button(action: submitForm) {
                        HStack {
                            Spacer()
                            if isFormValid {
                                Text("Send Message")
                                    .bold()
                            } else {
                                Text("Please fill in all required fields")
                                    .font(.caption)
                            }
                            Spacer()
                        }
                    }
                    .disabled(!isFormValid)
                    .foregroundColor(isFormValid ? .brandGreen : .gray)
                }
            }
            .navigationTitle("Contact Us")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
            .alert("Message Sent", isPresented: $showAlert) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func submitForm() {
        // In production, this would send to your backend
        // For now, we'll simulate sending
        
        let emailBody = """
        Name: \(name)
        Email: \(email)
        Category: \(selectedCategory.rawValue)
        Subject: \(subject.isEmpty ? "No subject" : subject)
        
        Message:
        \(message)
        """
        
        print("Contact form submitted:")
        print(emailBody)
        
        alertMessage = "Thank you for contacting us! We'll respond to \(email) within 24-48 hours."
        showAlert = true
        
        // Reset form
        name = ""
        email = ""
        subject = ""
        message = ""
        selectedCategory = .general
    }
}

#Preview {
    ContactView()
}
