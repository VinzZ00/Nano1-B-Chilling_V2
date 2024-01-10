//public func solution(_ A : inout [Int]) -> String {
//    // Implement your solution here
//
//    var result = ""
//    for x in Range(0...(A.count - 2)) {
//        print("Index : \(x)")
//        print(A.count)
//        if (A[x] > A[x + 1]) {
//            result = result + ">"
//        } else if (A[x] < A[x + 1]) {
//            result = result + "<"
//        } else {
//            result = result + "="
//        }
//    }
//    return result
//
//}
//

//
//solution(&a)

func genFrom(arr : [String], str: String) -> Bool {
    var bool = true
    for x in str {
        if !arr.contains(String(x)) {
            bool = false
            break
        }
    }
    return bool
}

public func solution(_ A : inout [Int]) -> Int {
    // Implement your solution here
    var arr = {
        A.map {String($0)}
    }()
    var longest = 0
    
    var n : [String] = []
    for x in Range(0...arr.count - 1){
        var x = Set(arr[x])
        if (x.count <= 2) {
            print("\(n)")
            print("number : \(x)")
            if (n.count >= 1) {
                if (genFrom(arr: n, str: String(x))) {
                    longest += 1
                } else {
                    n.removeAll()
                    longest = 0
                }
            } else {
                x.forEach { c in
                    print(c)
                    n.append(String(c))
                }
                longest += 1
            }
        } else {
            n.removeAll()
            longest = 0
        }
    }
    return longest
}


func solutions(_ A : inout [Int]) -> Int {
    var set = Set<Character>()
    var arr = {
        A.map {String($0)}
    }()
    var longest = 0
    
    for x in arr {
        x.forEach { c in
            set.insert(c)
        }
        if set.count < 3 {
            longest += 1
        } else {
            longest = 0
            set.
        }
    }
    return longest
}
var a = [43, 44, 64, 64, 46]
solutions(&a)
