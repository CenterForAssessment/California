#############################################################################
####
####          Create 2013 Combined LONG Data for TCRP/LAUSD.
####          Merge 2013 CMO Data with the prior Longitudinal data:
####          Adam Van Iwaarden, Center for Assessment :: September 2013
####
#############################################################################

###  Load necessary packages to load *.xlsx files and format data in R

options(java.parameters = "-Xmx8g") # Need to increase Java memory limits BEFORE loading the 'xlsx' package
library(xlsx)
library(data.table)
library(plyr)
library(SGP)

### Utility function used to clean some variables
trimTrailingSymbol <- function(line) gsub("(^_+)|(_+$)", "", line)

### ### ### ### ### ### ### ### ### ### ### ###
###	Read in and clean the CMO files seperately
### ### ### ### ### ### ### ### ### ### ### ###

###
###  Alliance
###

al <- rbind.fill(
	read.xlsx2('~/Dropbox/SGP/California/Data/Base_Files/Alliance/ALLIANCE SUBMISSION 2013-14 (9-18-13).xlsx', sheetName='1112'),
	read.xlsx2('~/Dropbox/SGP/California/Data/Base_Files/Alliance/ALLIANCE SUBMISSION 2013-14 (9-18-13).xlsx', sheetName='1213'))

al$CMO_NAME <- "Alliance" # Alliance College-Ready Public Schools

# Set up a generic system of TEST_NAMES for all CMOs.  Collapse all ELA and categories into one - only one course sequence there.  
# Collapse Grade level math  Fix mispellings, etc.
levels(al$CONTENT_AREA) <- c(NA, "ALGEBRA_I", "ALGEBRA_II", "BIOLOGY", "CHEMISTRY", "EARTH_SCIENCE", rep("ELA", 7), "GEOMETRY", "HISTORY", 
	"INTEGRATED_MATHEMATICS_2", "INTEGRATED_MATHEMATICS_1", "INTEGRATED_SCIENCE_1", "LIFE_SCIENCE", rep("MATHEMATICS", 3), "GENERAL_MATHEMATICS",
	"PHYSICS", "SUMMATIVE_HS_MATHEMATICS", "US_HISTORY", "WORLD_HISTORY")

##  ID - change to as.character.  
al$ID <- as.character(al$ID)
al$GRADE <- as.character(as.integer(as.character(al$GRADE)))
al$CONTENT_AREA <- as.character(al$CONTENT_AREA)
al$SCHOOL_NUMBER <- as.character(al$SCHOOL_NUMBER) #  Change these too - some CMOs are numeric, some are factors
al$SCHOOL_NAME <- as.character(al$SCHOOL_NAME)
al$SCALE_SCORE <- as.integer(as.character(al$SCALE_SCORE))
al$YEAR <- as.numeric(al$YEAR)+2011


##  ETHNICITY, ELL_STATUS, GIFTED_TALENTED_STATUS & IEP_STATUS

levels(al$ETHNICITY)[c(1, 7)] <- c('American Indian or Alaskan Native', 'Hispanic')

levels(al$ELL_STATUS) <- c("Unknown", "English Learner", "English Only", "Initially Fluent English Proficient", "Reclassified Fluent English Proficient")
levels(al$SES_STATUS) <- c(NA, "Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes")
levels(al$GENDER) <- c('Gender: Female', 'Gender: Male')
al$IEP_STATUS <- NULL # Missing  

##  ACHIEVEMENT_LEVEL

