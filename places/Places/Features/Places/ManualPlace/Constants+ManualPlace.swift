extension Constants {
    enum ManualPlace {
        enum Strings {
            static let title = "Manual place"
            static let disclaimer = "Provide manual coordinates below"
            static let latitudeLabel = "Latitude"
            static let longitudeLabel = "Longitude"
            static let latitudePlaceholder = "eg. 40.7128"
            static let longitudePlaceholder = "eg. 74.0.06"
            static let openWikipedia = "Open Wikipedia"
        }

        enum CoordinateRange {
            static let latitude: ClosedRange<Double> = -90...90
            static let longitude: ClosedRange<Double> = -180...180
        }
    }
}
