library(tidyverse)
library(ggcorrplot)
rawFile <- "https://raw.githubusercontent.com/jadenth0mas/Energy-Efficiency-Project/main/Data/ENB2012_data.csv"
df <- read.csv(rawFile)
df <- df[1:768,]
new_names <- c("compactness", "surface_area", "wall_area", "roof_area", "height", "orientation", "glazing_area", "glazing_distribution", "heating_load", "cooling_load")
colnames(df) <- new_names
head(df)
str(df)
summary(df)
sum(is.na(df))


# Exploration of X's

# Compactness
unique(df$compactness)
ggplot(df, aes(x=compactness)) +
  geom_histogram(bins=10)
ggplot(df, aes(x=compactness, y=heating_load)) +
  geom_point()
ggplot(df, aes(x=compactness, y=cooling_load)) +
  geom_point()
summary(df$compactness)

# Surface Area
unique(df$surface_area)
ggplot(df, aes(surface_area)) +
  geom_histogram(bins=10)
ggplot(df, aes(x=surface_area, y=heating_load)) +
  geom_point()
ggplot(df, aes(x=surface_area, y=cooling_load)) +
  geom_point()
summary(df$surface_area)

# Wall Area
unique(df$wall_area)
ggplot(df, aes(wall_area)) +
  geom_histogram(bins=10)
ggplot(df, aes(x=wall_area, y=heating_load)) +
  geom_point()
ggplot(df, aes(x=wall_area, y=cooling_load)) +
  geom_point()
summary(df$wall_area)

ggplot(df) +
  aes(x=orientation) +
  geom_histogram(bins=5)

ggcorrplot(cor(df), lab=T)

# Convert data type
cols <- c("orientation", "glazing_distribution")
df <- df %>% mutate_at(cols, factor)
summary(df)

# train and test split 
train <- sample(c(TRUE, FALSE), size=nrow(df), replace=T, prob=c(0.7,0.3))
df_train <- df[train,]
df_test <- df[!train,]
nrow(df_trainHL)
nrow(df_testHL)

# Heating and Cooling Load Train and Test and X and Y
df_trainHL <- df_train %>% select(!cooling_load)
df_testHL <- df_test %>% select(!cooling_load)
df_testHL_X <- df_test %>% select(!heating_load)
df_testHL_Y <- df_test %>% select(heating_load)
df_testCL <- df_test %>% select(!heating_load)
df_trainCL <- df_train %>% select(!heating_load)
df_testCL_X <- df_test %>% select(!cooling_load)
df_testCL_Y <- df_test %>% select(cooling_load)

# Heating Load Linear Regression
linear.fitHL <- lm(heating_load~.-roof_area, data=df_trainHL)
summary(linear.fitHL)

par(mfrow=c(2,2))
plot(linear.fitHL)

HL_predict <- predict(linear.fitHL, df_testHL_X)
mean((df_testHL_Y$heating_load-HL_predict)^2)

# Cooling Load Linear Regression
linear.fitCL <- lm(cooling_load~.-roof_area, data=df_trainCL)
summary(linear.fitCL)

par(mfrow=c(2,2))
plot(linear.fitCL)

CL_predict <- predict(linear.fitCL, df_testCL_X)
mean((df_testCL_Y$cooling_load-CL_predict)^2)
