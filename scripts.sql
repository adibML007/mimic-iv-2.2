-------------------------------------------
-- Create the tables and MIMIC-IV schema --
-------------------------------------------

----------------------
-- Creating schemas --
----------------------

DROP SCHEMA IF EXISTS mimiciv_hosp CASCADE;
CREATE SCHEMA mimiciv_hosp;
DROP SCHEMA IF EXISTS mimiciv_icu CASCADE;
CREATE SCHEMA mimiciv_icu;
--DROP SCHEMA IF EXISTS mimiciv_derived CASCADE;
--CREATE SCHEMA mimiciv_derived;

---------------------
-- Creating tables --
---------------------

-- hosp schema

DROP TABLE IF EXISTS mimiciv_hosp.admissions;
CREATE TABLE mimiciv_hosp.admissions
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER NOT NULL,
  admittime TIMESTAMP NOT NULL,
  dischtime TIMESTAMP,
  deathtime TIMESTAMP,
  admission_type VARCHAR(40) NOT NULL,
  admit_provider_id VARCHAR(10),
  admission_location VARCHAR(60),
  discharge_location VARCHAR(60),
  insurance VARCHAR(255),
  language VARCHAR(10),
  marital_status VARCHAR(30),
  race VARCHAR(80),
  edregtime TIMESTAMP,
  edouttime TIMESTAMP,
  hospital_expire_flag SMALLINT
);

DROP TABLE IF EXISTS mimiciv_hosp.d_hcpcs;
CREATE TABLE mimiciv_hosp.d_hcpcs
(
  code CHAR(5) NOT NULL,
  category SMALLINT,
  long_description TEXT,
  short_description VARCHAR(180)
);

DROP TABLE IF EXISTS mimiciv_hosp.diagnoses_icd;
CREATE TABLE mimiciv_hosp.diagnoses_icd
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER NOT NULL,
  seq_num INTEGER NOT NULL,
  icd_code CHAR(7),
  icd_version SMALLINT
);

DROP TABLE IF EXISTS mimiciv_hosp.d_icd_diagnoses;
CREATE TABLE mimiciv_hosp.d_icd_diagnoses
(
  icd_code CHAR(7) NOT NULL,
  icd_version SMALLINT NOT NULL,
  long_title VARCHAR(255)
);

DROP TABLE IF EXISTS mimiciv_hosp.d_icd_procedures;
CREATE TABLE mimiciv_hosp.d_icd_procedures
(
  icd_code CHAR(7) NOT NULL,
  icd_version SMALLINT NOT NULL,
  long_title VARCHAR(222)
);

DROP TABLE IF EXISTS mimiciv_hosp.d_labitems;
CREATE TABLE mimiciv_hosp.d_labitems
(
  itemid INTEGER NOT NULL,
  label VARCHAR(50),
  fluid VARCHAR(50),
  category VARCHAR(50)
);

DROP TABLE IF EXISTS mimiciv_hosp.drgcodes;
CREATE TABLE mimiciv_hosp.drgcodes
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER NOT NULL,
  drg_type VARCHAR(4),
  drg_code VARCHAR(10) NOT NULL,
  description VARCHAR(195),
  drg_severity SMALLINT,
  drg_mortality SMALLINT
);

DROP TABLE IF EXISTS mimiciv_hosp.emar_detail;
CREATE TABLE mimiciv_hosp.emar_detail
(
  subject_id INTEGER NOT NULL,
  emar_id VARCHAR(25) NOT NULL,
  emar_seq INTEGER NOT NULL,
  parent_field_ordinal VARCHAR(10),
  administration_type VARCHAR(50),
  pharmacy_id INTEGER,
  barcode_type VARCHAR(4),
  reason_for_no_barcode TEXT,
  complete_dose_not_given VARCHAR(5),
  dose_due VARCHAR(100),
  dose_due_unit VARCHAR(50),
  dose_given VARCHAR(255),
  dose_given_unit VARCHAR(50),
  will_remainder_of_dose_be_given VARCHAR(5),
  product_amount_given VARCHAR(30),
  product_unit VARCHAR(30),
  product_code VARCHAR(30),
  product_description VARCHAR(255),
  product_description_other VARCHAR(255),
  prior_infusion_rate VARCHAR(40),
  infusion_rate VARCHAR(40),
  infusion_rate_adjustment VARCHAR(50),
  infusion_rate_adjustment_amount VARCHAR(30),
  infusion_rate_unit VARCHAR(30),
  route VARCHAR(10),
  infusion_complete VARCHAR(1),
  completion_interval VARCHAR(50),
  new_iv_bag_hung VARCHAR(1),
  continued_infusion_in_other_location VARCHAR(1),
  restart_interval VARCHAR(2305),
  side VARCHAR(10),
  site VARCHAR(255),
  non_formulary_visual_verification VARCHAR(1)
);

DROP TABLE IF EXISTS mimiciv_hosp.emar;
CREATE TABLE mimiciv_hosp.emar
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER,
  emar_id VARCHAR(25) NOT NULL,
  emar_seq INTEGER NOT NULL,
  poe_id VARCHAR(25) NOT NULL,
  pharmacy_id INTEGER,
  enter_provider_id VARCHAR(10),
  charttime TIMESTAMP NOT NULL,
  medication TEXT,
  event_txt VARCHAR(100),
  scheduletime TIMESTAMP,
  storetime TIMESTAMP NOT NULL
);

DROP TABLE IF EXISTS mimiciv_hosp.hcpcsevents;
CREATE TABLE mimiciv_hosp.hcpcsevents
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER NOT NULL,
  chartdate DATE,
  hcpcs_cd CHAR(5) NOT NULL,
  seq_num INTEGER NOT NULL,
  short_description VARCHAR(180)
);

DROP TABLE IF EXISTS mimiciv_hosp.labevents;
CREATE TABLE mimiciv_hosp.labevents
(
  labevent_id INTEGER NOT NULL,
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER,
  specimen_id INTEGER NOT NULL,
  itemid INTEGER NOT NULL,
  order_provider_id VARCHAR(10),
  charttime TIMESTAMP(0),
  storetime TIMESTAMP(0),
  value VARCHAR(200),
  valuenum DOUBLE PRECISION,
  valueuom VARCHAR(20),
  ref_range_lower DOUBLE PRECISION,
  ref_range_upper DOUBLE PRECISION,
  flag VARCHAR(10),
  priority VARCHAR(7),
  comments TEXT
);

DROP TABLE IF EXISTS mimiciv_hosp.microbiologyevents;
CREATE TABLE mimiciv_hosp.microbiologyevents
(
  microevent_id INTEGER NOT NULL,
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER,
  micro_specimen_id INTEGER NOT NULL,
  order_provider_id VARCHAR(10),
  chartdate TIMESTAMP(0) NOT NULL,
  charttime TIMESTAMP(0),
  spec_itemid INTEGER NOT NULL,
  spec_type_desc VARCHAR(100) NOT NULL,
  test_seq INTEGER NOT NULL,
  storedate TIMESTAMP(0),
  storetime TIMESTAMP(0),
  test_itemid INTEGER,
  test_name VARCHAR(100),
  org_itemid INTEGER,
  org_name VARCHAR(100),
  isolate_num SMALLINT,
  quantity VARCHAR(50),
  ab_itemid INTEGER,
  ab_name VARCHAR(30),
  dilution_text VARCHAR(10),
  dilution_comparison VARCHAR(20),
  dilution_value DOUBLE PRECISION,
  interpretation VARCHAR(5),
  comments TEXT
);

