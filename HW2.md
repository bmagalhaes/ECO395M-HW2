ECO 395M: Exercise 2
====================

Bernardo Arreal Magalhaes - UTEID ba25727

Adhish Luitel - UTEID al49674

Ji Heon Shim - UTEID js93996

Exercise 2.1
------------

In this exercise, we analyzed a data set on house prices in Saratoga,
NY, in order to provide the local tax authority a predictive model to
estimate properties market values.

We started by hand-building five models for price in order to find out
the best one which outperforms the "medium" model that we considered in
class.

    model1= price ~ lotSize + age + landValue + livingArea + pctCollege + bedrooms + fireplaces + bathrooms + heating + fuel + sewer + waterfront + newConstruction + centralAir 
    model2= price~ lotSize + age + landValue + livingArea + pctCollege + bedrooms + fireplaces + bathrooms + heating + fuel + centralAir 
    model3= price~ (lotSize + age + landValue + livingArea + pctCollege + bedrooms + fireplaces + bathrooms + heating + fuel + centralAir)^2 
    model4= price~ lotSize + age +pctCollege * landValue + livingArea * (bedrooms + bathrooms) + fireplaces + heating + fuel + centralAir
    model5= price~ lotSize + age + age2 + pctCollege * landValue + livingArea * (bedrooms + bathrooms) + fireplaces + heating + fuel + centralAir

    model_medium = price ~ lotSize + age + livingArea + pctCollege + bedrooms + fireplaces + bathrooms + rooms + heating + fuel + centralAir

The main features of our models are:

Model 1 : include all main effects except rooms (excluded due to some
degree of collinearity with bedrooms and bathrooms)

Model 2: simplify model1 by reducing some
variables(-sewer-waterfront-newConstruction)

Model 3: add all the interactions on model 2

Model 4: allow only some interactions on model 2

Model 5: a polynomial model by adding age^2 on model 4

Model\_medium: baseline model with 11 main effects

In order to measure performances of each model, we randomly splitted the
data into training-test sets (with the training set containing 80% of
the observations and the test set containing the other 20%) 100 times
and calculated the average values of out-of-sample RMSE for each model
by comparing the fitted values with the observed values in each
repetition.

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
58325.22
</td>
<td style="text-align:right;">
59885.33
</td>
<td style="text-align:right;">
64199.27
</td>
<td style="text-align:right;">
59697
</td>
<td style="text-align:right;">
59737.89
</td>
<td style="text-align:right;">
65992.89
</td>
</tr>
</tbody>
</table>
The best model turned out to be model 1 with the least out-of-sample
RMSE value. The table below show the summary statistics for this model.

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
<tbody>
<tr>
<td style="text-align:left;font-weight: bold;">
Observations
</td>
<td style="text-align:right;">
1382
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
Dependent variable
</td>
<td style="text-align:right;">
price
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
Type
</td>
<td style="text-align:right;">
OLS linear regression
</td>
</tr>
</tbody>
</table>
<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
<tbody>
<tr>
<td style="text-align:left;font-weight: bold;">
F(17,1364)
</td>
<td style="text-align:right;">
141.55
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
R²
</td>
<td style="text-align:right;">
0.64
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
Adj. R²
</td>
<td style="text-align:right;">
0.63
</td>
</tr>
</tbody>
</table>
<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
Est.
</th>
<th style="text-align:right;">
S.E.
</th>
<th style="text-align:right;">
t val.
</th>
<th style="text-align:right;">
p
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;font-weight: bold;">
(Intercept)
</td>
<td style="text-align:right;">
106607.40
</td>
<td style="text-align:right;">
22903.65
</td>
<td style="text-align:right;">
4.65
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
lotSize
</td>
<td style="text-align:right;">
9654.26
</td>
<td style="text-align:right;">
2563.44
</td>
<td style="text-align:right;">
3.77
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
age
</td>
<td style="text-align:right;">
-99.57
</td>
<td style="text-align:right;">
67.16
</td>
<td style="text-align:right;">
-1.48
</td>
<td style="text-align:right;">
0.14
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
landValue
</td>
<td style="text-align:right;">
0.93
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
17.53
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
livingArea
</td>
<td style="text-align:right;">
72.01
</td>
<td style="text-align:right;">
4.87
</td>
<td style="text-align:right;">
14.79
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
pctCollege
</td>
<td style="text-align:right;">
-47.48
</td>
<td style="text-align:right;">
173.98
</td>
<td style="text-align:right;">
-0.27
</td>
<td style="text-align:right;">
0.78
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
bedrooms
</td>
<td style="text-align:right;">
-3226.45
</td>
<td style="text-align:right;">
2792.44
</td>
<td style="text-align:right;">
-1.16
</td>
<td style="text-align:right;">
0.25
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
fireplaces
</td>
<td style="text-align:right;">
1893.32
</td>
<td style="text-align:right;">
3462.91
</td>
<td style="text-align:right;">
0.55
</td>
<td style="text-align:right;">
0.58
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
bathrooms
</td>
<td style="text-align:right;">
22850.95
</td>
<td style="text-align:right;">
3811.35
</td>
<td style="text-align:right;">
6.00
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
heatinghot water/steam
</td>
<td style="text-align:right;">
-10029.48
</td>
<td style="text-align:right;">
4814.64
</td>
<td style="text-align:right;">
-2.08
</td>
<td style="text-align:right;">
0.04
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
heatingelectric
</td>
<td style="text-align:right;">
3381.35
</td>
<td style="text-align:right;">
14317.15
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
0.81
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
fuelelectric
</td>
<td style="text-align:right;">
-14827.22
</td>
<td style="text-align:right;">
14086.43
</td>
<td style="text-align:right;">
-1.05
</td>
<td style="text-align:right;">
0.29
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
fueloil
</td>
<td style="text-align:right;">
-7033.69
</td>
<td style="text-align:right;">
5917.91
</td>
<td style="text-align:right;">
-1.19
</td>
<td style="text-align:right;">
0.23
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
sewerpublic/commercial
</td>
<td style="text-align:right;">
-387.08
</td>
<td style="text-align:right;">
4186.89
</td>
<td style="text-align:right;">
-0.09
</td>
<td style="text-align:right;">
0.93
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
sewernone
</td>
<td style="text-align:right;">
2400.34
</td>
<td style="text-align:right;">
20440.35
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
0.91
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
waterfrontNo
</td>
<td style="text-align:right;">
-116535.66
</td>
<td style="text-align:right;">
18099.40
</td>
<td style="text-align:right;">
-6.44
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
newConstructionNo
</td>
<td style="text-align:right;">
42543.88
</td>
<td style="text-align:right;">
8581.98
</td>
<td style="text-align:right;">
4.96
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
centralAirNo
</td>
<td style="text-align:right;">
-10997.61
</td>
<td style="text-align:right;">
4024.81
</td>
<td style="text-align:right;">
-2.73
</td>
<td style="text-align:right;">
0.01
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td style="padding: 0; border: 0;" colspan="100%">
<sup></sup> Standard errors: OLS
</td>
</tr>
</tfoot>
</table>
In order to assess which variable is the strongest driver of house
prices (SO how much it improves the out-of-sample RMSE when it is
included in the model), we tested multiple scenarios where we excluded
each of the variables from model 1.

