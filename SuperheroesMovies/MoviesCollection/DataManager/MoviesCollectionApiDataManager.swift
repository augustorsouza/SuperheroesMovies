import Foundation

enum FetchFavoriteMovies: Error {
    case generic
}

protocol MoviesCollectionApiDataManagerProtocol: class {
    func performFetchMovies(ids: [String], error: @escaping (FetchFavoriteMovies) -> Void, success: @escaping ([Movie]) -> Void)
}

final class MoviesCollectionApiDataManager: MoviesCollectionApiDataManagerProtocol {

    private var errors: [Error] = []
    private var movies: [Movie] = []

    func performFetchMovies(ids: [String], error: @escaping (FetchFavoriteMovies) -> Void, success: @escaping ([Movie]) -> Void) {

        let group = DispatchGroup()
        let queue = DispatchQueue(label: "thread-safe-array-access", attributes: .concurrent)

        for id in ids {
            let url = URL(string: "http://www.omdbapi.com/?i=\(id)&apikey=8ba333f8")!
            print(url)
            let urlRequest = URLRequest(url: url)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)

            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                defer { group.leave() }

                // Check for the existance of data
                guard let data = data else {
                    self.errors.append(FetchFavoriteMovies.generic)
                    return
                }

                // Check for errors
                if let error = error {
                    self.errors.append(error)
                    return
                }

                // Append movie data
                do {
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    print(id)
                    queue.async(flags: .barrier) {
                        self.movies.append(movie)
                    }

                } catch {
                    self.errors.append(error)
                }

            }

            group.enter()

            task.resume()
        }

        group.notify(queue: .main) {
            guard !self.movies.isEmpty && self.errors.isEmpty else {
                error(.generic)
                return
            }

            queue.sync {
                success(self.movies)
            }
        }
    }

}
