import UIKit

// Complete the arrayManipulation function below.
func arrayManipulation(n: Int, queries: [[Int]]) -> Int {
    var result = Array(repeating: 0, count: n)

    for query in queries {
       let left_a = query[0] - 1
       let right_b = query[1] - 1
       let summand_k = query[2]
       result[left_a] += summand_k
       if (right_b + 1) < n {
          result[right_b + 1] -= summand_k
       }
    }

    var max = 0
    var x = 0
    for i in 0 ..< n {
       x += result[i]
       if max < x {
          max = x
       }
    }
    print(max)
    return max
}

/*
    5 3
    1 2 100
    2 5 100
    3 4 100
    =======
    a b k
    =======
    n = 5 -> Number of elements in Array
 
 */
arrayManipulation(n: 5, queries:[[1,2,100], [2,5,100], [3,4,100]])
