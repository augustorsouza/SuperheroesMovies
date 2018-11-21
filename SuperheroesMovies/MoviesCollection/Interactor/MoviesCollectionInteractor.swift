import Foundation

enum FetchMoviesError: Error {
    case failedToFetchFavorites
    case failedToFetchDetails
}

protocol MoviesCollectionInteractorProtocol: class {
    var presenter: MoviesCollectionPresenterProtocol? { get set }
    var apiDataManager: MoviesCollectionApiDataManagerProtocol? { get set }
    var localDataManager: MoviesCollectionLocalDataManagerProtocol? { get set }

    func fetchMovies(error: @escaping (FetchMoviesError) -> Void, success: @escaping ([MovieViewModel]) -> Void)
}

final class MoviesCollectionInteractor: MoviesCollectionInteractorProtocol {
    weak var presenter: MoviesCollectionPresenterProtocol?
    var apiDataManager: MoviesCollectionApiDataManagerProtocol?
    var localDataManager: MoviesCollectionLocalDataManagerProtocol?

    func fetchMovies(error: @escaping (FetchMoviesError) -> Void, success: @escaping ([MovieViewModel]) -> Void) {
        localDataManager?.performFetchFavoritesIds(
            error: { _ in error(.failedToFetchFavorites) },
            success: { [weak apiDataManager] ids in
                apiDataManager?.performFetchMovies(ids: ids, error: { _ in  error(.failedToFetchDetails) }, success: { movies in
                    success(movies.compactMap({ MovieViewModel(movie: $0) }))
                })
        })
    }
}
