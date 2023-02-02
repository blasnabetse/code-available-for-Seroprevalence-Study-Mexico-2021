use "/Users/insp/Dropbox/INSP 2021/ENSANUT/Seroprevalencia ensanut 2021/Paper seroprevalencia/Github/Dataset_seroprevalence2.dta", clear

*****Main analysis only include adults 
keep if age>=18

cd "/Users/insp/Dropbox/INSP 2021/ENSANUT/Seroprevalencia ensanut 2021/tabout

***Table 1
tabout sex agecat nseF education ocupation area region pos_papel using "Tabla 1_s.xls",replace  `modo' cells(row ci) format(1) `encabezado' h3("`vlabel' `encabezado2'") svy percent
tabout sex agecat nseF education ocupation area region posn_papel using "Tabla 1_n.xls",replace  `modo' cells(row ci) format(1) `encabezado' h3("`vlabel' `encabezado2'") svy percent

***Table 2
tabout sex agecat nseF education ocupation area region vaccinated using "Tabla 1_v.xls",replace  `modo' cells(row ci) format(1) `encabezado' h3("`vlabel' `encabezado2'") svy percent

egen agecat2=cut(age), at (18, 60, 120)
table agecat2, contents(min age max age) 


******Non-adjusted seroprevalences by type of vaccine
svy, sub(if age>=18&vaccinated==1): prop pos_papel, over(typevaccine)


***Adjusted seroprevalence by age group and type of vaccine 
svy, sub(if inrange(age,18,59)&vaccinated==1): poisson pos_papel i.sex age i.posn_papel tiempo_vac i.typevaccine
margins typevaccine, asbalanced atmeans
margins, asbalanced

svy, sub(if inrange(age,18,59)&vaccinated==1 & scheme==2): poisson pos_papel i.sex i.posn_papel tiempo_vac i.typevaccine
margins typevaccine, asbalanced atmeans
margins, asbalanced atmeans

svy, sub(if inrange(age,60,103)&vaccinated==1): poisson pos_papel i.sex age i.posn_papel tiempo_vac i.typevaccine 
margins typevaccine, asbalanced atmeans
margins, asbalanced atmeans

svy, sub(if inrange(age,60,103)&vaccinated==1&scheme==2): poisson pos_papel i.sex i.posn_papel tiempo_vac i.typevaccine 
margins typevaccine, asbalanced atmeans
margins, asbalanced atmeans

svy, sub(if vaccinated==1): poisson pos_papel i.sex age i.posn_papel tiempo_vac i.typevaccine 
margins typevaccine, asbalanced atmeans
margins, asbalanced



*****For the sensitivity analysis - Prevalence of antiN seroprevalence for people that had not taken the sinovac vaccine
svy, sub(if age>=18&typevaccine!=3): prop posn_papel



***Supplementary analysis**************
tabout sex agecat region posn_papel complete tiempo_vac_cat2 tipovacuna if edad>=18 using "Supplementary table.xls",replace  `modo' cells(row ci) format(1) `encabezado' h3("`vlabel' `encabezado2'") svy percent

****Table sample size****
tabout sex agecat nseF education ocupation area region vaccinated complete time_vac_cov2 typevaccine posn_papel using frec_muestral.xls,  c(freq) pop replace
tabout sex agecat nseF education ocupation area region vaccinated complete time_vac_cov2 typevaccine posn_papel using frec_.xls, svy c(freq) pop replace
tabout sex agecat nseF education ocupation area region vaccinated complete time_vac_cov2 typevaccine posn_papel using prev1.xls, cells(col ci) format(1) `encabezado' h3("`vlabel' `encabezado2'") svy percent replace

****Seroprevalences by month since vaccination
svy, sub(if age>=18&vaccinated==1&time_vac_cat3==0): prop pos_papel, over(agecat2)
svy, sub(if age>=18&vaccinated==1&time_vac_cat3==2): prop pos_papel, over(agecat2)
svy, sub(if age>=18&vaccinated==1&time_vac_cat3==4): prop pos_papel, over(agecat2)
svy, sub(if age>=18&vaccinated==1&time_vac_cat3==6): prop pos_papel, over(agecat2)


****Seroprevalences among non-vaccinated
svy, sub(if age>=18): prop posn_papel, over(vaccinated)
svy, sub(if age>=18): prop pos_papel, over(vaccinated)


******Non-adjusted seroprevalences by type of vaccine and age
svy, sub(if vaccinated==1&agecat2==18): prop pos_papel, over(typevaccine)
svy, sub(if vaccinated==1&agecat2==60): prop pos_papel, over(typevaccine)

svy, sub(if vaccinated==1&agecat2==18): prop pos_papel
svy, sub(if vaccinated==1&agecat2==60): prop pos_papel
