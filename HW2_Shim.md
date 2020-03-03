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

    model_medium = price ~ lotSize + age + livingArea + pctCollege + bedrooms + fireplaces + bathrooms + rooms + heating + fuel + centralAir

Here are the main features of our models.

Model 1 : include all main effects except roooms (exclude rooms because
of colinearity, rooms = bedrooms + batherooms) Model 2: simplify model1
by reducing some variables(-sewer-waterfront-newConstruction) Model 3:
add all the interactions on model 2 Model 4: allow only some
interactions on model 2 Model 5: a polynomial model by adding age^2 on
model 4 Model\_medium: baseline model with 11 main effects

In order to measure performances of each model, we run Monte Carlo
training-test split(train 80%, test 20%) for 100 times and calcaulate
the average values of out-of-sample RMSE for each model.

<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
model1
</th>
<th style="text-align:right;">
model2
</th>
<th style="text-align:right;">
model3
</th>
<th style="text-align:right;">
model4
</th>
<th style="text-align:right;">
model5
</th>
<th style="text-align:right;">
model.medium
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
AVG RMSE
</td>
<td style="text-align:right;">
59011.41
</td>
<td style="text-align:right;">
60537.55
</td>
<td style="text-align:right;">
64044.28
</td>
<td style="text-align:right;">
60351.47
</td>
<td style="text-align:right;">
60388.59
</td>
<td style="text-align:right;">
66972.17
</td>
</tr>
</tbody>
</table>

The best model turned out to be model 1 with the least out-of-sample
RMSE value. Here is the summary of model 1.

    summary(model1)

    ## 
    ## Call:
    ## lm(formula = price ~ . - rooms - age2, data = saratoga_train)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -229648  -35109   -4623   26725  453250 
    ## 
    ## Coefficients:
    ##                          Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)             8.419e+04  2.268e+04   3.712 0.000214 ***
    ## lotSize                 6.027e+03  2.343e+03   2.573 0.010192 *  
    ## age                    -1.581e+02  6.582e+01  -2.403 0.016409 *  
    ## landValue               1.030e+00  5.453e-02  18.882  < 2e-16 ***
    ## livingArea              7.158e+01  4.661e+00  15.356  < 2e-16 ***
    ## pctCollege             -1.557e+02  1.688e+02  -0.922 0.356499    
    ## bedrooms               -4.850e+03  2.684e+03  -1.807 0.070953 .  
    ## fireplaces             -2.425e+03  3.380e+03  -0.717 0.473208    
    ## bathrooms               2.581e+04  3.826e+03   6.747 2.22e-11 ***
    ## heatinghot water/steam -5.596e+03  4.713e+03  -1.187 0.235249    
    ## heatingelectric         9.934e+02  1.272e+04   0.078 0.937766    
    ## fuelelectric           -9.709e+03  1.249e+04  -0.777 0.437067    
    ## fueloil                -5.678e+03  5.614e+03  -1.011 0.311979    
    ## sewerpublic/commercial -2.620e+03  4.138e+03  -0.633 0.526788    
    ## sewernone               2.555e+03  1.991e+04   0.128 0.897883    
    ## waterfrontNo           -9.186e+04  1.839e+04  -4.994 6.68e-07 ***
    ## newConstructionNo       4.753e+04  8.500e+03   5.593 2.70e-08 ***
    ## centralAirNo           -9.189e+03  3.902e+03  -2.355 0.018658 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 58600 on 1364 degrees of freedom
    ## Multiple R-squared:  0.6549, Adjusted R-squared:  0.6506 
    ## F-statistic: 152.3 on 17 and 1364 DF,  p-value: < 2.2e-16

And we can find the variable which is the strongest driver of house
prices by assessing how much it improves the out-of-sample RMSE when it
is included in the model. So we test how much the out-of-sample
increases when we exclude a certain variable from our model 1, and get
the average RMSE by doing Monte Carlo simulation on different
training-test sets(80%-20%) for 100 times.

As the table below shows, “landValue” variable seems to be the storngest
drive of house prices. This result might be caused because land values
are already included in house prices(House price = Land value + Pure
house value), so they are strongly related to each other.

<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
AVG RMSE
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
model.wo.lotSize
</td>
<td style="text-align:right;">
57485.41
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.age
</td>
<td style="text-align:right;">
56950.97
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.landValue
</td>
<td style="text-align:right;">
58974.19
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.livingArea
</td>
<td style="text-align:right;">
63567.18
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.pctCollege
</td>
<td style="text-align:right;">
56978.12
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.bedrooms
</td>
<td style="text-align:right;">
57102.49
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.fireplaces
</td>
<td style="text-align:right;">
57032.48
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.bathrooms
</td>
<td style="text-align:right;">
57107.13
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.heating
</td>
<td style="text-align:right;">
57528.49
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.fuel
</td>
<td style="text-align:right;">
57007.21
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.sewer
</td>
<td style="text-align:right;">
56994.07
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.waterfront
</td>
<td style="text-align:right;">
59791.58
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.newConstruction
</td>
<td style="text-align:right;">
57573.75
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.centralAir
</td>
<td style="text-align:right;">
57206.98
</td>
</tr>
</tbody>
</table>

Now, we build a nonparametic KNN model to compare it with our linear
model and figure out which one performs better. By using the same train
and test sets that we used in our linear regression, the result shows
that whatever value K may have, the knn model is unlikely to perfrom
better than our linear model. In the graph below, the horizontal red
line shows the out-of-sample RMSE of our linear model. We can see that
all the RMSEs of the knn model in accordance with k values are plotted
above the red line. And the table below suggests the fact that the
minimum RMSE value of knn model is still bigger than our best-fit linear
model.

![](HW2_Shim_files/figure-markdown_strict/2.1.6-1.png)
<table class="table table-striped" style="width: auto !important; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:right;">
Kmin
</th>
<th style="text-align:right;">
knn.model.RMSE
</th>
<th style="text-align:right;">
linear.model.RMSE
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
7
</td>
<td style="text-align:right;">
66186.44
</td>
<td style="text-align:right;">
58692.8
</td>
</tr>
</tbody>
</table>

But there is random variation due to the particular choice of data
points that end up in your train/test split. So we run Monte-Carlo
simulation again using random train/test split for 100 times, and
compare the minimim RMSE of knn model with RMSE of our linear model. As
a result, we can see that our linear model outperforms the knn model.

<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
knn.model
</th>
<th style="text-align:right;">
linear.model
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Average RMSE
</td>
<td style="text-align:right;">
61874.54
</td>
<td style="text-align:right;">
59011.41
</td>
</tr>
</tbody>
</table>
