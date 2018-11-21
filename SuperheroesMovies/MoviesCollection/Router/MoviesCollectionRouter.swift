import UIKit

protocol MoviesCollectionRouterProtocol {
    func gotoMoviesDetails(movie: MovieViewModel)
}

final class MoviesCollectionRouter: MoviesCollectionRouterProtocol {

    var navigationController: UINavigationController?

    static func presentMoviesCollectionModule() -> UINavigationController? {
        guard let view: MoviesCollectionViewProtocol = UIStoryboard.main.instantiateViewController(withIdentifier: MoviesCollectionViewController.identifier) as? MoviesCollectionViewController
            else { return nil }

        let presenter: MoviesCollectionPresenterProtocol = MoviesCollectionPresenter()
        let interactor: MoviesCollectionInteractorProtocol = MoviesCollectionInteractor()
        let apiDataManager: MoviesCollectionApiDataManagerProtocol = MoviesCollectionApiDataManager()
        let localDataManager: MoviesCollectionLocalDataManagerProtocol = MoviesCollectionLocalDataManager()
        let router: MoviesCollectionRouterProtocol = MoviesCollectionRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.apiDataManager = apiDataManager
        interactor.localDataManager = localDataManager

        if let router = router as? MoviesCollectionRouter, let view = view as? MoviesCollectionViewController {
            router.navigationController = UINavigationController(rootViewController: view)
            return router.navigationController
        } else {
            return nil
        }
    }

    func gotoMoviesDetails(movie: MovieViewModel) {
        guard let movieDetailsView = MovieDetailsRouter.presentMovieDetailsModule(movie: movie) else { return }

        navigationController?.pushViewController(movieDetailsView, animated: true)
    }
}
