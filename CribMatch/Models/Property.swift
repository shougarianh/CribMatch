import Foundation

struct Property: Identifiable, Hashable {
    let id = UUID()
    let address: String
    let price: Double
    let bedrooms: Int
    let bathrooms: Int
    let squareFootage: Int
    let imageURLs: [String]
    let propertyType: PropertyType
    let listingType: ListingType
    let city: String
    let state: String
    let appliances: String?
    let commuteTime: String
    let parking: String
    let pets: String
    
    var formattedLocation: String {
        return "\(city), \(state)"
    }
    
    // Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Property, rhs: Property) -> Bool {
        return lhs.id == rhs.id
    }
}

enum PropertyType: String, Codable, CaseIterable {
    case house = "House"
    case apartment = "Apartment"
    case condo = "Condo"
    case townhouse = "Townhouse"
}

enum ListingType: String, Codable, CaseIterable {
    case buying = "Buying"
    case renting = "Renting"
}
