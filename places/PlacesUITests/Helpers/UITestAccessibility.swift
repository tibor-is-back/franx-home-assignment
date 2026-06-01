enum UITestAccessibility {
    enum Places {
        static let empty = "places_empty"
        static let manualPlaceButton = "places_manual_place_button"

        static let sanFranciscoListItem = "places_list_item_San Francisco-37.7749--122.4194"
    }

    enum ManualPlace {
        static let latitudeField = "manual_place_latitude_field"
        static let longitudeField = "manual_place_longitude_field"
        static let openWikipediaButton = "manual_place_open_wikipedia_button"
    }

    enum Common {
        static let errorRetry = "common_error_retry"
        static let toast = "common_toast"
        static let toastDismiss = "common_toast_dismiss"
    }
}
