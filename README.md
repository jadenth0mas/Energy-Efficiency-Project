# Energy Efficiency Project

## Description

In this project a linear regression is performed using the same data used in the paper, "". A model is used to predict the heating load, and another model is used to predict the cooling load based on the predictor variables, relative compactness, surface area, wall area, roof area, overall height, orientation, glazing area, and glazing distribution. 

## Methods

The R package dplyr was used to clean and formate the data that was obtained from a csv file, and the packages ggplot2 and ggcorrplot where used to visualize the data for exploratory data analysis. A linear regression model was made using the lm() function for both the heating load prediction and cooling load prediction. The model was evaluated by using adjusted $R^2$ and mean squared error, calculated using the equation $\sum_{i=1}^n(y_i-\hat{y_i})^2$ where $n$ is equal to the number of predicted observations.

## Results

## Discussion

## Sources
