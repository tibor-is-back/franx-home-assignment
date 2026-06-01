import SwiftUI

@Observable
final class ManualPlaveViewModel {

    var latitude: String = ""
    var longitude: String = ""

    var valid: Bool {
        isValidCoordinate(latitude, in: Constants.ManualPlace.CoordinateRange.latitude)
            && isValidCoordinate(longitude, in: Constants.ManualPlace.CoordinateRange.longitude)
    }

    private let deepLinkOpener: DeepLinkOpener

    init(deeplLinkOpener: DeepLinkOpener) {
        self.deepLinkOpener = deeplLinkOpener
    }

    func handleEvent(_ event: ManualPlaceViewEvent) {
        
    }

    private func isValidCoordinate(_ text: String, in range: ClosedRange<Double>) -> Bool {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty,
              let value = Double(trimmed) else {
            return false
        }
        return range.contains(value)
    }
}
