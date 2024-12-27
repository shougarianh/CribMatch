import SwiftUI

struct PropertySwipeView: View {
    @EnvironmentObject private var propertyManager: PropertyManager
    @State private var offset = CGSize.zero
    @State private var currentIndex: Int = 0
    @State private var nextOffset: CGFloat = UIScreen.main.bounds.height
    @State private var previousOffset: CGFloat = -UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            // Background Color
            Color(hex: "#98FB98")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Navigation Bar
                HStack(spacing: 0) {
                    // Left filter button
                    Button(action: {}) {
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.9))
                            .clipShape(Circle())
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    // Center Buying/Renting Menu
                    Menu {
                        Button("Buying") {
                            propertyManager.listingType = .buying
                        }
                        Button("Renting") {
                            propertyManager.listingType = .renting
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text(propertyManager.listingType.rawValue)
                                .foregroundColor(.black)
                                .fontWeight(.medium)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.black)
                                .font(.system(size: 12))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(20)
                    }
                    
                    Spacer()
                    
                    // Right menu button
                    Button(action: {}) {
                        Image(systemName: "line.horizontal.3")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.9))
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 20)
                }
                .frame(height: 60)
                .padding(.top, 8)
                
                if !propertyManager.properties.isEmpty {
                    ZStack {
                        // Previous Card (if exists)
                        if propertyManager.currentPropertyIndex > 0 {
                            PropertyCardView(
                                property: propertyManager.properties[propertyManager.currentPropertyIndex - 1],
                                verticalOffset: .zero
                            )
                            .offset(y: previousOffset)
                            .zIndex(0)
                        }
                        
                        // Current Card
                        PropertyCardView(
                            property: propertyManager.properties[propertyManager.currentPropertyIndex],
                            verticalOffset: offset
                        )
                        .zIndex(1)
                        
                        // Next Card (if exists)
                        if propertyManager.currentPropertyIndex < propertyManager.properties.count - 1 {
                            PropertyCardView(
                                property: propertyManager.properties[propertyManager.currentPropertyIndex + 1],
                                verticalOffset: .zero
                            )
                            .offset(y: nextOffset)
                            .zIndex(0)
                        }
                    }
                    .simultaneousGesture(
                        DragGesture()
                            .onChanged { gesture in
                                if abs(gesture.translation.height) > abs(gesture.translation.width) {
                                    offset = gesture.translation
                                    
                                    // Move adjacent cards
                                    if gesture.translation.height > 0 {
                                        previousOffset = -UIScreen.main.bounds.height + gesture.translation.height
                                    } else {
                                        nextOffset = UIScreen.main.bounds.height + gesture.translation.height
                                    }
                                }
                            }
                            .onEnded { gesture in
                                let threshold: CGFloat = 50
                                if gesture.translation.height < -threshold {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                        offset.height = -UIScreen.main.bounds.height
                                        nextOffset = 0
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        propertyManager.moveToNextProperty()
                                        offset = .zero
                                        nextOffset = UIScreen.main.bounds.height
                                        previousOffset = -UIScreen.main.bounds.height
                                    }
                                } else if gesture.translation.height > threshold {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                        offset.height = UIScreen.main.bounds.height
                                        previousOffset = 0
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        propertyManager.moveToPreviousProperty()
                                        offset = .zero
                                        nextOffset = UIScreen.main.bounds.height
                                        previousOffset = -UIScreen.main.bounds.height
                                    }
                                } else {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                        offset = .zero
                                        nextOffset = UIScreen.main.bounds.height
                                        previousOffset = -UIScreen.main.bounds.height
                                    }
                                }
                            }
                    )
                    .padding(.horizontal)
                } else {
                    Text("No More Properties")
                        .font(.title)
                }
                
                Spacer()
                
                // Like/Dislike Buttons
                HStack(spacing: 50) {
                    Button(action: {
                        withAnimation(.spring()) {
                            propertyManager.dislikeProperty()
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 30))
                            .foregroundColor(.black)
                            .padding(20)
                            .background(Color.white.opacity(0.9))
                            .clipShape(Circle())
                    }
                    .disabled(propertyManager.properties.isEmpty)
                    
                    Button(action: {
                        withAnimation(.spring()) {
                            propertyManager.likeProperty()
                        }
                    }) {
                        Image(systemName: "heart")
                            .font(.system(size: 30))
                            .foregroundColor(.red)
                            .padding(20)
                            .background(Color.white.opacity(0.9))
                            .clipShape(Circle())
                    }
                    .disabled(propertyManager.properties.isEmpty)
                }
                .padding(.bottom, 30)
            }
        }
    }
}