DROP TABLE IF EXISTS mimiciv_hosp.omr;
CREATE TABLE mimiciv_hosp.omr
(
  subject_id INTEGER NOT NULL,
  chartdate DATE NOT NULL,
  seq_num INTEGER NOT NULL,
  result_name VARCHAR(100) NOT NULL,
  result_value TEXT NOT NULL
);

DROP TABLE IF EXISTS mimiciv_hosp.patients;
CREATE TABLE mimiciv_hosp.patients
(
  subject_id INTEGER NOT NULL,
  gender CHAR(1) NOT NULL,
  anchor_age SMALLINT,
  anchor_year SMALLINT NOT NULL,
  anchor_year_group VARCHAR(20) NOT NULL,
  dod DATE
);

DROP TABLE IF EXISTS mimiciv_hosp.pharmacy;
CREATE TABLE mimiciv_hosp.pharmacy
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER NOT NULL,
  pharmacy_id INTEGER NOT NULL,
  poe_id VARCHAR(25),
  starttime TIMESTAMP(3),
  stoptime TIMESTAMP(3),
  medication TEXT,
  proc_type VARCHAR(50) NOT NULL,
  status VARCHAR(50),
  entertime TIMESTAMP(3) NOT NULL,
  verifiedtime TIMESTAMP(3),
  route VARCHAR(50),
  frequency VARCHAR(50),
  disp_sched VARCHAR(255),
  infusion_type VARCHAR(15),
  sliding_scale VARCHAR(1),
  lockout_interval VARCHAR(50),
  basal_rate REAL,
  one_hr_max VARCHAR(10),
  doses_per_24_hrs REAL,
  duration REAL,
  duration_interval VARCHAR(50),
  expiration_value INTEGER,
  expiration_unit VARCHAR(50),
  expirationdate TIMESTAMP(3),
  dispensation VARCHAR(50),
  fill_quantity VARCHAR(50)
);

DROP TABLE IF EXISTS mimiciv_hosp.poe_detail;
CREATE TABLE mimiciv_hosp.poe_detail
(
  poe_id VARCHAR(25) NOT NULL,
  poe_seq INTEGER NOT NULL,
  subject_id INTEGER NOT NULL,
  field_name VARCHAR(255) NOT NULL,
  field_value TEXT
);

DROP TABLE IF EXISTS mimiciv_hosp.poe;
CREATE TABLE mimiciv_hosp.poe
(
  poe_id VARCHAR(25) NOT NULL,
  poe_seq INTEGER NOT NULL,
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER,
  ordertime TIMESTAMP(0) NOT NULL,
  order_type VARCHAR(25) NOT NULL,
  order_subtype VARCHAR(50),
  transaction_type VARCHAR(15),
  discontinue_of_poe_id VARCHAR(25),
  discontinued_by_poe_id VARCHAR(25),
  order_provider_id VARCHAR(10),
  order_status VARCHAR(15)
);

DROP TABLE IF EXISTS mimiciv_hosp.prescriptions;
CREATE TABLE mimiciv_hosp.prescriptions
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER NOT NULL,
  pharmacy_id INTEGER NOT NULL,
  poe_id VARCHAR(25),
  poe_seq INTEGER,
  order_provider_id VARCHAR(10),
  starttime TIMESTAMP(3),
  stoptime TIMESTAMP(3),
  drug_type VARCHAR(20) NOT NULL,
  drug VARCHAR(255) NOT NULL,
  formulary_drug_cd VARCHAR(50),
  gsn VARCHAR(255),
  ndc VARCHAR(25),
  prod_strength VARCHAR(255),
  form_rx VARCHAR(25),
  dose_val_rx VARCHAR(100),
  dose_unit_rx VARCHAR(50),
  form_val_disp VARCHAR(50),
  form_unit_disp VARCHAR(50),
  doses_per_24_hrs REAL,
  route VARCHAR(50)
);

DROP TABLE IF EXISTS mimiciv_hosp.procedures_icd;
CREATE TABLE mimiciv_hosp.procedures_icd
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER NOT NULL,
  seq_num INTEGER NOT NULL,
  chartdate DATE NOT NULL,
  icd_code VARCHAR(7),
  icd_version SMALLINT
);

DROP TABLE IF EXISTS mimiciv_hosp.provider;
CREATE TABLE mimiciv_hosp.provider
(
  provider_id VARCHAR(10) NOT NULL
);

DROP TABLE IF EXISTS mimiciv_hosp.services;
CREATE TABLE mimiciv_hosp.services
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER NOT NULL,
  transfertime TIMESTAMP NOT NULL,
  prev_service VARCHAR(10),
  curr_service VARCHAR(10)
);

DROP TABLE IF EXISTS mimiciv_hosp.transfers;
CREATE TABLE mimiciv_hosp.transfers
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER,
  transfer_id INTEGER NOT NULL,
  eventtype VARCHAR(10),
  careunit VARCHAR(255),
  intime TIMESTAMP,
  outtime TIMESTAMP
);

-- icu schema

DROP TABLE IF EXISTS mimiciv_icu.caregiver;
CREATE TABLE mimiciv_icu.caregiver
(
  caregiver_id INTEGER NOT NULL
);

DROP TABLE IF EXISTS mimiciv_icu.chartevents;
CREATE TABLE mimiciv_icu.chartevents
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER NOT NULL,
  stay_id INTEGER NOT NULL,
  caregiver_id INTEGER,
  charttime TIMESTAMP NOT NULL,
  storetime TIMESTAMP,
  itemid INTEGER NOT NULL,
  value VARCHAR(200),
  valuenum FLOAT,
  valueuom VARCHAR(20),
  warning SMALLINT
);

DROP TABLE IF EXISTS mimiciv_icu.datetimeevents;
CREATE TABLE mimiciv_icu.datetimeevents
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER NOT NULL,
  stay_id INTEGER NOT NULL,
  caregiver_id INTEGER,
  charttime TIMESTAMP NOT NULL,
  storetime TIMESTAMP,
  itemid INTEGER NOT NULL,
  value TIMESTAMP NOT NULL,
  valueuom VARCHAR(20),
  warning SMALLINT
);

DROP TABLE IF EXISTS mimiciv_icu.d_items;
CREATE TABLE mimiciv_icu.d_items
(
  itemid INTEGER NOT NULL,
  label VARCHAR(100) NOT NULL,
  abbreviation VARCHAR(50) NOT NULL,
  linksto VARCHAR(30) NOT NULL,
  category VARCHAR(50) NOT NULL,
  unitname VARCHAR(50),
  param_type VARCHAR(20) NOT NULL,
  lownormalvalue FLOAT,
  highnormalvalue FLOAT
);

DROP TABLE IF EXISTS mimiciv_icu.icustays;
CREATE TABLE mimiciv_icu.icustays
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER NOT NULL,
  stay_id INTEGER NOT NULL,
  first_careunit VARCHAR(255),
  last_careunit VARCHAR(255),
  intime TIMESTAMP,
  outtime TIMESTAMP,
  los FLOAT
);

