extension AccessibilityIdentifier {
    enum Places {
        static let empty = "places_empty"
        static let manualPlaceButton = "places_manual_place_button"

        static func listItem(id: String) -> String {
            "places_list_item_\(id)"
        }
    }
}
