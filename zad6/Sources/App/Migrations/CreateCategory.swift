import Fluent

// Migration for creating a categories table or reverting changes
struct CreateCategory: AsyncMigration {
    // Creates a new table named categories
    func prepare(on database: Database) async throws {
        try await database.schema("categories")
                .id()
                .field("name", .string, .required)
                .field("description", .string, .required)
                .create()
    }

    // Reverts changes made in CreateCategory prepare method
    func revert(on database: Database) async throws {
        try await database.schema("categories").delete()
    }
}