DROP TABLE IF EXISTS mimiciv_icu.ingredientevents;
CREATE TABLE mimiciv_icu.ingredientevents
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER NOT NULL,
  stay_id INTEGER,
  caregiver_id INTEGER,
  starttime TIMESTAMP NOT NULL,
  endtime TIMESTAMP NOT NULL,
  storetime TIMESTAMP,
  itemid INTEGER NOT NULL,
  amount FLOAT,
  amountuom VARCHAR(20),
  rate FLOAT,
  rateuom VARCHAR(20),
  orderid INTEGER NOT NULL,
  linkorderid INTEGER,
  statusdescription VARCHAR(20),
  originalamount FLOAT,
  originalrate FLOAT
);

DROP TABLE IF EXISTS mimiciv_icu.inputevents;
CREATE TABLE mimiciv_icu.inputevents
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER NOT NULL,
  stay_id INTEGER,
  caregiver_id INTEGER,
  starttime TIMESTAMP NOT NULL,
  endtime TIMESTAMP NOT NULL,
  storetime TIMESTAMP,
  itemid INTEGER NOT NULL,
  amount FLOAT,
  amountuom VARCHAR(20),
  rate FLOAT,
  rateuom VARCHAR(20),
  orderid INTEGER NOT NULL,
  linkorderid INTEGER,
  ordercategoryname VARCHAR(50),
  secondaryordercategoryname VARCHAR(50),
  ordercomponenttypedescription VARCHAR(100),
  ordercategorydescription VARCHAR(30),
  patientweight FLOAT,
  totalamount FLOAT,
  totalamountuom VARCHAR(50),
  isopenbag SMALLINT,
  continueinnextdept SMALLINT,
  statusdescription VARCHAR(20),
  originalamount FLOAT,
  originalrate FLOAT
);

DROP TABLE IF EXISTS mimiciv_icu.outputevents;
CREATE TABLE mimiciv_icu.outputevents
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER NOT NULL,
  stay_id INTEGER NOT NULL,
  caregiver_id INTEGER,
  charttime TIMESTAMP(3) NOT NULL,
  storetime TIMESTAMP(3) NOT NULL,
  itemid INTEGER NOT NULL,
  value FLOAT NOT NULL,
  valueuom VARCHAR(20)
);

DROP TABLE IF EXISTS mimiciv_icu.procedureevents;
CREATE TABLE mimiciv_icu.procedureevents
(
  subject_id INTEGER NOT NULL,
  hadm_id INTEGER NOT NULL,
  stay_id INTEGER NOT NULL,
  caregiver_id INTEGER,
  starttime TIMESTAMP NOT NULL,
  endtime TIMESTAMP NOT NULL,
  storetime TIMESTAMP NOT NULL,
  itemid INTEGER NOT NULL,
  value FLOAT,
  valueuom VARCHAR(20),
  location VARCHAR(100),
  locationcategory VARCHAR(50),
  orderid INTEGER,
  linkorderid INTEGER,
  ordercategoryname VARCHAR(50),
  ordercategorydescription VARCHAR(30),
  patientweight FLOAT,
  isopenbag SMALLINT,
  continueinnextdept SMALLINT,
  statusdescription VARCHAR(20),
  originalamount FLOAT,
  originalrate FLOAT
);

-----------------------------------------
-- Load data into the MIMIC-IV schemas --
-----------------------------------------

-- To run from a terminal:
--  psql "dbname=<DBNAME> user=<USER>" -v mimic_data_dir=<PATH TO DATA DIR> -f load_gz.sql
\cd /mnt/mimic-iv

-- making sure that all tables are emtpy and correct encoding is defined -utf8- 
SET CLIENT_ENCODING TO 'utf8';

-- hosp schema
\cd hosp

\COPY mimiciv_hosp.admissions FROM PROGRAM 'gzip -dc admissions.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.d_hcpcs FROM PROGRAM 'gzip -dc d_hcpcs.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.diagnoses_icd FROM PROGRAM 'gzip -dc diagnoses_icd.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.d_icd_diagnoses FROM PROGRAM 'gzip -dc d_icd_diagnoses.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.d_icd_procedures FROM PROGRAM 'gzip -dc d_icd_procedures.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.d_labitems FROM PROGRAM 'gzip -dc d_labitems.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.drgcodes FROM PROGRAM 'gzip -dc drgcodes.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.emar_detail FROM PROGRAM 'gzip -dc emar_detail.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.emar FROM PROGRAM 'gzip -dc emar.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.hcpcsevents FROM PROGRAM 'gzip -dc hcpcsevents.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.labevents FROM PROGRAM 'gzip -dc labevents.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.microbiologyevents FROM PROGRAM 'gzip -dc microbiologyevents.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.omr FROM PROGRAM 'gzip -dc omr.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.patients FROM PROGRAM 'gzip -dc patients.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.pharmacy FROM PROGRAM 'gzip -dc pharmacy.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.poe_detail FROM PROGRAM 'gzip -dc poe_detail.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.poe FROM PROGRAM 'gzip -dc poe.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.prescriptions FROM PROGRAM 'gzip -dc prescriptions.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.procedures_icd FROM PROGRAM 'gzip -dc procedures_icd.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.provider FROM PROGRAM 'gzip -dc provider.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.services FROM PROGRAM 'gzip -dc services.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_hosp.transfers FROM PROGRAM 'gzip -dc transfers.csv.gz' DELIMITER ',' CSV HEADER NULL '';

-- icu schema
\cd ../icu

\COPY mimiciv_icu.caregiver FROM PROGRAM 'gzip -dc caregiver.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_icu.chartevents FROM PROGRAM 'gzip -dc chartevents.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_icu.datetimeevents FROM PROGRAM 'gzip -dc datetimeevents.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_icu.d_items FROM PROGRAM 'gzip -dc d_items.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_icu.icustays FROM PROGRAM 'gzip -dc icustays.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_icu.ingredientevents FROM PROGRAM 'gzip -dc ingredientevents.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_icu.inputevents FROM PROGRAM 'gzip -dc inputevents.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_icu.outputevents FROM PROGRAM 'gzip -dc outputevents.csv.gz' DELIMITER ',' CSV HEADER NULL '';
\COPY mimiciv_icu.procedureevents FROM PROGRAM 'gzip -dc procedureevents.csv.gz' DELIMITER ',' CSV HEADER NULL '';

---------------------------
---------------------------
-- Creating Primary Keys --
---------------------------
---------------------------

----------
-- hosp --
----------

-- patients

ALTER TABLE mimiciv_hosp.patients DROP CONSTRAINT IF EXISTS patients_pk CASCADE;
ALTER TABLE mimiciv_hosp.patients
ADD CONSTRAINT patients_pk
  PRIMARY KEY (subject_id);

-- admissions

ALTER TABLE mimiciv_hosp.admissions DROP CONSTRAINT IF EXISTS admissions_pk CASCADE;
ALTER TABLE mimiciv_hosp.admissions
ADD CONSTRAINT admissions_pk
  PRIMARY KEY (hadm_id);

-- transfers

ALTER TABLE mimiciv_hosp.transfers DROP CONSTRAINT IF EXISTS transfers_pk CASCADE;
ALTER TABLE mimiciv_hosp.transfers
ADD CONSTRAINT transfers_pk
  PRIMARY KEY (transfer_id);

----------
-- hosp --
----------

-- d_hcpcs

