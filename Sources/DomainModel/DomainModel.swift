import Foundation

struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    public var amount: Int
    public var currency: String

    init(amount total: Int, currency type: String)  {
        if (total > 0 && (type == "USD" || type == "GBP" || type == "EUR" || type == "CAN")) {
            amount = total
            currency = type
        } else {
            amount = 0
            currency = "USD"
        }
    }
    
    private let exchangeRate = ["GBP": 0.5, "EUR": 1.5, "CAN": 1.25, "USD": 1.0]
    
    public func convert(_ to: String) -> Money {
        var value: Money = Money(amount: 0, currency: "USD")
        if (to == "USD" || to == "GBP" || to == "EUR" || to == "CAN") {
            if (self.currency == to) {
                return self
            }
            
            var currentValue: Double = Double(self.amount)
            
            currentValue = Double(currentValue / exchangeRate[self.currency]!)
            currentValue = Double(currentValue * exchangeRate[to]!)
            
            value.amount = Int(round(currentValue))
            value.currency = to
            return value
        } else {
            return value
        }
    }

    public func add(_ to: Money) -> Money {
        let selfInGiven = self.convert(to.currency)
        let totAmount: Int = to.amount + selfInGiven.amount
        return Money(amount: totAmount, currency: to.currency)
    }

    public func subtract(_ from: Money) -> Money {
        let selfInGiven = self.convert(from.currency)
        let totAmount = from.amount - selfInGiven.amount
        return Money(amount: totAmount, currency: from.currency)
    }
}

////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    private var title: String
    private var type: JobType
    
    init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    
    public func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
            case .Hourly(let wage):
                return Int(round(wage * Double(hours)))
            case .Salary(let salary):
                return Int(salary)
        }
    }
    
    public func raise(byAmount: Double = 0, byPercent: Double = 0) {
        if (byAmount != 0) {
            switch self.type {
            case .Hourly(let wage):
                self.type = JobType.Hourly(wage + byAmount)
            case .Salary(let salary):
                self.type = JobType.Salary(salary + UInt(byAmount))
            }
        } else {
            switch self.type {
            case .Hourly(let wage):
                self.type = JobType.Hourly(wage + (wage * byPercent))
            case .Salary(let salary):
                self.type = JobType.Salary(salary + UInt(Double(salary) * byPercent))
            }
        }
        
    }
}

////////////////////////////////////
// Person
//
public class Person {
    public var firstName: String
    public var lastName: String
    public var age: Int
    public var job: Job? {
        didSet(oldVersion) {
            if age < 16 {
                job = nil
            }
        }
    }
    
    public var spouse: Person? {
        didSet(oldVersion) {
            if age < 16 {
                spouse = nil
            }
        }
    }
    
    init(firstName fn: String, lastName ln: String, age: Int) {
        self.firstName = fn
        self.lastName = ln
        self.age = age
    }
    
    func toString() -> String {
        let result: String  = String("[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]")
        return result
    } //
}

////////////////////////////////////
// Family
//
public class Family {
    public var members: [Person]
    
    init(spouse1: Person, spouse2: Person) {
        members = []
        if (spouse1.spouse == nil && spouse2.spouse == nil) {
            members.append(spouse1)
            members.append(spouse2)
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
        }
    }
    
    func haveChild(_ child: Person) -> Bool{
        var maxAge = 0
        for member in members {
            let currentAge = member.age
            if (currentAge > maxAge) {
                maxAge = currentAge
            }
        }
        if (maxAge > 21) {
            members.append(child)
            return true
        } else {
            return false
        }
    }
    
    func householdIncome() -> Int {
        var totalIncome = 0
        for member in members {
            let currJob = member.job
            if (currJob != nil) {
                let addition: Int = currJob!.calculateIncome(2000)
                totalIncome += Int(addition)
            }
            
        }
        return totalIncome
    }
}
