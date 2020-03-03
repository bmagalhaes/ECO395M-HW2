\#ECO 395M: Exercise 2

Bernardo Arreal Magalhaes - UTEID ba25727

Adhish Luitel - UTEID al49674

Ji Heon Shim - UTEID js93996

Exercise 2.1
------------

In this exercise, we hand-build five models for price in order to find
out the best one which outperforms the “medium” model that we considered
in class.

    model1= price ~ lotSize + age + landValue + livingArea + pctCollege + bedrooms + fireplaces + bathrooms + heating + fuel + sewer + waterfront + newConstruction + centralAir 
    model2= price~ lotSize + age + landValue + livingArea + pctCollege + bedrooms + fireplaces + bathrooms + heating + fuel + centralAir 
    model3= price~ (lotSize + age + landValue + livingArea + pctCollege + bedrooms + fireplaces + bathrooms + heating + fuel + centralAir)^2 
    model4= price~ lotSize + age +pctCollege * landValue + livingArea * (bedrooms + bathrooms) + fireplaces + heating + fuel + centralAir
    model5= price~ lotSize + age + age2 + pctCollege * landValue + livingArea * (bedrooms + bathrooms) + fireplaces + heating + fuel + centralAir

    model_medium = price ~ lotSize + age + livingArea + pctCollege + bedrooms + 
                     fireplaces + bathrooms + rooms + heating + fuel + centralAir

Here are the main features of our models.

Model 1 : include all main effects except roooms (exclude rooms because
of colinearity, rooms = bedrooms + batherooms) Model 2: simplify model1
by reducing some variables(-sewer-waterfront-newConstruction) Model 3:
add all the interactions on model 2 Model 4: allow only some
interactions on model 2 Model 5: a polynomial model by adding age^2 on
model 4 Model\_medium: baseline model with 11 main effects

In order to measure performances of each model, we run the Monte Carlo
training-test split(train 80%, test 20%) for 100 times and calcaulate
the average values of out-of-sample RMSE for each model. And the best
model turned out to be model 1 with the least out-of-sample RMSE value.

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ## Warning in predict.lm(model3, saratoga_test): prediction from a rank-deficient
    ## fit may be misleading

    ##      model1   model2   model3   model4   model5 model_medium
    ## V1 58432.46 59858.58 64764.01 59873.48 59912.65     65880.65
