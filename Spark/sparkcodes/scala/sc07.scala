// Array
val numbers = Array(1, 2, 3, 4)

// read the first element
val first = numbers(0)

// replace the 4th array element with 100
numbers(3) = 100 
numbers

// Using tuple format to get array data 
val arr = Array("Hello", "World", "Scala", "Spark")
(arr(0),arr(3))

// Creating the array of 2 rows and 2 columns 
val myarr= Array.ofDim[Int](2, 2) 

// Assigning the values 
myarr(0)(0) = 2                 
myarr(0)(1) = 7
myarr(1)(0) = 3
myarr(1)(1) = 4

myarr

// Creating 2D-array with initailization
var myarr2 = Array(Array(0, 2, 4, 6, 8), 
                   Array(1, 3, 5, 7, 9))

myarr2(1)

myarr2(1)(3)
