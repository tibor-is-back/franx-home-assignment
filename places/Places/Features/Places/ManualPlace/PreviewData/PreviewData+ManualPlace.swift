extension PreviewData {
    enum ManualPlace {
        static let deepLinkOpener: DeepLinkOpener = MockDeepLinkOpener()
    }
}

private struct MockDeepLinkOpener: DeepLinkOpener {
    func openLocation(latitude: Double, longitude: Double) throws(DeepLinkOpenerError) {}
}
