//
//  DataController.swift
//  AjmoApp
//
//  Created by Dora Franjic on 24/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import Foundation
import CoreData

// API prema bazi podataka
class DataController {
    
    // DataController modeliramo kao singleton
    static let shared = DataController()
    private init() {
    } // Prevent clients from creating another instance.
    
    // NSPersistentContainer je ulazna tocka prema Core Data
    // NSPersistentContainer stvara i upravlja NSManagedObjectModel-om (u ovom slucaju to je model "Model")
    // NSManagedObjectModel sadrzi definicije entiteta sa svojim atributima i medusobnim vezama (.xcdatamodeld datoteka)
    // NSPersistentContainer stvara i NSManagedObjectContext, objekt preko kojeg vrsimo interakciju s bazom podataka
    // Na NSManagedObjectContext objekt mozemo gledati kao na jedan shapshot baze podataka, trenutno stanje baze podataka
    // iz njega dohvacamo podatke iz baze, mijenajmo ih, stvaramo i brisemo.
    // Sve promjene nad objektima napravljene u NSManagedObjectContextu su napravljeno samo nad objektima u memoriji, da bi se te promjene perzistirale u bazu potrebno je spremiti context
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AjmoApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()

    lazy var cacheContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()

     func deleteData() {
        let context:NSManagedObjectContext = DataController.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BestCoffee")
               do {
                   let count = try context.count(for: fetchRequest)
                   print(count)
                   if count > 0 {
                       let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BestCoffee")
                       fetchRequest.returnsObjectsAsFaults = false
                       do {
                           let results = try context.fetch(fetchRequest)
                           for managedObject in results {
                               if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                                   context.delete(managedObjectData)
                               }
                           }
                       } catch let error as NSError {
                           print("Deleted all my data in myEntity error : \(error) \(error.userInfo)")
                       }
                   }
               } catch {
                   print(error.localizedDescription)
        } }
          
         
    
    // U DataController smjestamo metode koje komuniciraju s bazom; stvaranje, dohvacanje, brisanje i azuriranje podataka u bazi
    // Ovdje je primjer metode koja dohvaca sve review-ove iz baze podataka
    func fetchBestCoffee() -> [BestCoffee]? {
       
        // Genericki razred NSFetchRequest predstavlja upit na bazu podataka kojim dohvacamo objekte nekog razreda
        let request: NSFetchRequest<BestCoffee> = BestCoffee.fetchRequest()
        // NSFetchRequestu mozemo postaviti NSPredicate koji sadrzi uvjete koje objekti trebaju zadovoljiti da bi se dohvatili (slicno kao WHERE u SQL)
        // NSFetchRequestu mozemo postaviti i NSSortDescriptor-e kojima odredujemo atribute po kojima se rezultati upita sortiraju (kao ORDER BY)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let context = DataController.shared.persistentContainer.viewContext
        // izvodenje upita
        let bestCoffee = try? context.fetch(request)
        //print(bestCoffee?.count)
        
        return bestCoffee
    }
    
    // Sve promjene nad objektima napravljene u NSManagedObjectContextu su napravljeno samo nad objektima u memoriji, da bi se te promjene perzistirale u bazu potrebno je spremiti context, metodom .save()
    func saveContext () {
        
        // viewContext je NSManagedObjectContext objekt iz kojeg dohvacamo, u kojem stvaramo, brisemo ili mijenjamo objekte na main thread-u
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    }
    

