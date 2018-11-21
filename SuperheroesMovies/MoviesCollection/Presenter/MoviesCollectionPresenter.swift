import Foundation

protocol MoviesCollectionPresenterProtocol: class {
    var view: MoviesCollectionViewProtocol? { get set }
    var interactor: MoviesCollectionInteractorProtocol? { get set }
    var router: MoviesCollectionRouterProtocol? { get set }
    
    func shouldLoadMovies()
    func navigateToMovieDetails(movie: MovieViewModel)
}

final class MoviesCollectionPresenter: MoviesCollectionPresenterProtocol {

    weak var view: MoviesCollectionViewProtocol?
    var interactor: MoviesCollectionInteractorProtocol?
    var router: MoviesCollectionRouterProtocol?

    func shouldLoadMovies() {
        interactor?.fetchMovies(error: { [weak view ] _ in view?.failedToLoad() },
                                success: { [weak view] in view?.successfullyLoaded(movies: $0) })
    }

    func navigateToMovieDetails(movie: MovieViewModel) {
        router?.gotoMoviesDetails(movie: movie)
    }
}
