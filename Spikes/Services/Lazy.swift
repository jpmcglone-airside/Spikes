import Foundation

/// An implementation of `lazy` functionality using `@propertyWrapper`
@propertyWrapper
class Lazy<T> {
  fileprivate var loader: () -> T
  fileprivate var _value: T?

  var projectedValue: Lazy<T> { return self }
  var wrappedValue: T {
    _value = _value ?? loader()
    return _value!
  }

  init(wrappedValue: T) {
    fatalError("Use init(_ loader:) instead")
  }

  init(_ loader: @autoclosure @escaping () -> T) {
    self.loader = loader
  }

  init(load loader: @escaping () -> T) {
    self.loader = loader
  }

  /// Returns the underlying value to nil, so the next call of `wrappedValue` re-evaluates the lazy var
  func reset() {
    _value = nil
  }
}

/// Similar to `Lazy<T>`, `LazyMutable<T>` lets you change the wrappedValue
@propertyWrapper
class LazyMutable<T>: Lazy<T> {
  override var projectedValue: LazyMutable<T> { return self }
  override var wrappedValue: T {
    get { super.wrappedValue }
    set { set(newValue) }
  }

  func set(_ loader: @autoclosure @escaping () -> T) {
    set(loader)
  }

  func set(_ loader: @escaping () -> T) {
    _value = nil
    self.loader = loader
  }
}
