//
//  WeakArrayTests.swift
//  WeakArrayTests
//
//  Created by David Mauro on 7/27/14.
//  Copyright (c) 2014 David Mauro. All rights reserved.
//

import Foundation
import XCTest
import WeakArray

class Object: NSObject {
    override var description: String {
    return "object"
    }
}

class WeakArrayTests: XCTestCase {
    func testAddingObjectIncreasesCount() {
        var a = WeakArray<Object>()
        let obj: Object? = Object()
        a.append(obj)
        XCTAssert(a.count == 1, "Array count did not increase")
    }
    func testAddingObjectWithAppendIncreasesCount() {
        var a = WeakArray<Object>()
        let obj: Object? = Object()
        a.append(obj)
        XCTAssert(a.count == 1, "Array count did not increase")
    }

    func testCanStoreAndRetriveObject() {
        var a = WeakArray<Object>()
        let obj: Object? = Object()
        a.append(obj)
        XCTAssert(a[0] == obj, "Retrieved object was \(String(describing: a[0])) instead of expected obj")
    }

    func testStoredObjectsAreNotRetained() {
        var a = WeakArray<Object>()
        var obj: Object? = Object()
        a.append(obj)
        obj = nil
        XCTAssertNil(a[0], "We retrieved \(String(describing: a[0])) instead of nil")
    }

    func testCanStoreWithSubscript() {
        var a = WeakArray<Object>()
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        a.append(obj1)
        a[0] = obj2
        XCTAssert(a[0] == obj2, "Retrieved object was \(String(describing: a[0])) instead of expected obj")
    }

    func testCanSetWithRange() {
        var a = WeakArray<Object>()
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        let obj3: Object? = Object()
        let obj4: Object? = Object()
        a.append(obj1)
        a.append(obj2)
        a.append(obj3)
        a.append(obj4)
        a[1...3] = [obj1, obj1, obj1]
        XCTAssert(a[0] == obj1, "Retrieved object was \(String(describing: a[0])) instead of expected obj")
        XCTAssert(a[1] == obj1, "Retrieved object was \(String(describing: a[0])) instead of expected obj")
        XCTAssert(a[2] == obj1, "Retrieved object was \(String(describing: a[0])) instead of expected obj")
        XCTAssert(a[3] == obj1, "Retrieved object was \(String(describing: a[0])) instead of expected obj")
    }

    func testCanGetWithRange() {
        var a = WeakArray<Object>()
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        a.append(obj1)
        a.append(obj2)
        a.append(nil)
        let slice = a[0...2]
        XCTAssert(slice[slice.startIndex] == obj1, "First entry did not match")
        XCTAssert(slice[slice.startIndex + 1] == obj2, "Second entry did not match")
        XCTAssertNil(slice[slice.startIndex + 2], "Third entry should be nil")
    }

    func testAppendingWeakArraytoWeakArray() {
        var a1 = WeakArray<Object>()
        var a2 = WeakArray<Object>()
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        let obj3: Object? = Object()
        let obj4: Object? = Object()
        a1.append(obj1)
        a1.append(obj2)
        a2.append(obj3)
        a2.append(obj4)
        _ = a1 += a2
        XCTAssert(a1.count == 4, "Count is incorrect")
        XCTAssert(a1[2] == obj3, "Incorrect object added")
        XCTAssert(a1[3] == obj4, "Incorrect object added")
    }

    func testAppendingArrayToWeakArray() {
        var a1 = WeakArray<Object>()
        var a2 = [Object]()
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        let obj3: Object? = Object()
        let obj4: Object? = Object()
        a1.append(obj1)
        a1.append(obj2)
        a2.append(obj3!)
        a2.append(obj4!)
        _ = a1 += a2
        XCTAssert(a1.count == 4, "Count is incorrect")
        XCTAssert(a1[2] == obj3, "Incorrect object added")
        XCTAssert(a1[3] == obj4, "Incorrect object added")
    }

    func testAppendingFromArrayDoesNotRetain() {
        var a1 = WeakArray<Object>()
        var a2: [Object] = []
        var obj: Object? = Object()
        a2.append(obj!)
        _ = a1 += a2
        a2.removeLast()
        XCTAssert(a1[0] == obj, "Object was not added")
        obj = nil
        XCTAssertNil(a1[0], "Object did not become nil")
    }

    func testIterationGetsCorrectObjects() {
        var a = WeakArray<Object>()
        let obj: Object? = Object()
        a.append(obj)
        a.append(obj)
        a.append(obj)
        var i = 0
        for value in a {
            XCTAssert(value == obj, "Iterated value did not match")
            i += 1
        }
        XCTAssert(i == 3, "Iteration count did not match, was \(i) instead of 3")
    }

    func testIterationIsNotInterruptedByNilObject() {
        var a = WeakArray<Object>()
        let obj1: Object? = Object()
        var obj2: Object? = Object()
        let obj3: Object? = Object()
        a.append(obj1)
        a.append(obj2)
        a.append(obj3)
        obj2 = nil
        var i = 0
        for _ in a {
            i += 1
        }
        XCTAssert(i == 2, "Iteration count did not match, was \(i) instead of 2")
    }