Than, we verified how much the out-of-sample RMSE increases when we
exclude each certain variable, and get the average RMSE by doing Monte
Carlo simulation on different training-test sets (80%-20%) for 100
times.

As we can observe from the table below, "landValue" variable seems to be
the strongest drive of house prices. This result might be caused because
land values are already included in house prices(House price = Land
value + Pure house value), so they are strongly related to each other.

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
50470.73
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.age
</td>
<td style="text-align:right;">
50987.56
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.landValue
</td>
<td style="text-align:right;">
55397.43
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.livingArea
</td>
<td style="text-align:right;">
58552.70
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.pctCollege
</td>
<td style="text-align:right;">
50767.12
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.bedrooms
</td>
<td style="text-align:right;">
51011.86
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.fireplaces
</td>
<td style="text-align:right;">
50686.96
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.bathrooms
</td>
<td style="text-align:right;">
51521.60
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.heating
</td>
<td style="text-align:right;">
50877.97
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.fuel
</td>
<td style="text-align:right;">
50630.78
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.sewer
</td>
<td style="text-align:right;">
50741.43
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.waterfront
</td>
<td style="text-align:right;">
52081.83
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.newConstruction
</td>
<td style="text-align:right;">
51882.18
</td>
</tr>
<tr>
<td style="text-align:left;">
model.wo.centralAir
</td>
<td style="text-align:right;">
50719.13
</td>
</tr>
</tbody>
</table>
Now, we built a nonparametic KNN model to compare with our linear model
and figure out which one performs better. By using the same train and
test sets that we used in our linear regression, the result shows that
whatever value K may have, the knn model is unlikely to perform better
than our linear model.

In the graph below, the horizontal red line shows the out-of-sample RMSE
of our linear model. We can see that all the RMSEs of the knn model in
accordance with k values are plotted above the red line. And the table
below suggests that the minimum RMSE value of knn model is still bigger
than our best-fit linear model.

![](HW2_files/figure-markdown_strict/2.1.6-1.png)
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
16
</td>
<td style="text-align:right;">
61232.38
</td>
<td style="text-align:right;">
51155.57
</td>
</tr>
</tbody>
</table>
Since randomness plays a role due to the particular choice of data
points that end up in our train/test split, we addressed that issue by
running Monte-Carlo simulation again using random train/test split for
100 times, and compared the minimum RMSE of knn model with RMSE of our
linear model. As a result, we can see that our linear model outperforms
the knn model.

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
62430.71
</td>
<td style="text-align:right;">
58325.22
</td>
</tr>
</tbody>
</table>
.

