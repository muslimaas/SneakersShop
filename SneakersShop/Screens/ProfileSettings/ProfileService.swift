//
//  ProfileService.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 14.02.2026.
//

import FirebaseAuth
import FirebaseFirestore

final class ProfileService {

    static let shared = ProfileService()
    private let db = Firestore.firestore()

    private var uid: String? {
        Auth.auth().currentUser?.uid
    }

    func saveProfile(username: String,
                     shoeSize: String,
                     completion: @escaping (Error?) -> Void) {

        guard let uid else { return }

        db.collection("users")
            .document(uid)
            .setData([
                "username": username,
                "shoeSize": shoeSize
            ], merge: true) { error in
                completion(error)
            }
    }

    func fetchProfile(completion: @escaping (Result<(String, String), Error>) -> Void) {

        guard let uid else { return }

        db.collection("users")
            .document(uid)
            .getDocument { snapshot, error in

                if let error = error {
                    completion(.failure(error))
                    return
                }

                let username = snapshot?.data()?["username"] as? String ?? ""
                let shoeSize = snapshot?.data()?["shoeSize"] as? String ?? ""

                completion(.success((username, shoeSize)))
            }
    }
}
