//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

class RemoteCatsLoader: CatsLoader {
    func load(completion: @escaping (Result<[Cat], Error>) -> Void) {
        let cats = [
            Cat(id: "beng", name: "Bengal"),
            Cat(id: "aege", name: "Aegean"),
            Cat(id: "beng", name: "Bengal"),
            Cat(id: "aege", name: "Aegean"),
        ]
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            completion(.success(cats))
        }
    }

    @available(iOS 15.0, *)
    func load() async throws -> [Cat] {
        try await withCheckedThrowingContinuation { continuation in
            self.load { result in
                continuation.resume(with: result)
            }
        }
    }
}