Exercise 2.2
------------

This exercise is based on a dataset consisting of 987 screening
mammograms administered at a hospital in Seattle, Washington. The goal
of the analysis is to evaluate the performance of five different
radiologists considering several risk factors.

First, we analyzed the raw data to verify whether each radiologist has a
different recall rate (A.recallrate) or not, and compare precision
(B.cancerrate) and false negative (C.false\_negative) rates. We can
observe that, even though radiologist89 has a higher probability of
recalling patients, his false negative error rate (not recalling
patients that actually have cancer) doesn't substantially differ from
radiologist95 and radiologist34, who have the lowest recall rates.

![](HW2_files/figure-markdown_strict/2.2.1-1.png)

However, since each radiologist read the mammograms of a different set
of patients, this difference could be explained by the fact that some
radiologists might have seen patients whose clinical situation required
them to be recalled for further examination.

In order to analyse if, holding patient risk factors equal, some
radiologists are more clinically conservative than others in recalling
patients, we built two classification models:

    model1 = recall ~ radiologist + age + history + symptoms + menopause + density
    model2 = recall ~ (age + history + symptoms + menopause + density) * radiologist

The table below shows the Average Marginal Effect (AME) for each
radiologist in the two models. We can see that, when using Model 1,
radiologist89 is the most conservative - holding patient risk factors
equal, the probability of being recalled increases by 5.71 percentage
points when radiologist89 is the one reading the mammogram compared to
the baseline radiologist13.

When allowing for interactions between radiologist and each control
variable as in Model 2, radiologist89 is still the most conservative -
holding patient risk factors equal, the probability of being recalled
increases by 17.48 percentage points when radiologist89 is the one
reading the mammogram compared to the baseline radiologist13.

<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="border-bottom:hidden" colspan="1">
</th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2">
Model 1

</th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2">
Model 2

</th>
</tr>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
AME
</th>
<th style="text-align:right;">
se
</th>
<th style="text-align:right;">
AME
</th>
<th style="text-align:right;">
se
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
radiologist.34
</td>
<td style="text-align:right;">
-0.0642539
</td>
<td style="text-align:right;">
0.0540849
</td>
<td style="text-align:right;">
-0.0367519
</td>
<td style="text-align:right;">
0.2199254
</td>
</tr>
<tr>
<td style="text-align:left;">
radiologist.66
</td>
<td style="text-align:right;">
0.0436803
</td>
<td style="text-align:right;">
0.0341096
</td>
<td style="text-align:right;">
0.0395334
</td>
<td style="text-align:right;">
0.1191771
</td>
</tr>
<tr>
<td style="text-align:left;">
radiologist.89
</td>
<td style="text-align:right;">
0.0571172
</td>
<td style="text-align:right;">
0.0384375
</td>
<td style="text-align:right;">
0.1748448
</td>
<td style="text-align:right;">
0.1601575
</td>
</tr>
<tr>
<td style="text-align:left;">
radiologist.95
</td>
<td style="text-align:right;">
-0.0064281
</td>
<td style="text-align:right;">
0.0402581
</td>
<td style="text-align:right;">
-0.2994109
</td>
<td style="text-align:right;">
0.1285680
</td>
</tr>
</tbody>
</table>
Finally, in order to estimate how each radiologist would perform when
facing the same set of patients, we used a bootstrap to randomly split
the original dataset in a training dataset containing 80% of the
observations and a testing a dataset containing 20% of the observations,
repeating the process 100 times. In each repetition, we estimated both
models using the train dataset, and compared each model's predictions
when all radiologists, in a hypothetical scenario, analyze the entire
test dataset.

We computed average probability of recall per repetition, and calculated
the average of the 100 samples to mitigate the effect of randomization.
For both models, radiologist89 has the highest probability of recall,
followed by radiologist66, radiologist13, radiologist95 and radiologist
34.

<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="border-bottom:hidden" colspan="1">
</th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2">
(Out of sample) Average recall probability

</th>
</tr>
<tr>
<th style="text-align:left;">
radiologist
</th>
<th style="text-align:right;">
Model1
</th>
<th style="text-align:right;">
Model2
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
radiologist.13
</td>
<td style="text-align:right;">
0.1364196
</td>
<td style="text-align:right;">
0.1366029
</td>
</tr>
<tr>
<td style="text-align:left;">
radiologist.34
</td>
<td style="text-align:right;">
0.0869044
</td>
<td style="text-align:right;">
0.0887751
</td>
</tr>
<tr>
<td style="text-align:left;">
radiologist.66
</td>
<td style="text-align:right;">
0.1849797
</td>
<td style="text-align:right;">
0.1917025
</td>
</tr>
<tr>
<td style="text-align:left;">
radiologist.89
</td>
<td style="text-align:right;">
0.2041218
</td>
<td style="text-align:right;">
0.2304669
</td>
</tr>
<tr>
<td style="text-align:left;">
radiologist.95
</td>
<td style="text-align:right;">
0.1320091
</td>
<td style="text-align:right;">
0.1209368
</td>
</tr>
</tbody>
</table>
The results corroborate what we observed in the AME table, that some
radiologists are more clinically conservative than others in recalling
patients, even holding patient risk factors equal.

