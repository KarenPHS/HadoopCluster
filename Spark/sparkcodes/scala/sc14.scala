// Functions
// lambda expression 
val ex1 = (x:Int) => x + 2

// with multiple parameters 
val ex2 = (x:Int, y:Int) => x * y 

ex1(7)
ex2(2, 3) 

// list of numbers 
val lst = List(1, 1, 2, 3, 5, 8) 

// squaring each element of the list 
val res = lst.map( (x:Int) => x * x ) 

// alternative version
//val res = lst.map( x=> x * x ) 

println(res) 
