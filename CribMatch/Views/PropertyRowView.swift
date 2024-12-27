import SwiftUI

struct PropertyRowView: View {
    let property: Property
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(property.address)
                    .font(.headline)
                
                Text("$\(Int(property.price)) | \(property.bedrooms) BD | \(property.bathrooms) BA")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("\(property.propertyType.rawValue.capitalized) for \(property.listingType.rawValue)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