ALTER TABLE mimiciv_hosp.d_hcpcs DROP CONSTRAINT IF EXISTS d_hcpcs_pk CASCADE;
ALTER TABLE mimiciv_hosp.d_hcpcs
ADD CONSTRAINT d_hcpcs_pk
  PRIMARY KEY (code);

-- diagnoses_icd

ALTER TABLE mimiciv_hosp.diagnoses_icd DROP CONSTRAINT IF EXISTS diagnoses_icd_pk CASCADE;
ALTER TABLE mimiciv_hosp.diagnoses_icd
ADD CONSTRAINT diagnoses_icd_pk
  PRIMARY KEY (hadm_id, seq_num, icd_code, icd_version);

-- d_icd_diagnoses

ALTER TABLE mimiciv_hosp.d_icd_diagnoses DROP CONSTRAINT IF EXISTS d_icd_diagnoses_pk CASCADE;
ALTER TABLE mimiciv_hosp.d_icd_diagnoses
ADD CONSTRAINT d_icd_diagnoses_pk
  PRIMARY KEY (icd_code, icd_version);

-- d_icd_procedures

ALTER TABLE mimiciv_hosp.d_icd_procedures DROP CONSTRAINT IF EXISTS d_icd_procedures_pk CASCADE;
ALTER TABLE mimiciv_hosp.d_icd_procedures
ADD CONSTRAINT d_icd_procedures_pk
  PRIMARY KEY (icd_code, icd_version);

-- d_labitems

ALTER TABLE mimiciv_hosp.d_labitems DROP CONSTRAINT IF EXISTS d_labitems_pk CASCADE;
ALTER TABLE mimiciv_hosp.d_labitems
ADD CONSTRAINT d_labitems_pk
  PRIMARY KEY (itemid);

-- emar_detail

-- ALTER TABLE mimiciv_hosp.emar_detail DROP CONSTRAINT IF EXISTS emar_detail_pk;
-- ALTER TABLE mimiciv_hosp.emar_detail
-- ADD CONSTRAINT emar_detail_pk
--   PRIMARY KEY (emar_id, parent_field_ordinal);

-- emar

ALTER TABLE mimiciv_hosp.emar DROP CONSTRAINT IF EXISTS emar_pk CASCADE;
ALTER TABLE mimiciv_hosp.emar
ADD CONSTRAINT emar_pk
  PRIMARY KEY (emar_id);

-- hcpcsevents

ALTER TABLE mimiciv_hosp.hcpcsevents DROP CONSTRAINT IF EXISTS hcpcsevents_pk CASCADE;
ALTER TABLE mimiciv_hosp.hcpcsevents
ADD CONSTRAINT hcpcsevents_pk
  PRIMARY KEY (hadm_id, hcpcs_cd, seq_num);

-- labevents

ALTER TABLE mimiciv_hosp.labevents DROP CONSTRAINT IF EXISTS labevents_pk CASCADE;
ALTER TABLE mimiciv_hosp.labevents
ADD CONSTRAINT labevents_pk
  PRIMARY KEY (labevent_id);

-- microbiologyevents

ALTER TABLE mimiciv_hosp.microbiologyevents DROP CONSTRAINT IF EXISTS microbiologyevents_pk CASCADE;
ALTER TABLE mimiciv_hosp.microbiologyevents
ADD CONSTRAINT microbiologyevents_pk
  PRIMARY KEY (microevent_id);

-- pharmacy

ALTER TABLE mimiciv_hosp.pharmacy DROP CONSTRAINT IF EXISTS pharmacy_pk CASCADE;
ALTER TABLE mimiciv_hosp.pharmacy
ADD CONSTRAINT pharmacy_pk
  PRIMARY KEY (pharmacy_id);

-- poe_detail

ALTER TABLE mimiciv_hosp.poe_detail DROP CONSTRAINT IF EXISTS poe_detail_pk CASCADE;
ALTER TABLE mimiciv_hosp.poe_detail
ADD CONSTRAINT poe_detail_pk
  PRIMARY KEY (poe_id, field_name);

-- poe

ALTER TABLE mimiciv_hosp.poe DROP CONSTRAINT IF EXISTS poe_pk CASCADE;
ALTER TABLE mimiciv_hosp.poe
ADD CONSTRAINT poe_pk
  PRIMARY KEY (poe_id);

-- prescriptions

ALTER TABLE mimiciv_hosp.prescriptions DROP CONSTRAINT IF EXISTS prescriptions_pk CASCADE;
ALTER TABLE mimiciv_hosp.prescriptions
ADD CONSTRAINT prescriptions_pk
  PRIMARY KEY (pharmacy_id, drug_type, drug);

-- procedures_icd

ALTER TABLE mimiciv_hosp.procedures_icd DROP CONSTRAINT IF EXISTS procedures_icd_pk CASCADE;
ALTER TABLE mimiciv_hosp.procedures_icd
ADD CONSTRAINT procedures_icd_pk
  PRIMARY KEY (hadm_id, seq_num, icd_code, icd_version);

-- services

ALTER TABLE mimiciv_hosp.services DROP CONSTRAINT IF EXISTS services_pk CASCADE;
ALTER TABLE mimiciv_hosp.services
ADD CONSTRAINT services_pk
  PRIMARY KEY (hadm_id, transfertime, curr_service);

---------
-- icu --
---------

-- datetimeevents

ALTER TABLE mimiciv_icu.datetimeevents DROP CONSTRAINT IF EXISTS datetimeevents_pk CASCADE;
ALTER TABLE mimiciv_icu.datetimeevents
ADD CONSTRAINT datetimeevents_pk
  PRIMARY KEY (stay_id, itemid, charttime);

-- d_items

ALTER TABLE mimiciv_icu.d_items DROP CONSTRAINT IF EXISTS d_items_pk CASCADE;
ALTER TABLE mimiciv_icu.d_items
ADD CONSTRAINT d_items_pk
  PRIMARY KEY (itemid);

-- icustays

ALTER TABLE mimiciv_icu.icustays DROP CONSTRAINT IF EXISTS icustays_pk CASCADE;
ALTER TABLE mimiciv_icu.icustays
ADD CONSTRAINT icustays_pk
  PRIMARY KEY (stay_id);

-- inputevents

ALTER TABLE mimiciv_icu.inputevents DROP CONSTRAINT IF EXISTS inputevents_pk CASCADE;
ALTER TABLE mimiciv_icu.inputevents
ADD CONSTRAINT inputevents_pk
  PRIMARY KEY (orderid, itemid);

-- outputevents

ALTER TABLE mimiciv_icu.outputevents DROP CONSTRAINT IF EXISTS outputevents_pk CASCADE;
ALTER TABLE mimiciv_icu.outputevents
ADD CONSTRAINT outputevents_pk
  PRIMARY KEY (stay_id, charttime, itemid);

-- procedureevents

ALTER TABLE mimiciv_icu.procedureevents DROP CONSTRAINT IF EXISTS procedureevents_pk CASCADE;
ALTER TABLE mimiciv_icu.procedureevents
ADD CONSTRAINT procedureevents_pk
  PRIMARY KEY (orderid);

---------------------------
---------------------------
-- Creating Foreign Keys --
---------------------------
---------------------------

----------
-- hosp --
----------

-- admissions

ALTER TABLE mimiciv_hosp.admissions DROP CONSTRAINT IF EXISTS admissions_patients_fk;
ALTER TABLE mimiciv_hosp.admissions
ADD CONSTRAINT admissions_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

-- transfers

