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

Expenditure_list <- list(Price, Quantity, Expenditure,
                         Total_expenditure)
Expenditure_list

# Second element of the array

Expenditure_list[[2]]

# Example: Net Present Value

Amount <- 121
discount_rate <- 0.1
time <- 2

Net_present_value <- Amount/(1 + discount_rate)^time
Net_present_value

# multi-line comment shortcut: cmd + shift + c

# Another example. We now calculate the net present value of several sums of
# money. A cost of 150 is incurred now, and benefits of 135 and 140 are received after
# one and two years. The discount rate continues to be 10%. We use the concatenate
# (i.e. c()) function.

Cost_benefit_profile <- c(-150, 135, 140)
time_profile <- c(0, 1, 2)

Cost_benefit_present_value_profile <- Cost_benefit_profile/(1 + discount_rate)^time_profile

Net_present_value <- round(sum(Cost_benefit_present_value_profile), 2)

Net_present_value

# We need to be careful whileworkingwith vectors, paying attention to their dimensions.
# Below, we add a vector Three with three elements to a vector Two with one
# element.

Three <- c(3, 3, 3)
Two <- 2
Five <- Three + Two
Five

# What if we add the vector Three with three elements to a vector Mix with two
# elements?

Mix <- c(2, 9)
Mix

ThreeAndMix <- Three + Mix
ThreeAndMix

# After issuing the warning, R ‘recycles’ Mix; since the third element is missing it
# goes back to the first.
