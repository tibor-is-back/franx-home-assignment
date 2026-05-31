// swiftlint:disable nesting

extension AccessibilityIdentifier {
    enum Places {
        static let root = "places_root"
        static let loading = "places_loading"
        static let list = "places_list"
        static let empty = "places_empty"
        static let error = "places_error"

        static func listItem(id: String) -> String {
            "places_list_item_\(id)"
        }
    }
}
