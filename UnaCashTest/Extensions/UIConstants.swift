import CoreGraphics

public extension CGFloat {
    // Spacing
    /// Padding equals 16.0 points
    static var normalGap: Self { 16.0 }
    /// Padding equals 8.0 points
    static var halfGap: Self { normalGap / 2.0 }
    /// Padding equals 32.0 points
    static var doubleGap: Self { normalGap * 2.0 }

    // Button
    /// Button's height equals 48.0 points
    static var normalButton: Self { 48.0 }

    // Corner
    /// Corner radius equals 8.0 points
    static var smallCorner: Self { 8.0 }
    /// Corner radius equals 10.0 points
    static var normalCorner: Self { 10.0 }
}
