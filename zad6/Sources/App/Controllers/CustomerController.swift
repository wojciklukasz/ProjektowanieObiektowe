import Fluent
import Vapor

// routing for customers
// localhost:8080/customers
struct CustomerController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let customers = routes.grouped("customers")
        // GET localhost:8080/customers
        customers.get(use: index)
        // POST localhost:8080/customers
        customers.post(use: create)
        customers.group(":id") { customer in
            // GET localhost:8080/customers/id
            customer.get(use: show)
            // POST localhost:8080/customers
            customer.delete(use: delete)
        }
    }

    // Lists all customers in the DB
    // Returns CustomerRead.leaf template
    func index(req: Request) throws -> EventLoopFuture<View> {
        let allCustomers = Customer.query(on: req.db).all()

        return allCustomers.tryFlatMap { customer in
            req.view.render("CustomerRead", ["customers": customer])
        }
    }

    // Lists one customer with given ID
    // Returns CustomerOne.leaf template 
    func show(req: Request) throws -> EventLoopFuture<View> {
        let customer = Customer.find(req.parameters.get("id"), on: req.db)

        return customer.tryFlatMap { c in
            req.view.render("CustomerOne", ["customer": c])
        }
    }

    // Creates a new customer on POST
    func create(req: Request) async throws -> Customer {
        let customer = try req.content.decode(Customer.self)
        try await customer.save(on: req.db)
        return customer
    }

    // Deletes a customer with given ID on DELETE
    func delete(req: Request) async throws -> HTTPStatus {
        guard let customer = try await Customer.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await customer.delete(on: req.db)
        return .ok
    }
}
