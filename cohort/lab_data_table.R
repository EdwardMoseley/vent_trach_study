## Appendix 3: Vital Signs and Lab Values
    
## Data
dat <- read.csv("~/vent_trach_study/data/vent_trach_cohort_clean25May2020.csv", header = T,stringsAsFactors = F)


## Load Test/Train split
x_train <- read.csv("~/vent_trach_study/data/X_train.csv", header = T, stringsAsFactors = F)
x_test <- read.csv("~/vent_trach_study/data/X_test.csv", header = T, stringsAsFactors = F)

## d7_train
d7_train <- dat[(dat$ICUSTAY_ID %in% x_train$ICUSTAY_ID),]
## d7_test
d7_testing <- dat[(dat$ICUSTAY_ID %in% x_test$ICUSTAY_ID),]
  
## NOTE: USING "test" AS A VARIABLE LEVEL MESSES UP tableone package!!
d7_train$cohort <- rep("train", each = nrow(d7_train))
d7_testing$cohort <- rep("testing", each = nrow(d7_testing))

## collapse by binding data frames
dat <- rbind(d7_train, d7_testing)


## Clean
rm(list = ls()[grepl("test|train", ls())])



## Data
## LABS DAY ONE
## Create mean albumin
dat$LD1_ALBUMIN_MEAN <- apply(dat[,c("LD1_ALBUMIN_MIN", "LD1_ALBUMIN_MAX")], 1, mean)

## Create mean glucose
dat$LD1_GLUCOSE_MEAN <- apply(dat[,c("LD1_GLUCOSE_MIN", "LD1_GLUCOSE_MAX")], 1, mean)

## Anion Gap
dat$LD1_ANIONGAP_MEAN <- apply(dat[,c("LD1_ANIONGAP_MIN", "LD1_ANIONGAP_MAX")], 1, mean)

## Hemoglobin
dat$LD1_HEMOGLOBIN_MEAN <- apply(dat[,c("LD1_HEMOGLOBIN_MIN", "LD1_HEMOGLOBIN_MAX")], 1, mean)

## Hematocrit
dat$LD1_HEMATOCRIT_MEAN <- apply(dat[,c("LD1_HEMATOCRIT_MIN", "LD1_HEMATOCRIT_MAX")], 1, mean)

## WBCs
dat$LD1_WBC_MEAN <- apply(dat[,c("LD1_WBC_MIN", "LD1_WBC_MAX")], 1, mean)

## Platelets
dat$LD1_PLATELET_MEAN <- apply(dat[,c("LD1_PLATELET_MIN", "LD1_PLATELET_MAX")], 1, mean)

## Bands
dat$LD1_BANDS_MEAN <- apply(dat[,c("LD1_BANDS_MIN", "LD1_BANDS_MAX")], 1, mean)

## Sodium
dat$LD1_SODIUM_MEAN <- apply(dat[,c("LD1_SODIUM_MIN", "LD1_SODIUM_MAX")], 1, mean)

## Chloride
dat$LD1_CHLORIDE_MEAN <- apply(dat[,c("LD1_CHLORIDE_MIN", "LD1_CHLORIDE_MAX")], 1, mean)

## Bicarbonate
dat$LD1_BICARBONATE_MEAN <- apply(dat[,c("LD1_BICARBONATE_MIN", "LD1_BICARBONATE_MAX")], 1, mean)

## Blood Urea Nitrogen
dat$LD1_BUN_MEAN <- apply(dat[,c("LD1_BUN_MIN", "LD1_BUN_MAX")], 1, mean)

## Creatinine
dat$LD1_CREATININE_MEAN <- apply(dat[,c("LD1_CREATININE_MIN", "LD1_CREATININE_MAX")], 1, mean)

## Potassium
dat$LD1_POTASSIUM_MEAN <- apply(dat[,c("LD1_POTASSIUM_MIN", "LD1_POTASSIUM_MAX")], 1, mean)

## Labs MVD1

## LABS DAY ONE

## Create mean albumin
dat$LMVD1_ALBUMIN_MEAN <- apply(dat[,c("LMVD1_ALBUMIN_MIN", "LMVD1_ALBUMIN_MAX")], 1, mean)

