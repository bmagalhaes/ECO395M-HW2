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
59355.21
</td>
<td style="text-align:right;">
60787.06
</td>
<td style="text-align:right;">
64215.12
</td>
<td style="text-align:right;">
60529.83
</td>
<td style="text-align:right;">
60561.7
</td>
<td style="text-align:right;">
66897.86
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
    ## -228997  -34913   -4446   26018  466253 
    ## 
    ## Coefficients:
    ##                          Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)             9.833e+04  2.251e+04   4.368 1.35e-05 ***
    ## lotSize                 8.096e+03  2.354e+03   3.440  0.00060 ***
    ## age                    -1.172e+02  6.549e+01  -1.789  0.07384 .  
    ## landValue               9.135e-01  5.568e-02  16.408  < 2e-16 ***
    ## livingArea              7.503e+01  4.635e+00  16.187  < 2e-16 ***
    ## pctCollege             -1.938e+02  1.710e+02  -1.133  0.25724    
    ## bedrooms               -4.290e+03  2.694e+03  -1.593  0.11142    
    ## fireplaces             -2.442e+02  3.297e+03  -0.074  0.94096    
    ## bathrooms               2.401e+04  3.707e+03   6.476 1.31e-10 ***
    ## heatinghot water/steam -8.690e+03  4.630e+03  -1.877  0.06076 .  
    ## heatingelectric         7.003e+03  1.349e+04   0.519  0.60374    
    ## fuelelectric           -1.641e+04  1.325e+04  -1.238  0.21584    
    ## fueloil                -3.787e+03  5.649e+03  -0.670  0.50270    
    ## sewerpublic/commercial -3.316e+03  4.081e+03  -0.813  0.41662    
    ## sewernone              -1.048e+03  2.090e+04  -0.050  0.96002    
    ## waterfrontNo           -1.005e+05  1.803e+04  -5.570 3.06e-08 ***
    ## newConstructionNo       4.261e+04  8.106e+03   5.257 1.70e-07 ***
    ## centralAirNo           -1.155e+04  3.908e+03  -2.956  0.00317 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 57980 on 1364 degrees of freedom
    ## Multiple R-squared:  0.6489, Adjusted R-squared:  0.6445 
    ## F-statistic: 148.3 on 17 and 1364 DF,  p-value: < 2.2e-16

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
model\_wo\_lotSize
</td>
<td style="text-align:right;">
59956.81
</td>
</tr>
<tr>
<td style="text-align:left;">
model.w.o.age
</td>
<td style="text-align:right;">
60086.59
</td>
</tr>
<tr>
<td style="text-align:left;">
model.w.o.landValue
</td>
<td style="text-align:right;">
68203.79
</td>
</tr>
<tr>
<td style="text-align:left;">
model.w.o.livingArea
</td>
<td style="text-align:right;">
64860.41
</td>
</tr>
<tr>
<td style="text-align:left;">
model.w.o.pctCollege
</td>
<td style="text-align:right;">
59894.60
</td>
</tr>
<tr>
<td style="text-align:left;">
model.w.o.bedrooms
</td>
<td style="text-align:right;">
60088.88
</td>
</tr>
<tr>
<td style="text-align:left;">
model\_wo\_fireplaces
</td>
<td style="text-align:right;">
59931.60
</td>
</tr>
<tr>
<td style="text-align:left;">
model.w.o.bathrooms
</td>
<td style="text-align:right;">
60321.15
</td>
</tr>
<tr>
<td style="text-align:left;">
model.w.o.heating
</td>
<td style="text-align:right;">
60170.17
</td>
</tr>
<tr>
<td style="text-align:left;">
model.w.o.fuel
</td>
<td style="text-align:right;">
59911.32
</td>
</tr>
<tr>
<td style="text-align:left;">
model.w.o.sewer
</td>
<td style="text-align:right;">
59898.43
</td>
</tr>
<tr>
<td style="text-align:left;">
model.w.o.waterfront
</td>
<td style="text-align:right;">
62189.50
</td>
</tr>
<tr>
<td style="text-align:left;">
model.w.o.newConstruction
</td>
<td style="text-align:right;">
60823.49
</td>
</tr>
<tr>
<td style="text-align:left;">
model.w.o.centralAir
</td>
<td style="text-align:right;">
59889.17
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
12
</td>
<td style="text-align:right;">
72208.42
</td>
<td style="text-align:right;">
60391.35
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
62129.26
</td>
<td style="text-align:right;">
59355.21
</td>
</tr>
</tbody>
</table>
