import SwiftUI

struct PropertyCardView: View {
    let property: Property
    let verticalOffset: CGSize
    @State private var currentImageIndex = 0
    @State private var horizontalOffset: CGFloat = 0
    @State private var showDetails = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Property Images
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(property.imageURLs.indices, id: \.self) { index in
                        AsyncImage(url: URL(string: property.imageURLs[index])) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color.gray.opacity(0.1))
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width)
                                    .clipped()
                            case .failure:
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity)
                                    .padding(40)
                                    .background(Color.gray.opacity(0.1))
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: geometry.size.width)
                    }
                }
                .offset(x: -CGFloat(currentImageIndex) * geometry.size.width + horizontalOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if abs(value.translation.width) > abs(value.translation.height) {
                                horizontalOffset = value.translation.width
                            }
                        }
                        .onEnded { value in
                            let threshold = geometry.size.width * 0.2
                            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.8)) {
                                if value.translation.width < -threshold && currentImageIndex < property.imageURLs.count - 1 {
                                    currentImageIndex += 1
                                } else if value.translation.width > threshold && currentImageIndex > 0 {
                                    currentImageIndex -= 1
                                }
                                horizontalOffset = 0
                            }
                        }
                )
            }
            .frame(height: UIScreen.main.bounds.height * 0.65)
            .cornerRadius(25)
            .shadow(radius: 10, y: 5)
            .offset(verticalOffset)
            
            // Property Info Overlay
            VStack(alignment: .leading, spacing: 6) {
                Text("$\(Int(property.price))")
                    .font(.system(size: 28, weight: .bold))
                Text("\(property.bedrooms) Bed, \(property.bathrooms) Bath")
                    .font(.system(size: 18))
                Text(property.formattedLocation)
                    .font(.system(size: 18))
            }
            .padding(16)
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            .shadow(radius: 5)
            .offset(x: -20, y: -20)
            
            // Image Indicator Dots
            HStack(spacing: 6) {
                ForEach(0..<property.imageURLs.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentImageIndex ? Color.white : Color.white.opacity(0.5))
                        .frame(width: 6, height: 6)
                }
            }
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .padding([.trailing, .bottom], 20)
        }
        .onTapGesture {
            showDetails = true
        }
        .sheet(isPresented: $showDetails) {
            PropertyDetailView(property: property)
        }
    }
}
