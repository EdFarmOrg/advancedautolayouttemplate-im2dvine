import Foundation

struct Section: Hashable {
    
    let id = UUID()
    
    let type: SectionType
    let title: String
    let subtitle: String
    let items: [Item]
    
    init(type: SectionType, title: String = "", subtitle: String = "", items: [Item] = []) {
        self.type  = type
        self.title = title
        self.subtitle = subtitle
        self.items = items
    }
    
    enum ItemSectionType: String {
        case large
        case medium
        case header
        case ad
    }
    
    struct SectionType: RawRepresentable, Hashable {
        typealias RawValue = String
        var rawValue: String
        
        init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        static let large = SectionType(rawValue: Section.ItemSectionType.large.rawValue)
        static let medium = SectionType(rawValue: Section.ItemSectionType.medium.rawValue)
        static let header = SectionType(rawValue: Section.ItemSectionType.header.rawValue)
        static let ad = SectionType(rawValue: Section.ItemSectionType.ad.rawValue)
    }
}
