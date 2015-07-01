# [fit] What's new in
# [fit] *Swift 2.0*
## [fit] by **Francesco Perrotti-Garcia**

---

![left](gravatar.jpg)

# [fit] *Francesco* 
# [fit] *Perrotti-Garcia*
# [fit] iOS Developer
# [fit] **_@fpg1503_**
# [fit] *PlayKids* - Movile

---
![](movile.jpg)

---
![](playkids.png)

---
# Swift 2.0

---
![fit](chris.gif)

# Open Source

---

# [fit] What's new in Swfit
# Session 106 - 2015

---

# [fit] Bacon
![](bacon.png)


---

# Analytics

``` swift
func myAnalyticsLogger<T>(value: T) {
    print(value)
}
```

# Estado da Comida

``` swift
enum FoodState {
    case Raw, Fried, Cooked(Cooker)
}
```

---

# [fit] Mas, o que é um 
# [fit] *Cooker*?

---

# Cooker

``` swift
enum Cooker : CookerType {
    case Oven, Microwave, Stove
}
```

# CookerType
``` swift
protocol CookerType {
    func cook(Food)
}
```

---

# Meu primeiro *Cooker*

``` swift
extension Cooker {
    func cook(food: Food) {
        food.state = .Cooked(self)
        myAnalyticsLogger("Just cooked a \(food.state)\
        \(food.name) using a \(self)")
    }
}
```

---

# Comida 

``` swift
class Food {
    var state: FoodState
    var name: String

    init(name: String, state: FoodState) {
        self.name = name
        self.state = state

        myAnalyticsLogger("Just created a \(state) \(name)")
    }
}
```

---

# [fit] Podemos criar 
# [fit] *Bacon*!

---
# Bacon

``` swift
class Bacon : Food {
    let tasty = true
}
```

# Meu bacon

``` swift
let myBacon = Bacon(name: "🐽", state: .Raw)
//Just created a FoodState.Raw 🐽
```

--- 

# [fit] ❤️

---

# Enums

- Reflection
- Carregam representação textual
- `Either<T1, T2>` funciona 
- Podem ser recursivos (no more `Box`es)
- `indirect`

---

# Enums recursivos

## Futuramente

``` swift
enum Tree<T> {
	case Leaf(T)
	inidirect case Node(Tree, Tree)
}
```

## Pull Requests are welcome :)

---

# Escopos arbitrários

``` swift
do {
    let myTemporaryMicrowave = Cooker.Microwave
    
    var myTemporaryBacon = Bacon(name: "bacon", state: .Raw)
    
    myTemporaryMicrowave.cook(myTemporaryBacon)
}

//myTemporaryBacon não existe mais


```

## Consigo restringir mutabilidade 

---

# Outras mudanças

Antes: `do {} while`
Agora: `repeat{} while`

- Options sets funcionam como tipos nativos!

---
# Melhorias compilador

- Funções e métodos
- Novos warnings
- `var` --> `let`
- Ignorar resultado de método funcional

---

# Melhorias para teste

- Adição de `@testable`

# Documentação

- Suporte a Markdown

---

# Cooker Melhorado 
## Guard statements + pattern matching!

``` swift
extension Cooker {
    func cook(food: Food) {
        guard case .Raw = food.state else {
            myAnalyticsLogger("Attempted to cook \(food.state)\
            \(food.name) using \(self)")
            return
        }
        food.state = .Cooked(self)
        myAnalyticsLogger("Just cooked a \(food.state)\
        \(food.name) using a \(self)")
    }
}
```

---
# Pattern matching everywhere

- `guard case`
- `if case`
- `for case`


# Loops com filtro
- `for in... where filter`


---

# Melhorando Cooker
## Usando protocol extensions

``` swift
extension CookerType {
    func cook(food: Food) {
        guard case .Raw = food.state else {
            myAnalyticsLogger("Attempted to cook \(food.state)\
            \(food.name) using \(self)")
            return
        }
        food.state = .Cooked(self)
        myAnalyticsLogger("Just cooked a \(food.state)\
        \(food.name) using a \(self)")
    }
}
```

---

# Usando o protocolo em `FoodState`

``` swift
enum FoodState {
    case Raw, Fried, Cooked(CookerType)
}
```

---

# Criando um forno mais complexo

``` swift
struct Oven : CookerType {
    var temperature : Float
    var heatOn : Bool
    func turnOn() {
        self.heatOn = true
    }

    func turnOff() {
        self.heatOn = false
    }
}

```

---

# Criando um forno mais complexo (que funciona)

``` swift
struct Oven : CookerType {
    var temperature : Float
    var heatOn : Bool
    mutating func turnOn() {
        self.heatOn = true
    }

    mutating func turnOff() {
        self.heatOn = false
    }
}

```

---

``` swift 
struct Oven : CookerType {

	...

    mutating func cook(food: Food) {
        self.turnOn()
        guard case .Raw = food.state else {
            myAnalyticsLogger("Attempted to cook \(food.state)\
             \(food.name) using \(self)")
            return
        }
        food.state = .Cooked(self)
        myAnalyticsLogger("Just cooked a \(food.state) \(food.name) using a\
        \(self) at \(temperature) degrees")
        self.turnOff()
    }
}
```

---

# `Defer`
# [fit] ou como não colocar fogo na casa

``` swift 
struct Oven : CookerType {

	...

    mutating func cook(food: Food) {
        self.turnOn()
        defer {
            self.turnOff()
        }

        guard case .Raw = food.state else {
            myAnalyticsLogger("Attempted to cook \(food.state)\
             \(food.name) using \(self)")
            return
        }
        food.state = .Cooked(self)
        myAnalyticsLogger("Just cooked a \(food.state) \(food.name) using a\
        \(self) at \(temperature) degrees")
    }
}
```
---

# Availability

## Antes
`respondsToSelector`

- descobrir selector (Objective-C)
- não seguro
- pode dar falso positivo

---

# Availability

## Agora

- compilador checa
- estático
- lindo

`#available(iOS 9.0, *)`

---

# Protocol Extensions

- extremamente poderoso
- funcional mais natural
- protocol-oriented programming

--- 

# [fit] Protocol Oriented Programming in Swift
# Session 408 - 2015

---

# Error handling

- Erros triviais --> `Optional`s
- Erros irrecuperáveis --> `throw`
- *Erros não devem ser ignorados*
- Chega de `error:nil`

---

# Error handling

- `try`
- `do {} catch`
- `try!`
- `NSError` conforms com `ErrorType`
- leves

---

# [fit] *Obrigado*
# Dúvidas?

github.com/fpg1503/Presentations