ALTER TABLE mimiciv_hosp.transfers DROP CONSTRAINT IF EXISTS transfers_patients_fk;
ALTER TABLE mimiciv_hosp.transfers
ADD CONSTRAINT transfers_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

----------
-- hosp --
----------

-- diagnoses_icd

ALTER TABLE mimiciv_hosp.diagnoses_icd DROP CONSTRAINT IF EXISTS diagnoses_icd_patients_fk;
ALTER TABLE mimiciv_hosp.diagnoses_icd
ADD CONSTRAINT diagnoses_icd_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_hosp.diagnoses_icd DROP CONSTRAINT IF EXISTS diagnoses_icd_admissions_fk;
ALTER TABLE mimiciv_hosp.diagnoses_icd
ADD CONSTRAINT diagnoses_icd_admissions_fk
  FOREIGN KEY (hadm_id)
  REFERENCES mimiciv_hosp.admissions (hadm_id);

-- drgcodes

ALTER TABLE mimiciv_hosp.drgcodes DROP CONSTRAINT IF EXISTS drgcodes_patients_fk;
ALTER TABLE mimiciv_hosp.drgcodes
ADD CONSTRAINT drgcodes_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_hosp.drgcodes DROP CONSTRAINT IF EXISTS drgcodes_admissions_fk;
ALTER TABLE mimiciv_hosp.drgcodes
ADD CONSTRAINT drgcodes_admissions_fk
  FOREIGN KEY (hadm_id)
  REFERENCES mimiciv_hosp.admissions (hadm_id);

-- emar_detail

ALTER TABLE mimiciv_hosp.emar_detail DROP CONSTRAINT IF EXISTS emar_detail_patients_fk;
ALTER TABLE mimiciv_hosp.emar_detail
ADD CONSTRAINT emar_detail_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_hosp.emar_detail DROP CONSTRAINT IF EXISTS emar_detail_emar_fk;
ALTER TABLE mimiciv_hosp.emar_detail
ADD CONSTRAINT emar_detail_emar_fk
  FOREIGN KEY (emar_id)
  REFERENCES mimiciv_hosp.emar (emar_id);

-- emar

ALTER TABLE mimiciv_hosp.emar DROP CONSTRAINT IF EXISTS emar_patients_fk;
ALTER TABLE mimiciv_hosp.emar
ADD CONSTRAINT emar_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_hosp.emar DROP CONSTRAINT IF EXISTS emar_admissions_fk;
ALTER TABLE mimiciv_hosp.emar
ADD CONSTRAINT emar_admissions_fk
  FOREIGN KEY (hadm_id)
  REFERENCES mimiciv_hosp.admissions (hadm_id);

-- hcpcsevents

ALTER TABLE mimiciv_hosp.hcpcsevents DROP CONSTRAINT IF EXISTS hcpcsevents_patients_fk;
ALTER TABLE mimiciv_hosp.hcpcsevents
ADD CONSTRAINT hcpcsevents_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_hosp.hcpcsevents DROP CONSTRAINT IF EXISTS hcpcsevents_admissions_fk;
ALTER TABLE mimiciv_hosp.hcpcsevents
ADD CONSTRAINT hcpcsevents_admissions_fk
  FOREIGN KEY (hadm_id)
  REFERENCES mimiciv_hosp.admissions (hadm_id);

ALTER TABLE mimiciv_hosp.hcpcsevents DROP CONSTRAINT IF EXISTS hcpcsevents_d_hcpcs_fk;
ALTER TABLE mimiciv_hosp.hcpcsevents
ADD CONSTRAINT hcpcsevents_d_hcpcs_fk
  FOREIGN KEY (hcpcs_cd)
  REFERENCES mimiciv_hosp.d_hcpcs (code);

-- labevents

ALTER TABLE mimiciv_hosp.labevents DROP CONSTRAINT IF EXISTS labevents_patients_fk;
ALTER TABLE mimiciv_hosp.labevents
ADD CONSTRAINT labevents_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_hosp.labevents DROP CONSTRAINT IF EXISTS labevents_d_labitems_fk;
ALTER TABLE mimiciv_hosp.labevents
ADD CONSTRAINT labevents_d_labitems_fk
  FOREIGN KEY (itemid)
  REFERENCES mimiciv_hosp.d_labitems (itemid);

-- microbiologyevents

ALTER TABLE mimiciv_hosp.microbiologyevents DROP CONSTRAINT IF EXISTS microbiologyevents_patients_fk;
ALTER TABLE mimiciv_hosp.microbiologyevents
ADD CONSTRAINT microbiologyevents_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_hosp.microbiologyevents DROP CONSTRAINT IF EXISTS microbiologyevents_admissions_fk;
ALTER TABLE mimiciv_hosp.microbiologyevents
ADD CONSTRAINT microbiologyevents_admissions_fk
  FOREIGN KEY (hadm_id)
  REFERENCES mimiciv_hosp.admissions (hadm_id);

-- pharmacy

ALTER TABLE mimiciv_hosp.pharmacy DROP CONSTRAINT IF EXISTS pharmacy_patients_fk;
ALTER TABLE mimiciv_hosp.pharmacy
ADD CONSTRAINT pharmacy_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_hosp.pharmacy DROP CONSTRAINT IF EXISTS pharmacy_admissions_fk;
ALTER TABLE mimiciv_hosp.pharmacy
ADD CONSTRAINT pharmacy_admissions_fk
  FOREIGN KEY (hadm_id)
  REFERENCES mimiciv_hosp.admissions (hadm_id);

-- poe_detail

ALTER TABLE mimiciv_hosp.poe_detail DROP CONSTRAINT IF EXISTS poe_detail_patients_fk;
ALTER TABLE mimiciv_hosp.poe_detail
ADD CONSTRAINT poe_detail_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_hosp.poe_detail DROP CONSTRAINT IF EXISTS poe_detail_poe_fk;
ALTER TABLE mimiciv_hosp.poe_detail
ADD CONSTRAINT poe_detail_poe_fk
  FOREIGN KEY (poe_id)
  REFERENCES mimiciv_hosp.poe (poe_id);

-- poe

ALTER TABLE mimiciv_hosp.poe DROP CONSTRAINT IF EXISTS poe_patients_fk;
ALTER TABLE mimiciv_hosp.poe
ADD CONSTRAINT poe_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_hosp.poe DROP CONSTRAINT IF EXISTS poe_admissions_fk;
ALTER TABLE mimiciv_hosp.poe
ADD CONSTRAINT poe_admissions_fk
  FOREIGN KEY (hadm_id)
  REFERENCES mimiciv_hosp.admissions (hadm_id);

-- prescriptions

ALTER TABLE mimiciv_hosp.prescriptions DROP CONSTRAINT IF EXISTS prescriptions_patients_fk;
ALTER TABLE mimiciv_hosp.prescriptions
ADD CONSTRAINT prescriptions_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_hosp.prescriptions DROP CONSTRAINT IF EXISTS prescriptions_admissions_fk;
ALTER TABLE mimiciv_hosp.prescriptions
ADD CONSTRAINT prescriptions_admissions_fk
  FOREIGN KEY (hadm_id)
  REFERENCES mimiciv_hosp.admissions (hadm_id);

-- procedures_icd

