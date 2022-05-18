import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        req.view.render("index")
    }

    app.grouped("categories").get("create") { req -> EventLoopFuture<View> in
        req.view.render("CategoryCreate")
    }

    app.grouped("customers").get("create") { req -> EventLoopFuture<View> in
        req.view.render("CustomerCreate")
    }

    app.grouped("products").get("create") { req -> EventLoopFuture<View> in
//        let allCategories = try CategoryController().index(req: req)
//
//        return allCategories.tryFlatMap { c in
//            req.view.render("ProductCreate", ["categories": c])
//        }
        req.view.render("ProductCreate")
    }

    try app.register(collection: CategoryController())
    try app.register(collection: CustomerController())
    try app.register(collection: ProductController())
}
// https://docs.vapor.codes/4.0/routing/