//
//  JokeCoreData.swift
//  jokes
//
//  Created by ShrishMishra on 26/08/23.
//

import Foundation
import CoreData

class JokeCoreData {
static let shared = JokeCoreData()

private init() {}

lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "JokeDataModel")
    container.loadPersistentStores { (_, error) in
        if let error = error {
            fatalError("Failed to load Core Data stack: \(error)")
        }
    }
    return container
}()

func saveJokes(_ joke: String) {
    persistentContainer.performBackgroundTask { context in
        let fetchRequest: NSFetchRequest<Jokes> = Jokes.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "time", ascending: false)]
        fetchRequest.fetchLimit = 10
        if let jokes = try? context.fetch(fetchRequest), jokes.count >= 10 {
            for joke in jokes[9..<jokes.count] {
                context.delete(joke)
            }
        }
        let newJokes = Jokes(context: context)
        newJokes.title = joke
        newJokes.time = Date()
        do {
            try context.save()
        } catch {
            print("Failed to save joke: \(error.localizedDescription)")
        }
    }
}

func fetchJokes(limit: Int) -> [Jokes] {
    let context = persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<Jokes> = Jokes.fetchRequest()
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "time", ascending: false)]
    fetchRequest.fetchLimit = limit

    do {
        let jokes = try context.fetch(fetchRequest)
        return jokes
    } catch {
        print("Failed to fetch jokes: \(error)")
        return []
    }
}
}

