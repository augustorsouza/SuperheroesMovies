import Foundation

protocol MovieDetailsInteractorProtocol: class {
    var presenter: MovieDetailsPresenterProtocol? { get set }
    var apiDataManager: MovieDetailsApiDataManagerProtocol? { get set }
    var localDataManager: MovieDetailsLocalDataManagerProtocol? { get set }
}

final class MovieDetailsInteractor: MovieDetailsInteractorProtocol {

    weak var presenter: MovieDetailsPresenterProtocol?
    var apiDataManager: MovieDetailsApiDataManagerProtocol?
    var localDataManager: MovieDetailsLocalDataManagerProtocol?

}
