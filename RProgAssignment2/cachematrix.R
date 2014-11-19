## R Programming: Assignment 2
## Louise Crooks, 11/18/2014
## Caching the Inverse of a Matrix

## creates a special matrix object that can cache its inverse
## sample usage: 
## m <- matrix(sample.int(4, size = 2*2, replace=TRUE), nrow = 2, ncol=2)
## m4 <- makeCacheMatrix(m)
## m; cacheSolve(m4)

makeCacheMatrix <- function(x = matrix()) {
    slv <- NULL
    set <- function(y) {
      x <<- y
      slv <<- NULL
    }
    get <- function() x
    setInv <- function(inv) slv <<- inv
    getInv <- function() slv
    list(set = set, get = get,
         setInv = setInv,
         getInv = getInv)
}

## computes the inverse of the special matrix returned by 
## makeCacheMatrix. If the inverse has already been calculated, the 
## function retrives the inverse from the cache. 
## inverse uses the 'solve' function in R
## assumes that the matrix supplied is invertible.

cacheSolve <- function(x, ...) {
  slv <- x$getInv()
  if(!is.null(slv)) {
    message("getting cached data")
    return(slv)
  }
  dta <- x$get()
  slv <- solve(dta, ...)
  x$setInv(slv)
  slv
}

