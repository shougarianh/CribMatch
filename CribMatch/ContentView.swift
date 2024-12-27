import SwiftUI

struct ContentView: View {
    @StateObject private var propertyManager = PropertyManager()
    
    var body: some View {
        TabView {
            PropertySwipeView()
                .environmentObject(propertyManager)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Discover")
                }
            
            NavigationView {
                List(propertyManager.likedProperties) { property in
                    PropertyRowView(property: property)
                }
                .navigationTitle("Liked Properties")
            }
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Liked")
            }
            
            NavigationView {
                List(propertyManager.dislikedProperties) { property in
                    PropertyRowView(property: property)
                }
                .navigationTitle("Disliked Properties")
            }
            .tabItem {
                Image(systemName: "xmark")
                Text("Disliked")
            }
        }
        .environmentObject(propertyManager)
    }
}
