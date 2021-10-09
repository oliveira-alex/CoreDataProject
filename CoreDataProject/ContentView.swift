//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Alex Oliveira on 04/10/21.
//

import SwiftUI
import CoreData

struct CountriesListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest var countries: FetchedResults<Country>
    
    init(descriptorsArray: [NSSortDescriptor], predicate: NSPredicate?) {
        let request: NSFetchRequest<Country> = Country.fetchRequest()
        request.sortDescriptors = descriptorsArray
        request.predicate = predicate
        _countries = FetchRequest<Country>(fetchRequest: request)
    }
        
    var body: some View {
        List {
            ForEach(countries, id: \.self) { country in
                Section(header: Text(country.wrappedFullName)) {
                    ForEach(country.candyArray, id: \.self) { candy in
                        Text(candy.wrappedName)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
        
    @State private var ascending = true
    var descriptors: [NSSortDescriptor] {
        [NSSortDescriptor(keyPath: \Country.shortName, ascending: ascending)]
    }
    @State private var filterValue = ""
    var predicate: NSPredicate? {
        filterValue.isEmpty ? nil : NSPredicate(format: "fullName BEGINSWITH[c] %@", filterValue)
    }

    var body: some View {
        VStack {
            CountriesListView(descriptorsArray: descriptors, predicate: predicate)
            
            Button("Add") {
                let candy1 = Candy(context: self.moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: self.moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                let candy2 = Candy(context: self.moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: self.moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: self.moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: self.moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"
                
                let candy4 = Candy(context: self.moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: self.moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"
                
                if self.moc.hasChanges {
                    try? self.moc.save()
                }
            }
            
            Button("Ascending") {
                ascending = true
            }
            
            Button("Descending") {
                ascending = false
            }
            
            Button("Begins with 'U'") {
                filterValue = "U"
            }
            
            Button("Begins with 'S'") {
                filterValue = "S"
            }
            
            Button("No filter") {
                filterValue = ""
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
