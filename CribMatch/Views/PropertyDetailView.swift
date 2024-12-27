import SwiftUI

struct DetailItem: View {
    let title: String
    let value: String
    let valueColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 24, weight: .bold))
            Text(value)
                .font(.system(size: 24))
                .foregroundColor(valueColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
    }
}

struct PropertyDetailView: View {
    let property: Property
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Back Button
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            .padding(.top, 16)
            .padding(.leading)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    DetailItem(
                        title: "Price (\(property.listingType.rawValue))",
                        value: "$\(Int(property.price))",
                        valueColor: .green
                    )
                    
                    DetailItem(
                        title: "Bedrooms",
                        value: "\(property.bedrooms)",
                        valueColor: .green
                    )
                    
                    DetailItem(
                        title: "Bathrooms",
                        value: "\(property.bathrooms)",
                        valueColor: .green
                    )
                    
                    DetailItem(
                        title: "Appliances",
                        value: property.appliances ?? "No Information Available",
                        valueColor: property.appliances == nil ? .red : .green
                    )
                    
                    DetailItem(
                        title: "Commute Time",
                        value: property.commuteTime,
                        valueColor: .green
                    )
                    
                    DetailItem(
                        title: "Parking",
                        value: property.parking,
                        valueColor: .green
                    )
                    
                    DetailItem(
                        title: "Pets",
                        value: property.pets,
                        valueColor: .green
                    )
                }
                .padding(24)
            }
            
            // Like/Dislike Buttons
            HStack(spacing: 60) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                        .padding(22)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "heart")
                        .font(.system(size: 30))
                        .foregroundColor(.red)
                        .padding(22)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 30)
        }
        .background(Color(UIColor.systemBackground))
    }
}
