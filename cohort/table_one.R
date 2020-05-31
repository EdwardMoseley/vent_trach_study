## Table One

## Use tableone package for ease
if (!require("tableone")){install.packages("tableone")}

## to_hours
## convert MIMIC-III date time format to hours
to_hours <- function(some_time){
  return(as.numeric(strptime(some_time, "%Y-%m-%d %H:%M:%S", tz = "EST"))/(60*60))
}

## Load data set from our first trach study folder
dat <- read.csv("~/vent_trach_study/data/vent_trach_cohort_clean25May2020.csv", header = T, stringsAsFactors = F)

## Simplify ethnicity by bucketing
## table(dat$ETHNICITY)

## Reduce the number of ethnicities by scoping outward
dat[(grepl("WHITE", dat$ETHNICITY)),]$ETHNICITY <- "WHITE"
dat[(grepl("BLACK", dat$ETHNICITY)),]$ETHNICITY <- "BLACK"
dat[(grepl("HISPANIC", dat$ETHNICITY)),]$ETHNICITY <- "HISPANIC"
dat[(grepl("ASIAN", dat$ETHNICITY)),]$ETHNICITY <- "ASIAN"
dat[(grepl("PORTUGUESE", dat$ETHNICITY)),]$ETHNICITY <- "WHITE"
dat[(grepl("MIDDLE|NATIVE|MULTI|DECLINED|UNABLE|OTHER|NOT", dat$ETHNICITY)),]$ETHNICITY <- "UNKNOWN/OTHER"

## table(dat$ETHNICITY)

## Create Elixhauser Score by subsetting summing score components on hospital admission
dat$HOSP_ADMIT_ELIXHAUSER <- apply(dat[,grepl("HOSP_ADMIT_", colnames(dat))], 1, sum)

## Need: Admission date
## Date of Death
## Discharge Location
## Length of Stay

## Load MIMIC for missing data
adm <- read.csv("~/vent_trach_study/MIMIC-III/ADMISSIONS.csv", header = T, stringsAsFactors = F)
## Remove indices, keep only necessary rows
adm$ROW_ID <- NULL

## ICUSTAYS "icustay_detail" derived table
icu <- read.csv("~/vent_trach_study/MIMIC-III/icustay_detail.csv", header = T, stringsAsFactors = F)
## Change colnames to uppercase
colnames(icu) <- toupper(colnames(icu))

## Merge data sets
mimic <- merge(icu, adm, by = intersect(colnames(adm), colnames(icu)))

## Keep only rows needed
mimic <- mimic[ ,c("SUBJECT_ID",
                   "HADM_ID",
                   "ICUSTAY_ID",
                   "ADMITTIME",
                   "DOD",
                   "DISCHARGE_LOCATION",
                   "LOS_HOSPITAL",
                   "LOS_ICU")]

## Subset Table One Variables
dat <- dat[ ,c("SUBJECT_ID",
               "HADM_ID",
               "ICUSTAY_ID",
               "ADMISSION_AGE",
               "GENDER",
               "ETHNICITY",
               "ADMISSION_TYPE",
               "ADMISSION_LOCATION",
               "FIRST_CAREUNIT",
               "MORTALITY_3MO_DISCH",
               "MORTALITY_1YR_DISCH",
               "ICU_D1_APSIII",
               "ICU_D1_OASIS",
               "ICU_D1_SOFA",
               "ICU_D1_LODS",
               "ICU_D1_SAPSII",
               "HOSP_ADMIT_ELIXHAUSER", # Overall
               "HOSP_ADMIT_CONGESTIVE_HEART_FAILURE",
               "HOSP_ADMIT_CHRONIC_PULMONARY",
               "HOSP_ADMIT_LIVER_DISEASE",
               "HOSP_ADMIT_RENAL_FAILURE",
               "HOSP_ADMIT_METASTATIC_CANCER",
               "HOSP_ADMIT_PSYCHOSES",
               "HOSP_ADMIT_ALCOHOL_ABUSE",
               "HOSP_ADMIT_DRUG_ABUSE")]


## Merge to MIMIC
dat <- merge(dat, mimic, by = intersect(colnames(dat), colnames(mimic)))

## Order for ease
dat <- dat[with(dat, order(SUBJECT_ID, HADM_ID, ICUSTAY_ID)),]

## Generate date data in DAYS
dat$DAYS_UNTIL_DEATH <- (to_hours(dat$DOD) - to_hours(dat$ADMITTIME))/24

## Create another age column for median
dat$ADMISSION_AGE_NONNORM <- dat$ADMISSION_AGE

## Drop variables used to generate data...
dat$DOD <- NULL
dat$ADMITTIME <- NULL


