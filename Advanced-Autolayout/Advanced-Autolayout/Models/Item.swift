import Foundation

struct Item: Hashable {
    
    let id = UUID()
    let title: String
    let date: String
    let image: String
    
    init(title: String = "", date: String = "", image: String = "") {
        self.title = title
        self.date = date
        self.image = image
    }
}