After that, we analyzed if the data suggests that radiologists at this
hospital should be weighting some clinical risk factors more heavily
than they currently are when interpreting mammograms in order to make a
decision on whether to recall a patient or not.

We started by stablishing the following baseline model.

    baseline_model = cancer ~ recall

Then, we built multiple models adding each of the clinical risk factors
to the baseline model to evaluate the results separately.

    baseline_history_model = cancer ~ recall + history
    baseline_age_model = cancer ~ recall + age
    baseline_symptoms_model = cancer ~ recall + symptoms
    baseline_menopause_model = cancer ~ recall + menopause
    baseline_density_model = cancer ~ recall + density

If the radiologists were appropriately accounting for the clinical risk
factors when deciding whether to recall a patient for further
examination, we would expect the coefficient associated with the recall
variable to capture this effect, and the coefficient of the control
variable to be close to zero (so the odds ratio to be close to one).
Hence, including these variables in the model shouldn't considerably
affect the cancer predictions.

The table below summarizes the estimates from the 6 models. Here, we
observe that age 70 plus, density 4 (extremely dense) and
post-menopausal/unknown hormone-therapy status are some factors that are
increasing the odds of having a cancer, even after medical analysis!
Thus there's extra information in the risk factors that the doctors
should be weighting more heavily to recall patients than they currently
are.

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">
 
</th>
<th colspan="2" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">
Baseline Model
</th>
<th colspan="2" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">
+History
</th>
<th colspan="2" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">
+Age
</th>
<th colspan="2" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">
+Symptoms
</th>
<th colspan="2" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">
+Menopause
</th>
<th colspan="2" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">
+Density
</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">
Predictors
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
Odds Ratios
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
p
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
Odds Ratios
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
p
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
Odds Ratios
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  col7">
p
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  col8">
Odds Ratios
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  col9">
p
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  0">
Odds Ratios
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  1">
p
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  2">
Odds Ratios
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  3">
p
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
(Intercept)
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.02
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
<strong>&lt;0.001
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.02
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
<strong>&lt;0.001
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.01
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
<strong>&lt;0.001
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
0.02
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
<strong>&lt;0.001
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
0.02
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
<strong>&lt;0.001
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  2">
0.01
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  3">
<strong>&lt;0.001
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
recall
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
9.59
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
<strong>&lt;0.001
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
9.55
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
<strong>&lt;0.001
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
10.28
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
<strong>&lt;0.001
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
9.49
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
<strong>&lt;0.001
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
9.63
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
<strong>&lt;0.001
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  2">
9.58
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  3">
<strong>&lt;0.001
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
history
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
1.23
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.626
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  2">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  3">
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
age \[5059\]
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
1.21
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
0.697
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  2">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  3">
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
age \[6069\]
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.88
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
0.833
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  2">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  3">
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
age \[70plus\]
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
2.51
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
<strong>0.047</strong>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  2">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  3">
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
symptoms
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
1.30
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
0.686
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  2">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  3">
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
menopause \[postmenoNoHT\]
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
0.98
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
0.971
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  2">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  3">
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
menopause<br>\[postmenounknown\]
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
2.16
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
0.279
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  2">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  3">
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
menopause \[premeno\]
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
0.85
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
0.711
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  2">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  3">
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
density \[2\]
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  2">
1.95
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  3">
0.533
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
density \[3\]
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  2">
1.95
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  3">
0.526
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
density \[4\]
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col8">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col9">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  0">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  1">
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  2">
5.05
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  3">
0.137
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">
Observations
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
987
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
987
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
987
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
987
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
987
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="2">
987
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
R<sup>2</sup> Tjur
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
0.060
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
0.060
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
0.076
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
0.061
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
0.065
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="2">
0.069
</td>
</tr>
</table>
Considering the results above, we built a new model including those 3
risk factors.

    proposed_model = cancer ~ recall + age.70plus + postmenounknown + density.4

In order to assess how well this model performs when predicting cancer
status, we need to compare its predictions with the predictions from the
baseline model.

The confusion matrix for the baseline model below shows that the doctors
are currently predicting cancer with a 59.46% sensitivity (22/(22+15))
and a accuracy rate of 85.71% ((824+22)/987).

    ##       recall
    ## cancer   0   1
    ##      0 824 126
    ##      1  15  22

Considering the in-sample probability of cancer as a threshold for the
fitted values of the proposed model to predict cancer or not, we
computed the following confusion matrix. This matrix shows that, when
including age.70plus, postmenounknown and density.4 in the model, the
sensitivity increased to 64.86 (24/(13+24)) but the accuracy rate
slightly decreased to 84.60% ((811+24)/987).

    ##    yhat
    ## y     0   1
    ##   0 811 139
    ##   1  13  24

