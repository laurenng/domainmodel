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
    
    var amount: Double
    var currency: String
    
    init(_ total: Int, _ type: String) {
        if (type == "USD" || type == "GBP" || type == "EUR" || type == "CAN") {
            amount = Double(total)
            currency = type
        } else {
            amount = 0
            currency = "Null"
        }
    }
    
    mutating func convert(_ newCurrency: String) {
        let newAmount = USD_to_EUR(amount)
        print("CHANGING US TO EUR")
        amount = newAmount
        currency = newCurrency
    }
    
    func add() {
        
    }
    
    func subtract() {
        
    }
    
    func USD_to_GBP(_ n: Double) -> Double {
        print("CHANGING US TO GBP")
        return 0.5 * n
    }
    
    func USD_to_EUR(_ n: Double) -> Double{
        print("CHANGING US TO EUR")
        return 1.5 * n
    }
    
    func USD_to_CAN(_ n: Double) -> Double{
        print("CHANGING US TO CAN")
        return 1.25 * n
    }
}

let laurenMoney = Money(10, "USD")


////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
}

////////////////////////////////////
// Person
//
public class Person {
}

////////////////////////////////////
// Family
//
public class Family {
}
