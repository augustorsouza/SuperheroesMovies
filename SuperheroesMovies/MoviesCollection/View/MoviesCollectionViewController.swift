import UIKit

protocol MoviesCollectionViewProtocol: class {
    var presenter: MoviesCollectionPresenterProtocol? { get set }
    
    func startLoading()
    func failedToLoad()
    func successfullyLoaded(movies: [MovieViewModel])
}

final class MoviesCollectionViewController: UIViewController, MoviesCollectionViewProtocol {

    var presenter: MoviesCollectionPresenterProtocol?

    static var identifier: String { return String(describing: self) }

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.shouldLoadMovies()
    }

    // MARK: - shouldLoadMovies() related callbacks

    func startLoading() {

    }

    func failedToLoad() {

    }

    var movies: [MovieViewModel]? {
        didSet {
            collectionView.reloadData()
        }
    }

    func successfullyLoaded(movies: [MovieViewModel]) {
        self.movies = movies
    }
}

extension MoviesCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath)

        if let cell = cell as? MovieCollectionViewCell {
            let movie = movies?[indexPath.item]
            cell.setup(with: movie)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = movies?[indexPath.item] else { return }

        presenter?.navigateToMovieDetails(movie: movie)
    }
}
