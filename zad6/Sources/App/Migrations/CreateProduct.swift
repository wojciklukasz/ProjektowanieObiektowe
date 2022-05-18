import Fluent

// Migration for creating a products table or reverting changes
struct CreateProduct: AsyncMigration {
    // Creates a new table named products
    func prepare(on database: Database) async throws {
        try await database.schema("products")
                .id()
                .field("name", .string, .required)
                .field("price", .double, .required)
                .field("stock", .int, .required)
                .field("category_id", .uuid, .references("categories", "id"))
                .create()
    }

    // Reverts changes made in CreateProduct prepare method
    func revert(on database: Database) async throws {
        try await database.schema("products").delete()
    }
}