Since the medical literature suggests that a cancer that is diagnosed at
an early stage is more likely to be treated successfully, it is
reasonable to argue that the increase in sensitivity overcomes the
decrease in the accuracy rates caused by a higher amount of false
positive predictions. Hence, our best judgement is that the radiologists
should be weighting more heavily patients with 70 years old and above,
density 4 (extremely dense) and post-menopausal/unknown hormone-therapy
status when deciding whether to recall patients.

Exercise 2.3
============

In this exercise, we analyzed data from 39,797 online articles published
by Mashable during 2013 and 2014, in order to build a model to predict
which article goes viral. The criteria used for defining an article as
viral is if it surpasses the threshold of 1,400 shares. For each online
article, we have 36 variables that can be included in the model
(excluding URL since it is redundant for this analysis).

We started by plotting a histogram to visualize the frequency
distribution of the shares per article.

![](HW2_files/figure-markdown_strict/2.3.1-1.png)

If we observe the histogram of the number of shares, we can see that the
data is skewed towards the lower end. It shows that although there are a
broad range of articles that have well exceeded 7,000 shares, a large
portion of Mashable's articles are in the 800-1,200 shares range. A
majority being slightly below our 1,400 shares threshold.

As the variation of the shared articles is very broad, ranging from
almost 0 shares to close to 10,000 shares, it made sense to log scale
the response variable shares in order to compress down our data for
uniformity.

![](HW2_files/figure-markdown_strict/2.3.2-1.png)

Since the data is more uniformly distributed in the log scale, we
decided to use the transformed variable log(shares) in our predictive
models.

We started the model selection by building a baseline model including
all the available features as explanatory variables. So for our first
linear model, we fitted all 36 available variables (except for URL) to
make further assessments.

    lm1 = log(shares) ~ n_tokens_title + n_tokens_content + num_hrefs + num_self_hrefs + num_imgs +               num_videos + average_token_length + num_keywords + data_channel_is_lifestyle +                 data_channel_is_entertainment + data_channel_is_bus + data_channel_is_socmed +                 data_channel_is_tech + data_channel_is_world + self_reference_min_shares +                     self_reference_max_shares + self_reference_avg_sharess + weekday_is_monday +                   weekday_is_tuesday + weekday_is_wednesday + weekday_is_thursday +                              weekday_is_friday + weekday_is_saturday + weekday_is_sunday + is_weekend +                     global_rate_positive_words + global_rate_negative_words + avg_positive_polarity +               min_positive_polarity + max_positive_polarity + avg_negative_polarity +                        min_negative_polarity + max_negative_polarity + title_subjectivity +                           title_sentiment_polarity + abs_title_sentiment_polarity

