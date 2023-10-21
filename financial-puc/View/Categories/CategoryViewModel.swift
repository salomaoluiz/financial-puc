import Foundation
import CoreData

enum CategoryType: Int16 {
    case expense = 0
    case income = 1
}

struct CategoryStruct: Identifiable {
    let id = UUID()
    let name: String
    let type: CategoryType
}

class CategoryViewModel: ObservableObject {
    @Published var categoryName = ""
    @Published var categoryType = CategoryType.expense
    
    @Published var categories: [CategoryStruct] = []
    
    private var persistenceController = PersistenceController.shared
    
    init() {
        fetchCategories()
    }
    
    private func fetchCategories() {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        let context = persistenceController.container.viewContext
        
        do {
            let items = try context.fetch(fetchRequest)
            let categoriesData = items.map { item in
                CategoryStruct(name: item.name ?? "", type: CategoryType(rawValue: item.type) ?? CategoryType.expense)
            }
            
            categories = categoriesData
        } catch {
            print("Error fetching categories: \(error.localizedDescription)")
        }
    }
    
    func saveCategory() {
        let context = persistenceController.container.viewContext
        
        let newItem = Category(context: context)
        newItem.name = categoryName
        newItem.type = categoryType.rawValue
        newItem.id = UUID()
        
        do {
            try context.save()
            fetchCategories()
            categoryName = ""
            categoryType = .expense
        } catch {
            print("Error saving category: \(error.localizedDescription)")
        }
    }
    
    func fetchCategoriesById(id: UUID) -> Category? {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        fetchRequest.fetchLimit = 1
        let context = persistenceController.container.viewContext
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            
            print("Error fetching category by ID: \(error)")
            return nil
        }
    }
    
    
    func deleteCategory(category: CategoryStruct) {
        
        do {
            let context = persistenceController.container.viewContext
            if let categoryToDelete = fetchCategoriesById(id: category.id) {
                
                context.delete(categoryToDelete)
                try context.save()
                
            }
        } catch {
            print("Error saving category: \(error)")
        }
    }
    
    
    
}

