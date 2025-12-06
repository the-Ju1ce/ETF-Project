import Foundation

class ETFDataManager: ObservableObject {
    @Published var etfs: [ETF] = []
    @Published var analysisDate: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() {
        loadData()
    }
    
    func loadData() {
        isLoading = true
        errorMessage = nil
        
        guard let url = Bundle.main.url(forResource: "etf_analysis_20251205", withExtension: "json") else {
            errorMessage = "Could not find data file"
            isLoading = false
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let analysis = try decoder.decode(ETFAnalysis.self, from: data)
            
            DispatchQueue.main.async {
                self.etfs = analysis.recommendations
                self.analysisDate = self.formatDate(analysis.date)
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Error loading data: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
    
    private func formatDate(_ isoDate: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = formatter.date(from: isoDate) else {
            return isoDate
        }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        displayFormatter.timeStyle = .none
        return displayFormatter.string(from: date)
    }
    
    func sortByScore() {
        etfs.sort { $0.score > $1.score }
    }
    
    func sortByYield() {
        etfs.sort { $0.dividendYield > $1.dividendYield }
    }
    
    func sortByPerformance() {
        etfs.sort { ($0.monthPerformance ?? -999) > ($1.monthPerformance ?? -999) }
    }
}
