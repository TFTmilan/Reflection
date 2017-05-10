/// Set value for key of an instance
public func set(_ value: Any, key: String, for instance: inout Any) throws {
    try property(type: type(of: instance), key: key).write(value, to: mutableStorage(instance: &instance))
}

/// Set value for key of an instance
public func set(_ value: Any, key: String, for instance: AnyObject) throws {
    var copy: Any = instance
    try set(value, key: key, for: &copy)
}

/// Set value for key of an instance
public func set<T>(_ value: Any, key: String, for instance: inout T) throws {
    try property(type: T.self, key: key).write(value, to: mutableStorage(instance: &instance))
}

/// Set value for specified type. For cases when the object is casted as any but Type is known
public func set<T>(_ value: Any, key: String, type: Any.Type, for instance: inout T) throws {
    try property(type: type, key: key).write(value, to: mutableStorage(instance: &instance, type: type))
}

private func property(type: Any.Type, key: String) throws -> Property.Description {
    guard let property = try properties(type).first(where: { $0.key == key }) else { throw ReflectionError.instanceHasNoKey(type: type, key: key) }
    return property
}
