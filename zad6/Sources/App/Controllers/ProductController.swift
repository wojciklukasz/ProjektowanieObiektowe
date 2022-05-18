import Fluent
import Vapor

struct ProductController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let products = routes.grouped("products")
        products.get(use: index)
        products.post(use: create)
        products.group(":id") { product in
            product.get(use: show)
            product.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<View> {
        let allProducts = Product.query(on: req.db).all()

        return allProducts.tryFlatMap { product in
            req.view.render("ProductRead", ["products": product])
        }
    }

    func show(req: Request) throws -> EventLoopFuture<View> {
        let product = Product.find(req.parameters.get("id"), on: req.db)

        return product.tryFlatMap { p in
            req.view.render("ProductOne", ["product": p])
        }
    }

    func create(req: Request) async throws -> Product {
        let product = try req.content.decode(Product.self)
        try await product.save(on: req.db)
        return product
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let product = try await Product.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await product.delete(on: req.db)
        return .ok
    }
}
