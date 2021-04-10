#
# Exerciese from book Data Science - Sinan Ozdemir
#
# @since : Fri Apr  9 14:41:38 CEST 2021
#

### Calculate standard deviance 
#
# Distanza di un punto dei dati rispetto alla media
#
import numpy

temps = [32, 32, 31, 28, 29, 31, 39, 32, 32, 35, 26, 29]

# Calculate mean of values 
mean = numpy.mean(temps)

squared_differences = []
num_items = len(temps) 
products = 1

for temperature in temps:

    # Geometric mean
    products *= temperature
    geometric_mean = products ** (1./num_items)

    # Distance of single point from mean
    difference = temperature - mean

    # Square of difference
    squared_difference = difference ** 2

    squared_differences.append(squared_difference)

# Calculate VARIANCE
average_squared_difference = numpy.mean(squared_differences)

# Calculate standard deviation
standard_deviation = numpy.sqrt(average_squared_difference)

print ('mean:               ', mean)
print ('variance:           ', average_squared_difference)
print ('standard_deviation: ', standard_deviation)
print ('geometric mean:     ', geometric_mean)

# mean:                31.333333333333332
# variance:            10.388888888888888
# standard_deviation:  3.2231799343022858
# geometric mean:      31.173240057688545