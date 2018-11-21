import Foundation

enum FetchFavoriteError: Error {
    case missingDataManager
}

protocol MoviesCollectionLocalDataManagerProtocol: class {
    func performFetchFavoritesIds(error: @escaping (FetchFavoriteError) -> Void, success: @escaping ([String]) -> Void)
}

final class MoviesCollectionLocalDataManager: MoviesCollectionLocalDataManagerProtocol {

    private let favoriteIds = ["tt0468569", "tt3315342", "tt0451279", "tt1843866", "tt0316654", "tt2015381"]

    func performFetchFavoritesIds(error: @escaping (FetchFavoriteError) -> Void, success: @escaping ([String]) -> Void) {
        // 0.5 of delay just to simulate a file system read
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let strongSelf = self else {
                error(.missingDataManager)
                return
            }

            success(strongSelf.favoriteIds)
        }
    }
}
