#
# Exerciese from book Data Science - Sinan Ozdemir
#
# @since : Fri Apr  9 16:00:30 CEST 2021
#

import pandas as pd
import numpy as np

titanic_data = pd.read_csv('titanic.csv')
titanic_data.head()

titanic_data.shape # (891, 12)

titanic_data['Sex'] = np.where(titanic_data['Sex'] == 'female', 1, 0) 

titanic_data.describe()
#        PassengerId    Survived      Pclass         Sex         Age       SibSp       Parch        Fare
# count   891.000000  891.000000  891.000000  891.000000  714.000000  891.000000  891.000000  891.000000
# mean    446.000000    0.383838    2.308642    0.352413   29.699118    0.523008    0.381594   32.204208
# std     257.353842    0.486592    0.836071    0.477990   14.526497    1.102743    0.806057   49.693429
# min       1.000000    0.000000    1.000000    0.000000    0.420000    0.000000    0.000000    0.000000
# 25%     223.500000    0.000000    2.000000    0.000000   20.125000    0.000000    0.000000    7.910400
# 50%     446.000000    0.000000    3.000000    0.000000   28.000000    0.000000    0.000000   14.454200
# 75%     668.500000    1.000000    3.000000    1.000000   38.000000    1.000000    0.000000   31.000000
# max     891.000000    1.000000    3.000000    1.000000   80.000000    8.000000    6.000000  512.329200

# This function check the number of null values for every column 
titanic_data.isnull().sum()
# PassengerId      0
# Survived         0
# Pclass           0
# Name             0
# Sex              0
# Age            177
# SibSp            0
# Parch            0
# Ticket           0
# Fare             0
# Cabin          687
# Embarked         2
# dtype: int64


# Number of missing Age values = 177
print ( sum(titanic_data['Age'].isnull()))

# Calculate mean 
average_age = titanic_data['Age'].mean()

# Use fillna to replace n/a values with mean
titanic_data['Age'].fillna(average_age, inplace = True)

# Calculate the mean for every gender
titanic_data.groupby('Sex')['Age'].mean()
# Sex
# 0    30.505824
# 1    28.216730