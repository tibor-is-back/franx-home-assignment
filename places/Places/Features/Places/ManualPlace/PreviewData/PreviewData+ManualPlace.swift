extension PreviewData {
    enum ManualPlace {
        static let deepLinkOpener: DeepLinkOpener = MockDeepLinkOpener()
    }
}

private struct MockDeepLinkOpener: DeepLinkOpener {
    func openLocation(latitude: String, longitude: String) throws(DeepLinkOpenerError) {}
}
