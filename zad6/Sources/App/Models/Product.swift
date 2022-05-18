import Vapor
import Fluent

// The model to store information about products: their name, price and available stock
final class Product: Model, Content {
    // Name of the table
    static let schema = "products"

    // Unique identifier for product
    @ID(key: .id)
    var id: UUID?

    // Fields of product
    @Field(key: "name")
    var name: String
    @Field(key: "price")
    var price: Double
    @Field(key: "stock")
    var stock: Int

    // ForeignKey relation with Category
    @Parent(key: "category_id")
    var category: Category

    // Constructor for an empty product
    init() { }

    // Constructor which initializes all product fields
    init(id: UUID? = nil, name: String, price: Double, stock: Int, categoryID: UUID) {
        self.id = id
        self.name = name
        self.price = price
        self.stock = stock
        self.$category.id = categoryID
    }
}