## Create mean glucose
dat$LMVD1_GLUCOSE_MEAN <- apply(dat[,c("LMVD1_GLUCOSE_MIN", "LMVD1_GLUCOSE_MAX")], 1, mean)

## Anion Gap
dat$LMVD1_ANIONGAP_MEAN <- apply(dat[,c("LMVD1_ANIONGAP_MIN", "LMVD1_ANIONGAP_MAX")], 1, mean)

## Hemoglobin
dat$LMVD1_HEMOGLOBIN_MEAN <- apply(dat[,c("LMVD1_HEMOGLOBIN_MIN", "LMVD1_HEMOGLOBIN_MAX")], 1, mean)

## Hematocrit
dat$LMVD1_HEMATOCRIT_MEAN <- apply(dat[,c("LMVD1_HEMATOCRIT_MIN", "LMVD1_HEMATOCRIT_MAX")], 1, mean)

## WBCs
dat$LMVD1_WBC_MEAN <- apply(dat[,c("LMVD1_WBC_MIN", "LMVD1_WBC_MAX")], 1, mean)

## Platelets
dat$LMVD1_PLATELET_MEAN <- apply(dat[,c("LMVD1_PLATELET_MIN", "LMVD1_PLATELET_MAX")], 1, mean)

## Bands
dat$LMVD1_BANDS_MEAN <- apply(dat[,c("LMVD1_BANDS_MIN", "LMVD1_BANDS_MAX")], 1, mean)

## Sodium
dat$LMVD1_SODIUM_MEAN <- apply(dat[,c("LMVD1_SODIUM_MIN", "LMVD1_SODIUM_MAX")], 1, mean)

## Chloride
dat$LMVD1_CHLORIDE_MEAN <- apply(dat[,c("LMVD1_CHLORIDE_MIN", "LMVD1_CHLORIDE_MAX")], 1, mean)

## Bicarbonate
dat$LMVD1_BICARBONATE_MEAN <- apply(dat[,c("LMVD1_BICARBONATE_MIN", "LMVD1_BICARBONATE_MAX")], 1, mean)

## Blood Urea Nitrogen
dat$LMVD1_BUN_MEAN <- apply(dat[,c("LMVD1_BUN_MIN", "LMVD1_BUN_MAX")], 1, mean)

## Creatinine
dat$LMVD1_CREATININE_MEAN <- apply(dat[,c("LMVD1_CREATININE_MIN", "LMVD1_CREATININE_MAX")], 1, mean)

## Potassium
dat$LMVD1_POTASSIUM_MEAN <- apply(dat[,c("LMVD1_POTASSIUM_MIN", "LMVD1_POTASSIUM_MAX")], 1, mean)




## LABS DAY 7

## LABS DAY ONE

## Create mean albumin
dat$LMVD7_ALBUMIN_MEAN <- apply(dat[,c("LMVD7_ALBUMIN_MIN", "LMVD7_ALBUMIN_MAX")], 1, mean)

## Create mean glucose
dat$LMVD7_GLUCOSE_MEAN <- apply(dat[,c("LMVD7_GLUCOSE_MIN", "LMVD7_GLUCOSE_MAX")], 1, mean)

## Anion Gap
dat$LMVD7_ANIONGAP_MEAN <- apply(dat[,c("LMVD7_ANIONGAP_MIN", "LMVD7_ANIONGAP_MAX")], 1, mean)

## Hemoglobin
dat$LMVD7_HEMOGLOBIN_MEAN <- apply(dat[,c("LMVD7_HEMOGLOBIN_MIN", "LMVD7_HEMOGLOBIN_MAX")], 1, mean)

## Hematocrit
dat$LMVD7_HEMATOCRIT_MEAN <- apply(dat[,c("LMVD7_HEMATOCRIT_MIN", "LMVD7_HEMATOCRIT_MAX")], 1, mean)

## WBCs
dat$LMVD7_WBC_MEAN <- apply(dat[,c("LMVD7_WBC_MIN", "LMVD7_WBC_MAX")], 1, mean)

