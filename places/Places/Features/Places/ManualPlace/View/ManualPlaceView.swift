import SwiftUI

struct ManualPlaceView: View {

    @State private var viewModel: ManualPlaveViewModel

    init(deepLinkOpener: DeepLinkOpener) {
        _viewModel = State(initialValue: ManualPlaveViewModel(deeplLinkOpener: deepLinkOpener))
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(spacing: DesignSystem.Spacing.large) {
                    Image(systemName: "globe.europe.africa")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(DesignSystem.Colors.primary)
                        .frame(width: DesignSystem.Size.image, height: DesignSystem.Size.image)
                        .frame(maxWidth: .infinity)
                        .accessibilityHidden(true)

                    Text(Constants.ManualPlace.Strings.disclaimer)
                        .font(DesignSystem.Fonts.subheadline)
                        .foregroundStyle(DesignSystem.Colors.secondaryText)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .accessibilityIdentifier(AccessibilityIdentifier.ManualPlace.disclaimer)

                    VStack(alignment: .leading, spacing: DesignSystem.Spacing.medium) {
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
                    }

                    Button(Constants.ManualPlace.Strings.openWikipedia) {
                        viewModel.handleEvent(.openButtonTapped)
                    }
                        .buttonStyle(.primary)
                        .disabled(!viewModel.valid)
                        .accessibilityIdentifier(AccessibilityIdentifier.ManualPlace.openWikipediaButton)
                    }
                    .padding(DesignSystem.Spacing.medium)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(DesignSystem.Colors.screenBackground)

                if let message = viewModel.toastMessage {
                    ToastView(message: message) {
                        dismissToast()
                    }
                    .task(id: message) {
                        try? await Task.sleep(for: DesignSystem.Toast.dismissDelay)
                        dismissToast()
                    }
                }
            }
            .navigationTitle(Constants.ManualPlace.Strings.title)
            .navigationBarTitleDisplayMode(.inline)
            .accessibilityIdentifier(AccessibilityIdentifier.ManualPlace.root)
        }
    }

    private func dismissToast() {
        viewModel.handleEvent(.toastDismissed)
    }
}

#Preview {
    ManualPlaceView(deepLinkOpener: PreviewData.ManualPlace.deepLinkOpener)
}
