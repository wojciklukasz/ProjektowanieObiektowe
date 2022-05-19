import Fluent
import Vapor

// routing for products
// localhost:8080/products
struct ProductController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let products = routes.grouped("products")
        // GET localhost:8080/products
        products.get(use: index)
        // POST localhost:8080/products
        products.post(use: create)
        products.group(":id") { product in
            // GET localhost:8080/products/id
            product.get(use: show)
            // DELETE localhost:8080/products/id
            product.delete(use: delete)
        }
    }

    // Lists all products in the DB
    // Returns ProductRead.leaf template
    func index(req: Request) throws -> EventLoopFuture<View> {
        let allProducts = Product.query(on: req.db).all()

        return allProducts.tryFlatMap { product in
            req.view.render("ProductRead", ["products": product])
        }
    }

    // Lists one product with given ID
    // Returns ProductOne.leaf template 
    func show(req: Request) throws -> EventLoopFuture<View> {
        let product = Product.find(req.parameters.get("id"), on: req.db)

        return product.tryFlatMap { p in
            req.view.render("ProductOne", ["product": p])
        }
    }

    // Creates a new product on POST
    func create(req: Request) async throws -> Product {
        let product = try req.content.decode(Product.self)
        try await product.save(on: req.db)
        return product
    }

    // Deletes a product with given ID on DELETE
    func delete(req: Request) async throws -> HTTPStatus {
        guard let product = try await Product.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await product.delete(on: req.db)
        return .ok
    }
}
