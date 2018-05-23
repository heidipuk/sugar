import Vapor

/// Errors that can be thrown during authentication
public enum AuthenticationError: String, Error {
    case signingError
    case userNotFound
    case weakPassword
    case usernameAlreadyExists
    case incorrectPassword
    case incorrectOldPassword
    case passwordWithoutUsernameOrOldPassword
}

// MARK: - AbortError
extension AuthenticationError: AbortError {

    /// See `AbortError.status`
    public var status: HTTPResponseStatus {
        switch self {
        case .signingError                          : return .internalServerError
        case .userNotFound                          : return .unauthorized
        case .weakPassword                          : return .unprocessableEntity
        case .usernameAlreadyExists                 : return .unprocessableEntity
        case .incorrectPassword                     : return .unauthorized
        case .incorrectOldPassword                  : return .unauthorized
        case .passwordWithoutUsernameOrOldPassword  : return .unprocessableEntity
        }
    }

    /// See `AbortError.reason`
    public var reason: String {
        switch self {
        case .signingError:
            return "Could not convert signed JWT into String."
        case .userNotFound:
            return "Could not find user."
        case .weakPassword:
            return "The supplied password did not meet the password strength requirements."
        case .usernameAlreadyExists:
            return "A user with the supplied username already exists."
        case .incorrectPassword:
            return "Incorrect password given."
        case .incorrectOldPassword:
            return "Incorrect old password."
        case .passwordWithoutUsernameOrOldPassword:
            return "Password should only be provided when updating it or updating the username."
        }
    }
}

// MARK: - Debuggable
extension AuthenticationError: Debuggable {

    /// See `Debuggable.identifier`
    public var identifier: String {
        return rawValue
    }
}
