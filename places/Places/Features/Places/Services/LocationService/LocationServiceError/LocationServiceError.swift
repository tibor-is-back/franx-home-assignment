enum LocationsServiceError: Error, Equatable, Sendable {
    case offline
    case serverError
    case invalidData
}
