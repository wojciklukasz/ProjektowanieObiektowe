import Fluent
import Vapor

// routing for categories
// localhost:8080/categories
struct CategoryController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let categories = routes.grouped("categories")
        // GET localhost:8080/categories
        categories.get(use: index)
        // POST localhost:8080/categories
        categories.post(use: create)
        categories.group(":id") { category in
            // GET localhost:8080/categories/id
            category.get(use: show)
            // DELETE localhost:8080/categories/id
            category.delete(use: delete)
        }
    }

    // Lists all categories in the DB
    // Returns CategoryRead.leaf template
    func index(req: Request) throws -> EventLoopFuture<View> {
        let allCategories = Category.query(on: req.db).all()

        return allCategories.tryFlatMap { categories in
            req.view.render("CategoryRead", ["categories": categories])
        }
    }

    // Lists one category with given ID
    // Returns CategoryOne.leaf template    
    func show(req: Request) throws -> EventLoopFuture<View> {
        let category = Category.find(req.parameters.get("id"), on: req.db)

        return category.tryFlatMap { c in
            req.view.render("CategoryOne", ["category": c])
        }
    }

    // Creates a new category on POST
    func create(req: Request) async throws -> Category {
        let category = try req.content.decode(Category.self)
        try await category.save(on: req.db)
        return category
    }

    // Deletes a category with given ID on DELETE
    func delete(req: Request) async throws -> HTTPStatus {
        guard let category = try await Category.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await category.delete(on: req.db)
        return .ok
    }
}
