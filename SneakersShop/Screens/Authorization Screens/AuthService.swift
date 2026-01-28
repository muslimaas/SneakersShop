import FirebaseAuth

final class AuthService {

    static let shared = AuthService()

    private init() {}

    func signUp( email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser( withEmail: email, password: password) { _, error in
            if let error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func signIn( email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn( withEmail: email, password: password) { _, error in
            if let error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
