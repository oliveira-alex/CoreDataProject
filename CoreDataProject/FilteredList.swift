//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Alex Oliveira on 04/10/21.
//

import SwiftUI

struct FilteredList: View {
    var fetchRequest: FetchRequest<Singer>
    var singers: FetchedResults<Singer> { fetchRequest.wrappedValue }
    
    var body: some View {
        List(singers, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
    
    init(filter: String) {
        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }
}
