import UIKit

protocol HomeworkService {
    // Функция деления с остатком, должна вернуть в первой части результат деления, во второй части остаток.
    func divideWithRemainder(_ x: Int, by y: Int) -> (Int, Int)

    // Функция должна вернуть числа фибоначчи.
    func fibonacci(n: Int) -> [Int]

    // Функция должна выполнить сортировку пузырьком.
    func sort(rawArray: [Int]) -> [Int]

    // Функция должна преобразовать массив строк в массив первых символов строки.
    func firstLetter(strings: [String]) -> [Character]

    // Функция должна отфильтровать массив по условию, которое приходит в параметре `condition`. (Нельзя юзать `filter` у `Array`)
    func filter(array: [Int], condition: ((Int) -> Bool)) -> [Int]
}

// MARK: №1

struct HomeWorkServiceStruct : HomeworkService {
    
    func fibonacci(n: Int) -> [Int] {
        var ret : [Int] = [0, 1]
        if n == 0 {
            return [0]
        }
        else if n == 1 {
            return ret
        }
        for i in 2...n {
            ret.append(ret[i - 1] + ret[i - 2])
        }
        return (ret)
    }

    func sort(rawArray: [Int]) -> [Int] {
        var ret : [Int] = rawArray

        for _ in 0...ret.count {
            for j in 1..<ret.count {
                if ret[j - 1] > ret[j] {
                    ret.swapAt(j - 1, j)
                }
            }
        }
        return ret
    }

    func firstLetter(strings: [String]) -> [Character] {
        var ret : [Character] = []
        
        for string in strings {
            ret.append(string.first ?? Character("_"))
        }
        return ret
    }
    
    func filter(array: [Int], condition: ((Int) -> Bool)) -> [Int] {
        var ret : [Int] = []
        for i in 0..<array.count {
            if (condition(array[i])) {
                ret.append(array[i])
            }
        }
        return ret
    }
    
    func divideWithRemainder(_ x: Int, by y: Int) -> (Int, Int) {
        guard y != 0 else {
            print("NO!!!!")
            fatalError()
        }
        let res : Int = x / y
        let rem = x % y
        return(res, rem)
    }
}

//let en = HomeWorkServiceStruct()
//print(en.divideWithRemainder(8, by: 3))
//print(en.fibonacci(n: 0))
//print(en.firstLetter(strings: ["Hello", "World", "some", ""]))
//print(en.filter(array: [1, 2, 3, 4, 5, 6, 7, 8, 9 , 10], condition: {x in
//    return x % 2 == 0
//}))
//print(en.sort(rawArray: [9, 10, 15, 1, 2, 3 , 66, 15]))

// MARK: №2

class Author {
    private var name : String = "Author"
    private var description : String = "Description"
    
    func getName() -> String{
        return name
    }
}

class Book{
    private var author : Author
    private var title : String
    private var subject : String
    private var language : String = "eng"
    private var numOfPages : Int = 0
    
    init(author : Author, title : String, subject : String, lang : String, numOfPages : Int) {
        self.title = title
        self.subject = subject
        self.language = lang
        self.numOfPages = numOfPages
        self.author = author
    }
    
    func getTitle() -> String {
        return title
    }
}

class BookItem : Book {
    private var barcode : String
    private var price : Double
    public var status : Bool
    private let booklending : BookLending
    
    init(author : Author, title : String, subject : String, lang : String, numOfPages : Int, barcode : String, price : Double, booklending : BookLending) {
        self.barcode = barcode
        self.price = price
        self.booklending = booklending
        self.status = true
        super.init(author: author, title: title, subject: subject, lang: lang, numOfPages: numOfPages)
    }
}

struct LibraryCard {
    private var cardNumber : Int
    private var issuedAt : Date
    private var active : Bool
    
    init(cardNumber : Int, issuedAt : Date){
        self.cardNumber = cardNumber
        let calendar = Calendar.current
        let dateComp = DateComponents(calendar: calendar, year: calendar.component(.year, from: Date()) + 3)
        self.issuedAt = calendar.date(from: dateComp) ?? Date()
        self.active = true
    }
    
    func isActive() -> Bool {
        return active
    }
}

class User {
    private var id : Int
    private var name : String
    private var email : String
    
    init(id: Int, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
    
    func verify() -> Bool {
        if id != 0 && name != "Username" && email != "username@domain.com" {
            return true
        }
        return false
    }
    
    func printAccountData() {
        print("ID: \(id)\nNAME: \(name)\nEMAIL: \(email)")
    }
}

class Librearian : User {
    private var books : [BookItem] = []
    private var libraryCard : LibraryCard?
    
    override init(id: Int, name: String, email: String) {
        super.init(id: id, name: name, email: email)
    }
    

    func addBookItem(book : BookItem) -> Bool {
        books.append(book)
        return true
    }
    
    func hasLibCard() -> Bool {
        
        if libraryCard != nil && ((libraryCard?.isActive()) != nil){
            return true
        }
        return false
    }
}

struct Catalog {
    public var creationDate : Date
    public var totalBooks : Int
    public var bookTitles : Dictionary<String, Array<String>>
    public var bookAuthors : Dictionary<String, Array<String>>
    public var bookSubjects : Dictionary<String, Array<String>>
}

struct BookLending {
    var creationDate : Date
    var dueDate : Date
    var returnDate : Date
}

enum Subjects {
    case ActionAndAdventure
    case ComicBook
    case Detective
    case Mystery
    case Fantasy
    case HistoricalFiction
    case Horror
    case LiteraryFiction
    case Romance
    case SciFi
    case Suspense
}

enum dueDates {
    case oneweek
    case twoWeeks
    case month
    case twoMonths
    case eduYear
}


