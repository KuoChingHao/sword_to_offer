//
//  Copyright © 2022 Pinkoi. All rights reserved.
//

import XCTest

/// 剑指 Offer 12. 矩阵中的路径

extension Array where Element == Array<Character> {
    subscript(_ tuple: (Int, Int)) -> Element.Element {
        return self[tuple.0][tuple.1]
    }
}


final class LeetCodeTests_12: XCTestCase {
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        var lookup = [(Int, Int)]()
        for y in 0..<board.count {
            for x in 0..<board[y].count {
                if board[(y, x)] == word[word.startIndex] {
                    lookup.append((y, x))
                }
            }
        }
        
        let xRange = 0..<board[0].count
        let yRange = 0..<board.count
        for current in lookup {
            print("current: \((current.1, current.0))")
            var x = current.1
            var y = current.0
            var wIndex = word.startIndex
            var footprint = [current]
            while true {
                print("x, y = \((x, y))")
                let nextIndex = word.index(after: wIndex)
                if nextIndex == word.endIndex {
                    return true
                }
                let next = word[nextIndex]
                
                var isFind = false
                for direct in [(y-1, x), (y, x+1), (y+1, x), (y, x-1)] {
                    if !yRange.contains(direct.0) || !xRange.contains(direct.1) { continue }
                    if footprint.contains(where: { $0 == direct }) { continue }
                    if board[direct] == next {
                        y = direct.0
                        x = direct.1
                        footprint.append(direct)
                        wIndex = nextIndex
                        isFind = true
                        break
                    }
                }
                
                if !isFind {
                    break
                }
            }
        }
        return false
    }
    
    func test_0() {
        let result = exist([
            ["A", "B", "C", "E"],
            ["S", "F", "C", "S"],
            ["A", "D", "E", "E"]
        ], "ABCCED")
        XCTAssertEqual(result, true)
    }
    
    func test_1() {
        let result = exist([
            ["A", "D", "E", "E"],
            ["S", "F", "C", "S"],
            ["A", "B", "C", "E"],
        ], "ABCCED")
        XCTAssertEqual(result, true)
    }
    
    func test_2() {
        let result = exist([
            ["a", "b"],
            ["c", "d"]
        ], "abcd")
        XCTAssertEqual(result, false)
    }
    
    func test_3() {
        let result = exist([
            ["a","a"]
        ], "aaaa")
        XCTAssertEqual(result, false)
    }
    
    func test_4() {
        let result = exist([
            ["C","A","A"],
            ["A","A","A"],
            ["B","C","D"]
        ], "AAB")
        XCTAssertEqual(result, true)
    }
}

//
// func exist(_ board: [[Character]], _ word: String) -> Bool {
//    let maxX = board[0].count
//    let maxY = board.count
//    var x = 0
//    var y = 0
//
//    var wIndex = word.startIndex
//
//    while x < maxX || y < maxY {
//        let right = (y, x+1)
//        let down = (y+1, x)
//        let left = (y, x-1)
//
//        if board[y][x] == word[wIndex] {
//            if board[right] == word[word.index(after: wIndex)] {
//                wIndex = word.index(after: wIndex)
//                x += 1
//            } else if board[down] == word[word.index(after: wIndex)] {
//                wIndex = word.index(after: wIndex)
//                y += 1
//            } else if board[left] == word[word.index(after: wIndex)] {
//                wIndex = word.index(after: wIndex)
//                y -= 1
//            } else {
//
//            }
//        } else {
//            if board[right] == word[word.index(after: wIndex)] {
//                wIndex = word.index(after: wIndex)
//                x += 1
//            } else if board[down] == word[word.index(after: wIndex)] {
//                wIndex = word.index(after: wIndex)
//                y += 1
//            } else if board[left] == word[word.index(after: wIndex)] {
//                wIndex = word.index(after: wIndex)
//                y -= 1
//            }
//        }
//    }
// }
