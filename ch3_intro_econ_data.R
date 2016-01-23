ifri_car_liv <- read.csv('ifri_car_liv.csv')

head(ifri_car_liv)

# We choose specific rows and columns, seeing the first five rows and second, fifth
# and sixth columns:

ifri_car_liv[1:5, c(2, 5, 6)]

# We now see the first five rows and specific variables cid and ownstate:

ifri_car_liv[1:5, c('cid', 'ownstate')]

# We see the structure of the data using the function str.

str(ifri_car_liv)

# Read in .txt file

fishmayreq <- read.delim('fishmayreq.txt')

fishmayreq[1:5, c('pric', 'quan')]


