import Fluent
import Vapor

struct CategoryController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let categories = routes.grouped("categories")
        categories.get(use: index)
        categories.post(use: create)
        categories.group(":id") { category in
            category.get(use: show)
            category.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<View> {
        let allCategories = Category.query(on: req.db).all()

        return allCategories.tryFlatMap { categories in
            req.view.render("CategoryRead", ["categories": categories])
        }
    }

    func show(req: Request) throws -> EventLoopFuture<View> {
        let category = Category.find(req.parameters.get("id"), on: req.db)

        return category.tryFlatMap { c in
            req.view.render("CategoryOne", ["category": c])
        }
    }

    func create(req: Request) async throws -> Category {
        let category = try req.content.decode(Category.self)
        try await category.save(on: req.db)
        return category
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let category = try await Category.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await category.delete(on: req.db)
        return .ok
    }
}
