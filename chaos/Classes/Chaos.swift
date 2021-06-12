
import Foundation

@objc open class Chaos: NSObject {
    /**
      模糊搜索
     - Parameter needle: 搜索词
     - Parameter haystack: 源数据
     - Returns: Bool
    */
    @objc open class func search(needle: String, haystack: String) -> Bool {
        guard !needle.isEmpty else {
            return false
        }
        guard !haystack.isEmpty else {
            return false
        }
        guard needle.count <= haystack.count else {
            return false
        }
      
        if needle == haystack {
            return true
        }
        if haystack.contains(needle) {
            return true
        }
        if haystack.compare(needle, options: [.caseInsensitive, .diacriticInsensitive], range: haystack.startIndex ..< haystack.endIndex, locale: nil) == .orderedSame {
            return true
        }
        var needleIdx = needle.startIndex
        var haystackIdx = haystack.startIndex
      
        while needleIdx != needle.endIndex {
            if haystackIdx == haystack.endIndex {
                return false
            }
            if needle[needleIdx] == haystack[haystackIdx] {
                needleIdx = needle.index(after: needleIdx)
            }
            haystackIdx = haystack.index(after: haystackIdx)
        }
      
        return true
    }

    /**
     模糊匹配
     
     when fuzziness is 0 , fuzziness disabled.
     - Parameter needle: 匹配词
     - Parameter haystack: 源数据
     - Parameter fuzziness: 模糊度 (0-1)
     - Returns:  Bool
    */
    @objc open class func match(needle: String, haystack: String, fuzziness: Double = 0) -> Bool {
        return haystack.score(word: needle, fuzziness: fuzziness) != 0
    }
}

private extension String {
    func charAt(_ i: Int) -> Character {
        let index = self.index(self.startIndex, offsetBy: i)
        return self[index]
    }
  
    func charStrAt(_ i: Int) -> String {
        return String(self.charAt(i))
    }
}

extension String {
    /**
       Score of 0 for no match; up to 1 for perfect. "String".score(word:"str"); //=> 0.825
     - Parameter word: 关键词
     - Parameter fuzziness: 模糊度
     - Returns:  匹配评分数 (0-1)
     */
    public func score(word: String, fuzziness: Double = 0) -> Double {
        // If the string is equal to the word, perfect match.
        if self == word {
            return 1
        }
    
        // if it's not a perfect match and is empty return 0
        if word.isEmpty || self.isEmpty {
            return 0
        }
    
        var runningScore = 0.0
        var charScore = 0.0
        var finalScore = 0.0
    
        let string = self
        let lString = string.lowercased()
        let strLength = lString.count
        let lWord = word.lowercased()
        let wordLength = word.count
    
        var idxOf: String.Index!
        var startAt = lString.startIndex
        var fuzzies = 1.0
        var fuzzyFactor = 0.0
        var fuzzinessIsDisabled = true
    
        // Cache fuzzyFactor for speed increase
        if fuzziness > 0 {
            fuzzyFactor = 1 - fuzziness
            fuzzinessIsDisabled = false
        }
    
        for i in 0 ..< wordLength {
            // Find next first case-insensitive match of word's i-th character.
            // The search in "string" begins at "startAt".
      
            if let range = lString.range(
                of: lWord.charStrAt(i),
                options: [.caseInsensitive, .diacriticInsensitive],
                range: startAt ..< lString.endIndex,
                locale: nil
            ) {
                // start index of word's i-th character in string.
                idxOf = range.lowerBound
        
                if startAt == idxOf {
                    // Consecutive letter & start-of-string Bonus
                    charScore = 0.7
                }
                else {
                    charScore = 0.1
          
                    // Acronym Bonus
                    // Weighing Logic: Typing the first character of an acronym is as if you
                    // preceded it with two perfect character matches.
                    if lString[lString.index(before: idxOf)] == " " {
                        charScore += 0.8
                    }
                }
            }
            else {
                // Character not found.
                if fuzzinessIsDisabled {
                    // Fuzziness is nil. Return 0.
                    return 0
                }
                else {
                    fuzzies += fuzzyFactor
                    continue
                }
            }
      
            // Same case bonus.
            if lString[idxOf] == word[word.index(word.startIndex, offsetBy: i)] {
                charScore += 0.1
            }
      
            // Update scores and startAt position for next round of indexOf
            runningScore += charScore
            startAt = lString.index(after: idxOf)
        }
    
        // Reduce penalty for longer strings.
        finalScore = 0.5 * (runningScore / Double(strLength) + runningScore / Double(wordLength)) / fuzzies
    
        if finalScore < 0.85,
            lWord.charStrAt(0).compare(lString.charStrAt(0), options: .diacriticInsensitive) == .orderedSame
        {
            finalScore += 0.15
        }
    
        return finalScore
    }
}
