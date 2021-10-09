//
//  CountriesListView.swift
//  CoreDataProject
//
//  Created by Alex Oliveira on 09/10/21.
//

import CoreData
import SwiftUI

struct CountriesListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest var countries: FetchedResults<Country>
    
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
