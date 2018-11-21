import UIKit

protocol MovieDetailsViewProtocol: class {
    var presenter: MovieDetailsPresenterProtocol? { get set }
    func movieLoaded(movie: MovieViewModel)
}

final class MovieDetailsViewController: UIViewController, MovieDetailsViewProtocol {

    static var identifier: String { return String(describing: self) }

    var presenter: MovieDetailsPresenterProtocol?

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.shouldLoadMovie()
    }

    func movieLoaded(movie: MovieViewModel) {
        DispatchQueue.global(qos: .userInteractive).async {
            guard let data = try? Data(contentsOf: movie.coverUrl) else {
                // We could render a placeholder in here
                return
            }

            DispatchQueue.main.async { [weak self] in
                self?.coverImageView.image = UIImage(data: data)
            }
        }

        titleLabel.text = movie.title
        yearLabel.text = movie.year
        directorLabel.text = movie.director
    }
}