levels(al$ACHIEVEMENT_LEVEL) <- sapply(levels(al$ACHIEVEMENT_LEVEL), capwords)
al$ACHIEVEMENT_LEVEL <- ordered(al$ACHIEVEMENT_LEVEL, levels = c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

#  Scores outside of CST scale range - probably from the CAPA ...
al$TEST_TYPE <- NA
al$TEST_TYPE[al$SCALE_SCORE >= 150 & al$SCALE_SCORE <= 600] <- "CST"

## VALID_CASE

al$VALID_CASE <- "VALID_CASE"

al$VALID_CASE[al$TEST_TYPE != "CST" | is.na(al$TEST_TYPE)] <- "INVALID_CASE"

# Look for duplicates:

al <- data.table(al, key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE"))
             setkeyv(al, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID"))
dups <- data.table(al[c(which(duplicated(al))-1, which(duplicated(al))),], key=key(al))
al$VALID_CASE[which(duplicated(al))-1] <- "INVALID_CASE" # 

# setkeyv(al, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "SCALE_SCORE"))
# setkeyv(al, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
# dups <- data.table(al[c(which(duplicated(al))-1, which(duplicated(al))),], key=key(al))
# al$VALID_CASE[which(duplicated(al))-1] <- "INVALID_CASE" #  0 Invalidated in 2012

table(al$VALID_CASE) # 8 INVALID


###
###  Aspire
###

asp <- read.csv("~/Dropbox/SGP/California/Data/Base_Files/Aspire/Aspire_12-13_CST_SGP_File.csv", header=TRUE, na.strings="NULL")

names(asp) <- toupper(names(asp))
names(asp)[c(2:4,28)] <- c("LAST_NAME","FIRST_NAME", "CONTENT_GROUP", "CONTENT_AREA")

# Set up a generic system of CONTENT_AREA for all CMOs.  
levels(asp$CONTENT_AREA) <- c("ALGEBRA_I", "ALGEBRA_II", "ALGEBRA_I", "BIOLOGY", "CHEMISTRY", "ELA", "GENERAL_MATHEMATICS", "GEOMETRY",
	"HISTORY", "INTEGRATED_SCIENCE_1", "MATHEMATICS", "PHYSICS", "SCIENCE", "SUMMATIVE_HS_MATHEMATICS", "WORLD_HISTORY")

## EMH_LEVEL
levels(asp$EMH_LEVEL) <- c(NA, "Elementary", "Secondary")

##  SCHOOL_NUMBER / NAME
asp$SCHOOL_NUMBER[asp$SCHOOL_NUMBER==-1] <- NA
levels(asp$SCHOOL_NAME)[1] <- NA

##  ETHNICITY, ELL_STATUS, GENDER & IEP_STATUS
levels(asp$ELL_STATUS) <- c("Unknown", "English Learner", "English Only", "Initially Fluent English Proficient", 
	"Reclassified Fluent English Proficient", "To Be Determined") # Labels as provided by Aspire, matches Cali AYP Definitions of Subgroups.
levels(asp$SES_STATUS) <- c(NA, "Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(asp$IEP_STATUS) <- c(NA, "Student with Disabilities: No", "Student with Disabilities: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(asp$GENDER) <- c('Gender: Female', 'Gender: Male')
levels(asp$ETHNICITY)[1:3] <- c(NA, 'Black or African American', "American Indian or Alaskan Native")

##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary" and ran basic descriptives:
asp$ACHIEVEMENT_LEVEL <- ordered(asp$ACHIEVEMENT_LEVEL, levels = 1:5, labels=c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

##  Set all variables to the correct class for merging:

##  ID - change to as.character.  Will need to make sure there are no duplicates accross CMO's / LAUSD
asp$ID <- as.character(asp$ID)

#  Scores outside of CST scale range - probably from the CAPA ...
asp$TEST_TYPE <- "CMA"
asp$TEST_TYPE[asp$SCALE_SCORE >= 150 & asp$SCALE_SCORE <= 600] <- "CST"

## VALID_CASE
asp$VALID_CASE <- "VALID_CASE"

asp$VALID_CASE[asp$SCALE_SCORE < 150 | is.na(asp$SCALE_SCORE)] <- "INVALID_CASE"

# Duplicates
asp <- data.table(asp, key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE", "INSTRUCTOR_NUMBER_1")) # Add SCORE for kids with both Instructor # == NA (keep highest score)
setkeyv(asp, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID"))
dups <- data.table(asp[c(which(duplicated(asp))-1, which(duplicated(asp))),], key=c("YEAR", "CONTENT_AREA","GRADE", "ID", "INSTRUCTOR_NUMBER_1"))
asp$VALID_CASE[which(duplicated(asp))-1] <- "INVALID_CASE"

## No more dups added.  
setkeyv(asp, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "SCALE_SCORE"))
setkeyv(asp, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
dups <- data.table(asp[c(which(duplicated(asp))-1, which(duplicated(asp))),], key=c("YEAR", "CONTENT_AREA","GRADE", "ID"))
asp$VALID_CASE[which(duplicated(asp))-1] <- "INVALID_CASE" 

table(asp$VALID_CASE)
# 14 total INVALID_CASEs in 2013 ::  0 duplicates

asp$CONTENT_GROUP <- NULL

asp$INSTRUCTOR_NUMBER_2 <- NULL 
asp$INSTRUCTOR_NUMBER_3 <- NULL 
asp$INSTRUCTOR_NUMBER_4 <- NULL 
asp$INSTRUCTOR_2_WEIGHT <- NULL 
asp$INSTRUCTOR_3_WEIGHT <- NULL 
asp$INSTRUCTOR_4_WEIGHT <- NULL 

##  Get variables into proper class for merging
asp$SCHOOL_NUMBER <- as.character(asp$SCHOOL_NUMBER)
asp$SCHOOL_NAME <- as.character(asp$SCHOOL_NAME)
asp$DISTRICT_NUMBER <- as.character(asp$DISTRICT_NUMBER)
asp$DISTRICT_NAME <- as.character(asp$DISTRICT_NAME)
asp$INSTRUCTOR_NUMBER_1 <- as.character(asp$INSTRUCTOR_NUMBER_1)


###
###  Green Dot
###

gd <- read.delim('~/Dropbox/SGP/California/Data/Base_Files/Green Dot Public Schools/SGP_Upload_Green_Dot_Final.txt')

##  For some reason the ID was read in as scientific notation.  
##  Stacked 2012 & 2013 data sets, converted 'n/a' to blank, and changed year to numeric then saved as .txt file

# gd <- rbind.fill(
	# read.xlsx2('~/Dropbox/SGP/California/Data/Base_Files/Green Dot Public Schools/SGP_Upload_Green_Dot_Final.xlsx', sheetName='2012 Prior Data'),
	# read.xlsx2('~/Dropbox/SGP/California/Data/Base_Files/Green Dot Public Schools/SGP_Upload_Green_Dot_Final.xlsx', sheetName='2013 Data'))

gd$CMO_NAME <- "Green Dot" # Set to this to match last year's name - submitted as 'Green Dot Public Schools'
gd$INSTRUCTOR_NUMBER_2 <- NULL 
gd$INSTRUCTOR_NUMBER_. <- NULL 
gd$INSTRUCTOR_2_WEIGHT <- NULL 
gd$INSTRUCTOR_._WEIGHT <- NULL 

# Set up a system of TEST_TYPES.  
gd$TEST_TYPE <- "CMA"
gd$TEST_TYPE[gd$SCALE_SCORE >= 150 & gd$SCALE_SCORE <= 600] <- "CST"

# Set up a generic system of CONTENT_AREA for all CMOs.  

for (l in c(' 5', ' 6', ' 7', ' 8', ' 9', ' 10', ' 11')) {
	levels(gd$CONTENT_AREA) <- gsub(l, "", levels(gd$CONTENT_AREA))
}
levels(gd$CONTENT_AREA) <- toupper(levels(gd$CONTENT_AREA))
levels(gd$CONTENT_AREA) <- gsub("MATH", "MATHEMATICS", levels(gd$CONTENT_AREA))
levels(gd$CONTENT_AREA)[1] <- "GENERAL MATHEMATICS"
levels(gd$CONTENT_AREA) <- gsub(" ", "_", levels(gd$CONTENT_AREA))
levels(gd$CONTENT_AREA) <- gsub("INTEGRATED/COORDINATED", "INTEGRATED", levels(gd$CONTENT_AREA))
levels(gd$CONTENT_AREA)[17] <- "SUMMATIVE_HS_MATHEMATICS"
summary(gd$CONTENT_AREA)
gd$CONTENT_AREA <- as.character(gd$CONTENT_AREA)

##  ID - change to as.character.  Will need to make sure there are no duplicates accross CMO's / LAUSD
gd$ID <- as.character(gd$ID)

levels(gd$ETHNICITY)[c(1, 2, 5)] <- c("Black or African American", "American Indian or Alaskan Native", "Hispanic")

levels(gd$ELL_STATUS) <- c("English Learner", "English Only", "Initially Fluent English Proficient", 
	"Reclassified Fluent English Proficient", "Reclassified Fluent English Proficient", "To Be Determined") # Labeled to match Aspire , "Unknown"
levels(gd$SES_STATUS) <- c("Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(gd$IEP_STATUS) <- c("Student with Disabilities: No", "Student with Disabilities: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(gd$GENDER) <- c('Gender: Female', 'Gender: Male') 

##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary" and ran basic descriptives:
gd$ACHIEVEMENT_LEVEL <- ordered(gd$ACHIEVEMENT_LEVEL, levels = c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced")) 


## VALID_CASE
gd$VALID_CASE <- "VALID_CASE"
gd$VALID_CASE[gd$TEST_TYPE!="CST"] <- "INVALID_CASE"

# Duplicates on all important factors.  No diff school numbers, etc.  Take highest score
gd <- data.table(gd, key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE"))
setkeyv(gd,  c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID"))
dups <- data.table(gd[c(which(duplicated(gd))-1, which(duplicated(gd))),], key=c("ID", "YEAR", "CONTENT_AREA"))

gd$VALID_CASE[which(duplicated(gd))-1] <- "INVALID_CASE"

setkeyv(gd,  c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "SCALE_SCORE"))
setkeyv(gd,  c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
dups <- data.table(gd[c(which(duplicated(gd))-1, which(duplicated(gd))),], key=key(gd))

table(gd$VALID_CASE) # 5 cases in 2013 data

##  Get variables into proper class for merging
gd$SCHOOL_NUMBER <- as.character(gd$SCHOOL_NUMBER)
levels(gd$SCHOOL_NAME)[1] <- NA
gd$SCHOOL_NAME <- as.character(gd$SCHOOL_NAME)
gd$INSTRUCTOR_NUMBER_1 <- as.character(gd$INSTRUCTOR_NUMBER_1)
gd$INSTRUCTOR_1_WEIGHT <- NULL


###
###  PUC
###

puc <- read.xlsx2("~/Dropbox/SGP/California/Data/Base_Files/PUC/PUC CST Data File 2009-2013.xlsx", 1) #

puc$CMO_NAME <- "PUC"  #  Change from "PUC Schools" to match last year

# Set up a generic system of CONTENT_AREA for all CMOs.  
# Renamed PUC's Test Type variable "CST Test Name" in the .txt file to match other CMO's
# "Science and LIFE_SCIENCE collapsed into the same level-"CST_Science/LifeScience".  Need to seperate by grade.
levels(puc$CONTENT_AREA) <- c("ALGEBRA_I", "ALGEBRA_II", "BIOLOGY", "CHEMISTRY", "EARTH_SCIENCE", "ELA", "GENERAL_MATHEMATICS", "GEOMETRY", "US_HISTORY", 
	"INTEGRATED_SCIENCE_1", "INTEGRATED_SCIENCE_3", "MATHEMATICS", "PHYSICS", "SCIENCE", "SUMMATIVE_HS_MATHEMATICS", "WORLD_HISTORY")  
puc$CONTENT_AREA <- as.character(puc$CONTENT_AREA)

puc$CONTENT_AREA[puc$CONTENT_AREA=="SCIENCE" & as.integer(as.character(puc$GRADE)) > 8] <- "LIFE_SCIENCE"

##  Convert vars to correct class/format
puc$ID <- as.character(as.numeric(as.character(puc$ID)))
puc$GRADE <- as.character(as.integer(as.character(puc$GRADE)))
puc$YEAR <- as.character(as.integer(as.character(puc$YEAR)))
puc$SCALE_SCORE <- as.integer(as.character(puc$SCALE_SCORE))
puc$SCHOOL_NAME <- as.character(puc$SCHOOL_NAME)
puc$SCHOOL_NUMBER <- as.character(as.numeric(as.character(puc$SCHOOL_NUMBER)))
puc$DISTRICT_NAME <- as.character(puc$ORG_NAME)
puc$ORG_NAME <- NULL
puc$DISTRICT_NUMBER <- as.character(as.numeric(as.character(puc$DISTRICT_NUMBER)))
levels(puc$INSTRUCTOR_NUMBER_1)[225] <- '999999999999'
puc$INSTRUCTOR_NUMBER_1 <- as.character(as.numeric(as.character(puc$INSTRUCTOR_NUMBER_1)))
puc$Sub <- NULL

puc$TEST_TYPE <- "CMA"
puc$TEST_TYPE[puc$SCALE_SCORE >= 150 & puc$SCALE_SCORE <= 600] <- "CST"

##  ETHNICITY, ELL_STATUS, GIFTED_TALENTED_STATUS & IEP_STATUS

levels(puc$ETHNICITY)[1] <- NA

levels(puc$ELL_STATUS) <- c("Unknown", "English Learner", "English Learner", "English Only", "Initially Fluent English Proficient", "Reclassified Fluent English Proficient") # Labeled to match Aspire
levels(puc$SES_STATUS) <- c(NA, "Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(puc$IEP_STATUS) <- c(NA, "Student with Disabilities: No", "Student with Disabilities: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(puc$GENDER) <- c(NA, 'Gender: Female', 'Gender: Male') 

##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary" and ran basic descriptives:
puc$ACHIEVEMENT_LEVEL <- ordered(as.integer(puc$ACHIEVEMENT_LEVEL), levels = 1:6, labels = c(NA, "Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))


## VALID_CASE
puc$VALID_CASE <- "VALID_CASE"

puc$VALID_CASE[is.na(puc$SCALE_SCORE) | puc$TEST_TYPE == 'CMA'] <- "INVALID_CASE"

# Duplicates  -  same scores and INSTRUCTOR_NUMBER_1
puc <- data.table(puc, key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE", "INSTRUCTOR_NUMBER_1"))
dups <- data.table(puc[c(which(duplicated(puc))-1, which(duplicated(puc))),], key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
puc$VALID_CASE[which(duplicated(puc))-1] <- "INVALID_CASE"  #  Identical cases (mostly LAUSD)

setkeyv(puc, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE","ID", "SCALE_SCORE"))
setkeyv(puc, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE","ID"))
dups <- data.table(puc[c(which(duplicated(puc))-1, which(duplicated(puc))),], key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
puc$VALID_CASE[which(duplicated(puc))-1] <- "INVALID_CASE"  

# setkeyv(puc, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "SCALE_SCORE"))
# setkeyv(puc, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
# dups <- data.table(puc[c(which(duplicated(puc))-1, which(duplicated(puc))),], key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
# puc$VALID_CASE[which(duplicated(puc))-1] <- "INVALID_CASE"

table(puc$VALID_CASE) #  7 invalid cases  


####
####  COMBINE ALL CMO FILES TOGETHER
####

CMO_Data_LONG <- rbind.fill(asp, gd, puc, al)

CMO_Data_LONG$CONTENT_AREA <- as.character(CMO_Data_LONG$CONTENT_AREA)

levels(CMO_Data_LONG$EMH_LEVEL) <- c("Elementary", "Secondary", "High School", "Middle School", "High School", "Middle School", "High School", "Middle School") #Still not great/consistent ...

#  Clean names - Some are all caps
trimWhiteSpace <- function(line) gsub("(^ +)|( +$)", "", line)

f.names <- sapply(levels(CMO_Data_LONG$FIRST_NAME), capwords)
levels(CMO_Data_LONG$FIRST_NAME) <- trimWhiteSpace(f.names)

l.names <- sapply(levels(CMO_Data_LONG$LAST_NAME), capwords)
levels(CMO_Data_LONG$LAST_NAME) <- trimWhiteSpace(l.names)

save(CMO_Data_LONG, file="~/Dropbox/SGP/California/Data/Base_Files/CMO_Data_LONG-2013.Rdata")

# rm(al); rm(asp); rm(gd); rm(puc); gc()


### ### ### ### ### ### ### ### ### ### ### ### ### ###
###			Read in and clean the annual LAUSD files
### ### ### ### ### ### ### ### ### ### ### ### ### ###

###
###  2013 :: Add in Demographic Info, change from wide to long. change Var names/factor values, rinse & repeat 
###

la_2013 <- read.delim("~/Dropbox/SGP/California/Data/Base_Files/LAUSD/SY2012-13/TCRP_Star_2013.txt", header=TRUE) #TCRP_STAR_file_2012_13.csv
names(la_2013) <- toupper(names(la_2013))

demog.2013 <- read.delim("~/Dropbox/SGP/California/Data/Base_Files/LAUSD/SY2012-13/Demographics 2012-13.txt", header=TRUE)
names(demog.2013) <- toupper(names(demog.2013))
demog.2013 <- demog.2013[,c(1, 3:4, 6, 9:11, 13)]

# Merge in the demographic data.  Keep as data frame for column number indexing.  Change to data.table for teacher ID merge.
la_2013 <- merge(la_2013, demog.2013, by="STUDENT_PSEUDO_ID", all.x=TRUE)


###  Wide to long ::

##  ELA
tmp.la <- la_2013[, c(1:6, grep("ELA", names(la_2013)), 25:31)] #Select all columns with "ELA" in the names
names(tmp.la)[7:9] <- c("TEST_TYPE", "SCALE_SCORE", "ACHIEVEMENT_LEVEL") # Rename generic: "CSTORCMA_ELA" "SCALEDSCORE_ELA" "PERFORMANCELEVEL_ELA"
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out a few records
tmp.la$TEST_TYPE[tmp.la$RECTYPE==2] <- 3
tmp.la$TEST_TYPE[tmp.la$RECTYPE==3] <- 4
tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CMA_is only in grades 3-9, these are CST_teSTS_in grades 2, 10 & 11
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))
tmp.la$CONTENT_AREA <- factor(paste(tmp.la$TEST_TYPE, " ELA", sep=""))#  Will later match up with CMO data "CONTENT_AREA"
levels(tmp.la$CONTENT_AREA)[2] <- "ELA"

la <- tmp.la

##  Math
tmp.la <- la_2013[, c(1:6, grep("MATH", names(la_2013)), 25:31)] 
names(tmp.la)[7:10] <- c("LAUSD_TEST_CODE", "TEST_TYPE", "SCALE_SCORE", "ACHIEVEMENT_LEVEL") # Rename MATH specific vars to generic
# "MATHTESTTAKEN"         "CSTORCMA_MATH"         "SCALEDSCORE_MATH"      "PERFORMANCELEVEL_MATH"
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out a few records

tmp.la$TEST_TYPE[tmp.la$RECTYPE==2] <- 3
tmp.la$TEST_TYPE[tmp.la$RECTYPE==3] <- 4
tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CMA_is only in grades 3-9, these are CST_teSTS_in grades 2, 10 & 11
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))

#table(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE, tmp.la$GRADE)

tmp.la$CONTENT_AREA <- paste(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE); tmp.la$CONTENT_AREA <- factor(tmp.la$CONTENT_AREA)
levels(tmp.la$CONTENT_AREA) <- c("CMA_MATHEMATICS", "CMA_ALGEBRA I", "CMA_GEOMETRY", "CMA_MATHEMATICS", "MATHEMATICS", "GENERAL_MATHEMATICS", "SUMMATIVE_HS_MATHEMATICS", "ALGEBRA_I", "INTEGRATED_MATHEMATICS_1", "GEOMETRY", "INTEGRATED_MATHEMATICS_2", "ALGEBRA_II", "CST_MATH_CODE_8", "MATHEMATICS") #  Numbers from LAUSD data dictionary. 

la <- rbind.fill(tmp.la, la)

## SCIENCE
grep("SCIENCE", names(la_2013)) # EOCSCIENCE, "Social Science", etc.  Don't use this here!
names(la_2013)[grep("SCIENCE", names(la_2013))]

tmp.la <- la_2013[, c(1:6, 9, 12, 15, 21, 25:31)] #Select SCIENCE fields - do this seperately from EOC-SCIENCE...
names(tmp.la)[7:10] <- c("LAUSD_TEST_CODE", "TEST_TYPE", "SCALE_SCORE", "ACHIEVEMENT_LEVEL") # Rename SCIENCE specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out missing records

tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CMA_is only in grade 5
tmp.la$TEST_TYPE[tmp.la$RECTYPE==2] <- 3 # There are a handful of CAPA_tests
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))

tmp.la$CONTENT_AREA <- paste(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE); tmp.la$CONTENT_AREA <- factor(tmp.la$CONTENT_AREA)
levels(tmp.la$CONTENT_AREA) <- c("CMA_EARTH_SCIENCE", "CMA_BIOLOGY", "CMA_CHEMISTRY", "CMA_PHYSICS", "CMA_INTEGRATED_SCIENCE_1", "CMA_INTEGRATED_SCIENCE_2", "CMA_INTEGRATED_SCIENCE_3", "CMA_UNKNOWN_SCIENCE", "CMA_SCIENCE", "EARTH_SCIENCE", "BIOLOGY", "CHEMISTRY",  "PHYSICS", "INTEGRATED_SCIENCE_1", "INTEGRATED_SCIENCE_2", "INTEGRATED_SCIENCE_3", "UNKNOWN_SCIENCE", "SCIENCE") #  Numbers from LAUSD data dictionary. 

la <- rbind.fill(tmp.la, la)

##  EOC SCIENCE
tmp.la <- la_2013[, c(1:6, 9, 12, 18, 24, 25:31)] #Select SCIENCE fields - do this seperately from EOC-SCIENCE...
names(tmp.la)[7:10] <- c("LAUSD_TEST_CODE", "TEST_TYPE", "SCALE_SCORE", "ACHIEVEMENT_LEVEL") # Rename SCIENCE specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CST_TESTS_ONLY
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))

#table(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE, tmp.la$GRADE)

tmp.la$CONTENT_AREA <- paste(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE); tmp.la$CONTENT_AREA <- factor(tmp.la$CONTENT_AREA)
levels(tmp.la$CONTENT_AREA) <- c("CMA_EARTH_SCIENCE", "CMA_BIOLOGY", "CMA_CHEMISTRY",  "CMA_PHYSICS", "CMA_INTEGRATED_SCIENCE_1", "CMA_INTEGRATED_SCIENCE_2", "CMA_INTEGRATED_SCIENCE_3", "EARTH_SCIENCE", "BIOLOGY", "CHEMISTRY",  "PHYSICS", "INTEGRATED_SCIENCE_1", "INTEGRATED_SCIENCE_2", "INTEGRATED_SCIENCE_3", "INTEGRATED_SCIENCE_4") #  Numbers from LAUSD data dictionary. 
 
la <- rbind.fill(tmp.la, la)

## History
tmp.la <- la_2013[, c(1:6, grep("HISTORYSOCIAL", names(la_2013)), 25:31)] 
names(tmp.la)[7:8] <- c("SCALE_SCORE", "ACHIEVEMENT_LEVEL") # Rename HISTORY specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE <- factor(1, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))
tmp.la$CONTENT_AREA <- factor("HISTORY")

la <- rbind.fill(tmp.la, la)

##  WORLD_HISTORY

tmp.la <- la_2013[, c(1:6, grep("WORLDHISTORY", names(la_2013)), 25:31)] 
names(tmp.la)[7:8] <- c("SCALE_SCORE", "ACHIEVEMENT_LEVEL") # Rename WORLD_HISTORY specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE <- factor(1, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))
tmp.la$CONTENT_AREA <- factor("WORLD_HISTORY")
# tmp.la$CONTENT_AREA <- "HISTORY" #Put in the CONTENT_AREA Field

la <- rbind.fill(tmp.la, la)

dim(la)

###  Rename Vars, Set factor levels, etc. etc.

#  Which School number?  The one in demog file has lots of NA's...
names(la)[c(1, 4:5, 9, 13:15)] <- c("ID", "SCHOOL_NAME", "SCHOOL_NUMBER", "YEAR", "ETHNICITY", "ELL_STATUS", "SES_STATUS") # NO IEP_STATUS in 2013 data

la$SCHCDSCODE <- NULL #  All LAUSD's state code.  CDSCODE in 2012

# la$GRADECODE <- factor(la$GRADECODE, ordered=TRUE)

la$ID <- as.character(la$ID)

##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary"
la$ACHIEVEMENT_LEVEL <- ordered(la$ACHIEVEMENT_LEVEL, levels = 1:5, labels=c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

##  ETHNICITY, ELL_STATUS, GENDER & IEP_STATUS

levels(la$GENDER) <- c(NA, NA, 'Gender: Female', 'Gender: Male')
levels(la$GENDERCODE)<- c('Gender: Female', 'Gender: Male')
# fill in NA from GENDERCODE and null out.
la$GENDER[is.na(la$GENDER)] <- la$GENDERCODE[is.na(la$GENDER)]
la$GENDERCODE <- NULL

levels(la$ETHNICITY) <- c('American Indian or Alaskan Native', 'Asian', 'Black or African American', 'Filipino', 'Hispanic', 'Pacific Islander', 'White')  # Conform to some of the conventions used in the CMOs.  Still lots of inconsistency - some have more detail than others ...

levels(la$ELL_STATUS) <- c("English Only", "Initially Fluent English Proficient", "English Learner", "Reclassified Fluent English Proficient", "Unknown")
levels(la$SES_STATUS) <- c("Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes") # AVI based on Cali AYP Definitions of Subgroups

# levels(la$IEP_STATUS) NO IEP Data in 2013 submission


## VALID_CASE
la$VALID_CASE <- "VALID_CASE"

la$VALID_CASE[la$TEST_TYPE != "CST"] <- "INVALID_CASE"

#  Total duplicates
la <- data.table(la, key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE", "SCHOOL_NUMBER"))
dups <- data.table(la[c(which(duplicated(la))-1, which(duplicated(la))),], key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))

la$VALID_CASE[which(duplicated(la))-1] <- "INVALID_CASE"  # 436 cases - checked again and some triplicates, but all are invalid already.

# Different Score dups ::  Only one kid in 2013 with different recorded scores, and different school
setkeyv(la, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCHOOL_NUMBER", "SCALE_SCORE"))
setkeyv(la, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCHOOL_NUMBER"))
dups <- data.table(la[c(which(duplicated(la))-1, which(duplicated(la))),], key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
dim(dups["VALID_CASE"])
la$VALID_CASE[which(duplicated(la))-1] <- "INVALID_CASE"  # 33,178 cases

setkeyv(la, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "SCALE_SCORE"))
setkeyv(la, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
dups <- data.table(la[c(which(duplicated(la))-1, which(duplicated(la))),], key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
dim(dups["VALID_CASE"])
la$VALID_CASE[which(duplicated(la))-1] <- "INVALID_CASE"  # 237 (valid) cases

table(la$VALID_CASE) #83,969

lausd <- la

rm(la_2013); rm(demog.2013)
gc()

###
###  Collect & Merge in the TEACHER DATA 
###

####  2013
###  Elementary Schools :: Collect all three periods
##  EP1
tchr.2013 <- read.delim("~/Dropbox/SGP/California/Data/Base_Files/LAUSD/SY2012-13/Marks Ele EP1 2013.txt", header=TRUE)
#table(tchr.2013$CRS_COURSE_CODE, tchr.2013$CRS_COURSE_NAME)

tchr.2013 <- tchr.2013[c(10:9, 2, 6, 4, 8)] #"student_pseudo_id"   "teacher_pseudo_id"   "MARKING_PERIOD_CODE" "SCH_CDS_CODE" "PRL_PREFERRED_LOCATION_CODE" "CRS_COURSE_NAME" 
names(tchr.2013) <- c("ID", "INSTRUCTOR_NUMBER_1", "MARKING_PERIOD", "SCHOOL_NUMBER", "PRLPREFERREDLOCATIONCODE", "CONTENT_AREA")
tchr.2013 <- tchr.2013[!is.na(tchr.2013$INSTRUCTOR_NUMBER_1),]
tchr.2013 <- tchr.2013[tchr.2013$CONTENT_AREA %in% c("MATHEMATICS", "READING", "ELD READING", "WRITING", "ELD WRITING", "HIST SOC SCI", "SCIENCE"),]
tchr.2013$CONTENT_AREA<-droplevels(tchr.2013$CONTENT_AREA)
levels(tchr.2013$CONTENT_AREA) <- c("ELA", "ELA", "HISTORY", "MATHEMATICS", "ELA", "SCIENCE", "ELA")

tchr.2013$ID <- as.character(tchr.2013$ID)
tchr.2013$INSTRUCTOR_NUMBER_1 <- as.character(tchr.2013$INSTRUCTOR_NUMBER_1)

# Remove duplicates
tchr.2013 <- data.table(tchr.2013, key=c("CONTENT_AREA", "SCHOOL_NUMBER", "INSTRUCTOR_NUMBER_1", "ID"))
tchr.2013 <- tchr.2013[which(!duplicated(tchr.2013)),]

lausd.tchr <- tchr.2013

## EP2
tchr.2013 <- read.delim("~/Dropbox/SGP/California/Data/Base_Files/LAUSD/SY2012-13/Marks Ele EP2 2013.txt", header=TRUE)

tchr.2013 <- tchr.2013[c(10:9, 2, 6, 4, 8)]
names(tchr.2013) <- c("ID", "INSTRUCTOR_NUMBER_1", "MARKING_PERIOD", "SCHOOL_NUMBER", "PRLPREFERREDLOCATIONCODE", "CONTENT_AREA")
tchr.2013 <- tchr.2013[!is.na(tchr.2013$INSTRUCTOR_NUMBER_1),]
tchr.2013 <- tchr.2013[tchr.2013$CONTENT_AREA %in% c("MATHEMATICS", "READING", "ELD READING", "WRITING", "ELD WRITING", "HIST SOC SCI", "SCIENCE"),]
tchr.2013$CONTENT_AREA<-droplevels(tchr.2013$CONTENT_AREA)
levels(tchr.2013$CONTENT_AREA) <- c("ELA", "ELA", "HISTORY", "MATHEMATICS", "ELA", "SCIENCE", "ELA")

tchr.2013$ID <- as.character(tchr.2013$ID)
tchr.2013$INSTRUCTOR_NUMBER_1 <- as.character(tchr.2013$INSTRUCTOR_NUMBER_1)
tchr.2013 <- data.table(tchr.2013, key=c("CONTENT_AREA", "SCHOOL_NUMBER", "INSTRUCTOR_NUMBER_1", "ID"))
tchr.2013 <- tchr.2013[which(!duplicated(tchr.2013)),]

lausd.tchr <- rbind(lausd.tchr, tchr.2013)

## EP3
tchr.2013 <- read.delim("~/Dropbox/SGP/California/Data/Base_Files/LAUSD/SY2012-13/Marks Ele EP3 2013.txt", header=TRUE)

tchr.2013 <- tchr.2013[c(10:9, 2, 6, 4, 8)]
names(tchr.2013) <- c("ID", "INSTRUCTOR_NUMBER_1", "MARKING_PERIOD", "SCHOOL_NUMBER", "PRLPREFERREDLOCATIONCODE", "CONTENT_AREA")
tchr.2013 <- tchr.2013[!is.na(tchr.2013$INSTRUCTOR_NUMBER_1),]
tchr.2013 <- tchr.2013[tchr.2013$CONTENT_AREA %in% c("MATHEMATICS", "READING", "ELD READING", "WRITING", "ELD WRITING", "HIST SOC SCI", "SCIENCE"),]
tchr.2013$CONTENT_AREA<-droplevels(tchr.2013$CONTENT_AREA)
levels(tchr.2013$CONTENT_AREA) <- c("ELA", "ELA", "HISTORY", "MATHEMATICS", "ELA", "SCIENCE", "ELA")

tchr.2013$ID <- as.character(tchr.2013$ID)
tchr.2013$INSTRUCTOR_NUMBER_1 <- as.character(tchr.2013$INSTRUCTOR_NUMBER_1)
tchr.2013 <- data.table(tchr.2013, key=c("CONTENT_AREA", "SCHOOL_NUMBER", "INSTRUCTOR_NUMBER_1", "ID"))
tchr.2013 <- tchr.2013[which(!duplicated(tchr.2013)),]

lausd.tchr <- rbind(lausd.tchr, tchr.2013)


###  Secondary Schools :: add to Elem.
tchr.2013 <- read.delim("~/Dropbox/SGP/California/Data/Base_Files/LAUSD/SY2012-13/Mark Secondary 2013.txt", header=TRUE)

tchr.2013 <- tchr.2013[c(12:11, 2, 6, 4, 7, 9)] # ,12
names(tchr.2013) <- c("ID", "INSTRUCTOR_NUMBER_1", "MARKING_PERIOD", "SCHOOL_NUMBER", "PRLPREFERREDLOCATIONCODE", "CONTENT_AREA", "COURSE_NAME")
tchr.2013 <- tchr.2013[!is.na(tchr.2013$INSTRUCTOR_NUMBER_1),]

# summary(tchr.2013$COURSE_NAME[tchr.2013$CONTENT_AREA == "COMPUTER SCIENCE"])
# summary(tchr.2013$COURSE_NAME[tchr.2013$CONTENT_AREA == "INTERDISCIPLINARY"])
# tchr.2013[tchr.2013$CONTENT_AREA == "INTERDISCIPLINARY",] All "ELA" so add it in
# summary(tchr.2013$CONTENT_AREA[tchr.2013$COURSE_NAME == "HOMEROOM"])
# summary(tchr.2013$COURSE_NAME[tchr.2013$CONTENT_AREA == "SP ED:VOC ED F HAND"]) #  Lots of COURSES/INSTRCTORS we could add here.  Some big/obvious:

###  Adds about 25,000 courses
math.index <- grep("MATH",names(summary(tchr.2013$COURSE_NAME[tchr.2013$CONTENT_AREA == "SP ED:VOC ED F HAND"])))
ela.index <- c(grep("ELA",names(summary(tchr.2013$COURSE_NAME[tchr.2013$CONTENT_AREA == "SP ED:VOC ED F HAND"]))),
				grep("ENG",names(summary(tchr.2013$COURSE_NAME[tchr.2013$CONTENT_AREA == "SP ED:VOC ED F HAND"]))),
				grep("READ",names(summary(tchr.2013$COURSE_NAME[tchr.2013$CONTENT_AREA == "SP ED:VOC ED F HAND"]))),
				grep("WRIT",names(summary(tchr.2013$COURSE_NAME[tchr.2013$CONTENT_AREA == "SP ED:VOC ED F HAND"]))))
sci.index <- c(grep("SCI",names(summary(tchr.2013$COURSE_NAME[tchr.2013$CONTENT_AREA == "SP ED:VOC ED F HAND"]))))
hst.index <- c(grep("HIST",names(summary(tchr.2013$COURSE_NAME[tchr.2013$CONTENT_AREA == "SP ED:VOC ED F HAND"]))))
courses <- names(summary(tchr.2013$COURSE_NAME[tchr.2013$CONTENT_AREA == "SP ED:VOC ED F HAND"]))
for (i in math.index) {
	tchr.2013$CONTENT_AREA[tchr.2013$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2013$COURSE_NAME == courses[i] ] <- "MATHEMATICS"
}

for (i in ela.index) {
	tchr.2013$CONTENT_AREA[tchr.2013$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2013$COURSE_NAME == courses[i] ] <- "ENGLISH" # will change to ELA
}

for (i in sci.index) {
	tchr.2013$CONTENT_AREA[tchr.2013$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2013$COURSE_NAME == courses[i] ] <- "SCIENCE"
}

for (i in hst.index) {
	tchr.2013$CONTENT_AREA[tchr.2013$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2013$COURSE_NAME == courses[i] ] <- "SOCIAL SCIENCE"
}


tchr.2013 <- tchr.2013[tchr.2013$CONTENT_AREA %in% c("BILINGUAL-ESL", "ENGLISH", "INTERDISCIPLINARY", "MATHEMATICS", "READING", "SCIENCE", "SOCIAL SCIENCE"),]
tchr.2013$CONTENT_AREA<-droplevels(tchr.2013$CONTENT_AREA)
levels(tchr.2013$CONTENT_AREA) <- c("ELA", "ELA", "MATHEMATICS", "MATHEMATICS", "ELA", "SCIENCE", "HISTORY")

tchr.2013$CA2 <- tchr.2013$COURSE_NAME
levels(tchr.2013$CA2)[grep("ALGEBRA 1", levels(tchr.2013$CA2))] <- 'ALGEBRA_I'
levels(tchr.2013$CA2)[grep("ALG 1", levels(tchr.2013$CA2))] <- 'ALGEBRA_I'
levels(tchr.2013$CA2)[grep("ALG1", levels(tchr.2013$CA2))] <- 'ALGEBRA_I'
levels(tchr.2013$CA2)[grep("ALG 2", levels(tchr.2013$CA2))] <- 'ALGEBRA_II'
levels(tchr.2013$CA2)[grep("ALG2", levels(tchr.2013$CA2))] <- 'ALGEBRA_II'
levels(tchr.2013$CA2)[grep("ALGEBRA 2", levels(tchr.2013$CA2))] <- 'ALGEBRA_II'
levels(tchr.2013$CA2)[grep("ALGEBRA READ", levels(tchr.2013$CA2))] <- 'ALGEBRA_I' # why not?
levels(tchr.2013$CA2)[grep("GEOMETRY", levels(tchr.2013$CA2))] <- 'GEOMETRY'
levels(tchr.2013$CA2)[grep("GEOM ", levels(tchr.2013$CA2))] <- 'GEOMETRY'

levels(tchr.2013$CA2)[grep('GEO & ALG', levels(tchr.2013$CA2))] <- "INTEGRATED_MATHEMATICS_1"
levels(tchr.2013$CA2)[grep('INTEGR MATH 1', levels(tchr.2013$CA2))] <- "INTEGRATED_MATHEMATICS_1"
levels(tchr.2013$CA2)[grep('INTEGR MATH 2', levels(tchr.2013$CA2))] <- "INTEGRATED_MATHEMATICS_2"
levels(tchr.2013$CA2)[grep('INTEGR MATH 3', levels(tchr.2013$CA2))] <- "INTEGRATED_MATHEMATICS_3"

levels(tchr.2013$CA2)[grep("MATH 4", levels(tchr.2013$CA2))] <- 'MATHEMATICS'
levels(tchr.2013$CA2)[grep("MATH 5", levels(tchr.2013$CA2))] <- 'MATHEMATICS'
levels(tchr.2013$CA2)[grep("MATH 6", levels(tchr.2013$CA2))] <- 'MATHEMATICS'
levels(tchr.2013$CA2)[grep("MATH 7", levels(tchr.2013$CA2))] <- 'MATHEMATICS'
levels(tchr.2013$CA2)[grep("MATH ", levels(tchr.2013$CA2))] <- 'GENERAL_MATHEMATICS'
levels(tchr.2013$CA2)[grep(" MATH", levels(tchr.2013$CA2))] <- 'GENERAL_MATHEMATICS'


levels(tchr.2013$CA2)[grep("BIO", levels(tchr.2013$CA2))] <- 'BIOLOGY'
levels(tchr.2013$CA2)[grep("CHEM", levels(tchr.2013$CA2))] <- 'CHEMISTRY'
levels(tchr.2013$CA2)[grep("PHYSICS", levels(tchr.2013$CA2))] <- 'PHYSICS'
levels(tchr.2013$CA2)[grep("EARTH", levels(tchr.2013$CA2))] <- 'EARTH_SCIENCE'
levels(tchr.2013$CA2)[grep("SCI ", levels(tchr.2013$CA2))] <- 'SCIENCE'
levels(tchr.2013$CA2)[grep("ESL SCI", levels(tchr.2013$CA2))] <- 'SCIENCE'
levels(tchr.2013$CA2)[grep("SCIENCE ", levels(tchr.2013$CA2))] <- 'SCIENCE'

levels(tchr.2013$CA2)[grep("SPAN", levels(tchr.2013$CA2))] <- 'SPANISH' # Just to get rid of it later/seperate from ELA
levels(tchr.2013$CA2)[grep("ENGLISH", levels(tchr.2013$CA2))] <- 'ELA'
levels(tchr.2013$CA2)[grep("ENG ", levels(tchr.2013$CA2))] <- 'ELA'
levels(tchr.2013$CA2)[grep("WRIT", levels(tchr.2013$CA2))] <- 'ELA'
levels(tchr.2013$CA2)[grep("WR COMM", levels(tchr.2013$CA2))] <- 'ELA'
levels(tchr.2013$CA2)[grep("LIT", levels(tchr.2013$CA2))] <- 'ELA'
levels(tchr.2013$CA2)[grep("READ", levels(tchr.2013$CA2))] <- 'ELA'
levels(tchr.2013$CA2)[grep("INTERVEN ELA", levels(tchr.2013$CA2))] <- 'ELA'

levels(tchr.2013$CA2)[grep("U.S. HIST", levels(tchr.2013$CA2))] <- 'US_HISTORY'
levels(tchr.2013$CA2)[grep("US HIST", levels(tchr.2013$CA2))] <- 'US_HISTORY'
levels(tchr.2013$CA2)[grep("WLD HIST", levels(tchr.2013$CA2))] <- 'WORLD_HISTORY'
levels(tchr.2013$CA2)[grep("SS HIST", levels(tchr.2013$CA2))] <- 'HISTORY'
levels(tchr.2013$CA2)[grep("ESL HIST", levels(tchr.2013$CA2))] <- 'HISTORY'
levels(tchr.2013$CA2)[grep("HIST ALT", levels(tchr.2013$CA2))] <- 'HISTORY'

levels(tchr.2013$CA2)[grep("ESL", levels(tchr.2013$CA2))] <- 'ELA' # Do this after ESL HIST

subjects <- c("ELA", "MATHEMATICS", "GENERAL_MATHEMATICS", 'INTEGRATED_MATHEMATICS_1', 'INTEGRATED_MATHEMATICS_2', 'GEOMETRY',  'ALGEBRA_I', 'ALGEBRA_II', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS', "EARTH_SCIENCE", "SCIENCE", "HISTORY", "US_HISTORY", 'WORLD_HISTORY')

tchr.2013$CA2[!tchr.2013$CA2 %in% subjects] <- NA
tchr.2013$CA2 <- droplevels(tchr.2013$CA2)

table(tchr.2013$CONTENT_AREA, tchr.2013$CA2)
table(tchr.2013$CONTENT_AREA, is.na(tchr.2013$CA2))

tchr.2013$CA2[is.na(tchr.2013$CA2)] <- tchr.2013$CONTENT_AREA[is.na(tchr.2013$CA2)] 
# tchr.2013 <- data.table(tchr.2013[tchr.2013$CA2 %in% subjects,])

tchr.2013 <- data.table(tchr.2013)
setnames(tchr.2013, 'CONTENT_AREA', 'CONTENT_GROUP')
setnames(tchr.2013, 'CA2', 'CONTENT_AREA')

tchr.2013$ID <- as.character(tchr.2013$ID)
tchr.2013$INSTRUCTOR_NUMBER_1 <- as.character(tchr.2013$INSTRUCTOR_NUMBER_1)

#  Remove teachers in same Dept/Content_area in SAME classes in the SAME SCHOOL & SEMESTER first
setkeyv(tchr.2013, c("CONTENT_AREA", "SCHOOL_NUMBER", "MARKING_PERIOD", "INSTRUCTOR_NUMBER_1", "ID"))
tchr.2013 <- tchr.2013[which(!duplicated(tchr.2013)),]

#  Remove teachers in same Content_area in multiple classes in the SAME SCHOOL (hopefully similar to above)
setkeyv(tchr.2013, c("CONTENT_AREA", "SCHOOL_NUMBER", "INSTRUCTOR_NUMBER_1", "ID"))
tchr.2013 <- tchr.2013[which(!duplicated(tchr.2013)),]

#  Remove teachers in same Content_area in multiple classes in Different SCHOOL (looks like most are NA school numbers)
setkeyv(tchr.2013, c("CONTENT_AREA", "MARKING_PERIOD", "INSTRUCTOR_NUMBER_1", "ID"))
setkeyv(tchr.2013, c("CONTENT_AREA", "INSTRUCTOR_NUMBER_1", "ID"))
tchr.2013 <- tchr.2013[-(which(duplicated(tchr.2013))-1),] # Still take the LATER period - end of year

table(tchr.2013$CONTENT_AREA, tchr.2013$CONTENT_GROUP)

###  If these are secondary teachers, MATH might actually be GEN MATH (MATH 4 above could be 4th period math, or similar)
math.tch <- tchr.2013[which(CONTENT_AREA=='MATHEMATICS')]
math.tch$CONTENT_AREA <- 'GENERAL_MATHEMATICS'
tchr.2013 <- rbind(tchr.2013, math.tch)

tchr.2013[, CONTENT_GROUP := NULL]
tchr.2013[, COURSE_NAME := NULL]

lausd.tchr <- data.table(rbind.fill(lausd.tchr, tchr.2013), key=c("CONTENT_AREA", "ID"))

#  Remove teachers that a student had more than one in a year.  Keep the LATEST period available (EP3 and SPRING)
setkeyv(lausd.tchr, c("ID", "SCHOOL_NUMBER", "MARKING_PERIOD", "INSTRUCTOR_NUMBER_1", "CONTENT_AREA"))
setkeyv(lausd.tchr, c("ID", "SCHOOL_NUMBER", "INSTRUCTOR_NUMBER_1", "CONTENT_AREA"))
lausd.tchr <- lausd.tchr[-(which(duplicated(lausd.tchr))-1),]


#  Now "WIDEN" the file by subject area
setkeyv(lausd.tchr, c("ID", "CONTENT_AREA", "SCHOOL_NUMBER"))

# find unique teachers and "first" of multiple teachers (not sure how to rank these in terms of relevance or importance)
unq.ids <- which(!duplicated(lausd.tchr)); length(unq.ids)
dup.ids <- which(duplicated(lausd.tchr)); length(dup.ids)

lausd.tchr$TEACHER_COUNT <- NA
#  step 1 - assign unique and "first" teachers a 1
lausd.tchr$TEACHER_COUNT[unq.ids] <- 1
# step 2 add 1 to the first "duplicates"
lausd.tchr$TEACHER_COUNT[dup.ids] <- lausd.tchr$TEACHER_COUNT[dup.ids-1]+1
# step 3 add 1 to the NA's  -  Have to repeat up to a count of 7 in 2011 !!!
#summary(lausd.tchr$TEACHER_COUNT) 
while(any(is.na(lausd.tchr$TEACHER_COUNT))){
	lausd.tchr$TEACHER_COUNT[which(is.na(lausd.tchr$TEACHER_COUNT))] <- lausd.tchr$TEACHER_COUNT[which(is.na(lausd.tchr$TEACHER_COUNT))-1]+1
}
#table(lausd.tchr$TEACHER_COUNT) 

tmp.lausd.tchr <- lausd.tchr
lausd.tchr$TEACHER_COUNT <- factor(lausd.tchr$TEACHER_COUNT)
lausd.tchr$CONTENT_AREA <- as.character(lausd.tchr$CONTENT_AREA)
lausd.tchr$ID <- factor(paste(lausd.tchr$ID, lausd.tchr$PRLPREFERREDLOCATIONCODE))
setnames(lausd.tchr, 'INSTRUCTOR_NUMBER_1', 'INSTRUCTOR_NUMBER')
setkeyv(lausd.tchr, c("CONTENT_AREA", "TEACHER_COUNT"))
lausd.tchr[, MARKING_PERIOD := NULL]

#LAUSD_Teacher_Links object 
LAUSD_Teacher_Links <- data.frame()
for (j in subjects) {
	# tmp.tchr <- reshape(lausd.tchr[j],
	tmp.tchr <- reshape(data.frame(subset(lausd.tchr, CONTENT_AREA==j)),
						idvar='ID',
						timevar='TEACHER_COUNT',
						drop=c('CONTENT_AREA', 'SCHOOL_NUMBER', 'PRLPREFERREDLOCATIONCODE'), # take  'MARK' out above now too 
						direction='wide',
						sep="_")

	tmp.tchr$CONTENT_AREA <- j
	tmp.tchr$YEAR <- 2013
	
	LAUSD_Teacher_Links <- rbind.fill(LAUSD_Teacher_Links, tmp.tchr)
}

##  split apart the ID variable into ID and SCHOOL NUMBER
LAUSD_Teacher_Links$SCHOOL_NUMBER <- LAUSD_Teacher_Links$ID
levels(LAUSD_Teacher_Links$ID) <- sapply(levels(LAUSD_Teacher_Links$ID), function(s) strsplit(s, " ")[[1]][1], USE.NAMES=FALSE)
levels(LAUSD_Teacher_Links$SCHOOL_NUMBER) <- sapply(levels(LAUSD_Teacher_Links$SCHOOL_NUMBER), function(s) strsplit(s, " ")[[1]][2], USE.NAMES=FALSE)

LAUSD_Teacher_Links$ID <- as.character(LAUSD_Teacher_Links$ID)
LAUSD_Teacher_Links$SCHOOL_NUMBER <- as.character(LAUSD_Teacher_Links$SCHOOL_NUMBER)

LAUSD_Teacher_Links <- data.table(LAUSD_Teacher_Links, key=c("ID", "SCHOOL_NUMBER", "CONTENT_AREA"))

# unq.ids <- which(!duplicated(LAUSD_Teacher_Links)); length(unq.ids)
# dup.ids <- which(duplicated(LAUSD_Teacher_Links)); length(dup.ids) # Should be 0 duplicates.  2013, Check!

# rm(lausd.tchr);rm(tchr.2013); rm(tmp.tchr); rm(dups);gc()

save(LAUSD_Teacher_Links, file="~/Dropbox/SGP/California/Data/Base_Files/LAUSD/SY2012-13/LAUSD_Teacher_Links-2013.Rdata", compress="bzip2")


####
####  Merge the Teacher links into LAUSD test data
####

#  Only keep 2 teachers
LAUSD_Teacher_Links[, INSTRUCTOR_NUMBER_3 := NULL]
LAUSD_Teacher_Links[, INSTRUCTOR_NUMBER_4 := NULL]
LAUSD_Teacher_Links[, INSTRUCTOR_NUMBER_5 := NULL]
LAUSD_Teacher_Links[, INSTRUCTOR_NUMBER_6 := NULL]
LAUSD_Teacher_Links[, INSTRUCTOR_NUMBER_7 := NULL]
LAUSD_Teacher_Links[, INSTRUCTOR_NUMBER_8 := NULL]

LAUSD_Teacher_Links[, YEAR := as.character(YEAR)]


lausd[, YEAR := '2013']
lausd[, YEAR := as.character(YEAR)]

lausd[, CONTENT_AREA := as.character(CONTENT_AREA)]
lausd[which(CONTENT_AREA=="HISTORY" & GRADE==11), CONTENT_AREA := "US_HISTORY"]

lausd[, SCHOOL_NUMBER := NULL]
setnames(lausd, 'PRLPREFERREDLOCATIONCODE', 'SCHOOL_NUMBER')
lausd[, SCHOOL_NAME := as.character(SCHOOL_NAME)]
lausd[, SCHOOL_NUMBER := as.character(SCHOOL_NUMBER)]

setkeyv(LAUSD_Teacher_Links, c("ID", "CONTENT_AREA", "YEAR", "SCHOOL_NUMBER"))
setkeyv(lausd, c("ID", "CONTENT_AREA", "YEAR", "SCHOOL_NUMBER"))

LAUSD_Data_LONG <- merge(lausd, LAUSD_Teacher_Links, all.x=TRUE)
# sum(!is.na(LAUSD_Data_LONG$INSTRUCTOR_NUMBER_1))
# table(is.na(LAUSD_Data_LONG$INSTRUCTOR_NUMBER_1), LAUSD_Data_LONG$CONTENT_AREA) #  Good enough for now.  No matches for some tests...

#  ADD these vars in to match the CMO file
LAUSD_Data_LONG[, CMO_NAME := "LAUSD"]

LAUSD_Data_LONG[, DISTRICT_NAME := "Los Angeles Unified School District"]
LAUSD_Data_LONG[, DISTRICT_NUMBER := '1964733']

##  School names look fine this year
# sch.names <- levels(LAUSD_Data_LONG$SCHOOL_NAME)
# sch.names <- sapply(sch.names, capwords, special.words=la.special.words, USE.NAMES=FALSE)
# levels(LAUSD_Data_LONG$SCHOOL_NAME) <- sch.names

LAUSD_Data_LONG[, RECTYPE := NULL]

save(LAUSD_Data_LONG, file="~/Dropbox/SGP/California/Data/Base_Files/LAUSD/SY2012-13/LAUSD_Data_LONG-2013.Rdata")


### ### ### ### ### ### ### ### ### ### ### ###
###			Merge the CMO & LAUSD files
### ### ### ### ### ### ### ### ### ### ### ###

###  Final completion of CA_2013

# load("~/Dropbox/SGP/California/Data/LAUSD_Data_LONG-2013.Rdata")
# load("~/Dropbox/SGP/California/Data/CMO_Data_LONG-2013.Rdata")

CA_2013 <- data.table(rbind.fill(CMO_Data_LONG, LAUSD_Data_LONG))

key.og <- c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID")

# setkeyv(CA_2013, c(key.og, "INSTRUCTOR_NUMBER_1", "GRADE", "SCALE_SCORE")) # CMOs will not have data on other CMOs teachers, so sort out NA's here
# dups <- data.table(CA_2013[c(which(duplicated(CA_2013))-1, which(duplicated(CA_2013))),], key=key(CA_2013)) #  All LAUSD
# dim(dups["VALID_CASE"])
# CA_2013$VALID_CASE[which(duplicated(CA_2013))] <- "INVALID_CASE" #  All already INVALID 2013

# setkeyv(CA_2013, c(key.og, "INSTRUCTOR_NUMBER_1", "GRADE"))
# dups <- data.table(CA_2013[c(which(duplicated(CA_2013))-1, which(duplicated(CA_2013))),], key=c("ID", "YEAR", "CONTENT_AREA", "GRADE"))
# dim(dups["VALID_CASE"])
# CA_2013$VALID_CASE[which(duplicated(CA_2013))-1] <- "INVALID_CASE" #  All already INVALID 2013

#  Some duplicates with different GRADE levels in the same year, but those should sort themselves out in the analyses

#  Here's where I'm seeing CMO duplicates of students
setkeyv(CA_2013, c(key.og, "GRADE", "INSTRUCTOR_NUMBER_1")) # Puts NA on BOTTOM
setkeyv(CA_2013, c(key.og, "GRADE"))
dup.idx <- which(duplicated(CA_2013))
dups1 <- data.table(CA_2013[sort(c(dup.idx-1, dup.idx)),], key=key(CA_2013))
dups2 <- dups1["VALID_CASE"]

CA_2013$VALID_CASE[which(duplicated(CA_2013))] <- "INVALID_CASE" # Takes out the NA instructors.  ALL 2012, so shouldn't be an issue for 2013 SGPs either

#  No more dups based on SGP key
setkeyv(CA_2013, c(key.og))
dups <- data.table(CA_2013[sort(c(which(duplicated(CA_2013))-1, which(duplicated(CA_2013)))),], key=key(CA_2013))
dim(dups["VALID_CASE"])
CA_2013$VALID_CASE[which(duplicated(CA_2013))] <- "INVALID_CASE" # Takes out LAUSD for SSID 7104090576 - wrong grade

table(CA_2013$VALID_CASE) # 84482 in 2013

# Make names prettier
trimWhiteSpace <- function(line) gsub("(^ +)|( +$)", "", line)
CA_2013$FIRST_NAME<- trimWhiteSpace(CA_2013$FIRST_NAME)
CA_2013$LAST_NAME <- trimWhiteSpace(CA_2013$LAST_NAME)

CA_2013$SCHOOL_NAME <- trimWhiteSpace(CA_2013$SCHOOL_NAME)
CA_2013$SCHOOL_NUMBER_PROVIDED <- CA_2013$SCHOOL_NUMBER
CA_2013$SCHOOL_NUMBER[!is.na(CA_2013$SCHOOL_NUMBER)] <- paste(CA_2013$CMO_NAME[!is.na(CA_2013$SCHOOL_NUMBER)], CA_2013$SCHOOL_NUMBER[!is.na(CA_2013$SCHOOL_NUMBER)], sep="_")

table(CA_2013$DISTRICT_NAME, CA_2013$CMO_NAME)
CA_2013$DISTRICT_NAME[CA_2013$DISTRICT_NAME=="1"] <- 'Alliance College-Ready Public Schools'

CA_2013$DISTRICT_NAME[CA_2013$DISTRICT_NAME=="LAUSD"] <- 'Los Angeles Unified School District'

#Clean up the SCHOOL NAMES - added 1/03/11
split.sym <- c(" @ ", " @", "@"," # ", " #", "#", "/", "rfk", " (MASS)", "(k-12)")
split.fix <- c(rep(" at ", 3), rep(" No. ", 3), "-", "RFK", "", "K-12")

CA_2013[, SCHOOL_NAME := factor(SCHOOL_NAME)]
for (f in 1:length(split.sym)) {
	levels(CA_2013$SCHOOL_NAME) <- gsub(split.sym[f], split.fix[f], levels(CA_2013$SCHOOL_NAME))
}
CA_2013[, SCHOOL_NAME := as.character(SCHOOL_NAME)]

#  History and US History labeled inconsistently.  This is how it "should" be...
CA_2013$CONTENT_AREA[CA_2013$CONTENT_AREA=="US_HISTORY" & CA_2013$GRADE==8] <- "HISTORY"
CA_2013$CONTENT_AREA[CA_2013$CONTENT_AREA=="HISTORY" & CA_2013$GRADE==11] <- "US_HISTORY"

# Fix 10th grade 'Science' courses (mostly LAUSD)
CA_2013$CONTENT_AREA[CA_2013$CONTENT_AREA=="SCIENCE" & CA_2013$GRADE==10] <- "LIFE_SCIENCE"
# Opposite problem for Alliance 8th grade
CA_2013$CONTENT_AREA[CA_2013$CONTENT_AREA=="LIFE_SCIENCE" & CA_2013$GRADE==8] <- "SCIENCE"

#  Change "MATHEMATICS" back to "MATHEMATICS" and 8th and 9th grade "MATHEMATICS" to "GENERAL_MATHEMATICS"
CA_2013$CONTENT_AREA[CA_2013$CONTENT_AREA=="MATHEMATICS" & CA_2013$GRADE %in% c(8,9)] <- "GENERAL_MATHEMATICS"

#  Clean up grades and content areas:

CA_2013$VALID_CASE[CA_2013$CONTENT_AREA=="ELA" & !CA_2013$GRADE %in% 2:11] <- "INVALID_CASE"
CA_2013$VALID_CASE[CA_2013$CONTENT_AREA=="MATHEMATICS" & !CA_2013$GRADE %in% 2:7] <- "INVALID_CASE"
CA_2013$VALID_CASE[CA_2013$CONTENT_AREA=="GENERAL_MATHEMATICS" & !CA_2013$GRADE %in% 8:9] <- "INVALID_CASE"
CA_2013$VALID_CASE[CA_2013$CONTENT_AREA=="SCIENCE" & !CA_2013$GRADE %in% c(5,8)] <- "INVALID_CASE"

table(CA_2013$VALID_CASE) #84,589


###################################################################################################
##  Combine 2013 data with the prior years data.  
##  Remove the data that are exact duplicates and apply other invalidation biz rules
###################################################################################################

load('~/CENTER/SGP/California/Data/California_Data_LONG-2012_REVISED_060913.Rdata')
load("/Users/avi/Dropbox/SGP/California/Data/TCRP_INSTRUCTOR_NUMBERS.Rdata")

CA_2013n <- copy(CA_2013)

CA_2013[, NEW_DATA := TRUE]
CA_2013[, ACHIEVEMENT_LEVEL_PROVIDED := ACHIEVEMENT_LEVEL]
CA_2013[, CMO_NUMBER := as.numeric(ordered(CMO_NAME, levels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")))]
CA_2013[, GRADE_REPORTED := GRADE]
CA_2013[which(CONTENT_AREA %in% c('WORLD_HISTORY', 'US_HISTORY', 
		'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'ALGEBRA_II', 'GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS',
		'INTEGRATED_MATHEMATICS_1', 'INTEGRATED_MATHEMATICS_2', 'INTEGRATED_MATHEMATICS_3',
		'INTEGRATED_SCIENCE_1', 'INTEGRATED_SCIENCE_2', 'INTEGRATED_SCIENCE_3', 'INTEGRATED_SCIENCE_4',
		'EARTH_SCIENCE', 'LIFE_SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS')), GRADE := 'EOCT']


California_Data_LONG[, NEW_DATA := FALSE]
California_Data_LONG[, CONTENT_GROUP := NULL]
California_Data_LONG[, ORIGINAL_SGP := NULL]
California_Data_LONG[, ORIGINAL_SGP_PRIORS_USED := NULL]
California_Data_LONG[which(CONTENT_AREA %in% c('WORLD_HISTORY', 'US_HISTORY', 
		'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'ALGEBRA_II', 'GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS',
		'INTEGRATED_MATHEMATICS_1', 'INTEGRATED_MATHEMATICS_2', 'INTEGRATED_MATHEMATICS_3',
		'INTEGRATED_SCIENCE_1', 'INTEGRATED_SCIENCE_2', 'INTEGRATED_SCIENCE_3', 'INTEGRATED_SCIENCE_4',
		'EARTH_SCIENCE', 'LIFE_SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS')), GRADE := 'EOCT']


##  Extract INSTRUCTOR NUMBER and add to TCRP_ object created June 2013
##  Clean up weights
CA_2013$INSTRUCTOR_2_WEIGHT[CA_2013$INSTRUCTOR_1_WEIGHT==0.5] <- 0.5 #  These (118) cases were all 1's.  Weight needs to sum to 1

CA1 <- CA_2013[!is.na(INSTRUCTOR_NUMBER_1) & INSTRUCTOR_NUMBER_1 !=""][,list(ID, CONTENT_AREA, YEAR, INSTRUCTOR_NUMBER_1, INSTRUCTOR_1_WEIGHT, CMO_NAME)]
CA2 <- CA_2013[!is.na(INSTRUCTOR_NUMBER_2) & INSTRUCTOR_NUMBER_2 !=""][,list(ID, CONTENT_AREA, YEAR, INSTRUCTOR_NUMBER_2, INSTRUCTOR_2_WEIGHT, CMO_NAME)]

setnames(CA1, c('INSTRUCTOR_NUMBER_1', 'INSTRUCTOR_1_WEIGHT'), c('INSTRUCTOR_NUMBER', 'INSTRUCTOR_WEIGHT'))
setnames(CA2, c('INSTRUCTOR_NUMBER_2', 'INSTRUCTOR_2_WEIGHT'), c('INSTRUCTOR_NUMBER', 'INSTRUCTOR_WEIGHT'))

TCRP_INSTRUCTOR_NUMBERS_2013 <- data.table(rbind.fill(CA1, CA2), key=c("ID", "CONTENT_AREA", "YEAR"))
TCRP_INSTRUCTOR_NUMBERS_2013[,INSTRUCTOR_ENROLLMENT_STATUS := 'Enrolled Instructor: Yes']
TCRP_INSTRUCTOR_NUMBERS_2013$INSTRUCTOR_WEIGHT[is.na(TCRP_INSTRUCTOR_NUMBERS_2013$INSTRUCTOR_WEIGHT)] <- 1

###  Create unique teacher IDs  (some CMOs had same number system)
TCRP_INSTRUCTOR_NUMBERS_2013[["INSTRUCTOR_NUMBER"]] <- paste(TCRP_INSTRUCTOR_NUMBERS_2013[["CMO_NAME"]], TCRP_INSTRUCTOR_NUMBERS_2013[["INSTRUCTOR_NUMBER"]], sep="_")
TCRP_INSTRUCTOR_NUMBERS_2013[, CMO_NAME := NULL]


###  Clean up CA_2013
names(CA_2013)[grep('INSTRUCTOR', names(CA_2013))]

CA_2013[, INSTRUCTOR_NUMBER_1 := NULL]
CA_2013[, INSTRUCTOR_NUMBER_2 := NULL]
CA_2013[, INSTRUCTOR_1_WEIGHT := NULL]
CA_2013[, INSTRUCTOR_2_WEIGHT := NULL]

##  Stack the old and new data
TCRP_INSTRUCTOR_NUMBERS <- data.table(rbind.fill(TCRP_INSTRUCTOR_NUMBERS, TCRP_INSTRUCTOR_NUMBERS_2013))
California_Data_LONG <- data.table(rbind.fill(California_Data_LONG, CA_2013))

##  Clean up lingering issues in NEW and OLD data
California_Data_LONG[, TEST_TYPE := factor(TEST_TYPE)]
levels(California_Data_LONG$TEST_TYPE) <- c("CST", "CMA", "CAPA", "STS", "CAPA", "CMA", "CST", "STS")
California_Data_LONG[, TEST_TYPE := as.character(TEST_TYPE)]

California_Data_LONG[ which(CONTENT_AREA=='CMA ELA'), CONTENT_AREA := 'CMA_ELA']

###  Remove duplicate cases.  Some keep old data, others (where test scores have changed) keep the new
setkeyv(California_Data_LONG, c(key.og, "GRADE", "SCALE_SCORE", "CMO_NAME", "NEW_DATA"))
setkeyv(California_Data_LONG, c(key.og, "GRADE", "SCALE_SCORE", "CMO_NAME"))
dups <- data.table(California_Data_LONG[c(which(duplicated(California_Data_LONG))-1, which(duplicated(California_Data_LONG))),], key=key(California_Data_LONG))
dim(dups['VALID_CASE'])

# This is old data (from 2009-12) included in the NEW DATA submissions that is identical to original submission data.  Keep the OLD data
# table(dups['VALID_CASE']$CMO_NAME, dups['VALID_CASE']$YEAR)
California_Data_LONG <- California_Data_LONG[which(!duplicated(California_Data_LONG)),]


setkeyv(California_Data_LONG, c(key.og, "GRADE", "SCALE_SCORE", "NEW_DATA"))
setkeyv(California_Data_LONG, c(key.og, "GRADE", "SCALE_SCORE"))
dups <- data.table(California_Data_LONG[c(which(duplicated(California_Data_LONG))-1, which(duplicated(California_Data_LONG))),], key=key(California_Data_LONG))

## Looks like kids that went from one CMO to another.  Keep the OLD data again (original submission from CMO the kid was enrolled in at the time)
California_Data_LONG <- California_Data_LONG[which(!duplicated(California_Data_LONG)),]
 
setkeyv(California_Data_LONG, c(key.og, "SCALE_SCORE", "NEW_DATA")) 
setkeyv(California_Data_LONG, c(key.og, "SCALE_SCORE"))
dups <- data.table(California_Data_LONG[c(which(duplicated(California_Data_LONG))-1, which(duplicated(California_Data_LONG))),], key=key(California_Data_LONG))
## 17 duplicates here.  Look like the same issue as above, but with ELA students with conflicting GRADE levels reported.  
## This time keep ALL data, and just invalidate the OLD cases
California_Data_LONG[which(duplicated(California_Data_LONG))-1, VALID_CASE := 'INVALID_CASE'] #

##  New Data that has a changed score.  Probably the most concerning!  Only 5 cases though... 
##  Keep ALL data, and just invalidate the OLD cases.
setkeyv(California_Data_LONG, c(key.og, "NEW_DATA"))
setkeyv(California_Data_LONG, c(key.og))
dups <- data.table(California_Data_LONG[c(which(duplicated(California_Data_LONG))-1, which(duplicated(California_Data_LONG))),], key=key(California_Data_LONG))

California_Data_LONG[which(duplicated(California_Data_LONG))-1, VALID_CASE := 'INVALID_CASE'] #

table(California_Data_LONG$VALID_CASE)

# INVALID_CASE   VALID_CASE 
      # 381619      6236929 

###
###		prepareSGP
###

California_SGP <- prepareSGP(California_Data_LONG, data_supplementary = list(INSTRUCTOR_NUMBER = TCRP_INSTRUCTOR_NUMBERS), create.additional.variables = FALSE)


###  Save objects with 2013 data

save(California_SGP, file='Data/California_SGP-Data_ONLY.Rdata')
save(California_Data_LONG, file='Data/California_Data_LONG.Rdata')
save(TCRP_INSTRUCTOR_NUMBERS, file='Data/TCRP_INSTRUCTOR_NUMBERS.Rdata')
