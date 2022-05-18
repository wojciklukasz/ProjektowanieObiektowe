import Fluent

// Migration for creating a customers table or reverting changes
struct CreateCustomer: AsyncMigration {
    // Creates a new table named customers
    func prepare(on database: Database) async throws {
        try await database.schema("customers")
                .id()
                .field("email", .string, .required)
                .field("first_name", .string, .required)
                .field("last_name", .string, .required)
                .create()
    }

    // Reverts changes made in CreateCustomer prepare method
    func revert(on database: Database) async throws {
        try await database.schema("customers").delete()
    }
}