ALTER TABLE mimiciv_hosp.procedures_icd DROP CONSTRAINT IF EXISTS procedures_icd_patients_fk;
ALTER TABLE mimiciv_hosp.procedures_icd
ADD CONSTRAINT procedures_icd_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_hosp.procedures_icd DROP CONSTRAINT IF EXISTS procedures_icd_admissions_fk;
ALTER TABLE mimiciv_hosp.procedures_icd
ADD CONSTRAINT procedures_icd_admissions_fk
  FOREIGN KEY (hadm_id)
  REFERENCES mimiciv_hosp.admissions (hadm_id);

-- services

ALTER TABLE mimiciv_hosp.services DROP CONSTRAINT IF EXISTS services_patients_fk;
ALTER TABLE mimiciv_hosp.services
ADD CONSTRAINT services_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_hosp.services DROP CONSTRAINT IF EXISTS services_admissions_fk;
ALTER TABLE mimiciv_hosp.services
ADD CONSTRAINT services_admissions_fk
  FOREIGN KEY (hadm_id)
  REFERENCES mimiciv_hosp.admissions (hadm_id);

---------
-- icu --
---------

-- chartevents

ALTER TABLE mimiciv_icu.chartevents DROP CONSTRAINT IF EXISTS chartevents_patients_fk;
ALTER TABLE mimiciv_icu.chartevents
ADD CONSTRAINT chartevents_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_icu.chartevents DROP CONSTRAINT IF EXISTS chartevents_admissions_fk;
ALTER TABLE mimiciv_icu.chartevents
ADD CONSTRAINT chartevents_admissions_fk
  FOREIGN KEY (hadm_id)
  REFERENCES mimiciv_hosp.admissions (hadm_id);

ALTER TABLE mimiciv_icu.chartevents DROP CONSTRAINT IF EXISTS chartevents_icustays_fk;
ALTER TABLE mimiciv_icu.chartevents
ADD CONSTRAINT chartevents_icustays_fk
  FOREIGN KEY (stay_id)
  REFERENCES mimiciv_icu.icustays (stay_id);

ALTER TABLE mimiciv_icu.chartevents DROP CONSTRAINT IF EXISTS chartevents_d_items_fk;
ALTER TABLE mimiciv_icu.chartevents
ADD CONSTRAINT chartevents_d_items_fk
  FOREIGN KEY (itemid)
  REFERENCES mimiciv_icu.d_items (itemid);

-- datetimeevents

ALTER TABLE mimiciv_icu.datetimeevents DROP CONSTRAINT IF EXISTS datetimeevents_patients_fk;
ALTER TABLE mimiciv_icu.datetimeevents
ADD CONSTRAINT datetimeevents_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_icu.datetimeevents DROP CONSTRAINT IF EXISTS datetimeevents_admissions_fk;
ALTER TABLE mimiciv_icu.datetimeevents
ADD CONSTRAINT datetimeevents_admissions_fk
  FOREIGN KEY (hadm_id)
  REFERENCES mimiciv_hosp.admissions (hadm_id);

ALTER TABLE mimiciv_icu.datetimeevents DROP CONSTRAINT IF EXISTS datetimeevents_icustays_fk;
ALTER TABLE mimiciv_icu.datetimeevents
ADD CONSTRAINT datetimeevents_icustays_fk
  FOREIGN KEY (stay_id)
  REFERENCES mimiciv_icu.icustays (stay_id);

ALTER TABLE mimiciv_icu.datetimeevents DROP CONSTRAINT IF EXISTS datetimeevents_d_items_fk;
ALTER TABLE mimiciv_icu.datetimeevents
ADD CONSTRAINT datetimeevents_d_items_fk
  FOREIGN KEY (itemid)
  REFERENCES mimiciv_icu.d_items (itemid);

-- icustays

ALTER TABLE mimiciv_icu.icustays DROP CONSTRAINT IF EXISTS icustays_patients_fk;
ALTER TABLE mimiciv_icu.icustays
ADD CONSTRAINT icustays_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_icu.icustays DROP CONSTRAINT IF EXISTS icustays_admissions_fk;
ALTER TABLE mimiciv_icu.icustays
ADD CONSTRAINT icustays_admissions_fk
  FOREIGN KEY (hadm_id)
  REFERENCES mimiciv_hosp.admissions (hadm_id);

-- inputevents

ALTER TABLE mimiciv_icu.inputevents DROP CONSTRAINT IF EXISTS inputevents_patients_fk;
ALTER TABLE mimiciv_icu.inputevents
ADD CONSTRAINT inputevents_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_icu.inputevents DROP CONSTRAINT IF EXISTS inputevents_admissions_fk;
ALTER TABLE mimiciv_icu.inputevents
ADD CONSTRAINT inputevents_admissions_fk
  FOREIGN KEY (hadm_id)
  REFERENCES mimiciv_hosp.admissions (hadm_id);

ALTER TABLE mimiciv_icu.inputevents DROP CONSTRAINT IF EXISTS inputevents_icustays_fk;
ALTER TABLE mimiciv_icu.inputevents
ADD CONSTRAINT inputevents_icustays_fk
  FOREIGN KEY (stay_id)
  REFERENCES mimiciv_icu.icustays (stay_id);

ALTER TABLE mimiciv_icu.inputevents DROP CONSTRAINT IF EXISTS inputevents_d_items_fk;
ALTER TABLE mimiciv_icu.inputevents
ADD CONSTRAINT inputevents_d_items_fk
  FOREIGN KEY (itemid)
  REFERENCES mimiciv_icu.d_items (itemid);

-- outputevents

ALTER TABLE mimiciv_icu.outputevents DROP CONSTRAINT IF EXISTS outputevents_patients_fk;
ALTER TABLE mimiciv_icu.outputevents
ADD CONSTRAINT outputevents_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_icu.outputevents DROP CONSTRAINT IF EXISTS outputevents_admissions_fk;
ALTER TABLE mimiciv_icu.outputevents
ADD CONSTRAINT outputevents_admissions_fk
  FOREIGN KEY (hadm_id)
  REFERENCES mimiciv_hosp.admissions (hadm_id);

ALTER TABLE mimiciv_icu.outputevents DROP CONSTRAINT IF EXISTS outputevents_icustays_fk;
ALTER TABLE mimiciv_icu.outputevents
ADD CONSTRAINT outputevents_icustays_fk
  FOREIGN KEY (stay_id)
  REFERENCES mimiciv_icu.icustays (stay_id);

ALTER TABLE mimiciv_icu.outputevents DROP CONSTRAINT IF EXISTS outputevents_d_items_fk;
ALTER TABLE mimiciv_icu.outputevents
ADD CONSTRAINT outputevents_d_items_fk
  FOREIGN KEY (itemid)
  REFERENCES mimiciv_icu.d_items (itemid);

-- procedureevents

ALTER TABLE mimiciv_icu.procedureevents DROP CONSTRAINT IF EXISTS procedureevents_patients_fk;
ALTER TABLE mimiciv_icu.procedureevents
ADD CONSTRAINT procedureevents_patients_fk
  FOREIGN KEY (subject_id)
  REFERENCES mimiciv_hosp.patients (subject_id);

ALTER TABLE mimiciv_icu.procedureevents DROP CONSTRAINT IF EXISTS procedureevents_admissions_fk;
ALTER TABLE mimiciv_icu.procedureevents
ADD CONSTRAINT procedureevents_admissions_fk
  FOREIGN KEY (hadm_id)
  REFERENCES mimiciv_hosp.admissions (hadm_id);

