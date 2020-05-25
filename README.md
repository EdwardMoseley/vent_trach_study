# Deep Learning to Predict Mortality Prior to Tracheostomy Decision in Adults with Respiratory Failure

This github repo represents the code base used to perform this study.

This code base relies on [MIMIC-III](https://mimic.physionet.org/) for data substrate, as well as queries from the [MIMIC-III Code Repository](https://github.com/MIT-LCP/mimic-code). Any SQL queries refer to MIMIC-III's [postgres build](https://github.com/MIT-LCP/mimic-code/tree/master/buildmimic/postgres).

To recreate the analysis:

1. `cohort/Cohort Selection.Rmd` is used to generate the cohort from MIMIC-III flat files.
  * a `MIMIC-III` folder containing the database's flat files is required

2. `cohort/cohort.sql` is used to perform more complex queries for MIMIC-III-derived data, including illness severity scores, mechanical ventilation status, etc.

3. `cohort/Clinical Tables.Rmd` is used to generate the entire data set from the tables which are output from `cohort.sql`.

4. `modeling/Preprocessing for Modeling.ipynb` is used to preprocess data (scaling, normalization) and perform the training/testing split.

5. `modeling/modelfinding_1yr_mort.ipynb` and `modeling/modelfinding_3mo_mort.ipynb` are used to conduct a neural architecture search for their respective models.

6. `modeling/Model Evaluation.ipynb` is used to analyze and visualize resulting model metrics.