extension AccessibilityIdentifier {
    enum Places {
        static let root = "places_root"
        static let loading = "places_loading"
        static let list = "places_list"
        static let empty = "places_empty"
        static let error = "places_error"
        static let manualPlaceButton = "places_manual_place_button"

        static func listItem(id: String) -> String {
            "places_list_item_\(id)"
        }
    }
}
