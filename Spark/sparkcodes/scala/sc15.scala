// Functions
def transform(x:Int, func:Int => Double) : Double = {
    return func(x) 
}

// lambda is passed to func:Int => Double 
val res = transform(2, r => 3.14 * r * r) 
println(res) 
