import Foundation

extension String {
    func formatDate() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "YYYY-MM-dd"
        guard let date = inputFormatter.date(from: self) else { return nil }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "YYYY"
        return outputFormatter.string(from: date)
    }
    
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
