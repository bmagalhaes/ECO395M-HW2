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

In order to measure performances of each model, we run the Monte Carlo
training-test split(train 80%, test 20%) for 100 times and calcaulate
the average values of out-of-sample RMSE for each model. And the best
model turned out to be model 1 with the least out-of-sample RMSE value.

<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
model.1
</th>
<th style="text-align:right;">
model.2
</th>
<th style="text-align:right;">
model.3
</th>
<th style="text-align:right;">
model.4
</th>
<th style="text-align:right;">
model.5
</th>
<th style="text-align:right;">
model\_medium
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
AVG RMSE
</td>
<td style="text-align:right;">
58293.47
</td>
<td style="text-align:right;">
59815.37
</td>
<td style="text-align:right;">
62798.86
</td>
<td style="text-align:right;">
59617.68
</td>
<td style="text-align:right;">
59652.72
</td>
<td style="text-align:right;">
65979.21
</td>
</tr>
</tbody>
</table>

We can find the variable which is the strongest driver of house prices
by assessing how much it improves the out-of-sample RMSE when it is
included in the model. So we test how much the out-of-sample increases
when we exclude a certain variable from our model 1, and get the average
RMSE by doing the Monte Carlo simulation on different training-test
sets(80%-20%) for 100 times.

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
54666.04
</td>
</tr>
<tr>
<td style="text-align:left;">
model\_wo\_age
</td>
<td style="text-align:right;">
54527.76
</td>
</tr>
<tr>
<td style="text-align:left;">
model\_wo\_landValue
</td>
<td style="text-align:right;">
56962.26
</td>
</tr>
<tr>
<td style="text-align:left;">
model\_wo\_livingArea
</td>
<td style="text-align:right;">
61668.68
</td>
</tr>
<tr>
<td style="text-align:left;">
model\_wo\_pctCollege
</td>
<td style="text-align:right;">
54569.87
</td>
</tr>
<tr>
<td style="text-align:left;">
model\_wo\_bedrooms
</td>
<td style="text-align:right;">
54799.69
</td>
</tr>
<tr>
<td style="text-align:left;">
model\_wo\_fireplaces
</td>
<td style="text-align:right;">
54566.22
</td>
</tr>
<tr>
<td style="text-align:left;">
model\_wo\_bathrooms
</td>
<td style="text-align:right;">
55742.95
</td>
</tr>
<tr>
<td style="text-align:left;">
model\_wo\_heating
</td>
<td style="text-align:right;">
54805.78
</td>
</tr>
<tr>
<td style="text-align:left;">
model\_wo\_fuel
</td>
<td style="text-align:right;">
54588.64
</td>
</tr>
<tr>
<td style="text-align:left;">
model\_wo\_sewer
</td>
<td style="text-align:right;">
54599.69
</td>
</tr>
<tr>
<td style="text-align:left;">
model\_wo\_waterfront
</td>
<td style="text-align:right;">
55134.43
</td>
</tr>
<tr>
<td style="text-align:left;">
model\_wo\_newConstruction
</td>
<td style="text-align:right;">
55070.60
</td>
</tr>
<tr>
<td style="text-align:left;">
model\_wo\_centralAir
</td>
<td style="text-align:right;">
54829.19
</td>
</tr>
</tbody>
</table>