    func testModifyingAnArrayDoesNotAffectCopies() {
        var a = WeakArray<Object>()
        let obj: Object? = Object()
        a.append(obj)
        var b = a
        b[0] = nil
        XCTAssertNotNil(a[0], "Changing one array affected the other")
    }

    func testCanBeConstructedWithArrayLiteral() {
        let obj: Object? = Object()
        let a: WeakArray = [obj!]
        XCTAssert(a[0] == obj, "Object was not added")
    }

    func testFirst() {
        var a = WeakArray<Object>()
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        a.append(obj1)
        a.append(obj2)
        XCTAssert(a.first == obj1, "First object did not match")
    }

    func testLast() {
        var a = WeakArray<Object>()
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        a.append(obj1)
        a.append(obj2)
        XCTAssert(a.last == obj2, "Last object did not match")
    }

    func testWithSameValuesAreEqual() {
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        let a: WeakArray = [obj1!, obj2!]
        let b: WeakArray = [obj1!, obj2!]
        XCTAssert(a == b, "Arrays are not equal")
    }

    func testWithDifferentValuesAreNotEqual() {
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        let a: WeakArray = [obj1!]
        let b: WeakArray = [obj2!]
        XCTAssert(a != b, "Arrays should not be equal")
    }

    func testSlicesOfSameValuesAreEqual() {
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        let a: WeakArray = [obj1!, obj2!]
        let b: WeakArray = [obj1!, obj2!]
        XCTAssert(a[0...1] == b[0...1], "Slices are not equal")
    }

    func testSliceOfDifferentValuesAreNotEqual() {
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        let obj3: Object? = Object()
        let a: WeakArray = [obj1!, obj2!, obj3!]
        let b: WeakArray = [obj1!, obj2!, obj3!]
        XCTAssert(a[0...1] != b[1...2], "Slices should not be equal")
    }

    func testInsertAtIndexInsertsElementInCorrectLocation() {
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        let obj3: Object? = Object()
        var a: WeakArray = [obj1!, obj2!]
        a.insert(obj3, at: 1)
        let b: WeakArray = [obj1!, obj3!, obj2!]
        XCTAssert(a == b, "Order did not match")
    }

    func testReplaceRangeReplacesItemsInRange() {
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        let obj3: Object? = Object()
        let obj4: Object? = Object()
        var a: WeakArray = [obj1!, obj2!]
        a.replaceRange(0...1, with: [obj3!, obj4!])
        let b: WeakArray = [obj3!, obj4!]
        XCTAssert(a == b, "Values did not match")
    }

    func testSpliceInsertsElementsInCorrectLocation() {
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        let obj3: Object? = Object()
        let obj4: Object? = Object()
        var a: WeakArray = [obj1!, obj2!]
        a.insert(contentsOf: [obj3!, obj4!], at: 1)
        let b: WeakArray = [obj1!, obj3!, obj4!, obj2!]
        XCTAssert(a == b, "Order did not match")
    }

    func testExtendAppendsElements() {
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        let obj3: Object? = Object()
        let obj4: Object? = Object()
        var a: WeakArray = [obj1!, obj2!]
        let b: WeakArray = [obj3!, obj4!]
        let c: WeakArray = [obj1!, obj2!, obj3!, obj4!]
        a.append(contentsOf: b[0...1])
        XCTAssert(a == c, "Items not appended correctly")
    }

    func testFilterOnlyAddsForTrueValue() {
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        let obj3: Object? = Object()
        let obj4: Object? = Object()
        let a: WeakArray = [obj1!, obj2!, obj3!, obj4!]
        var count = 0
        let b = a.filter { item in
            count += 1
            return count == 4
        }
        XCTAssert(b.count == 1, "Too many added")
        XCTAssert(b[0] == obj4, "Incorrect element added")
    }

    func testReversePutsElemetsInCorrectOrder() {
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        let obj3: Object? = Object()
        let obj4: Object? = Object()
        let a: WeakArray = [obj1!, obj2!, obj3!, obj4!]
        let b = a.reverse()
        let c: WeakArray = [obj4!, obj3!, obj2!, obj1!]
        XCTAssert(b == c, "Did not reverse properly")
    }
    
    func testIndexOfFindsCorrectPosition() {
        let obj1: Object? = Object()
        let obj2: Object? = Object()
        let obj3: Object? = Object()
        let obj4: Object? = Object()
        let obj5: Object? = Object()
        let a: WeakArray = [obj1!, obj2!, obj3!, obj4!]
        
        XCTAssert(a.index(of: obj1) == 0, "Object not in correct position, is in \(String(describing: a.index(of: obj1))) instead of 0")
        XCTAssert(a.index(of: obj2) == 1, "Object not in correct position, is in \(String(describing: a.index(of: obj2))) instead of 1")
        XCTAssert(a.index(of: obj3) == 2, "Object not in correct position, is in \(String(describing: a.index(of: obj3))) instead of 2")
        XCTAssert(a.index(of: obj4) == 3, "Object not in correct position, is in \(String(describing: a.index(of: obj4))) instead of 3")
        XCTAssert(a.index(of: obj5) == nil, "Object not in correct position, is in \(String(describing: a.index(of: obj5))) instead of nil")
    }
}

