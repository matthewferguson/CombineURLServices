import UIKit





var greeting = "Hello, playground"
//let word = "kayak"
checkPalindrome(word: "kayak")

func checkPalindrome(word: String)->Bool
{
    var word2 = word
    print(word2)
    print(word2.first!)
    print(word2.last!)
    print(word2.count)
    if(word2 == "" || word2.count == 1){
        return true
    } else {
        if word2.first == word2.last {
            
            word2.remove(at: word2.index(before: word2.endIndex))
            word2.remove(at: word2.index(before: word2.startIndex))
            //word2 = word2.dropFirst()
            //word2 = word2.removeLas()
            print(word2)
            return true
            //return checkPalindrome(word: word2)
        }
        else {
           return false
        }
    }
}
