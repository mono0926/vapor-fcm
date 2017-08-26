/// see: https://firebase.google.com/docs/cloud-messaging/http-server-ref#table1
public enum FCMError: String, Error {
    case
    MissingRegistration,
    InvalidRegistration,
    NotRegistered,
    InvalidPackageName,
    MismatchSenderId,
    InvalidParameters,
    MessageTooBig,
    InvalidDataKey,
    InvalidTtl,
    Unavailable,
    InternalServerError,
    DeviceMessageRateExceeded,
    TopicsMessageRateExceeded,
    InvalidApnsCredential
}
