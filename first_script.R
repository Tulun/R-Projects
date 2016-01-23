2 + 3

Price <- c(10, 3, 15)

Price

length(Price)

Price[1]

Price[2:3]

Quantity <- c(25, 3, 20)

Expenditure <- Price * Quantity

Total_expenditure <- sum(Expenditure)

# Matrices

Matrix_PQE <- matrix(data = cbind(Price, Quantity, Expenditure), ncol = 3)
Matrix_PQE

# Printing the first row

Matrix_PQE[1, ]

# Printing second column

Matrix_PQE[, 2]

# Printing third column

Matrix_PQE[1, 2]

# Data Frames

Exp_data <- data.frame(Price, Quantity)
Exp_data

Exp_data[, 2]

# You can also refer to the second column by using the $

Exp_data$Quantity

## Lists