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

summary(df$bmi)
summary(df$ageYear)

range(df$bmi) # c(min(df$bmi), max(df$bmi))

hist(df$bmi)
abline(v = c(18,5, 25), col = "red")

plot(density(df$bmi))

boxplot(df$bmi)
boxplot(bmi ~ sex, df)

install.packages("beanplot")
library(beanplot)
beanplot(df$bmi)
beanplot(bmi ~ sex, df)
?beanplot

pie(table(df$sex))
barplot(table(df$sex))
dotchart(table(df$sex))

pairs(df)

## intro stats

t.test(bmi ~ sex, df)


## ANOVA

aov(height ~ sex, df)
summary(aov(height ~ sex, data = df))

## intro data.table

df <- read.csv("http://bit.ly/CEU-R-hotels-2017")
str(df)
head(df)

min(df$price_HUF)
max(df$price_HUF)
summary(df$price_HUF)
hist(hotels$price_HUF)
df[ , df$price_HUF == 5309]

hotels <- df

which.max(hotels$price_HUF)
hotels[1374, ]
hotels[which.max(hotels$price_HUF), ]

hotels[which.min(hotels$price_HUF), ]

hotels[which(hotels$price_HUF > 100000), ]

pricey <- hotels[which(hotels$price_HUF > 100000), ]

pricey[which(pricey$rating < 4), ]
str(pricey[which(pricey$rating < 4), ])

pricey_and_low_retad <- pricey[which(pricey$rating < 4), ]

hist(pricey_and_low_retad$rating)

pricey_and_low_retad$rate_cat <- 1

?cut

pricey_and_low_retad$rate_cat <- cut(pricey_and_low_retad$rating, 4)
table(pricey_and_low_retad$rate_cat)

pricey_and_low_retad$rate_cat <- cut(pricey_and_low_retad$rating, c(1, 2, 3, 4))
table(pricey_and_low_retad$rate_cat)

pie(table(pricey_and_low_retad$rate_cat))

price_cut <- cut(hotels$price_HUF, c(0, 10000, 100000, max(hotels$price_HUF)), labels = c("cheap", "avg", "pricey"), dig.lab = 8)
pie(table(price_cut))
table(price_cut)

## data.table

install.packages("data.table")
library(data.table)

hotels <- data.table(hotels)
str(hotels)

## filtering

hotels[price_HUF > 100000]
hotels[price_HUF > 100000 & rating < 4]

hotels[, .N]

hotels[, mean(price_HUF)]

## group by

hotels[, mean(price_HUF), by = stars]

hotels_by_stars <- hotels[, list(price_avg = mean(price_HUF),
              price_min = min(price_HUF),
              price_max = max(price_HUF)),
       by = stars]

hotels[, list(price_min = min(price_HUF)), by = rating][order(rating)]

str(hotels)

price <- hotels$price_HUF/310
str(hotels)
hist(price)

hotels_by_city <- hotels[, list(price_avg = mean(price_HUF),
                                 price_min = min(price_HUF),
                                 price_max = max(price_HUF)),
                          by = stars]

hotels_by_cities <- hotels[, list(
  avg_rating = round(mean(rating, na.rm = TRUE), 2),
  avg_stars = round(mean(stars, na.rm = TRUE), 2),
  avg_price = round(mean(price, na.rm = TRUE))),
  by = city]

plot(hotels_by_cities$avg_stars, hotels_by_cities$)
plot(hotels_by_cities$avg_price, hotels_by_cities$avg_stars)
