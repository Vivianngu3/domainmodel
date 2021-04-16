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
    public var amount : Int
    public var currency : String
    private var exchanges = ["USD": 1.0, "GBP": 0.5, "EUR" : 1.5, "CAN" : 1.25]

    init(amount: Int, currency : String) {
        if !exchanges.keys.contains(currency) {
            print("Invalid Currency")
            self.amount = 0
            self.currency = " "
        } else {
            self.amount = amount
            self.currency = currency
        }
    }

    public func convert(_ to: String) -> Money {
        let result = Int(Double(self.amount) / self.exchanges[self.currency]! * self.exchanges[to]!)
        return Money(amount: result, currency: to)
    }
    
    public func add(_ to: Money) -> Money {
        let selfGiven = self.convert(to.currency)
        let toAmount = to.amount + selfGiven.amount
        return Money(amount: toAmount, currency: to.currency)
    }
    
    public func subtract(_ from: Money) -> Money {
        let selfGiven = self.convert(from.currency)
        let toAmount = from.amount - selfGiven.amount
        return Money(amount: toAmount, currency: from.currency)
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
    
    public func raise(byAmount: Double) {
        switch self.type {
            case .Hourly(let wage):
                self.type = JobType.Hourly(wage + byAmount)
            case .Salary(let salary):
                self.type = JobType.Salary(salary + UInt(round(byAmount)))
            }
    }
    
    public func raise(byAmount: Int) {
        switch self.type {
            case .Hourly(let wage):
                self.type = JobType.Hourly(wage + Double(byAmount))
            case .Salary(let salary):
                self.type = JobType.Salary(salary + UInt(byAmount))
            }
    }
    
    public func raise(byPercent: Double) {
        switch self.type {
        case .Hourly(let wage):
            self.type = JobType.Hourly(wage + (wage * byPercent))
        case .Salary(let salary):
            self.type = JobType.Salary(salary + UInt(round(Double(salary) * byPercent)))
        }
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