ALTER TABLE mimiciv_icu.procedureevents DROP CONSTRAINT IF EXISTS procedureevents_icustays_fk;
ALTER TABLE mimiciv_icu.procedureevents
ADD CONSTRAINT procedureevents_icustays_fk
  FOREIGN KEY (stay_id)
  REFERENCES mimiciv_icu.icustays (stay_id);

ALTER TABLE mimiciv_icu.procedureevents DROP CONSTRAINT IF EXISTS procedureevents_d_items_fk;
ALTER TABLE mimiciv_icu.procedureevents
ADD CONSTRAINT procedureevents_d_items_fk
  FOREIGN KEY (itemid)
  REFERENCES mimiciv_icu.d_items (itemid);

--------------------------------------
--------------------------------------
-- Indexes for all MIMIC-IV modules --
--------------------------------------
--------------------------------------

----------
-- core --
----------

SET search_path TO mimic_core;

-- patients
DROP INDEX IF EXISTS patients_idx01;
CREATE INDEX patients_idx01
  ON patients (anchor_age);

DROP INDEX IF EXISTS patients_idx02;
CREATE INDEX patients_idx02
  ON patients (anchor_year);

-- admissions
 
DROP INDEX IF EXISTS admissions_idx01;
CREATE INDEX admissions_idx01
  ON admissions (admittime, dischtime, deathtime);

-- transfers

DROP INDEX IF EXISTS transfers_idx01;
CREATE INDEX transfers_idx01
  ON transfers (hadm_id);

DROP INDEX IF EXISTS transfers_idx02;
CREATE INDEX transfers_idx02
  ON transfers (intime);

DROP INDEX IF EXISTS transfers_idx03;
CREATE INDEX transfers_idx03
  ON transfers (careunit);

----------
-- hosp --
----------

SET search_path TO mimic_hosp;

-- d_icd_diagnoses

DROP INDEX IF EXISTS D_ICD_DIAG_idx02;
CREATE INDEX D_ICD_DIAG_idx02
  ON D_ICD_DIAGNOSES (LONG_TITLE);

-- D_ICD_PROCEDURES

DROP INDEX IF EXISTS D_ICD_PROC_idx02;
CREATE INDEX D_ICD_PROC_idx02
  ON D_ICD_PROCEDURES (LONG_TITLE);

-- drgcodes

DROP INDEX IF EXISTS drgcodes_idx01;
CREATE INDEX drgcodes_idx01
  ON drgcodes (drg_code, drg_type);

DROP INDEX IF EXISTS drgcodes_idx02;
CREATE INDEX drgcodes_idx02
  ON drgcodes (description, drg_severity);

-- d_labitems

DROP INDEX IF EXISTS d_labitems_idx01;
CREATE INDEX d_labitems_idx01
  ON d_labitems (label, fluid, category);

DROP INDEX IF EXISTS d_labitems_idx02;
CREATE INDEX d_labitems_idx02
  ON d_labitems (loinc_code);

-- emar_detail

DROP INDEX IF EXISTS emar_detail_idx01;
CREATE INDEX emar_detail_idx01
  ON emar_detail (pharmacy_id);

DROP INDEX IF EXISTS emar_detail_idx02;
CREATE INDEX emar_detail_idx02
  ON emar_detail (product_code);

DROP INDEX IF EXISTS emar_detail_idx03;
CREATE INDEX emar_detail_idx03
  ON emar_detail (route, site, side);

DROP INDEX IF EXISTS EMAR_DET_idx04;
CREATE INDEX EMAR_DET_idx04
  ON EMAR_DETAIL (PRODUCT_DESCRIPTION);

-- emar

DROP INDEX IF EXISTS emar_idx01;
CREATE INDEX emar_idx01
  ON emar (poe_id);

DROP INDEX IF EXISTS emar_idx02;
CREATE INDEX emar_idx02
  ON emar (pharmacy_id);

DROP INDEX IF EXISTS emar_idx03;
CREATE INDEX emar_idx03
  ON emar (charttime, scheduletime, storetime);

DROP INDEX IF EXISTS emar_idx04;
CREATE INDEX emar_idx04
  ON emar (medication);

-- HCPCSEVENTS

DROP INDEX IF EXISTS HCPCSEVENTS_idx04;
CREATE INDEX HCPCSEVENTS_idx04
  ON HCPCSEVENTS (SHORT_DESCRIPTION);

-- labevents

DROP INDEX IF EXISTS labevents_idx01;
CREATE INDEX labevents_idx01
  ON labevents (charttime, storetime);

DROP INDEX IF EXISTS labevents_idx02;
CREATE INDEX labevents_idx02
  ON labevents (specimen_id);

-- microbiologyevents

DROP INDEX IF EXISTS microbiologyevents_idx01;
CREATE INDEX microbiologyevents_idx01
  ON microbiologyevents (chartdate, charttime, storedate, storetime);

DROP INDEX IF EXISTS microbiologyevents_idx02;
CREATE INDEX microbiologyevents_idx02
  ON microbiologyevents (spec_itemid, test_itemid, org_itemid, ab_itemid);

DROP INDEX IF EXISTS microbiologyevents_idx03;
CREATE INDEX microbiologyevents_idx03
  ON microbiologyevents (micro_specimen_id);

-- pharmacy

DROP INDEX IF EXISTS pharmacy_idx01;
CREATE INDEX pharmacy_idx01
  ON pharmacy (poe_id);

DROP INDEX IF EXISTS pharmacy_idx02;
CREATE INDEX pharmacy_idx02
  ON pharmacy (starttime, stoptime);

DROP INDEX IF EXISTS pharmacy_idx03;
CREATE INDEX pharmacy_idx03
  ON pharmacy (medication);

DROP INDEX IF EXISTS pharmacy_idx04;
CREATE INDEX pharmacy_idx04
  ON pharmacy (route);

-- poe

DROP INDEX IF EXISTS poe_idx01;
CREATE INDEX poe_idx01
  ON poe (order_type);

-- prescriptions

DROP INDEX IF EXISTS prescriptions_idx01;
CREATE INDEX prescriptions_idx01
  ON prescriptions (starttime, stoptime);

---------
-- icu --
---------

SET search_path TO mimic_icu;

-- chartevents

DROP INDEX IF EXISTS chartevents_idx01;
CREATE INDEX chartevents_idx01
  ON chartevents (charttime, storetime);

-- datetimeevents

DROP INDEX IF EXISTS datetimeevents_idx01;
CREATE INDEX datetimeevents_idx01
  ON datetimeevents (charttime, storetime);

DROP INDEX IF EXISTS datetimeevents_idx02;
CREATE INDEX datetimeevents_idx02
  ON datetimeevents (value);

-- d_items

DROP INDEX IF EXISTS d_items_idx01;
CREATE INDEX d_items_idx01
  ON d_items (label, abbreviation);

DROP INDEX IF EXISTS d_items_idx02;
CREATE INDEX d_items_idx02
  ON d_items (category);

-- icustays

DROP INDEX IF EXISTS icustays_idx01;
CREATE INDEX icustays_idx01
  ON icustays (first_careunit, last_careunit);

DROP INDEX IF EXISTS icustays_idx02;
CREATE INDEX icustays_idx02
  ON icustays (intime, outtime);

-- inputevents

