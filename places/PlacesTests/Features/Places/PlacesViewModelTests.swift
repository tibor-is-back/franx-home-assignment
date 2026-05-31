import Testing
@testable import Places

@MainActor
struct PlacesViewModelTests {
    @Test
    func givenNewViewModel_whenCreated_thenStateIsLoading() {
        // Given
        // When
        let sut = makeSUT()

        // Then
        #expect(sut.viewModel.state.content == .loading)
        #expect(sut.viewModel.state.overlay == .none)
    }

    @Test
    func givenLocations_whenViewAppeared_thenStateIsLoadedWithMappedPlaces() async {
        // Given
        let sut = makeSUT()
        sut.locationService.locations = [
            LocationDTO(name: "Amsterdam", lat: 52.3676, long: 4.9041)
        ]

        // When
        await sut.viewModel.handleEvent(.viewAppeared)

        // Then
        #expect(sut.locationService.fetchCount == 1)
        guard case .loaded(let places) = sut.viewModel.state.content else {
            Issue.record("Expected loaded state")
            return
        }
        #expect(places == [
            PlaceViewData(
                locationName: "Amsterdam",
                latitude: "52.3676",
                longitude: "4.9041",
                continent: .europe
            )
        ])
        #expect(sut.viewModel.state.overlay == .none)
    }

    @Test
    func givenNilLocationName_whenViewAppeared_thenUsesUnknownLocationLabel() async {
        // Given
        let sut = makeSUT()
        sut.locationService.locations = [
            LocationDTO(name: nil, lat: 40.4381, long: -3.7481)
        ]

        // When
        await sut.viewModel.handleEvent(.viewAppeared)

        // Then
        guard case .loaded(let places) = sut.viewModel.state.content else {
            Issue.record("Expected loaded state")
            return
        }
        #expect(places.count == 1)
        #expect(places[0].locationName == Constants.Places.Strings.unknownLocation)
    }

    @Test
    func givenEmptyLocations_whenViewAppeared_thenStateIsNoPlaces() async {
        // Given
        let sut = makeSUT()
        sut.locationService.locations = []

        // When
        await sut.viewModel.handleEvent(.viewAppeared)

        // Then
        #expect(sut.viewModel.state.content == .noPlaces)
        #expect(sut.viewModel.state.overlay == .none)
    }

    @Test
    func givenOfflineError_whenViewAppeared_thenStateIsNoInternetError() async {
        // Given
        let sut = makeSUT()
        sut.locationService.error = .offline

        // When
        await sut.viewModel.handleEvent(.viewAppeared)

        // Then
        #expect(sut.viewModel.state.content == .error(
            title: Constants.Places.Strings.noInternetErrorTitle,
            subtitle: Constants.Places.Strings.noInternetErrorSubtitle
        ))
    }

    @Test
    func givenServerError_whenViewAppeared_thenStateIsGeneralError() async {
        // Given
        let sut = makeSUT()
        sut.locationService.error = .serverError

        // When
        await sut.viewModel.handleEvent(.viewAppeared)

        // Then
        #expect(sut.viewModel.state.content == .error(
            title: Constants.Places.Strings.generalErrorTitle,
            subtitle: Constants.Places.Strings.generalErrorSubtitle
        ))
    }

    @Test
    func givenInvalidDataError_whenViewAppeared_thenStateIsGeneralError() async {
        // Given
        let sut = makeSUT()
        sut.locationService.error = .invalidData

        // When
        await sut.viewModel.handleEvent(.viewAppeared)

        // Then
        #expect(sut.viewModel.state.content == .error(
            title: Constants.Places.Strings.generalErrorTitle,
            subtitle: Constants.Places.Strings.generalErrorSubtitle
        ))
    }

    @Test
    func givenFailedFetch_whenRetryTapped_thenFetchesLocationsAgain() async {
        // Given
        let sut = makeSUT()
        sut.locationService.error = .offline
        await sut.viewModel.handleEvent(.viewAppeared)
        sut.locationService.error = nil
        sut.locationService.locations = [
            LocationDTO(name: "Mumbai", lat: 19.0824, long: 72.8118)
        ]

        // When
        await sut.viewModel.handleEvent(.retryTapped)

        // Then
        #expect(sut.locationService.fetchCount == 2)
        guard case .loaded(let places) = sut.viewModel.state.content else {
            Issue.record("Expected loaded state")
            return
        }
        #expect(places.count == 1)
        #expect(places[0].locationName == "Mumbai")
    }

    @Test
    func givenLoadedState_whenPlaceTappedAndDeepLinkSucceeds_thenOpensLocationWithoutToast() async {
        // Given
        let sut = makeSUT()
        sut.locationService.locations = [
            LocationDTO(name: "Copenhagen", lat: 55.6713, long: 12.5238)
        ]
        await sut.viewModel.handleEvent(.viewAppeared)
        guard case .loaded(let places) = sut.viewModel.state.content else {
            Issue.record("Expected loaded state")
            return
        }

        // When
        await sut.viewModel.handleEvent(.placeTapped(places[0]))

        // Then
        #expect(sut.deepLinkOpener.lastLatitude == "55.6713")
        #expect(sut.deepLinkOpener.lastLongitude == "12.5238")
        #expect(sut.viewModel.state.overlay == .none)
    }

    @Test
    func givenLoadedState_whenPlaceTappedAndDeepLinkFails_thenShowsAppNotInstalledToast() async {
        // Given
        let sut = makeSUT()
        sut.locationService.locations = [
            LocationDTO(name: "Copenhagen", lat: 55.6713, long: 12.5238)
        ]
        sut.deepLinkOpener.shouldThrow = true
        await sut.viewModel.handleEvent(.viewAppeared)
        guard case .loaded(let places) = sut.viewModel.state.content else {
            Issue.record("Expected loaded state")
            return
        }

        // When
        await sut.viewModel.handleEvent(.placeTapped(places[0]))

        // Then
        #expect(sut.viewModel.state.overlay == .toast(message: Constants.Places.Strings.appNotInstalled))
        guard case .loaded = sut.viewModel.state.content else {
            Issue.record("Expected content to remain loaded")
            return
        }
    }

    @Test
    func givenToastVisible_whenDismissToast_thenOverlayIsNone() async {
        // Given
        let sut = makeSUT()
        sut.locationService.locations = [
            LocationDTO(name: "Copenhagen", lat: 55.6713, long: 12.5238)
        ]
        sut.deepLinkOpener.shouldThrow = true
        await sut.viewModel.handleEvent(.viewAppeared)
        guard case .loaded(let places) = sut.viewModel.state.content else {
            Issue.record("Expected loaded state")
            return
        }
        await sut.viewModel.handleEvent(.placeTapped(places[0]))

        // When
        await sut.viewModel.handleEvent(.dismissToast)

        // Then
        #expect(sut.viewModel.state.overlay == .none)
    }

    private func makeSUT() -> SUT {
        let locationService = MockLocationsService()
        let deepLinkOpener = MockDeepLinkOpener()
        let viewModel = PlacesViewModel(
            locationService: locationService,
            deepLinkOpener: deepLinkOpener
        )
        return SUT(
            viewModel: viewModel,
            locationService: locationService,
            deepLinkOpener: deepLinkOpener
        )
    }
}

@MainActor
private struct SUT {
    let viewModel: PlacesViewModel
    let locationService: MockLocationsService
    let deepLinkOpener: MockDeepLinkOpener
}

@MainActor
private final class MockLocationsService: LocationsService {
    var locations: [LocationDTO] = []
    var error: LocationsServiceError?
    private(set) var fetchCount = 0

    func fetchLocations() async throws(LocationsServiceError) -> [LocationDTO] {
        fetchCount += 1
        if let error {
            throw error
        }
        return locations
    }
}

@MainActor
private final class MockDeepLinkOpener: DeepLinkOpener {
    var shouldThrow = false
    private(set) var lastLatitude: String?
    private(set) var lastLongitude: String?

    func openLocation(latitude: String, longitude: String) throws(DeepLinkOpenerError) {
        lastLatitude = latitude
        lastLongitude = longitude
        if shouldThrow {
            throw .unableToOpenDestination
        }
    }
}
