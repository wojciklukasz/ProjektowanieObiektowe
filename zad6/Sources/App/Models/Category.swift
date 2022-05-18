import Vapor
import Fluent

// The model to store information about categories: their name and description
final class Category: Model, Content {
    // Name of the table
    static let schema = "categories"

    // Unique identifier for category
    @ID(custom: "id")
    var id: UUID?

    // Fields of category
    @Field(key: "name")
    var name: String
    @Field(key: "description")
    var description: String

    // Constructor for an empty category
    init() { }

    // Constructor which initializes all category fields
    init(id: UUID? = nil, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}