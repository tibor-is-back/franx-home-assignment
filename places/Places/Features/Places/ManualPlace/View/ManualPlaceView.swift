import SwiftUI

struct ManualPlaceView: View {

    @State private var viewModel: ManualPlaveViewModel

    init(deepLinkOpener: DeepLinkOpener) {
        _viewModel = State(initialValue: ManualPlaveViewModel(deeplLinkOpener: deepLinkOpener))
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                VStack(spacing: DesignSystem.Spacing.large) {
                    PlaceIconView(
                        continent: viewModel.continent,
                        containerSize: DesignSystem.Size.largeIconContainer
                    )

                    Text(Constants.ManualPlace.Strings.disclaimer)
                        .font(DesignSystem.Fonts.subheadline)
                        .foregroundStyle(DesignSystem.Colors.secondaryText)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)

                    ValidatedNumericTextField(
                        label: Constants.ManualPlace.Strings.latitudeLabel,
                        placeholder: Constants.ManualPlace.Strings.latitudePlaceholder,
                        text: $viewModel.latitude,
                        range: Constants.ManualPlace.CoordinateRange.latitude,
                        accessibilityIdentifier: AccessibilityIdentifier.ManualPlace.latitudeField
                    )

                    ValidatedNumericTextField(
                        label: Constants.ManualPlace.Strings.longitudeLabel,
                        placeholder: Constants.ManualPlace.Strings.longitudePlaceholder,
                        text: $viewModel.longitude,
                        range: Constants.ManualPlace.CoordinateRange.longitude,
                        accessibilityIdentifier: AccessibilityIdentifier.ManualPlace.longitudeField
                    )

                    Button {
                        viewModel.handleEvent(.openButtonTapped)
                    } label: {
                        Text(Constants.ManualPlace.Strings.openWikipedia)
                    }
                    .disabled(!viewModel.valid)
                    .buttonStyle(.primary)
                    .accessibilityIdentifier(AccessibilityIdentifier.ManualPlace.openWikipediaButton)
                    .accessibilityRespondsToUserInteraction(viewModel.valid)
                }
                .padding(DesignSystem.Spacing.medium)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

                if let message = viewModel.toastMessage {
                    ToastView(
                        message: message,
                        onDismiss: { viewModel.handleEvent(.toastDismissed) }
                    )
                    .padding(.horizontal, DesignSystem.Spacing.medium)
                    .padding(.top, DesignSystem.Spacing.medium)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(DesignSystem.Colors.screenBackground)
            .navigationTitle(Constants.ManualPlace.Strings.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ManualPlaceView(deepLinkOpener: PreviewData.ManualPlace.deepLinkOpener)
}

#Preview("Dark") {
    ManualPlaceView(deepLinkOpener: PreviewData.ManualPlace.deepLinkOpener)
        .preferredColorScheme(.dark)
}