## Platelets
dat$LMVD7_PLATELET_MEAN <- apply(dat[,c("LMVD7_PLATELET_MIN", "LMVD7_PLATELET_MAX")], 1, mean)

## Bands
dat$LMVD7_BANDS_MEAN <- apply(dat[,c("LMVD7_BANDS_MIN", "LMVD7_BANDS_MAX")], 1, mean)

## Sodium
dat$LMVD7_SODIUM_MEAN <- apply(dat[,c("LMVD7_SODIUM_MIN", "LMVD7_SODIUM_MAX")], 1, mean)

## Chloride
dat$LMVD7_CHLORIDE_MEAN <- apply(dat[,c("LMVD7_CHLORIDE_MIN", "LMVD7_CHLORIDE_MAX")], 1, mean)

## Bicarbonate
dat$LMVD7_BICARBONATE_MEAN <- apply(dat[,c("LMVD7_BICARBONATE_MIN", "LMVD7_BICARBONATE_MAX")], 1, mean)

## Blood Urea Nitrogen
dat$LMVD7_BUN_MEAN <- apply(dat[,c("LMVD7_BUN_MIN", "LMVD7_BUN_MAX")], 1, mean)

## Creatinine
dat$LMVD7_CREATININE_MEAN <- apply(dat[,c("LMVD7_CREATININE_MIN", "LMVD7_CREATININE_MAX")], 1, mean)

## Potassium
dat$LMVD7_POTASSIUM_MEAN <- apply(dat[,c("LMVD7_POTASSIUM_MIN", "LMVD7_POTASSIUM_MAX")], 1, mean)


## Subset necessary data
dat <- dat[ ,c("RRTMVD7_RRT",
              "VPMVD7_VP",
            ## Physiology on ICU Admission 
              "VD1_HEARTRATE_MEAN",
              "VD1_SYSBP_MEAN",
              "VD1_DIASBP_MEAN",
            ## MAP not available
              "VD1_RESPRATE_MEAN",
              "VD1_SPO2_MEAN",
              "BMID1",
              "VD1_TEMPC_MEAN",
            ## GCS not available
            "LD1_ALBUMIN_MEAN", 
            "LD1_GLUCOSE_MEAN",                   
            "LD1_ANIONGAP_MEAN", 
            "LD1_HEMOGLOBIN_MEAN",                
            "LD1_HEMATOCRIT_MEAN", 
            "LD1_WBC_MEAN",                       
            "LD1_PLATELET_MEAN",                   
            "LD1_BANDS_MEAN",                     
            "LD1_SODIUM_MEAN",                     
            "LD1_CHLORIDE_MEAN",                  
            "LD1_BICARBONATE_MEAN",                
            "LD1_BUN_MEAN",                       
            "LD1_CREATININE_MEAN",                 
            "LD1_POTASSIUM_MEAN",                 
            "LMVD1_ALBUMIN_MEAN",                  
            "LMVD1_GLUCOSE_MEAN",                 
            "LMVD1_ANIONGAP_MEAN",                 
            "LMVD1_HEMOGLOBIN_MEAN",              
            "LMVD1_HEMATOCRIT_MEAN",               
            "LMVD1_WBC_MEAN",                     
            "LMVD1_PLATELET_MEAN",                 
            "LMVD1_BANDS_MEAN",                   
            "LMVD1_SODIUM_MEAN",                   
            "LMVD1_CHLORIDE_MEAN",                
            "LMVD1_BICARBONATE_MEAN",              
            "LMVD1_BUN_MEAN",                     
            "LMVD1_CREATININE_MEAN",               
            "LMVD1_POTASSIUM_MEAN",               
            "LMVD7_ALBUMIN_MEAN",                  
            "LMVD7_GLUCOSE_MEAN",                 
            "LMVD7_ANIONGAP_MEAN",                 
            "LMVD7_HEMOGLOBIN_MEAN",              
            "LMVD7_HEMATOCRIT_MEAN",               
            "LMVD7_WBC_MEAN",                     
            "LMVD7_PLATELET_MEAN",                 
            "LMVD7_BANDS_MEAN",               
            "LMVD7_SODIUM_MEAN",                   
            "LMVD7_CHLORIDE_MEAN",                
            "LMVD7_BICARBONATE_MEAN",
            "LMVD7_BUN_MEAN",
            "LMVD7_CREATININE_MEAN",
            "LMVD7_POTASSIUM_MEAN", 
            "cohort")]


