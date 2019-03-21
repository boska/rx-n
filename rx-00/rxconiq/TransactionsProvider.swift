import RxSwift

struct API {
  static private let baseURL = "http://demo5481020.mockable.io/"
  static private let transactionsRoute = "transactions"
  private let decoder = JSONDecoder()
  static var transactions: Observable<[Transaction]> {
    guard let request = try? URLRequest(url: baseURL + transactionsRoute, method: .get) else {
      fatalError()
    }
    let decoder = JSONDecoder()
    return URLSession.shared.rx.response(request: request)
      .map({ result in
        let (_,data) = result
        return try decoder.decode([Transaction].self, from: data)
    })
  }
}
