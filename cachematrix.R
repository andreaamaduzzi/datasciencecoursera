## This function calculate the inverse matrix of X and cache it.
## If you try to make a new inverse martrix of XX, that is 
## identical to X, it gives you back the inverse matrix cached,
## otherwise it solve.

## The first function, makeCacheMatrix creates a special "matrix"
## object that can cache its inverse

## 1- set the value of the matrix (x) and of the inverse
##    matrix (im)
## 2- get the value of the matrix (x) cached
## 3- set the value of the inverse matrix (im)
## 4- get the value of the inverse matrix (im)

makeCacheMatrix <- function(x = matrix()) {
    
    im <- NULL
    
    set_matrix <- function(y) {
        x <<- y
        im <<- NULL
    }
    get_matrix <- function() {x}
    set_invmatrix <- function(invmatrix) {im <<- invmatrix}
    get_invmatrix <- function() {im}
    
    a <- list(set_matrix = set_matrix, get_matrix = get_matrix,
              set_invmatrix = set_invmatrix, 
              get_invmatrix = get_invmatrix)
    
} 



## the cacheSolve function computes the inverse of the special 
## "matrix" returned by makeCacheMatrix above. If the inverse has 
## already been calculated (and the matrix has not changed), then
## the cachesolve should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
    
    
    om <- x$get_matrix()
    im <- x$get_invmatrix()
    
    if(identical(x,om)) {
        
        message("getting cached matrix")
        return(im)
        
    } else{
        
        im <- solve(x, ...)
        
        x$set_matrix(x)
        x$set_invmatrix(im)
        
        im
        
    }
    
}




