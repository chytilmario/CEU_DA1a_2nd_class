h <- c(174, 170, 160)
w <- c(90, 80, 70)
df <- data.frame(height = h, weight = w)
df

## df [rows, columns]

df[1,1]
df[3, 2]
df[1, ]
df[ , 1]
df[c(1, 2), ]
df[1:2, ]

## to create a new column in df. dataframe:

df$bmi <- df$weight / (df$height/100)^2
df

summary(df$bmi)

df <- read.csv("http://bit.ly/CEU-R-heights")
str(df)
df$bmi <- df$weightLb * 0.45359237/ (df$heightIn * 2.54/100)^2
str(df)

df$height <- df$heightIn * 2.54
df$weight <- df$weightLb * 0.45359237
df$bmi <- df$weight / (df$height/100)^2
df