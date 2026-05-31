import Testing
@testable import Places

struct ContinentTests {
    @Test
    func givenNorthAmericanCoordinates_whenFromLatitudeLongitude_thenReturnsNorthAmerica() {
        // Given
        let latitude = 40.7128
        let longitude = -74.0060

        // When
        let continent = Continent.from(latitude: latitude, longitude: longitude)

        // Then
        #expect(continent == .northAmerica)
    }

    @Test
    func givenSouthAmericanCoordinates_whenFromLatitudeLongitude_thenReturnsSouthAmerica() {
        // Given
        let latitude = -23.5505
        let longitude = -46.6333

        // When
        let continent = Continent.from(latitude: latitude, longitude: longitude)

        // Then
        #expect(continent == .southAmerica)
    }

    @Test
    func givenEuropeanCoordinates_whenFromLatitudeLongitude_thenReturnsEurope() {
        // Given
        let latitude = 52.3676
        let longitude = 4.9041

        // When
        let continent = Continent.from(latitude: latitude, longitude: longitude)

        // Then
        #expect(continent == .europe)
    }

    @Test
    func givenAfricanCoordinates_whenFromLatitudeLongitude_thenReturnsAfrica() {
        // Given
        let latitude = 6.5244
        let longitude = 3.3792

        // When
        let continent = Continent.from(latitude: latitude, longitude: longitude)

        // Then
        #expect(continent == .africa)
    }

    @Test
    func givenAsianCoordinates_whenFromLatitudeLongitude_thenReturnsAsia() {
        // Given
        let latitude = 35.6762
        let longitude = 139.6503

        // When
        let continent = Continent.from(latitude: latitude, longitude: longitude)

        // Then
        #expect(continent == .asia)
    }
}
