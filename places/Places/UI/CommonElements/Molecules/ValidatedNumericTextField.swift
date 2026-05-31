import SwiftUI

private enum NumericTextValidation {
    case valid
    case invalidNumber
    case outOfRange

    static func result(for text: String, in range: ClosedRange<Double>) -> NumericTextValidation {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return .valid }

        guard let value = Double(trimmed) else { return .invalidNumber }
        guard range.contains(value) else { return .outOfRange }
        return .valid
    }

    static func errorMessage(for text: String, in range: ClosedRange<Double>) -> String? {
        switch result(for: text, in: range) {
        case .valid:
            return nil
        case .invalidNumber:
            return Constants.Common.Strings.invalidNumber
        case .outOfRange:
            return outOfRangeMessage(for: range)
        }
    }

    private static func outOfRangeMessage(for range: ClosedRange<Double>) -> String {
        let lower = String(range.lowerBound)
        let upper = String(range.upperBound)
        return String(format: Constants.Common.Strings.outOfRange, lower, upper)
    }
}

struct ValidatedNumericTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    let range: ClosedRange<Double>
    let accessibilityIdentifier: String

    private var validationError: String? {
        NumericTextValidation.errorMessage(for: text, in: range)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.xSmall) {
            Text(label)
                .font(DesignSystem.Fonts.headline)
                .foregroundStyle(DesignSystem.Colors.primaryText)

            TextField(placeholder, text: $text)
                .font(DesignSystem.Fonts.body)
                .keyboardType(.decimalPad)
                .padding(DesignSystem.Spacing.small)
                .background(
                    RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.small)
                        .fill(Color(.secondarySystemGroupedBackground))
                )
                .overlay {
                    RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.small)
                        .strokeBorder(borderColor, lineWidth: 1)
                }
                .accessibilityIdentifier(accessibilityIdentifier)
                .accessibilityLabel(label)

            if let validationError {
                Text(validationError)
                    .font(DesignSystem.Fonts.caption)
                    .foregroundStyle(DesignSystem.Colors.error)
                    .accessibilityIdentifier("\(accessibilityIdentifier)_error")
                    .accessibilityLabel(validationError)
            }
        }
    }

    private var borderColor: Color {
        validationError != nil ? DesignSystem.Colors.error : DesignSystem.Colors.separator
    }
}

#Preview("Valid") {
    ValidatedNumericTextFieldPreview(initialText: "40.7128")
}

#Preview("Invalid number") {
    ValidatedNumericTextFieldPreview(initialText: "abc")
}

#Preview("Out of range") {
    ValidatedNumericTextFieldPreview(initialText: "120")
}

#Preview("Valid – Dark") {
    ValidatedNumericTextFieldPreview(initialText: "40.7128")
        .preferredColorScheme(.dark)
}

private struct ValidatedNumericTextFieldPreview: View {
    @State private var text: String

    init(initialText: String) {
        _text = State(initialValue: initialText)
    }

    var body: some View {
        ValidatedNumericTextField(
            label: "Latitude",
            placeholder: "eg. 40.7128",
            text: $text,
            range: -90...90,
            accessibilityIdentifier: "preview_latitude_field"
        )
        .padding(DesignSystem.Spacing.medium)
        .background(DesignSystem.Colors.screenBackground)
    }
}
