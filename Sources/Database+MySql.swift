import Vapor
import Fluent
   
extension Database {
   // MARK: Foreign
   
   /// A helper function to create foreign keys
   /// Use to execute the query drop.database.driver.raw()
   ///
   /// - Parameters:
   ///   - parentTable: parent table
   ///   - parentPrimaryKey: parent column
   ///   - childTable: children table
   ///   - childForeignKey: children column
   /// - Returns: MySQL query
    public static func foreign(
        parentTable: String,
        parentPrimaryKey: String,
        childTable: String,
        childForeignKey: String
        ) -> String {
        return "ALTER TABLE " + childTable + " ADD CONSTRAINT " + childTable + "_" + parentTable + "_" + parentPrimaryKey + "_foreign FOREIGN KEY(" + childForeignKey + ") REFERENCES " + parentTable + "(" + parentPrimaryKey + ")"
    }
    
    /// A helper function to execute foreign index
    ///
    /// - Parameters:
    ///   - parentTable: parent table
    ///   - parentPrimaryKey: parent column
    ///   - childTable: children table
    ///   - childForeignKey: children column
    /// - Returns: MySQL query
    public func foreign(
        parentTable: String,
        parentPrimaryKey: String,
        childTable: String,
        childForeignKey: String
        ) throws {
        
        try self.driver.raw(Database.foreign(parentTable: parentTable, parentPrimaryKey: parentTable, childTable: childTable, childForeignKey: childForeignKey))
    }
   
    // MARK: Index
    /// A helper function to index
    /// Use to execute the query drop.database.driver.raw()
    ///
    /// - Parameters:
    ///   - table: table
    ///   - column: column
    ///   - name: name of index
    /// - Returns: MySQL query
    public static func index(table: String, column: String, name: String? = nil) -> String {
    
        var nameString = name ?? ""
    
        // Add trailing space
        if(nameString.count > 0) {
            nameString += " "
        }
    
        return "ALTER TABLE " + table + " ADD INDEX " + nameString + "(" + column + ")"
    }
    
    /// A helper function to execute index
    ///
    /// - Parameters:
    ///   - table: table
    ///   - column: column
    ///   - name: name of index
    /// - Returns: MySQL query
    public func index(table: String, column: String, name: String? = nil) throws {
        try self.driver.raw(Database.index(table: table, column: column, name: name))
    }
}