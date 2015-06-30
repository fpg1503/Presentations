//: Playground - noun: a place where people can play

import UIKit

func myAnalyticsLogger<T>(value: T) {
    print(value)
}

class Food {
    var state: FoodState
    var name: String

    init(name: String, state: FoodState) {
        self.name = name
        self.state = state

        myAnalyticsLogger("Just created a \(state) \(name)")
    }
}

protocol CookerType {
    func cook(Food)
}

/*
enum Cooker : CookerType {
    case Oven, Microwave, Stove
}*/

/*
extension Cooker {
    func cook(food: Food) {
        food.state = .Cooked(self)
        myAnalyticsLogger("Just cooked a \(food.state) \(food.name) using a \(self)")
    }
}
*/

/*
enum FoodState {
    case Raw, Fried, Cooked(Cooker)
}*/

class Bacon : Food {
    let tasty = true
}

let myBacon = Bacon(name: "🐽", state: .Raw)
//Just created a FoodState.Raw 🐽

/*let myOven = Cooker.Oven

myOven.cook(myBacon)*/


//Indirect enums

/*enum Tree<T> {
	case Leaf(T)
	inidirect case Node(Tree, Tree)
}*/

/*
do {
    let myTemporaryMicrowave = Cooker.Microwave
    
    var myTemporaryBacon = Bacon(name: "bacon", state: .Raw)
    
    myTemporaryMicrowave.cook(myTemporaryBacon)
}*/

//myTemporaryBacon não existe mais


var i = 0

/*
do {
 i++;
} while (i < 100)
*/

//vira

repeat {
    i++
} while (i < 100)

extension CookerType {
    func cook(food: Food) {
        guard case .Raw = food.state else {
            myAnalyticsLogger("Attempted to cook \(food.state) \(food.name) using \(self)")
            return
        }
        food.state = .Cooked(self)
        myAnalyticsLogger("Just cooked a \(food.state) \(food.name) using a \(self)")
    }
}

//Criando um forno mais complexo

enum FoodState {
    case Raw, Fried, Cooked(CookerType)
}

/*
struct Oven : CookerType {
    var temperature : Float
    var heatOn : Bool
    mutating func turnOn() {
        self.heatOn = true
    }

    mutating func turnOff() {
        self.heatOn = false
    }

    mutating func cook(food: Food) {
        self.turnOn()
        guard case .Raw = food.state else {
            myAnalyticsLogger("Attempted to cook \(food.state) \(food.name) using \(self)")
            return
        }
        food.state = .Cooked(self)
        myAnalyticsLogger("Just cooked a \(food.state) \(food.name) using a \(self) at \(temperature) degrees")
        self.turnOff();
    }
} */

/*
struct Oven : CookerType {
    var temperature : Float
    var heatOn : Bool
    mutating func turnOn() {
        self.heatOn = true
    }

    mutating func turnOff() {
        self.heatOn = false
    }

    mutating func cook(food: Food) {
        self.turnOn()
        defer {
            self.turnOff()
        }

        guard case .Raw = food.state else {
            myAnalyticsLogger("Attempted to cook \(food.state) \(food.name) using \(self)")
            return
        }
        food.state = .Cooked(self)
        myAnalyticsLogger("Just cooked a \(food.state) \(food.name) using a \(self) at \(temperature) degrees")
    }
}*/


