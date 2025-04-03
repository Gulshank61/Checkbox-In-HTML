import Foundation

class Person {
  var name: String

  init(name: String) {
    self.name = name
  }

  func griet() {
    print("Hello, my name is \(name)")
  }
}

// Test Instance
let person = Person("name")
person.griet()