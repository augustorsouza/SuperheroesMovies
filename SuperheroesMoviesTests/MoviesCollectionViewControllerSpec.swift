import Quick
import Nimble
import Nimble_Snapshots
import UIKit
@testable import SuperheroesMovies

class MoviesCollectionViewControllerSpec: QuickSpec {

    override func spec() {

        describe("with movies loaded successfully") {
            var sut: MoviesCollectionViewController!

            beforeEach {
                let moviesCollectionViewController = UIStoryboard.main.instantiateViewController(withIdentifier: MoviesCollectionViewController.identifier) as! MoviesCollectionViewController

                sut = moviesCollectionViewController

                let presenter = MoviesCollectionPresenterMock()
                sut.presenter = presenter
                presenter.view = sut

                // Access the view to trigger the viewDidLoad().
                _ = sut.view
            }

            it("should have the correct number of cells") {
                let numberOfItems = sut.collectionView(sut.collectionView, numberOfItemsInSection: 0)

                expect(numberOfItems).to(equal(2))
            }

            it("has valid snapshot") {
                expect(sut).toEventually(haveValidSnapshot(), timeout: 5.0)
            }
        }
    }

}

class MoviesCollectionPresenterMock: MoviesCollectionPresenterProtocol {
    var view: MoviesCollectionViewProtocol?

    var interactor: MoviesCollectionInteractorProtocol?

    var router: MoviesCollectionRouterProtocol?

    func shouldLoadMovies() {
        // Load content
        let movie1 = Movie(title: "Movie 1", coverUrl: "https://via.placeholder.com/150", director: "Director 1", year: "2018")
        let movie2 = Movie(title: "Movie 2", coverUrl: "https://via.placeholder.com/300", director: "Director 2", year: "2017")
        let movies: [MovieViewModel] = [MovieViewModel(movie: movie1)!, MovieViewModel(movie: movie2)!]

        view?.successfullyLoaded(movies: movies)
    }

    func navigateToMovieDetails(movie: MovieViewModel) { }
}
