//
//  ContentView.swift
//  FoodPin
//
//  Created by Ricardo Roman Landeros on 13/12/22.
//

import SwiftUI

struct RestaurantListView: View {
    
    @State var restaurants = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isFavorite: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei", isFavorite: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavorite: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster", isFavorite: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkee", isFavorite: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isFavorite: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isFavorite: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haigh", isFavorite: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palomino", isFavorite: false),
        Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavorite: false),
        Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isFavorite: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "graham", isFavorite: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "waffleandwolf", isFavorite: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isFavorite: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isFavorite: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isFavorite: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavorite: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavorite: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavorite: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "cask", isFavorite: false)
    ]
    
    var body: some View {
        List {
            ForEach(restaurants.indices, id: \.self){index in
                ListNormal(restaurant: $restaurants[index])
                
            }//forEach
            .onDelete(perform: { indexSet in
                    restaurants.remove(atOffsets: indexSet)
                })
            
            .listRowSeparator(.hidden)
        }//list
        .listStyle(.plain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
    }
}

struct ListNormal: View {
    
    // MARK: Binding
    @Binding var restaurant: Restaurant
    
    // MARK: - State variables
    @State private var showOptions = false
    @State private var showError = false
    
//    @Binding var isfavorite: Bool
//    var nameRestaurant: String
//    var image: String
//    var type: String
//    var location: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(restaurant.image)
                .resizable()
                .frame(width: 120, height: 120)
                .cornerRadius(20)
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.system(.title2, design: .rounded))
                Text(restaurant.type)
                    .font(.system(.body, design: .rounded))
                Text(restaurant.location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }//VStack
            
            if restaurant.isFavorite {
                Spacer()
                
                Image(systemName: "heart.fill")
                    .foregroundColor(.yellow)
            }
        }//HStack
        .contextMenu{
            Button {
                self.showError.toggle()
            } label: {
                HStack {
                    Text("Reserve table")
                    Image(systemName: "phone")
                }
            }
            
            Button {
                self.restaurant.isFavorite.toggle()
            } label: {
                HStack {
                    Text(restaurant.isFavorite ? "Desmarcar favorite" : "Marcar favorito")
                    Image(systemName: "heart")
                }
            }
            
            Button {
                self.showOptions.toggle()
            } label: {
                HStack {
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
            }

        }//contextMenu
        .alert("NO avilitado", isPresented: $showError) {
            Button("OK") {
                
            }
        } message: {
            Text("Lo sentimos esta caracteristica esta pronto abilitada")
        }
        .sheet(isPresented: $showOptions) {
            let defaulttext = "Just Checking in at \(restaurant.name)"
            
            if let imageToShare = UIImage(named: restaurant.image){
                ActivityView(activityItems: [defaulttext, imageToShare])
            } else {
                ActivityView(activityItems: [defaulttext])
            }
        }
    }
}

struct ListNormalAncho: View {
    @State private var showOptions = false
    @State private var showError = false
    
    @Binding var isfavorite: Bool
    
    var nameRestaurant: String
    var image: String
    var type: String
    var location: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .cornerRadius(20)
                
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(nameRestaurant)
                        .font(.system(.title2, design: .rounded))
                    Text(type)
                        .font(.system(.body, design: .rounded))
                    Text(location)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                if isfavorite {
                    Spacer()
                    
                    Image(systemName: "heart.fill")
                        .foregroundColor(.yellow)
                }
            }
            
            
        }//VStack padre
        .onTapGesture {
            showOptions.toggle()
        }
        .confirmationDialog("Que quieres hacer?", isPresented: $showOptions, titleVisibility: .visible) {
            Button("Reservar mesa"){
                self.showError.toggle()
            }
            
            Button(isfavorite ? "Desmarcar favorite" :"Marcar favorito"){
                self.isfavorite.toggle()
            }
        }
        .alert("NO avilitado", isPresented: $showError) {
            Button("OK") {
                
            }
        } message: {
            Text("Lo sentimos esta caracteristica esta pronto abilitada")
        }
    }
}
