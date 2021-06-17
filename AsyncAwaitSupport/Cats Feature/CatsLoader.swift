//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

protocol CatsLoader {
    @available(iOS 15.0, *)
    func load() async throws -> [Cat]

    func load(completion: @escaping (Result<[Cat], Error>) -> Void)
}
