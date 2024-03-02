//
//  ViewController.swift
//  AssignmentApp
//
//  Created by Nayan Sayare on 20/06/22.
//

import UIKit

class Parent {
  var name: String?
  var number: String?
}

class SecondClass {
  var className: String?
  var parentRef: Parent?
}

struct SecondStruct {
  var structName: String?
  var parentRef: Parent?
}

struct DemoClass {
  var value: Int?
}

class A {
  var arr = [10,20,30]
}

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testClosure()
        /*
        calCulateMod(for: 5)
        let obj = Solution()
        print(obj.longestPalindrome("babad"))
        
        */
        
        self.navigationController?.navigationBar.isHidden = true
        let vc: MainViewController = MainViewController.loadFromNib(MainViewController.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func testClosure1() {
        let obj = A()
        let q: DispatchQueue = DispatchQueue(label: "serial-queue")
        
        func firstMethod() {
            
            q.async { [obj] in
                print(obj.arr)
            }
        }
        
        func modify() {
            print("modified called")
            obj.arr = [10,20,30,40]
        }
        
        firstMethod()
        modify()
    }
    
    func testClosure() {
         var classObj = SecondClass() /// m1
         var structObj = SecondStruct() // m2

       
               
        classObj.className = "ABC"
        structObj.structName = "PQR" 
        
         var closure = { [classObj, structObj] in
           print(classObj.className)
           print(structObj.structName)
         }
         
         


         classObj.className = "MNQ"
         structObj.structName = "XYZ" // m4

         closure()
         
        /*
        var obj = DemoClass()

        var closure = { [obj] in
          print(obj.value)
        }

        obj.value = 10
        closure()
         */
    }
    
    func calCulateMod(for val: Int) {
        let res = (21 / val) % val
        print("\(res)")
    }
    
    func crashFunc() {
        let str: String = "B NAVYA SREE"
        
        let words = str.components(separatedBy: " ")
        words.map{ $0.maskedString() }.joined(separator: " ")
    }
    
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        var i: Int = Int.zero, j: Int = Int.zero
        let numsCount: Int = nums.count
        var resultArr: [Int] = [Int]()
        
        while (i + 1) < (nums.count - 1) {
            resultArr[j] = nums[i]
            j += 1
            if nums[i] == nums[i + 1] {
                i += 2
            } else {
                i += 1
            }
        }
        
        i = Int.zero
        for ele in resultArr {
            nums[i] = ele
            i += 1
        }
        
        while i < numsCount {
            nums[i] = 0
            i += 1
        }
        return resultArr.count
    }
    
    func isPalindrome(_ s: String) -> Bool {
        guard !s.isEmpty else { return true }
        let str = s.filter { $0.isNumber || $0.isLetter }.lowercased()
        return str == String(str.reversed())
    }
    
    func maxProfit(_ prices: [Int]) -> Int {
        var minNum: Int = prices.first ?? Int.zero
        var maxProfit: Int = minNum
        
        for ele in prices {
            if ele < minNum {
                minNum = ele
            } else {
                maxProfit = ele - minNum
            }
        }
        return maxProfit
    }
}

extension String {
    func maskedNumber() -> String {
        var maskedNumber = ""
        if  (self.count > 10) {
            let prefix = self.prefix(5)
            let suffix = self.suffix(2)
            let string = String(repeating: "*", count: self.count - prefix.count - suffix.count)
            maskedNumber = prefix + string + suffix
        } else {
            let prefix = self.prefix(1)
            let suffix = self.suffix(1)
            let string = String(repeating: "*", count: self.count - prefix.count - suffix.count)
            maskedNumber = prefix + string + suffix
        }
        return maskedNumber
    }