DROP INDEX IF EXISTS inputevents_idx01;
CREATE INDEX inputevents_idx01
  ON inputevents (starttime, endtime);

DROP INDEX IF EXISTS inputevents_idx02;
CREATE INDEX inputevents_idx02
  ON inputevents (ordercategorydescription);

-- outputevents

DROP INDEX IF EXISTS outputevents_idx01;
CREATE INDEX outputevents_idx01
  ON outputevents (charttime, storetime);
  
-- procedureevents

DROP INDEX IF EXISTS procedureevents_idx01;
CREATE INDEX procedureevents_idx01
  ON procedureevents (starttime, endtime);

DROP INDEX IF EXISTS procedureevents_idx02;
CREATE INDEX procedureevents_idx02
  ON procedureevents (ordercategoryname);


-- Validate the MIMIC-IV tables built correctly by checking against known row counts
-- of MIMIC-IV v2.2
WITH expected AS
(
    SELECT 'admissions' AS tbl,         431231 AS row_count UNION ALL
    SELECT 'd_hcpcs' AS tbl,            89200 AS row_count UNION ALL
    SELECT 'd_icd_diagnoses' AS tbl,    109775 AS row_count UNION ALL
    SELECT 'd_icd_procedures' AS tbl,   85257 AS row_count UNION ALL
    SELECT 'd_labitems' AS tbl,         1622 AS row_count UNION ALL
    SELECT 'diagnoses_icd' AS tbl,      4756326 AS row_count UNION ALL
    SELECT 'drgcodes' AS tbl,           604377 AS row_count UNION ALL
    SELECT 'emar' AS tbl,               26850359 AS row_count UNION ALL
    SELECT 'emar_detail' AS tbl,        54744789 AS row_count UNION ALL
    SELECT 'hcpcsevents' AS tbl,        150771 AS row_count UNION ALL
    SELECT 'labevents' AS tbl,          118171367 AS row_count UNION ALL
    SELECT 'microbiologyevents' AS tbl, 3228713 AS row_count UNION ALL
    SELECT 'omr' AS tbl,                6439169 AS row_count UNION ALL
    SELECT 'patients' AS tbl,           299712 AS row_count UNION ALL
    SELECT 'pharmacy' AS tbl,           13584514 AS row_count UNION ALL
    SELECT 'poe' AS tbl,                39366291 AS row_count UNION ALL
    SELECT 'poe_detail' AS tbl,         3879418 AS row_count UNION ALL
    SELECT 'prescriptions' AS tbl,      15416708 AS row_count UNION ALL
    SELECT 'procedures_icd' AS tbl,     669186 AS row_count UNION ALL
    SELECT 'services' AS tbl,           468029 AS row_count UNION ALL
    SELECT 'transfers' AS tbl,          1890972 AS row_count UNION ALL
    -- icu data
    SELECT 'icustays' AS tbl,           73181 AS row_count UNION ALL
    SELECT 'd_items' AS tbl,            4014 AS row_count UNION ALL
    SELECT 'chartevents' AS tbl,        313645063 AS row_count UNION ALL
    SELECT 'datetimeevents' AS tbl,     7112999 AS row_count UNION ALL
    SELECT 'inputevents' AS tbl,        8978893 AS row_count UNION ALL
    SELECT 'outputevents' AS tbl,       4234967 AS row_count UNION ALL
    SELECT 'procedureevents' AS tbl,    696092 AS row_count
)
, observed as
(
    SELECT 'admissions' AS tbl, count(*) AS row_count FROM mimiciv_hosp.admissions UNION ALL
    SELECT 'd_hcpcs' AS tbl, count(*) AS row_count FROM mimiciv_hosp.d_hcpcs UNION ALL
    SELECT 'd_icd_diagnoses' AS tbl, count(*) AS row_count FROM mimiciv_hosp.d_icd_diagnoses UNION ALL
    SELECT 'd_icd_procedures' AS tbl, count(*) AS row_count FROM mimiciv_hosp.d_icd_procedures UNION ALL
    SELECT 'd_labitems' AS tbl, count(*) AS row_count FROM mimiciv_hosp.d_labitems UNION ALL
    SELECT 'diagnoses_icd' AS tbl, count(*) AS row_count FROM mimiciv_hosp.diagnoses_icd UNION ALL
    SELECT 'drgcodes' AS tbl, count(*) AS row_count FROM mimiciv_hosp.drgcodes UNION ALL
    SELECT 'emar' AS tbl, count(*) AS row_count FROM mimiciv_hosp.emar UNION ALL
    SELECT 'emar_detail' AS tbl, count(*) AS row_count FROM mimiciv_hosp.emar_detail UNION ALL
    SELECT 'hcpcsevents' AS tbl, count(*) AS row_count FROM mimiciv_hosp.hcpcsevents UNION ALL
    SELECT 'labevents' AS tbl, count(*) AS row_count FROM mimiciv_hosp.labevents UNION ALL
    SELECT 'microbiologyevents' AS tbl, count(*) AS row_count FROM mimiciv_hosp.microbiologyevents UNION ALL
    SELECT 'omr' AS tbl, count(*) AS row_count FROM mimiciv_hosp.omr UNION ALL
    SELECT 'patients' AS tbl, count(*) AS row_count FROM mimiciv_hosp.patients UNION ALL
    SELECT 'pharmacy' AS tbl, count(*) AS row_count FROM mimiciv_hosp.pharmacy UNION ALL
    SELECT 'poe' AS tbl, count(*) AS row_count FROM mimiciv_hosp.poe UNION ALL
    SELECT 'poe_detail' AS tbl, count(*) AS row_count FROM mimiciv_hosp.poe_detail UNION ALL
    SELECT 'prescriptions' AS tbl, count(*) AS row_count FROM mimiciv_hosp.prescriptions UNION ALL
    SELECT 'procedures_icd' AS tbl, count(*) AS row_count FROM mimiciv_hosp.procedures_icd UNION ALL
    SELECT 'services' AS tbl, count(*) AS row_count FROM mimiciv_hosp.services UNION ALL
    SELECT 'transfers' AS tbl, count(*) AS row_count FROM mimiciv_hosp.transfers UNION ALL
    -- icu data
    SELECT 'icustays' AS tbl, count(*) AS row_count FROM mimiciv_icu.icustays UNION ALL
    SELECT 'chartevents' AS tbl, count(*) AS row_count FROM mimiciv_icu.chartevents UNION ALL
    SELECT 'd_items' AS tbl, count(*) AS row_count FROM mimiciv_icu.d_items UNION ALL
    SELECT 'datetimeevents' AS tbl, count(*) AS row_count FROM mimiciv_icu.datetimeevents UNION ALL
    SELECT 'inputevents' AS tbl, count(*) AS row_count FROM mimiciv_icu.inputevents UNION ALL
    SELECT 'outputevents' AS tbl, count(*) AS row_count FROM mimiciv_icu.outputevents UNION ALL
    SELECT 'procedureevents' AS tbl, count(*) AS row_count FROM mimiciv_icu.procedureevents
)
SELECT
    exp.tbl
    , exp.row_count AS expected_count
    , obs.row_count AS observed_count
    , CASE
        WHEN exp.row_count = obs.row_count
        THEN 'PASSED'
        ELSE 'FAILED'
    END AS ROW_COUNT_CHECK
FROM expected exp
INNER JOIN observed obs
  ON exp.tbl = obs.tbl
ORDER BY exp.tbl
;