## Factor
dat$RRTMVD7_RRT <- factor(dat$RRTMVD7_RRT)
dat$VPMVD7_VP <- factor(dat$VPMVD7_VP)

## Nonnormal columns of interest
cols_of_int <- c(## Physiology on ICU Admission 
                 "VD1_HEARTRATE_MEAN",
                 "VD1_SYSBP_MEAN",
                 "VD1_DIASBP_MEAN",
                 ## MAP not available
                 "VD1_RESPRATE_MEAN",
                 "VD1_SPO2_MEAN",
                 "BMID1",
                 "VD1_TEMPC_MEAN",
                 ## GCS not available
                 "LD1_ALBUMIN_MEAN", 
                 "LD1_GLUCOSE_MEAN",                   
                 "LD1_ANIONGAP_MEAN", 
                 "LD1_HEMOGLOBIN_MEAN",                
                 "LD1_HEMATOCRIT_MEAN", 
                 "LD1_WBC_MEAN",                       
                 "LD1_PLATELET_MEAN",                   
                 "LD1_BANDS_MEAN",                     
                 "LD1_SODIUM_MEAN",                     
                 "LD1_CHLORIDE_MEAN",                  
                 "LD1_BICARBONATE_MEAN",                
                 "LD1_BUN_MEAN",                       
                 "LD1_CREATININE_MEAN",                 
                 "LD1_POTASSIUM_MEAN",                 
                 "LMVD1_ALBUMIN_MEAN",                  
                 "LMVD1_GLUCOSE_MEAN",                 
                 "LMVD1_ANIONGAP_MEAN",                 
                 "LMVD1_HEMOGLOBIN_MEAN",              
                 "LMVD1_HEMATOCRIT_MEAN",               
                 "LMVD1_WBC_MEAN",                     
                 "LMVD1_PLATELET_MEAN",                 
                 "LMVD1_BANDS_MEAN",                   
                 "LMVD1_SODIUM_MEAN",                   
                 "LMVD1_CHLORIDE_MEAN",                
                 "LMVD1_BICARBONATE_MEAN",              
                 "LMVD1_BUN_MEAN",                     
                 "LMVD1_CREATININE_MEAN",               
                 "LMVD1_POTASSIUM_MEAN",               
                 "LMVD7_ALBUMIN_MEAN",                  
                 "LMVD7_GLUCOSE_MEAN",                 
                 "LMVD7_ANIONGAP_MEAN",                 
                 "LMVD7_HEMOGLOBIN_MEAN",              
                 "LMVD7_HEMATOCRIT_MEAN",               
                 "LMVD7_WBC_MEAN",                     
                 "LMVD7_PLATELET_MEAN",                 
                 "LMVD7_BANDS_MEAN",                   
                 "LMVD7_SODIUM_MEAN",                   
                 "LMVD7_CHLORIDE_MEAN",                
                 "LMVD7_BICARBONATE_MEAN",              
                 "LMVD7_BUN_MEAN",                     
                 "LMVD7_CREATININE_MEAN",               
                 "LMVD7_POTASSIUM_MEAN",  
                 "cohort")

write.csv(print(tableone::CreateTableOne(data = dat, strata = "cohort"), nonnormal = cols_of_int, noSpaces = T), file = "~/vent_trach_study/appendix_3_30May2020.csv")

## Reload appendix to change brackets to parentheses
app <- read.csv("~/vent_trach_study/appendix_3_30May2020.csv", header = T, stringsAsFactors = F)

## Convert brackets to parentheses
for (nm in colnames(app)){
  app[[nm]] <- gsub("\\[", "(", app[[nm]])
  app[[nm]] <- gsub("\\]", ")", app[[nm]])
}

write.csv(app, file = "~/vent_trach_study/appendix_3_30May2020.csv")
