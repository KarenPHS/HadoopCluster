// Functions
// function definition
def functionToAdd(a:Int, b:Int) : Int = { 
    var sum:Int = 0
    sum = a + b 

    // returning the value of sum 
    return sum 
} 

functionToAdd(5,3)

def DataCounts(i: Int) { 
    var total: Int = 0
    var times3: Int = 0
    
    total = i + i
    times3 = i * 3
    
    println(s"${i} + ${i} = ${total}") 
    println(s"${i} * 3 = ${times3}") 
} 

// function call 
DataCounts(5)  
