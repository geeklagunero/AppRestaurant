//
//  ContentView.swift
//  FoodPin
//
//  Created by Ricardo Roman Landeros on 13/12/22.
//

import SwiftUI

struct RestaurantListView: View {
    
    @State var restaurantIsFavorites = Array(repeating: false, count: 21)
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]

    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    var body: some View {
        List {
            ForEach(restaurantNames.indices, id: \.self){index in
                ListNormalAncho(isfavorite: $restaurantIsFavorites[index], nameRestaurant: restaurantNames[index], image: restaurantImages[index], type: restaurantTypes[index], location: restaurantLocations[index])
                
                
            }//forEach
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
    
    @State private var showOptions = false
    @State private var showError = false
    
    @Binding var isfavorite: Bool
    var nameRestaurant: String
    var image: String
    var type: String
    var location: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(image)
                .resizable()
                .frame(width: 120, height: 120)
                .cornerRadius(20)
            VStack(alignment: .leading) {
                Text(nameRestaurant)
                    .font(.system(.title2, design: .rounded))
                Text(type)
                    .font(.system(.body, design: .rounded))
                Text(location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }//VStack
            
            if isfavorite {
                Spacer()
                
                Image(systemName: "heart.fill")
                    .foregroundColor(.yellow)
            }
        }//HStack
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
