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
    
    init(descriptorParameter: Bool, predicateFirstParameter: FilterKey, predicateSecondParameter: String) {
        let request: NSFetchRequest<Country> = Country.fetchRequest()
        
        var descriptor: [NSSortDescriptor] {
            [NSSortDescriptor(keyPath: \Country.shortName, ascending: descriptorParameter)]
        }
        request.sortDescriptors = descriptor
        
        var predicate: NSPredicate? {
            if predicateFirstParameter == .none || predicateSecondParameter.isEmpty  {
                return nil
            } else {
                let predicateString = "fullName \(predicateFirstParameter.rawValue.uppercased())[c] '\(predicateSecondParameter)'"
                return NSPredicate(format: predicateString)
            }
        }
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

//struct CountriesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CountriesListView()
//    }
//}
