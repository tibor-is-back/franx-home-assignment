import Testing
@testable import Places

@MainActor
struct ManualPlaceViewModelTests {
    @Test
    func givenNewViewModel_whenCreated_thenCoordinatesAreEmptyAndToastIsNil() {
        let sut = makeSUT()

        #expect(sut.viewModel.latitude.isEmpty)
        #expect(sut.viewModel.longitude.isEmpty)
        #expect(sut.viewModel.toastMessage == nil)
        #expect(sut.viewModel.valid == false)
    }

    @Test
    func givenEmptyCoordinates_whenValidChecked_thenReturnsFalse() {
        let sut = makeSUT()

        #expect(sut.viewModel.valid == false)
    }

    @Test
    func givenValidCoordinates_whenValidChecked_thenReturnsTrue() {
        let sut = makeSUT()
        sut.viewModel.latitude = "52.37"
        sut.viewModel.longitude = "4.89"

        #expect(sut.viewModel.valid == true)
    }

    @Test
    func givenLatitudeOutOfRange_whenValidChecked_thenReturnsFalse() {
        let sut = makeSUT()
        sut.viewModel.latitude = "91"
        sut.viewModel.longitude = "4.89"

        #expect(sut.viewModel.valid == false)
    }

    @Test
    func givenLongitudeOutOfRange_whenValidChecked_thenReturnsFalse() {
        let sut = makeSUT()
        sut.viewModel.latitude = "52.37"
        sut.viewModel.longitude = "181"

        #expect(sut.viewModel.valid == false)
    }

    @Test
    func givenInvalidNumericInput_whenValidChecked_thenReturnsFalse() {
        let sut = makeSUT()
        sut.viewModel.latitude = "abc"
        sut.viewModel.longitude = "4.89"

        #expect(sut.viewModel.valid == false)
    }

    @Test
    func givenEmptyCoordinates_whenContinentChecked_thenReturnsAllContinents() {
        let sut = makeSUT()

        #expect(sut.viewModel.continent == .allContinents)
    }

    @Test
    func givenEuropeanCoordinates_whenContinentChecked_thenReturnsEurope() {
        let sut = makeSUT()
        sut.viewModel.latitude = "52.37"
        sut.viewModel.longitude = "4.89"

        #expect(sut.viewModel.continent == .europe)
    }

    @Test
    func givenOpenOceanCoordinates_whenContinentChecked_thenReturnsAllContinents() {
        let sut = makeSUT()
        sut.viewModel.latitude = "0"
        sut.viewModel.longitude = "-160"

        #expect(sut.viewModel.continent == .allContinents)
    }

    @Test
    func givenWhitespaceAroundCoordinates_whenValidChecked_thenReturnsTrue() {
        let sut = makeSUT()
        sut.viewModel.latitude = "  52.37  "
        sut.viewModel.longitude = "  4.89  "

        #expect(sut.viewModel.valid == true)
    }

    @Test
    func givenValidCoordinates_whenOpenButtonTappedAndDeepLinkSucceeds_thenOpensLocationWithoutToast() {
        let sut = makeSUT()
        sut.viewModel.latitude = "52.37"
        sut.viewModel.longitude = "4.89"

        sut.viewModel.handleEvent(.openButtonTapped)

        #expect(sut.deepLinkOpener.lastLatitude == "52.37")
        #expect(sut.deepLinkOpener.lastLongitude == "4.89")
        #expect(sut.viewModel.toastMessage == nil)
    }

    @Test
    func givenValidCoordinates_whenOpenButtonTappedAndDeepLinkFails_thenShowsAppNotInstalledToast() {
        let sut = makeSUT()
        sut.viewModel.latitude = "52.37"
        sut.viewModel.longitude = "4.89"
        sut.deepLinkOpener.shouldThrow = true

        sut.viewModel.handleEvent(.openButtonTapped)

        #expect(sut.viewModel.toastMessage == Constants.ManualPlace.Strings.appNotInstalled)
    }

    @Test
    func givenToastVisible_whenToastDismissed_thenToastIsNil() {
        let sut = makeSUT()
        sut.viewModel.latitude = "52.37"
        sut.viewModel.longitude = "4.89"
        sut.deepLinkOpener.shouldThrow = true
        sut.viewModel.handleEvent(.openButtonTapped)

        sut.viewModel.handleEvent(.toastDismissed)

        #expect(sut.viewModel.toastMessage == nil)
    }

    private func makeSUT() -> SUT {
        let deepLinkOpener = MockDeepLinkOpener()
        let viewModel = ManualPlaveViewModel(deeplLinkOpener: deepLinkOpener)
        return SUT(viewModel: viewModel, deepLinkOpener: deepLinkOpener)
    }
}

@MainActor
private struct SUT {
    let viewModel: ManualPlaveViewModel
    let deepLinkOpener: MockDeepLinkOpener
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