The table below summarizes the coefficients associated with each
variable from this model.

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
<tbody>
<tr>
<td style="text-align:left;font-weight: bold;">
Observations
</td>
<td style="text-align:right;">
39644
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
Dependent variable
</td>
<td style="text-align:right;">
log(shares)
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
Type
</td>
<td style="text-align:right;">
OLS linear regression
</td>
</tr>
</tbody>
</table>
<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
<tbody>
<tr>
<td style="text-align:left;font-weight: bold;">
F(34,39609)
</td>
<td style="text-align:right;">
110.85
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
R²
</td>
<td style="text-align:right;">
0.09
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
Adj. R²
</td>
<td style="text-align:right;">
0.09
</td>
</tr>
</tbody>
</table>
<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
Est.
</th>
<th style="text-align:right;">
S.E.
</th>
<th style="text-align:right;">
t val.
</th>
<th style="text-align:right;">
p
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;font-weight: bold;">
(Intercept)
</td>
<td style="text-align:right;">
7.90
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
181.13
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
n\_tokens\_title
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
1.53
</td>
<td style="text-align:right;">
0.13
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
n\_tokens\_content
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.97
</td>
<td style="text-align:right;">
0.33
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
num\_hrefs
</td>
<td style="text-align:right;">
0.01
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
12.37
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
num\_self\_hrefs
</td>
<td style="text-align:right;">
-0.01
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
-7.88
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
num\_imgs
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
7.11
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
num\_videos
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
2.76
</td>
<td style="text-align:right;">
0.01
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
average\_token\_length
</td>
<td style="text-align:right;">
-0.06
</td>
<td style="text-align:right;">
0.01
</td>
<td style="text-align:right;">
-8.67
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
num\_keywords
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
6.73
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
data\_channel\_is\_lifestyle
</td>
<td style="text-align:right;">
-0.19
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
-7.99
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
data\_channel\_is\_entertainment
</td>
<td style="text-align:right;">
-0.44
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
-26.92
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
data\_channel\_is\_bus
</td>
<td style="text-align:right;">
-0.27
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
-14.84
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
data\_channel\_is\_socmed
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
2.30
</td>
<td style="text-align:right;">
0.02
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
data\_channel\_is\_tech
</td>
<td style="text-align:right;">
-0.12
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
-7.08
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
data\_channel\_is\_world
</td>
<td style="text-align:right;">
-0.50
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
-28.65
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
self\_reference\_min\_shares
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
1.30
</td>
<td style="text-align:right;">
0.19
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
self\_reference\_max\_shares
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.80
</td>
<td style="text-align:right;">
0.42
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
self\_reference\_avg\_sharess
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
2.25
</td>
<td style="text-align:right;">
0.02
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
weekday\_is\_monday
</td>
<td style="text-align:right;">
-0.23
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
-11.57
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
weekday\_is\_tuesday
</td>
<td style="text-align:right;">
-0.29
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
-14.65
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
weekday\_is\_wednesday
</td>
<td style="text-align:right;">
-0.29
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
-14.74
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
weekday\_is\_thursday
</td>
<td style="text-align:right;">
-0.28
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
-14.20
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
weekday\_is\_friday
</td>
<td style="text-align:right;">
-0.22
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
-10.66
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
weekday\_is\_saturday
</td>
<td style="text-align:right;">
0.01
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
0.69
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
weekday\_is\_sunday
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
is\_weekend
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
global\_rate\_positive\_words
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
0.32
</td>
<td style="text-align:right;">
0.77
</td>
<td style="text-align:right;">
0.44
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
global\_rate\_negative\_words
</td>
<td style="text-align:right;">
-0.64
</td>
<td style="text-align:right;">
0.51
</td>
<td style="text-align:right;">
-1.26
</td>
<td style="text-align:right;">
0.21
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
avg\_positive\_polarity
</td>
<td style="text-align:right;">
0.23
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
2.76
</td>
<td style="text-align:right;">
0.01
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
min\_positive\_polarity
</td>
<td style="text-align:right;">
-0.28
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
-3.23
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
max\_positive\_polarity
</td>
<td style="text-align:right;">
-0.03
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
-0.89
</td>
<td style="text-align:right;">
0.38
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
avg\_negative\_polarity
</td>
<td style="text-align:right;">
-0.36
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
-4.00
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
min\_negative\_polarity
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
0.69
</td>
<td style="text-align:right;">
0.49
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
max\_negative\_polarity
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
1.73
</td>
<td style="text-align:right;">
0.08
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
title\_subjectivity
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
1.97
</td>
<td style="text-align:right;">
0.05
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
title\_sentiment\_polarity
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
3.64
</td>
<td style="text-align:right;">
0.00
</td>
</tr>
<tr>
<td style="text-align:left;font-weight: bold;">
abs\_title\_sentiment\_polarity
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
1.07
</td>
<td style="text-align:right;">
0.28
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td style="padding: 0; border: 0;" colspan="100%">
<sup></sup> Standard errors: OLS
</td>
</tr>
</tfoot>
</table>
For our linear models 2 and 3, we removed the variables that were
dropped from lm1 due to multicollinearity or that yielded a high p-value
such as the number of words in the content (n\_tokens\_content), maximum
share of referenced articles (self\_reference\_max\_shares), maximum
polarity of positive words (max\_positive\_polarity), minimum polarity
of negative words (min\_negative\_polarity), and the dummy variables
indicating if the article was posted in a sunday (weekday\_is\_sunday)
or in the weekend (is\_weekend).

