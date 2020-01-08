# Exercises

A <- c(1, 2, 3)
B <- c(4, 5, 6)

> m <- rbind(A, B)
> m
  [,1] [,2] [,3]
A    1    2    3
B    4    5    6

> n <- cbind(A, B)
> n
     A B
[1,] 1 4
[2,] 2 5
[3,] 3 6

> j <- matrix(1:9, byrow = T,  nrow = 3)
> j
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    4    5    6
[3,]    7    8    9

> j <- matrix(1:9, byrow = F, nrow = 3)
> j
     [,1] [,2] [,3]
[1,]    1    4    7
[2,]    2    5    8
[3,]    3    6    9

> is.matrix(j)
[1] TRUE

> l <- matrix(1:25, by-km row = T, nrow = 5)
> l
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    2    3    4    5
[2,]    6    7    8    9   10
[3,]   11   12   13   14   15
[4,]   16   17   18   19   20
[5,]   21   22   23   24   25

# From row 2 to 3, from colum 2 to 3
> z <- l[2:3, 2:3]
> z
     [,1] [,2]
[1,]    7    8
[2,]   12   13

# Sum of all elements
> sum(l)
[1] 325