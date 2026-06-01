import SwiftUI

nonisolated enum Continent: CaseIterable {
    case europe
    case asia
    case africa
    case northAmerica
    case southAmerica
    case allContinents

    @MainActor var color: Color {
        switch self {
        case .europe: DesignSystem.Colors.locationBlue
        case .asia: DesignSystem.Colors.locationRed
        case .africa: DesignSystem.Colors.locationOrange
        case .northAmerica: DesignSystem.Colors.locationPurple
        case .southAmerica: DesignSystem.Colors.locationTeal
        case .allContinents: DesignSystem.Colors.locationGray
        }
    }

    var imageName: String {
        switch self {
        case .europe: "continent-europe"
        case .asia: "continent-asia"
        case .africa: "continent-africa"
        case .northAmerica: "continent-north-america"
        case .southAmerica: "continent-south-america"
        case .allContinents: "all-continents"
        }
    }

    static func from(latitude: Double, longitude: Double) -> Continent {
        if latitude >= 7, longitude <= -50 {
            return .northAmerica
        }

        if latitude < 15, longitude <= -30 {
            return .southAmerica
        }

        if latitude >= 35, longitude >= -10, longitude <= 40 {
            return .europe
        }

        if latitude >= -35, latitude <= 37, longitude >= -20, longitude <= 55 {
            return .africa
        }

        if latitude >= -5, latitude <= 55, longitude >= 95 {
            return .asia
        }

        if latitude >= 5, latitude <= 45, longitude >= 25, longitude < 95 {
            return .asia
        }

        return .allContinents
    }
}
