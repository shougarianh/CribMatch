import Foundation
import SwiftUI

class PropertyManager: ObservableObject {
    @Published var properties: [Property] = []
    @Published var likedProperties: [Property] = []
    @Published var dislikedProperties: [Property] = []
    @Published var currentPropertyIndex: Int = 0
    @Published var listingType: ListingType = .buying
    
    init() {
        properties = createMockProperties()
    }
    
    private func createMockProperties() -> [Property] {
        return [
            Property(
                address: "123 Mountain View",
                price: 69000,
                bedrooms: 6,
                bathrooms: 9,
                squareFootage: 2500,
                imageURLs: [
                    "https://images.unsplash.com/photo-1580587771525-78b9dba3b914",
                    "https://images.unsplash.com/photo-1584622650111-993a426fbf0a",
                    "https://images.unsplash.com/photo-1512917774080-9991f1c4c750"
                ],
                propertyType: .house,
                listingType: .buying,
                city: "Boston",
                state: "MA",
                appliances: nil,
                commuteTime: "6 Minutes",
                parking: "9 Car Garage",
                pets: "Pet Friendly"
            ),
            Property(
                address: "456 Lake Drive",
                price: 425000,
                bedrooms: 3,
                bathrooms: 2,
                squareFootage: 1800,
                imageURLs: [
                    "https://images.unsplash.com/photo-1568605114967-8130f3a36994",
                    "https://images.unsplash.com/photo-1576941089067-2de3c901e126",
                    "https://images.unsplash.com/photo-1598228723793-52759bba239c"
                ],
                propertyType: .house,
                listingType: .buying,
                city: "Cambridge",
                state: "MA",
                appliances: "Washer/Dryer, Dishwasher",
                commuteTime: "15 Minutes",
                parking: "2 Car Garage",
                pets: "No Pets"
            ),
            Property(
                address: "789 Forest Lane",
                price: 550000,
                bedrooms: 5,
                bathrooms: 4,
                squareFootage: 3000,
                imageURLs: [
                    "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9",
                    "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c",
                    "https://images.unsplash.com/photo-1600607687644-aac4c3eac7f4"
                ],
                propertyType: .house,
                listingType: .buying,
                city: "Somerville",
                state: "MA",
                appliances: "Full Suite",
                commuteTime: "10 Minutes",
                parking: "Street Parking",
                pets: "Cats Only"
            )
        ]
    }
    
    func likeProperty() {
        guard !properties.isEmpty else { return }
        let property = properties[currentPropertyIndex]
        likedProperties.append(property)
        properties.remove(at: currentPropertyIndex)
        
        if properties.isEmpty {
            currentPropertyIndex = 0
        } else if currentPropertyIndex >= properties.count {
            currentPropertyIndex = properties.count - 1
        }
    }
    
    func dislikeProperty() {
        guard !properties.isEmpty else { return }
        let property = properties[currentPropertyIndex]
        dislikedProperties.append(property)
        properties.remove(at: currentPropertyIndex)
        
        if properties.isEmpty {
            currentPropertyIndex = 0
        } else if currentPropertyIndex >= properties.count {
            currentPropertyIndex = properties.count - 1
        }
    }
    
    func moveToNextProperty() {
        if !properties.isEmpty {
            if currentPropertyIndex < properties.count - 1 {
                currentPropertyIndex += 1
            } else {
                currentPropertyIndex = 0
            }
        }
    }
    
    func moveToPreviousProperty() {
        if !properties.isEmpty {
            if currentPropertyIndex > 0 {
                currentPropertyIndex -= 1
            } else {
                currentPropertyIndex = properties.count - 1
            }
        }
    }
}