Finally, for our linear model 4 we used a stepwise selection (starting
from lm2 - with up to 10 steps) and, in order to determine the subset of
variables to include, we chose the one that yields the minimum Akaike
Information Criteria (AIC).

    lm2 = log(shares) ~ n_tokens_title + num_hrefs + num_self_hrefs + num_imgs + num_videos +            average_token_length + num_keywords + data_channel_is_lifestyle +                              data_channel_is_entertainment + data_channel_is_bus + data_channel_is_socmed +                 data_channel_is_tech + data_channel_is_world + self_reference_min_shares +                     self_reference_avg_sharess + weekday_is_monday + weekday_is_tuesday +                          weekday_is_wednesday + weekday_is_thursday + weekday_is_friday + weekday_is_saturday +         global_rate_positive_words + global_rate_negative_words + avg_positive_polarity +              min_positive_polarity + avg_negative_polarity + max_negative_polarity +                        title_subjectivity + title_sentiment_polarity + abs_title_sentiment_polarity

    lm3 = log(shares) ~ (n_tokens_title + num_hrefs + num_self_hrefs + num_imgs + num_videos +            average_token_length + num_keywords + data_channel_is_lifestyle +                              data_channel_is_entertainment + data_channel_is_bus + data_channel_is_socmed +                 data_channel_is_tech + data_channel_is_world + self_reference_min_shares +                     self_reference_avg_sharess + weekday_is_monday + weekday_is_tuesday +                          weekday_is_wednesday + weekday_is_thursday + weekday_is_friday + weekday_is_saturday +         global_rate_positive_words + global_rate_negative_words + avg_positive_polarity +              min_positive_polarity + avg_negative_polarity + max_negative_polarity +                        title_subjectivity + title_sentiment_polarity + abs_title_sentiment_polarity)^2

    lm4 = log(shares) ~ n_tokens_title + num_hrefs + num_self_hrefs + num_imgs + 
          num_videos + average_token_length + num_keywords + data_channel_is_lifestyle + 
          data_channel_is_entertainment + data_channel_is_bus + data_channel_is_socmed + 
          data_channel_is_tech + data_channel_is_world + self_reference_min_shares + 
          self_reference_avg_sharess + weekday_is_monday + weekday_is_tuesday + 
          weekday_is_wednesday + weekday_is_thursday + weekday_is_friday + 
          weekday_is_saturday + global_rate_positive_words + global_rate_negative_words + 
          avg_positive_polarity + min_positive_polarity + avg_negative_polarity + 
          max_negative_polarity + title_subjectivity + title_sentiment_polarity + 
          abs_title_sentiment_polarity + self_reference_min_shares:self_reference_avg_sharess + 
          num_self_hrefs:num_imgs + num_hrefs:data_channel_is_bus + 
          data_channel_is_socmed:avg_positive_polarity + num_keywords:global_rate_negative_words + 
          n_tokens_title:num_self_hrefs + num_self_hrefs:global_rate_positive_words + 
          num_imgs:data_channel_is_world + data_channel_is_entertainment:min_positive_polarity + 
          num_hrefs:data_channel_is_tech

In order to determine the most accurate model which accounts the
relevant variables to predict how articles reach the 1,400 shares
threshold, we utilized a bootstrap to randomly split the original
dataset in a training dataset containing 80% of the observations and a
testing a dataset containing the remaining 20%. We then repeated this
process 100 times and, for each repetition, we estimated our four linear
models using the train dataset, and fitted the values in the test
dataset to compare each model's prediction error rate.

The table shown below summarizes the average error rate for each of the
four models. The results were averaged over 100 random train/test split
samples in order to mollify the irregularities that could arise from
randomization of samples. We can infer from the results that, on
average, the third linear model yields the most accurate predictions.

<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
lm1
</th>
<th style="text-align:right;">
lm2
</th>
<th style="text-align:right;">
lm3
</th>
<th style="text-align:right;">
lm4
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
AVG Error Rate
</td>
<td style="text-align:right;">
0.41384
</td>
<td style="text-align:right;">
0.41357
</td>
<td style="text-align:right;">
0.39178
</td>
<td style="text-align:right;">
0.403
</td>
</tr>
</tbody>
</table>
The table below reports the confusion matrix yielded by lm3 when using
this model on the entire dataset. The model yielded an accuracy rate of
61.50% ((8051+16332)/39644) and an error rate of 38.50%
((12031+3230)/39644). Meanwhile, the true positive rate was 83.49%
(16332/(3230+16332)), and the false positive rate was 59.91%
(12031/(8051+12031)).

    ##      viral_hat
    ## viral     0     1
    ##     0  8051 12031
    ##     1  3230 16332

The model is clearly predicting too many false positives. However, to
assess its performance we need to compare these results to a "null"
model, which would be to always predict the outcome that is most common
in the data. Since 20082 out of 39644 articles didn't go viral, if we
predicted all the articles not to go viral our accuracy rate would be of
50.66% (20082/39644). Hence, our model improved the accuracy rate from
50.66% to 61.50%.

Another approach would be to analyze this question from a classification
perspective. We created a dummy variable viral, defined as having over
1,400 shares or not. By having the response variable as a binomial, we
were able to utilize the logit models which are listed below.