## Convert mortality from boolean to numeric
dat$MORTALITY_3MO_DISCH <- as.numeric(dat$MORTALITY_3MO_DISCH)
dat$MORTALITY_1YR_DISCH <- as.numeric(dat$MORTALITY_1YR_DISCH)


## Change levels for tabulation
## Admission Location
dat[(grepl("REFERRAL", dat$ADMISSION_LOCATION)),]$ADMISSION_LOCATION <- "PHYS/CLINIC REFERRAL"
dat[(grepl("TRANSFER", dat$ADMISSION_LOCATION)),]$ADMISSION_LOCATION <- "TRANSFER FROM HOSP/SNF"


## Discharge Location
## Rehab = SNF
dat$DISCHARGE_LOCATION <- ifelse(dat$DISCHARGE_LOCATION == "REHAB/DISTINCT PART HOSP", "SNF", dat$DISCHARGE_LOCATION)
## Aggregate SHORT TERM HOSPITAL and OTHER
dat$DISCHARGE_LOCATION <- ifelse(dat$DISCHARGE_LOCATION == "SHORT TERM HOSPITAL", "SHORT TERM HOSPITAL/OTHER", dat$DISCHARGE_LOCATION)
dat$DISCHARGE_LOCATION <- ifelse(dat$DISCHARGE_LOCATION == "OTHER FACILITY", "SHORT TERM HOSPITAL/OTHER", dat$DISCHARGE_LOCATION)
## Hospice
dat[(grepl("HOSPICE", dat$DISCHARGE_LOCATION)),]$DISCHARGE_LOCATION <- "HOSPICE"
## DISC ~= HOME HEALTH
dat[(grepl("DISC", dat$DISCHARGE_LOCATION)),]$DISCHARGE_LOCATION <- "HOME HEALTH CARE"
## Home = Home/Home Health
dat[(grepl("HOME", dat$DISCHARGE_LOCATION)),]$DISCHARGE_LOCATION <- "HOME/HOME HEALTH CARE"
## Left = Home
dat[(grepl("LEFT", dat$DISCHARGE_LOCATION)),]$DISCHARGE_LOCATION <- "HOME/HOME HEALTH CARE"

## RENAME ELIXHAUSER SCORE FOR EASE
colnames(dat)[which(colnames(dat) == "HOSP_ADMIT_ELIXHAUSER")] <- "ELIXHAUSER"


## Load Test/Train split
x_train <- read.csv("~/vent_trach_study/data/X_train.csv", header = T, stringsAsFactors = F)
x_test <- read.csv("~/vent_trach_study/data/X_test.csv", header = T, stringsAsFactors = F)

## d7_train
d7_train <- dat[(dat$ICUSTAY_ID %in% x_train$ICUSTAY_ID),]
## d7_test
d7_testing <- dat[(dat$ICUSTAY_ID %in% x_test$ICUSTAY_ID),]



## Clean
rm(adm, icu, mimic, dat, x_train, x_test)


## Double-check
nrow(d7_train) + nrow(d7_testing)

## add cohort
## NOTE: USING "test" AS A VARIABLE LEVEL MESSES UP tableone package!!
d7_train$cohort <- rep("train", each = nrow(d7_train))
d7_testing$cohort <- rep("testing", each = nrow(d7_testing))

## collapse by binding data frames
d7 <- rbind(d7_train, d7_testing)

## Clean
rm(list = ls()[grepl("testing|train", ls())])

## Factor character variables with a wicked one-liner before tabulating
for (name in colnames(d7)) if (is.character(d7[[name]])) d7[[name]] <- as.factor(d7[[name]])

## Factor Elixhauser Comorbidities

for (name in colnames(d7)[grepl("HOSP_ADMIT_", colnames(d7))]) d7[[name]] <- as.factor(d7[[name]])

## Factor Mortality

for (name in colnames(d7)[grepl("MORTALITY", colnames(d7))]) d7[[name]] <- as.factor(d7[[name]])

## Define non normal variables
non_normal <- c("ADMISSION_AGE_NONNORM", 
                "ICU_D1_APSIII", 
                "ICU_D1_OASIS",
                "ICU_D1_SOFA",
                "ICU_D1_LODS",
                "ICU_D1_SAPSII",
                "LOS_HOSPITAL",
                "LOS_ICU",
                "ELIXHAUSER",
                "DAYS_UNTIL_DEATH")


d7_tab <- CreateTableOne(data = d7, strata = "cohort")

write.csv(print(d7_tab, nonnormal = non_normal, 
                quote = F, noSpaces = T, showAllLevels = T), file = "~/vent_trach_study/table_one30May2020.csv")