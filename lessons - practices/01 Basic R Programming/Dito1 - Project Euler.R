library(numbers)
prime <- 600851475143
factor <- primeFactors(prime)
max(factor)

get_prime_factor <- function(n){
  numvec<- numeric()
  if (n>=2) {
    while(n%%2==0){
      numvec<- c(numvec,2)
      n = n/2
    }
  i = 3
  while(n!=1){
    while(n%%i == 0){
      numvec<- c(numvec,i)
      n=n/i
    }
    i=i+2
  }
  print(numvec)
  }
  else stop("masukkan bilangan yang lebih besar")
}

hasil <- get_prime_factor(prime)
max(hasil)