In the first logit model we included as explanatory variables all the
available features. In the second, we excluded those that showed
multicollinearity or too high p-values. In the third model, we used the
explanatory variables that were included the linear model that yielded
the highest accuracy rate.

    glm1 = viral ~ n_tokens_title + n_tokens_content + num_hrefs + num_self_hrefs + num_imgs +               num_videos + average_token_length + num_keywords + data_channel_is_lifestyle +                 data_channel_is_entertainment + data_channel_is_bus + data_channel_is_socmed +                 data_channel_is_tech + data_channel_is_world + self_reference_min_shares +                     self_reference_max_shares + self_reference_avg_sharess + weekday_is_monday +                   weekday_is_tuesday + weekday_is_wednesday + weekday_is_thursday +                              weekday_is_friday + weekday_is_saturday + weekday_is_sunday + is_weekend +                     global_rate_positive_words + global_rate_negative_words + avg_positive_polarity +               min_positive_polarity + max_positive_polarity + avg_negative_polarity +                        min_negative_polarity + max_negative_polarity + title_subjectivity +                           title_sentiment_polarity + abs_title_sentiment_polarity

    glm2 = viral ~ n_tokens_title + num_hrefs + num_self_hrefs + num_imgs + num_videos +                   average_token_length + num_keywords + data_channel_is_lifestyle +                              data_channel_is_entertainment + data_channel_is_bus + data_channel_is_socmed +                 data_channel_is_tech + data_channel_is_world + self_reference_min_shares +                     self_reference_avg_sharess + weekday_is_monday + weekday_is_tuesday +                          weekday_is_wednesday + weekday_is_thursday + weekday_is_friday + weekday_is_saturday +         global_rate_positive_words + global_rate_negative_words + avg_positive_polarity +              min_positive_polarity + avg_negative_polarity + max_negative_polarity +                        title_subjectivity + title_sentiment_polarity + abs_title_sentiment_polarity

    glm3 = viral ~ (n_tokens_title + num_hrefs + num_self_hrefs + num_imgs + num_videos +                  average_token_length + num_keywords + data_channel_is_lifestyle +                              data_channel_is_entertainment + data_channel_is_bus + data_channel_is_socmed +                 data_channel_is_tech + data_channel_is_world + self_reference_min_shares +                     self_reference_avg_sharess + weekday_is_monday + weekday_is_tuesday +                          weekday_is_wednesday + weekday_is_thursday + weekday_is_friday + weekday_is_saturday +         global_rate_positive_words + global_rate_negative_words + avg_positive_polarity +              min_positive_polarity + avg_negative_polarity + max_negative_polarity +                        title_subjectivity + title_sentiment_polarity + abs_title_sentiment_polarity)^2

As with we did with the linear models, we used a bootstrap to randomly
split the dataset into training and testing datasets containing 80% of
observations and 20% of observations respectively. This process was
repeated 50 times. For each repetition, we estimated three logit models
using the train dataset and used each model's prediction on the test set
to compare the accuracy rate when predicting which articles go viral.

The table shown below summarizes the average error rate for each of the
three models. The results were averaged over 50 random train/test split
samples in order to mollify the irregularities that could arise from
randomization of samples. We can infer from the results that, on
average, the third linear model yields the most accurate predictions.

<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
glm1
</th>
<th style="text-align:right;">
glm2
</th>
<th style="text-align:right;">
glm3
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
AVG Error Rate
</td>
<td style="text-align:right;">
0.3704
</td>
<td style="text-align:right;">
0.37056
</td>
<td style="text-align:right;">
0.3617
</td>
</tr>
</tbody>
</table>
The table below reports the confusion matrix yielded by glm3 when using
this model on the entire dataset. The model yielded an accuracy rate of
65.02% ((12963+12813)/39644) and an error rate of 34.98%
((7119+6749)/39644). Meanwhile, the true positive rate was 65.5%
(12813/(6749+12813)), and the false positive rate was 35.45%
(7119/(12963+7119)).

    ##      viral_hat
    ## viral     0     1
    ##     0 13062  7020
    ##     1  6911 12651

Having assessed the accuracy rates of the best models from the first and
the second the approach, the logit model turned out to perform slightly
better, giving a higher in-sample accuracy rate when trying to predict
which article went viral.

<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
Accuracy Rate
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
lm
</td>
<td style="text-align:right;">
0.6150489
</td>
</tr>
<tr>
<td style="text-align:left;">
glm
</td>
<td style="text-align:right;">
0.6485975
</td>
</tr>
</tbody>
</table>
Finally, we used the K-nearest neighbors methodology to build a
nonparametric predictive model and compare its results to those we found
using linear and logistic models. As we did with the other models, we
used a bootstrap to randomly split the dataset into training and testing
datasets containing 80% of observations and 20% of observations
respectively. This process was repeated 5 times. For each repetition, we
estimated 15 possible Ks (from 5 to 75, by 5)and compared its
predictions accuracy in the test dataset.

![](HW2_files/figure-markdown_strict/2.3.12-1.png)

We found that the optimal K and the average accuracy yielded by it was
the following.

<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:right;">
K
</th>
<th style="text-align:right;">
Accuracy
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
70
</td>
<td style="text-align:right;">
0.6261067
</td>
</tr>
</tbody>
</table>
Finally, we can conclude that the logit model (lm3) performed better
than the other models we tested. This model yielded a 63.79% out of
sample accuracy rate, and a 65.02% in sample accuracy rate. When we
compare it to the null-model (50.66%), improvement in the out of sample
accuracy rate reaches 28.35% (65.02/50.66 - 1).

As a conjecture, our best judgement is that the difference in the
performance between each approach possibly occurred due to the fact
that, when trying to predict the number of shares, the discrepancy in
the frequency distribution observed in the first histogram ends up
affecting the variance of the estimates. The logistic model we used
don't have that problem since its outcome is a probability (so bounded
between 0 and 1) and the fitted values that overcame the in-sample
probability of being viral as the models predictions.
