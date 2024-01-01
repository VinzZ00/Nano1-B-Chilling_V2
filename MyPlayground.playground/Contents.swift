import UIKit

var greeting = "Hello, playground"

func a() {
    print("ini adalah a")
}

DispatchQueue.main.async {
    a()
}
