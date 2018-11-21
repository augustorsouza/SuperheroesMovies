import Foundation

protocol MovieDetailsPresenterProtocol: class {
    var view: MovieDetailsViewProtocol? { get set }
    var interactor: MovieDetailsInteractorProtocol? { get set }
    var router: MovieDetailsRouterProtocol? { get set }
    
    func shouldLoadMovie()
}

final class MovieDetailsPresenter: MovieDetailsPresenterProtocol {

    weak var view: MovieDetailsViewProtocol?
    var interactor: MovieDetailsInteractorProtocol?
    var router: MovieDetailsRouterProtocol?

    let movie: MovieViewModel

    init(movie: MovieViewModel) {
        self.movie = movie
    }

    func shouldLoadMovie() {
        view?.movieLoaded(movie: movie)
    }

}
