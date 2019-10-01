import UIKit


//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Look at data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
//:
//: a. Use an `enum` type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//:
//: b. Use a struct to represent an `Airport` (Destination or Arrival)
//:
//: c. Use a struct to represent a `Flight`.
//:
//: d. Use a `Date?` for the departure time since it may be canceled.
//:
//: e. Use a `String?` for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
//:
//: f. Use a class to represent a `DepartureBoard` with a list of departure flights, and the current airport

enum FlightStatus: String {
    case enRoute = "En Route"
    case scheduled = "Scheduled"
    case canceled = "Canceled"
    case delayed = "Delayed"
    case landed = "Landed"
    case boarding = "Boarding"
}

struct Airport {
    let name: String
    let city: String
}

struct Flight {
    let departureTime: Date?
    let terminal: String?
    let destination: Airport
    let status: FlightStatus
}

let jfk = Airport(name: "JFK", city: "New York")

class DepartureBoard {
    var airport = jfk
    var departureFlights: [Flight] = []
    
    func alertPassengers() {
        
        for flight in departureFlights {
            if let departureTime = flight.departureTime {
            switch flight.status {
            case .canceled:
                print("Were sorry your flight to \(flight.destination.city) was canceled, here is a $500 voucher")
            case .boarding:
                print("Your flight is boarding, please head to terminal: \(flight.terminal ?? "TBD")")
            case .scheduled:
                print("Your flight to \(flight.destination.city) is scheduled to depart at \(departureTime) from terminal \(flight.terminal ?? "TBD")")
            case .landed:
                print("Your flight has landed")
            case .enRoute:
                print("Your flight is En Route")
            default:
                print("Your flight is delayed")
        }
            } else {
                switch flight.status {
                    case .canceled:
                        print("Were sorry your flight to \(flight.destination.city) was canceled, here is a $500 voucher")
                    case .boarding:
                        print("Your flight is boarding, please head to terminal: \(flight.terminal ?? "TBD")")
                    case .scheduled:
                        print("Your flight to \(flight.destination.city) is scheduled to depart at TBD from terminal \(flight.terminal ?? "TBD")")
                    case .landed:
                        print("Your flight has landed")
                    case .enRoute:
                        print("Your flight is En Route")
                    default:
                        print("Your flight is delayed")
                }
                
            }
}
}
}
//: ## 2. Create 3 flights and add them to a departure board
//: a. For the departure time, use `Date()` for the current time
//:
//: b. Use the Array `append()` method to add `Flight`'s
//:
//: c. Make one of the flights `.canceled` with a `nil` departure time
//:
//: d. Make one of the flights have a `nil` terminal because it has not been decided yet.
//:
//: e. Stretch: Look at the API for [`DateComponents`](https://developer.apple.com/documentation/foundation/datecomponents?language=objc) for creating a specific time
let roc = Airport(name: "ROC", city: "Rochester")
let mvy = Airport(name: "MNY", city: "Martha's Vineyard")
let btv = Airport(name: "BTV", city: "Burlington")

let flight1 = Flight(departureTime: Date(), terminal: "5", destination: roc, status: .scheduled)
let flight2 = Flight(departureTime: nil, terminal: "6", destination: mvy, status: .canceled)
let flight3 = Flight(departureTime: Date(), terminal: nil, destination: btv, status: .scheduled)

let DBoard = DepartureBoard()

DBoard.departureFlights.append(flight1)
DBoard.departureFlights.append(flight2)
DBoard.departureFlights.append(flight3)
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function

func printDepartures(departureBoard: DepartureBoard) {
    
    for flight in departureBoard.departureFlights {
        
        if let unwrappedTime = flight.departureTime {
            
            if let unwrappedTerminal = flight.terminal {
                print("Date: \(unwrappedTime) Terminal: \(unwrappedTerminal)   Destination: \(flight.destination.city) -- Status: \(flight.status.rawValue) ")
            } else {
                print("Date: \(unwrappedTime) Terminal: TBD Destination: \(flight.destination.city) -- Status: \(flight.status.rawValue) ")
            }
            
        } else if let unwrappedTerminal1 = flight.terminal {
            print("Date: TBD                       Terminal: \(unwrappedTerminal1)   Destination: \(flight.destination.city) -- Status: \(flight.status.rawValue) ")
        } else {
            print("Date:   Terminal:   Destination: \(flight.destination.city) -- Status: \(flight.status.rawValue) ")
        }
    }
}

printDepartures(departureBoard: DBoard)
//: ## 4. Make a second function to print print an empty string if the `departureTime` is nil
//: a. Createa new `printDepartures2(departureBoard:)` or modify the previous function
//:
//: b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//:
//: c. Call the new or udpated function. It should not print `Optional(2019-05-30 17:09:20 +0000)` for departureTime or for the Terminal.
//:
//: d. Stretch: Format the time string so it displays only the time using a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter) look at the `dateStyle` (none), `timeStyle` (short) and the `string(from:)` method
//:
//: e. Your output should look like:
//:
//:     Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: 4 Status: Canceled
//:     Destination: Rochester Airline: Jet Blue Airways Flight: B6 586 Departure Time: 1:26 PM Terminal:  Status: Scheduled
//:     Destination: Boston Airline: KLM Flight: KL 6966 Departure Time: 1:26 PM Terminal: 4 Status: Scheduled

//^^

//: ## 5. Add an instance method to your `DepatureBoard` class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a `switch` on the flight status variable.
//: a. If the flight is canceled print out: "We're sorry your flight to \(city) was canceled, here is a $500 voucher"
//:
//: b. If the flight is scheduled print out: "Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)"
//:
//: c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
//:
//: d. If the `departureTime` or `terminal` are optional, use "TBD" instead of a blank String
//:
//: e. If you have any other cases to handle please print out appropriate messages
//:
//: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
//:
//: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.


DBoard.alertPassengers()

//: ## 6. Create a free-standing function to calculate your total airfair for checked bags and destination
//: Use the method signature, and return the airfare as a `Double`
//:
//:     func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
//:     }
//:
//: a. Each bag costs $25
//:
//: b. Each mile costs $0.10
//:
//: c. Multiply the ticket cost by the number of travelers
//:
//: d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
//:
//: e. Make sure to cast the numbers to the appropriate types so you calculate the correct airfare
//:
//: f. Stretch: Use a [`NumberFormatter`](https://developer.apple.com/documentation/foundation/numberformatter) with the `currencyStyle` to format the amount in US dollars.

func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    let costOfBags = Double(checkedBags) * 25.00
    let costOfDistance = Double(distance) * 0.1
    let totalCost = Double(travelers) * (costOfBags + costOfDistance)
    return totalCost
}

print(calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3))

