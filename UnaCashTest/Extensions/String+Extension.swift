import Foundation

public extension String {
    static let empty = ""

    func deletingPrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }
    
    func applyPatternOnNumbers(pattern: String) -> String {
        let replacmentCharacter: Character = "#"
        let pureNumber = replacingOccurrences(of: "[^۰-۹0-9]", with: String.empty, options: .regularExpression)
        var result: String = .empty
        var pureNumberIndex = pureNumber.startIndex
        for patternCharacter in pattern {
            guard pureNumberIndex < pureNumber.endIndex else { return result }
            if patternCharacter == replacmentCharacter {
                result.append(pureNumber[pureNumberIndex])
                pureNumber.formIndex(after: &pureNumberIndex)
            } else {
                result.append(patternCharacter)
            }
        }
        return result
    }
}
