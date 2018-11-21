import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    static var identifier: String { return String(describing: self) }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!

    func setup(with movie: MovieViewModel?) {
        guard let movie = movie else {
            // We could work with the empty state in here
            return
        }

        titleLabel.text = movie.title

        DispatchQueue.global(qos: .userInteractive).async {
            guard let data = try? Data(contentsOf: movie.coverUrl) else {
                // We could render a placeholder in here
                return
            }

            DispatchQueue.main.async { [weak self] in
                self?.coverImageView.image = UIImage(data: data)
            }
        }
    }
}
