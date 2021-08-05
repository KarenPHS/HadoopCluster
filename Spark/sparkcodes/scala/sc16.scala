// Class
class Dog(breed: String) { 
    var br: String = breed 
        
    def bark() : String = {
        eat("meat")
        return "Woof woof!"
    }
    
    def legs = "Four"
    
    private def eat(food: String) : Unit = {
        println(s"I am eating $food") 

//    private def eat(food: String) {
//        println(s"I am eating $food") 
    }
}

val myDog = new Dog("Akita")

myDog.br
myDog.bark()
myDog.legs
