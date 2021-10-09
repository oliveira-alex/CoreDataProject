//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Alex Oliveira on 04/10/21.
//

import SwiftUI
import CoreData

enum FilterKey: String {
    case beginsWith, endsWith, none
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
        
    @State private var ascending = true

    @State private var filterKey: FilterKey = .beginsWith
    @State private var filterValue = ""


    var body: some View {
        VStack {
            CountriesListView(descriptorParameter: ascending,
                              predicateFirstParameter: filterKey,
                              predicateSecondParameter: filterValue
            )
            
            Button("Add") {
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                let candy2 = Candy(context: moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"
                
                let candy4 = Candy(context: moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"
                
                if moc.hasChanges {
                    try? moc.save()
                }
            }
            
            Button(ascending ? "Ascending" : "Descending") {
                ascending.toggle()
            }
            
            HStack {
                VStack {
                    Button("Begins with 'U'") {
                        filterKey = .beginsWith
                        filterValue = "U"
                    }
                    
                    Button("Begins with 'S'") {
                        filterKey = .beginsWith
                        filterValue = "S"
                    }
                }
                
                Spacer()
                
                VStack {
                    Button("Ends with 'M'") {
                        filterKey = .endsWith
                        filterValue = "M"
                    }
                    
                    Button("Ends with 'D'") {
                        filterKey = .endsWith
                        filterValue = "D"
                    }
                }
            }
            .padding(.horizontal)
            
            Button("No filter") {
                filterKey = .none
                filterValue = ""
            }
            
            Button("Delete All") {
                let allObjects = moc.registeredObjects
                for object in allObjects {
                    moc.delete(object)
                }
                
                if moc.hasChanges {
                    try? moc.save()
                }
            }
            .foregroundColor(.red)
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
