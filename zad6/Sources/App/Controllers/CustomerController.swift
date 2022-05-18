import Fluent
import Vapor

struct CustomerController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let customers = routes.grouped("customers")
        customers.get(use: index)
        customers.post(use: create)
        customers.group(":id") { customer in
            customer.get(use: show)
            customer.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<View> {
        let allCustomers = Customer.query(on: req.db).all()

        return allCustomers.tryFlatMap { customer in
            req.view.render("CustomerRead", ["customers": customer])
        }
    }

    func show(req: Request) throws -> EventLoopFuture<View> {
        let customer = Customer.find(req.parameters.get("id"), on: req.db)

        return customer.tryFlatMap { c in
            req.view.render("CustomerOne", ["customer": c])
        }
    }

    func create(req: Request) async throws -> Customer {
        let customer = try req.content.decode(Customer.self)
        try await customer.save(on: req.db)
        return customer
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let customer = try await Customer.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await customer.delete(on: req.db)
        return .ok
    }
}
