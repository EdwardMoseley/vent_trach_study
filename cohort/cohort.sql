-- ---
-- Create Trach_Cohort from cohort selected according to
-- Clinical Tables.Rmd
-- Note: Requires full MIMIC-III database
-- ---

DROP TABLE IF EXISTS trach_cohort CASCADE;
CREATE TABLE trach_cohort
(
  SUBJECT_ID INT NOT NULL,
  HADM_ID INT NOT NULL,
  ICUSTAY_ID INT NOT NULL,
  ADMITTIME TIMESTAMP(0) NOT NULL,
  INTIME TIMESTAMP(0) NOT NULL,
  FIRST_VENT_STARTTIME TIMESTAMP(0) NOT NULL,
  OUTTIME TIMESTAMP(0) NOT NULL,
  DISCHTIME TIMESTAMP(0) NOT NULL,
  DBSOURCE VARCHAR(15)
) ;

COPY trach_cohort(SUBJECT_ID, 
                  HADM_ID, 
                  ICUSTAY_ID, 
                  ADMITTIME, 
                  INTIME, 
                  FIRST_VENT_STARTTIME, 
                  OUTTIME, 
                  DISCHTIME,
                  DBSOURCE)

FROM '~/vent_trach_study/data/psql_keys.csv' DELIMITER ',' CSV HEADER;

--- Call queries

\i '~/vent_trach_study/queries/blood-gas-first-day.sql'
\i '~/vent_trach_study/queries/blood-gas-first-vent-day.sql'
\i '~/vent_trach_study/queries/blood-gas-seventh-vent-day.sql'

\i '~/vent_trach_study/queries/labs-first-day.sql'
\i '~/vent_trach_study/queries/labs-first-vent-day.sql'
\i '~/vent_trach_study/queries/labs-seventh-vent-day.sql'

\i '~/vent_trach_study/queries/vitals-first-day.sql'
\i '~/vent_trach_study/queries/vitals-first-vent-day.sql'
\i '~/vent_trach_study/queries/vitals-seventh-vent-day.sql'

\i '~/vent_trach_study/queries/weight-first-day.sql'
\i '~/vent_trach_study/queries/weight-first-vent-day.sql'
\i '~/vent_trach_study/queries/weight-seventh-vent-day.sql'

\i '~/vent_trach_study/queries/rrt-first-day.sql'
\i '~/vent_trach_study/queries/rrt-first-vent-day.sql'
\i '~/vent_trach_study/queries/rrt-seventh-vent-day.sql'

--- Copy output to csv

\copy (SELECT * FROM bloodgasfirstday) to '~/vent_trach_study/data/blood-gas-first-day.csv' with csv header
\copy (SELECT * FROM bloodgasfirstventday) to '~/vent_trach_study/data/blood-gas-first-vent-day.csv' with csv header
\copy (SELECT * FROM bloodgasseventhventday) to '~/vent_trach_study/data/blood-gas-seventh-vent-day.csv' with csv header

\copy (SELECT * FROM vitalsfirstday) to '~/vent_trach_studydata/data/vitals-first-day.csv' with csv header
\copy (SELECT * FROM vitalsfirstventday) to '~/vent_trach_study/data/vitals-first-vent-day.csv' with csv header
\copy (SELECT * FROM vitalsseventhventday) to '~/vent_trach_study/data/vitals-seventh-vent-day.csv' with csv header

\copy (SELECT * FROM labsfirstday) to '~/vent_trach_study/data/labs-first-day.csv' with csv header
\copy (SELECT * FROM labsfirstventday) to '~/vent_trach_study/data/labs-first-vent-day.csv' with csv header
\copy (SELECT * FROM labsseventhventday) to '~/vent_trach_study/data/labs-seventh-vent-day.csv' with csv header

\copy (SELECT * FROM weightfirstday) to '~/vent_trach_study/data/weight-first-day.csv' with csv header
\copy (SELECT * FROM weightfirstventday) to '~/vent_trach_study/data/weight-first-vent-day.csv' with csv header
\copy (SELECT * FROM weightseventhventday) to '~/vent_trach_study/data/weight-seventh-vent-day.csv' with csv header

\copy (SELECT * FROM rrtfirstday) to '~/vent_trach_study/data/rrt-first-day.csv' with csv header
\copy (SELECT * FROM rrtfirstventday) to '~/vent_trach_study/data/rrt-first-vent-day.csv' with csv header
\copy (SELECT * FROM rrtseventhventday) to '~/vent_trach_study/data/rrt-seventh-vent-day.csv' with csv header

\copy (SELECT * FROM vasopressordurations) to '~/vent_trach_study/data/vasopressordurations.csv' with csv header