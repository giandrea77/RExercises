# Recreate the following dataframe by creating vectors and using the data.frame function:

> Age <- c(22, 25, 26)
> Weight <- c(150, 165, 120
> Sex <- c('M', 'M', 'F')
> df <- data.frame(Age, Weight, Sex)
> df
  Age Weight Sex
1  22    150   M
2  25    165   M
3  26    120   F

> row.names(df) <- c('Sam', 'Frank', 'Amy')
> df
      Age Weight Sex
Sam    22    150   M
Frank  25    165   M
Amy    26    120   F

# Alternative
df <- data.frame(row.names = c('Sam', 'Frank', 'Amy'), Age, Weight, Sex)

# Check if it is a data frame
> is.data.frame(df)
[1] TRUE

# Ex 3: Use as.data.frame() to convert a matrix into a dataframe:
# In [3]:
> mat <- matrix(1:25,nrow = 5)

> dfm <- data.frame(mat)

> dfm
  X1 X2 X3 X4 X5
1  1  6 11 16 21
2  2  7 12 17 22
3  3  8 13 18 23
4  4  9 14 19 24
5  5 10 15 20 25

> colnames(dfm) <- c('V1', 'V2', 'V3', 'V4', 'V5')

> dfm
  V1 V2 V3 V4 V5
1  1  6 11 16 21
2  2  7 12 17 22
3  3  8 13 18 23
4  4  9 14 19 24
5  5 10 15 20 25

# Alternative
> as.data.frame(mat)
  V1 V2 V3 V4 V5
1  1  6 11 16 21
2  2  7 12 17 22
3  3  8 13 18 23
4  4  9 14 19 24
5  5 10 15 20 25

# Ex 5: Display the first 6 rows of df
> dfc <- mtcars
> dfc[1:6, ]
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

# Ex 6: What is the average mpg value for all the cars?
> mean(dfc$mpg)
[1] 20.09062

# Ex 7: Select the rows where all cars have 6 cylinders (cyl column)
> subset(dfc, subset = cyl == 6)
                mpg cyl  disp  hp drat    wt  qsec vs am gear carb
Mazda RX4      21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag  21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
Hornet 4 Drive 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
Valiant        18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
Merc 280       19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
Merc 280C      17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
Ferrari Dino   19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6

# Ex 8: Select the columns am,gear, and carb.
> dfc[, c('am', 'gear', 'carb')]
                    am gear carb
Mazda RX4            1    4    4
Mazda RX4 Wag        1    4    4
Datsun 710           1    4    1
Hornet 4 Drive       0    3    1
Hornet Sportabout    0    3    2
Valiant              0    3    1
Duster 360           0    3    4
Merc 240D            0    4    2
Merc 230             0    4    2
Merc 280             0    4    4
Merc 280C            0    4    4
Merc 450SE           0    3    3
Merc 450SL           0    3    3
Merc 450SLC          0    3    3
Cadillac Fleetwood   0    3    4
Lincoln Continental  0    3    4
Chrysler Imperial    0    3    4
Fiat 128             1    4    1
Honda Civic          1    4    2
Toyota Corolla       1    4    1
Toyota Corona        0    3    1
Dodge Challenger     0    3    2
AMC Javelin          0    3    2
Camaro Z28           0    3    4
Pontiac Firebird     0    3    2
Fiat X1-9            1    4    1
Porsche 914-2        1    5    2
Lotus Europa         1    5    2
Ford Pantera L       1    5    4
Ferrari Dino         1    5    6
Maserati Bora        1    5    8
Volvo 142E           1    4    2

# Ex 9: Create a new column called performance, which is calculated by hp/wt.
> dfc$performance <- dfc$hp / dfc$wt

# Ex 10: Your performance column will have several decimal place precision. Figure out how to use round() (check help(round)) to reduce this accuracy to only 2 decimal places.
> dfc$performance <- round(dfc$performance, 2)

# Ex 10: What is the average mpg for cars that have more than 100 hp AND a wt value of more than 2.5.
> mean(dfc[dfc$hp > 100 & dfc$wt >= 2.5, c('mpg')])
[1] 16.86364

#Alternative
> mean(subset(dfc, hp > 100 & wt > 2.5)$mpg)
[1] 16.86364

# Ex 11: What is the mpg of the Hornet Sportabout?
> dfc['Hornet Sportabout',]$mpg
[1] 18.7