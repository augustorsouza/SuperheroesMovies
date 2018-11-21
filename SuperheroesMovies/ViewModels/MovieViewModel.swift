import Foundation

struct MovieViewModel {
    let title: String
    let coverUrl: URL
    let director: String
    let year: String

    init?(movie: Movie) {
        guard let coverUrl = URL(string: movie.coverUrl) else { return nil }

        self.title = movie.title
        self.coverUrl = coverUrl
        self.director = movie.director
        self.year = movie.year
    }
}
