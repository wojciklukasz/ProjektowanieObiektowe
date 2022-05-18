import Vapor
import Fluent

// The model to store information about customers: their email, first name and last name
final class Customer: Model, Content {
    // Name of the table
    static let schema = "customers"

    // Unique identifier for customer
    @ID(key: .id)
    var id: UUID?

    // Fields of customer
    @Field(key: "email")
    var email: String
    @Field(key: "first_name")
    var first_name: String
    @Field(key: "last_name")
    var last_name: String

    // Constructor for an empty customer
    init() { }

    // Constructor which initializes all customer fields
    init(id: UUID? = nil, email: String, first_name: String, last_name: String) {
        self.id = id
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
    }
}