/*TITLE:        descriptives_inferential_cd_2018.do
  INVESTIGATOR: Christopher R Gonzales
  SAMPLE:       Children's Museum and Lab Schools 2012-2016
  PURPOSE:      Provide descriptive and inferential Statistics for
				        "Introspection Plays an Early Role in in Children's Explicit
				        Theory of Mind Development" in Child Development (2018)
				        doi: 10.1111/cdev.12876
  DATE:			    05/10/2022
  EDITED BY: 	  CRG
*/

****extra stata modules****

*note: only uncomment if needed to be installed on the current workstation

/*
fre - frequency tables
ssc install fre

pcorrmatt - pairwise correlations controlling for multiple variables
ssc install pcorrmat
*/



*Data File Location
clear
cd ..\data\
use cd_2018_fulldata.dta


********************************************************************************
*       (1) Summary of Study Sample and Demographics                           *
********************************************************************************

*calculating children's ages from DOB and TestDate
/*
Stata stores dates and times in units of milliseconds. The extra divisions after
the basic subtraction are to transform the values from milliseconds to years
*/

gen age_years = (Test_Date - DOB)/1000/60/60/24/365

*Create Simple Histogram of calculated age variable
/*
The option ", freq" after hist request that the histgram Y-axis be in simple
count rather than in sample density units.
*/
hist age_years, freq

*Recode age_years into categorical variable for Descriptive purposes
**save as a new variable age_group
recode age_years 0/3 = 2 3/4 = 3 4/5 = 4 5/max = 6, generate(age_group)
fre age_group

*calculate other reported demographic variables from analyses
fre gender source tasks

********************************************************************************
*     (2) Descriptives of individual Tasks By Age - Table 1                    *
********************************************************************************

*Calcualte proportion pass for each task by age group
sort age_group
by age_group: sum sp op sk ok

*Calcualte binomial test against change performance for each task.
by age_group: bitest sp = .25
by age_group: bitest op = .25
by age_group: bitest sk = .25
by age_group: bitest ok = .25

********************************************************************************
*     (3) Transform Data to Long Format and conduct MLM Table 2    *
********************************************************************************


********************************************************************************
*     (4) Examine Patterns of Error Data on Tasks - Table 3                    *
********************************************************************************