    func maskedString() -> String {
        maskedNumber()
    }

    
    func removeAlphaNumeric(str: String) -> String {
        var res: String = self
        for i in str {
            res = res.replacingOccurrences(of: "\(i)", with: "")
        }
        return res
    }
}


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func reverseLinkList(head: ListNode?) -> ListNode? {
        var prev: ListNode? = nil
        var next: ListNode? = nil
        var current: ListNode? = head
        
        while current != nil {
            next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        
        return prev
    }
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var tempRes: ListNode? = nil
        var resultL: ListNode? = tempRes
        var tempL1: ListNode? = reverseLinkList(head: l1)
        var tempL2: ListNode? = reverseLinkList(head: l2)
        var carry: Int = Int.zero
        
        while tempL1?.next != nil && tempL2?.next != nil {
            var sum: Int = carry + (tempL1?.val ?? Int.zero) + (tempL2?.val ?? Int.zero)
            if sum > 9 {
                let temp = sum % 10
                sum /= 10
                carry = sum
                sum = temp
            } else {
                carry = Int.zero
            }
            tempRes = ListNode(sum)
            tempRes = tempRes?.next
            
            tempL1 = tempL1?.next
            tempL2 = tempL2?.next
        }
        
        while tempL2?.next != nil {
            var sum: Int = carry + (tempL2?.val ?? Int.zero)
            if sum > 9 {
                let temp = sum % 10
                sum /= 10
                carry = sum
                sum = temp
            } else {
                carry = Int.zero
            }
            tempRes = ListNode(sum)
            tempRes = tempRes?.next
            
            tempL2 = tempL2?.next
        }
        
        while tempL1?.next != nil {
            var sum: Int = carry + (tempL1?.val ?? Int.zero)
            if sum > 9 {
                let temp = sum % 10
                sum /= 10
                carry = sum
                sum = temp
            } else {
                carry = Int.zero
            }
            tempRes = ListNode(sum)
            tempRes = tempRes?.next
            
            tempL1 = tempL1?.next
        }
        
        return resultL
    }
    
    func generate(_ numRows: Int) -> [[Int]] {
        if numRows == 1 {
            return [[1]]
        } else if numRows == 2 {
            return [[1], [1, 1]]
        }
        var result: [[Int]] = [[1], [1,1]]
        
        for idx in 2..<numRows {
            var tempArr: [Int] = [1]
            var prevArr: [Int] = result.last!
            for i in 0..<prevArr.count - 1 {
                tempArr.append(prevArr[i] + prevArr[i + 1])
            }
            tempArr.append(1)
            result.append(tempArr)
        }
        return result
    }
}
extension Solution {
    func removeDuplicates(nums: [Int]) -> [Int] {
        Array(Set(nums))
    }
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard !s.isEmpty else { return Int.zero }
        var maxCount: Int = Int.zero
        var charArr: [Character] = []
        for ch in s {
            if let idx = charArr.firstIndex(of: ch) {
                charArr.removeSubrange(0...idx)
            }
            charArr.append(ch)
            maxCount = max(maxCount, charArr.count)
        }
        return maxCount
    }
    
    func middleNode(_ head: ListNode?) -> ListNode? {
        var slow: ListNode? = head
        var fast: ListNode? = head
        var prev: ListNode? = head
        
        while fast != nil || fast?.next != nil {
            if prev?.val != slow?.val {
                prev = slow
            }
            slow = slow?.next
            fast = fast?.next?.next
        }
        return slow
    }
    
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var arrCount: Int = nums.count - 1
        var result: [Int] = [1]
        var startIdx: Int = Int.zero
        var postFixVal: Int = 1
        
        // set prefix value
        for idx in stride(from: Int.zero, to: arrCount, by: 1) {
            result.append(result[startIdx] * nums[idx])
            startIdx += 1
        }
        
        // update postfix value
        for idx in stride(from: arrCount, to: -1, by: -1) {
            result[startIdx] *= postFixVal
            postFixVal *= nums[idx]
            startIdx -= 1
        }
        
        return result
    }
    
    func hammingWeight(_ n: Int) -> Int {
        var count = 0
        var num = n
        
        for _ in 0..<32 {
            if num & 1 == 1 {
                count += 1
            }
            num >>= 1
        }
        return count
    }
    
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var resultArr: [[Int]] = []
        var nums: [Int] = nums.sorted()
        var count: Int = nums.count - 1
        
        for i in nums.indices {
            if i > Int.zero && nums[i] == nums[i - 1] {
                continue
            }
            var j = i + 1
            var k = count
            while j < k {
                let sum: Int = nums[i] + nums[j] + nums[k]
                if sum < Int.zero {
                    j += 1
                } else if sum > Int.zero {
                    k -= 1
                } else {
                    resultArr.append([nums[i], nums[j], nums[k]])
                    j += 1
                    k -= 1
                    while j < k && nums[j] == nums[j - 1] { j += 1 }
                    while j < k && nums[k] == nums[k + 1] { k -= 1 }
                }
            }
        }
        
        return resultArr
    }
    
    // [4,5,6,0,1,2]
    func findMin(_ nums: [Int]) -> Int {
        var resValue: Int = Int.max
        var startIdx: Int = Int.zero
        var endIndex: Int = nums.count - 1
        
        while startIdx <= endIndex {
            let mid: Int = startIdx + ((endIndex - startIdx) / 2)
            
            if nums[startIdx] <= nums[mid] {
                resValue = min(resValue, nums[startIdx])
                startIdx = mid + 1
            } else {
                resValue = min(resValue, nums[mid])
                endIndex = mid - 1
            }
        }
        return resValue
    }
    
    /*
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        lazy var arrCount: Int = coins.count - 1
        var prev: [Int] = Array(repeating: Int.zero, count: amount + 1)
        var curr: [Int] = Array(repeating: Int.zero, count: amount + 1)
        
        for i in Int.zero...amount {
            if i % coins[Int.zero] == Int.zero {
                prev[i] = i / coins[Int.zero]
            } else {
                prev[i] = Int.max
            }
        }
        
        for i in 1..<arrCount {
            for j in Int.zero...amount {
                var take: Int = Int.max
                let notTake: Int = prev[j]
                
                if coins[i] <= j {
                    take = 1 + curr[j - coins[i]]
                }
                curr[j] = min(take, notTake)
            }
            prev = curr
        }
        
        if prev[amount] >= Int.max {
            return -1
        } 
        return prev[amount]
    }
     */
    
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        var dp: [Int] = Array(repeating: amount + 1, count: amount + 1)
        dp[0] = Int.zero
        
        for i in 1..<amount + 1 {
            for coin in coins where i <= coin {
                dp[i] = min(dp[i], dp[i - coin] + 1)
            }
        }
        
        
        return dp[amount] > amount ? -1 : dp[amount]
    }
    
    func missingNumber(_ nums: [Int]) -> Int {
        var arrCount: Int = nums.count
        var result: Int = (arrCount * (arrCount + 1)) / 2
        
        for idx in 0..<arrCount {
            result -= nums[idx]
        }
        
        return result
    }
    
    func countBits(_ n: Int) -> [Int] {
        var array: [Int] = Array(repeating: 0, count: n + 1)
        for i in 0 ... n { array[i] = helper(i) }
        return array
    }
    
    private func helper(_ n: Int) -> Int {
        var n = n
        var count = 0
        while n > 0 {
            count += n & 1
            n >>= 1
        }
        return count
    }
    
    func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        var dp: [Int] = Array(repeating: Int.zero, count: target + 1)
        dp[0] = 1
        for i in 1...target {
            for val in nums where val <= i {
                dp[i] += dp[i - val]
            }
        }
        return dp[target]
    }
    
    func lengthOfLIS(_ nums: [Int]) -> Int {
        var result: Int = Int.min
        var currentCount: Int = Int.zero
        
        for idx in 0..<nums.count - 1 {
            currentCount += 1
            if nums[idx] > nums[idx + 1] {
                result = max(result, currentCount)
                currentCount = Int.zero
            }
        }
        if currentCount > result {
            result = currentCount
        }
        return result
    }
    
    func plusOne(_ digits: [Int]) -> [Int] {
        var carry: Int = 1
        var digits: [Int] = digits
        
        for idx in stride(from: digits.count - 1, to: 0, by: -1) {
            var sum: Int = digits[idx] + carry
            if sum > 9 {
                carry = 1
                sum = sum % 10
            } else {
                carry = Int.zero
            }
            
            digits[idx] = sum
        }
        
        if var element = digits.first, carry > Int.zero {
            element += carry
            if element > 9 {
                digits[0] = element % 10
                element /= 10
                digits = [element] + digits
            } else {
                digits[0] = element
            }
        }
        
        return digits
    }
    
    func isAnagram(_ s: String, _ t: String) -> Bool {
        if s.count != t.count {
            return false
        }
        
        var dict: [Character: Int] = [Character: Int]()
        
        for ch in s {
            dict[ch, default: Int.zero] += 1
        }
        
        for ch in t {
            if let count = dict[ch], count > Int.zero {
                dict[ch] = count - 1
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isPalindrome(_ s: String) -> Bool {
        var str: [String.Element] = Array(s.filter({ $0.isNumber || $0.isLetter }))
        var startIdx: Int = Int.zero
        var endIndex: Int = str.count - 1
        
        while startIdx <= endIndex {
            if str[startIdx] != str[endIndex] {
                return false
            }
            startIdx += 1
            endIndex -= 1
        }
        return true
    }
    
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        let count1: Int = text1.count
        let count2: Int = text2.count
        
        var temp = String(text1.reversed())
        let s: [String.Element] = Array(text1.lowercased())
        let t: [String.Element] = Array(text2.lowercased())
        
        var dp: [[Int]] = Array(repeating: Array(repeating: Int.zero, count: count2 + 1), count: count1 + 1)
        
        for i in 1...count1 {
            for j in 1...count2 {
                if s[i - 1] == t[j - 1] {
                    dp[i][j] = 1 + dp[i - 1][j - 1]
                } else {
                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
                }
            }
        }
        
        return dp[count1][count2]
    }
    
    func longestPalindrome(_ s: String) -> String {
        let len: Int = s.count
        let arr: [String.Element] = Array(s)
        if len <= 1 { return s }
        var lhs: Int = 0, rhs: Int = 0
        var dp: [[Bool]] = Array(repeating: Array(repeating: false, count: len), count: len)
        for i in 1..<len {
            for j in 0..<i where arr[j] == arr[i] && (dp[j+1][i-1] || i - j <= 2) {
                dp[j][i] = true
                if i - j > rhs - lhs {
                    lhs = j
                    rhs = i
                }
            }
        }
        return String(arr[lhs...rhs])
    }
    
    func canJump(_ nums: [Int]) -> Bool {
        var arrCount: Int = nums.count
        
        if arrCount == 1 {
            return true
        }
        
        var maxi: Int = Int.zero
        
        for idx in Int.zero..<arrCount where maxi >= idx {
            if maxi < idx + nums[idx] {
                maxi = idx + nums[idx]
            }
            
            if maxi >= arrCount - 1 {
                return true
            }
        }
        return false
    }
    
    func minWindow(_ s: String, _ t: String) -> String {
        var map_t: [Character: Int] = [:]
        var map_s: [Character: Int] = [:]
        
        var s: [String.Element] = Array(s)
        var t: [String.Element] = Array(t)
        
        for ch in t {
            map_t[ch, default: Int.zero] += 1
        }
        
        var i: Int = 0, j: Int = 0
        var result: Int = Int.max
        var currCount: Int = Int.zero
        var lhs: Int = 0, rhs: Int = 0
        var count_t: Int = map_t.count
        
        while j < s.count {
            map_s[s[j], default: Int.zero] += 1
            
            if map_s[s[j]] == map_t[s[j]] {
                currCount += 1
            }
            
            while currCount == count_t {
                if j - i + 1 < result {
                    lhs = i
                    rhs = j
                    result = j - i + 1
                    
                }
                map_s[s[i], default: Int.zero] -= 1
                
                if let count = map_t[s[i]], map_s[s[i]]! < count {
                    currCount -= 1
                }
                
                i += 1
            }
            
            j += 1
        }
        
        return String(s[lhs...rhs])
    }
    
    func hasCycle(_ head: ListNode?) -> Bool {
        var slow: ListNode? = head
        var fast: ListNode? = head?.next
        
        while fast != nil && fast?.next != nil {
            if slow === fast {
                return true
            }
            slow = slow?.next
            fast = fast?.next?.next
        }
        return false
    }
}

extension Array where Element: Hashable {
    mutating func removeDuplicate() {
        var resultArr: [Element] = []
        var dict: [Element: Int] = [:]
        
        for ele in self {
            if dict[ele] == nil {
                dict[ele] = Int.zero
                resultArr.append(ele)
            }
        }
        
        self = resultArr
    }
}

extension Collection {
    func mapN<T>(_ transform: ((Element) throws -> T)) rethrows -> [T] {
        var result: [T] = []
        
        for ele in self where (try? transform(ele)) != nil {
            result.append((try? transform(ele))!)
        }
        
        return result
    }
}

struct structA {
    var obj: structB!
}

struct structB {
    var intNum: Int = Int.zero
    
}

protocol TestProtocol {
    func test()
}

extension TestProtocol {
    func test() {
        print("Testing Extension")
    }
    
    func test01() {
        print("Testing Protocol Extension Method")
    }
}

struct TestingProtocolStruct: TestProtocol {
    func test() {
        print("Overriden in Struct")
    }
    
     
}

final class TestFinalClass: TestProtocol {
    
}

extension TestFinalClass {
    func test() {
        //
    }
}
