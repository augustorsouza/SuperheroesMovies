import UIKit

protocol MovieDetailsRouterProtocol {
    func goBackToMoviesCollection(navigationController: UINavigationController?)
}

final class MovieDetailsRouter: MovieDetailsRouterProtocol {

    static func presentMovieDetailsModule(movie: MovieViewModel) -> UIViewController? {

        let view: MovieDetailsViewProtocol = UIStoryboard.main.instantiateViewController(withIdentifier: MovieDetailsViewController.identifier) as! MovieDetailsViewController
        let presenter: MovieDetailsPresenterProtocol = MovieDetailsPresenter(movie: movie)
        let interactor: MovieDetailsInteractorProtocol = MovieDetailsInteractor()
        let apiDataManager: MovieDetailsApiDataManagerProtocol = MovieDetailsApiDataManager()
        let localDataManager: MovieDetailsLocalDataManagerProtocol = MovieDetailsLocalDataManager()
        let router: MovieDetailsRouterProtocol = MovieDetailsRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.apiDataManager = apiDataManager
        interactor.localDataManager = localDataManager

        return view as? UIViewController
    }

    func goBackToMoviesCollection(navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: true)
    }
}
