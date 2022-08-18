import SwiftUI

public extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = .zero
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, .zero)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

    init?(hex: String?) {
        guard let hex = hex else { return nil }
        self.init(hex: hex)
    }

    static let silver: Color = Color(hex: "E4EAED")
    static let alluminium: Color = Color(hex: "C4CFD4")
    static let platina: Color = Color(hex: "8B9DA6")
    static let castIron: Color = Color(hex: "333333")
    static let nephritis: Color = Color(hex: "08CFAB")
    static let mercury: Color = Color(hex: "F6F8F9")
    static let coral: Color = Color(hex: "FF655C")
}
