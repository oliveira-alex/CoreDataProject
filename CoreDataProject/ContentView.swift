//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Alex Oliveira on 04/10/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        Button("Save") {
            if self.moc.hasChanges {
                try? self.moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
