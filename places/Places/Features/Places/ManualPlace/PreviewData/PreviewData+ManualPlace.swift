extension PreviewData {
    @MainActor
    enum ManualPlace {
        static let deepLinkOpener: DeepLinkOpener = StubDeepLinkOpener()
    }
}
