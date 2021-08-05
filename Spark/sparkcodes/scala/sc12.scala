// Control flow
// declare three variables 
var a: Int = 80
var b: Int = 50
var c: Int = 100

// condition_1 
if (a > b)
{ 
    // condition_2 
    if (a > c) 
    { 
        println("a is largest")
    } 
    else
    { 
        println("c is largest")
    } 
} 

var a = 5
// loop execution 
while (a > 0) 
{ 
    println("a is : " + a) 
    a -= 1 
}

var a = 5 
// loop execution 
do
{ 
    println("a is : " + a) 
    a -= 1 
} while (a > 0) 

val ranklist = List(1, 2, 3, 4, 5) 

// For loop with collection 
for( rank <- ranklist){ 
    println("Book rank is : " +rank); 
} 
