##########################################################
####
#### Code for preparation of California LONG data
####
##########################################################

library(SGP)
library(car)

"CA" <- "CA"

# Set SGP file as working directory
setwd("/Users/adamvaniwaarden/CENTER/SGP")


### ### ### ### ### ### ### ### ### ### ### ###
###	Read in and clean the CMO files seperately
### ### ### ### ### ### ### ### ### ### ### ###

###
###  Alliance
###

al <- read.delim("./California/Data/Base_Files/Alliance/Alliance_avi_112911.txt", header=TRUE) # New text file

al$CMO <- factor(al$CMO, levels=c("Alliance", 2:5), labels = c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))  # ? LAUSD as NA?

# Set up a generic system of TEST_NAMES for all CMOs.  Collapse all ELA and categories into one - only one course sequence there.  
# Collapse Grade level math  Fix mispellings, etc.
levels(al$CST.Test.Name) <- c("ALGEBRA_I", "ALGEBRA_II", "BIOLOGY", "CHEMISTRY", "EARTH_SCIENCE", "EARTH_SCIENCE", "ELA", "ELA", "ELA", "ELA", "ELA", "ELA", "ELA", "ELA", "GRADE_LEVEL_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "GEOMETRY", "GRADE_LEVEL_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "HISTORY", "INTEGRATED_SCIENCE_1", "INTEGRATED_SCIENCE_1", "LIFE_SCIENCE", "GRADE_LEVEL_MATHEMATICS", "PHYSICS", "SCIENCE", "SCIENCE", "SUMMATIVE_HS_MATHEMATICS", "US_HISTORY", "US_HISTORY", "WORLD_HISTORY")

##  ID - change to factor.  Will need to make sure there are no duplicates accross CMO's / LAUSD
al$ID <- factor(al$ID)
al$SCHOOL_NUMBER <- factor(al$SCHOOL_NUMBER) #  Change these too - some CMOs are numeric, some are factors
al$INSTRUCTOR_NUMBER_1 <- factor(al$INSTRUCTOR_NUMBER_1)

#  YEAR is fine

##  CONTENT_AREA
levels(al$CONTENT_AREA) <- c("ELA", "HISTORY", "MATHEMATICS", "MATHEMATICS", "SCIENCE")

##  ETHNICITY, ELL_STATUS, GIFTED_TALENTED_STATUS & IEP_STATUS
	#  Numeric Factors - need to get codes from them to convert.
levels(al$ETHNICITY)# "", "0", "100", "200", "201", "202", "203", "204", "299", "301", "400", "500", "600", "700", "800", "999", "#N/A"
levels(al$ELL_STATUS)
levels(al$GIFTED_TALENTED_STATUS)
levels(al$IEP_STATUS)
##  ? What is NSLP

levels(al$ETHNICITY) <- c(NA, NA, NA, 'American Indian or Alaska Native',  'Asian', 'Chinese', 'Japanese', 'Korean', 'Vietnamese',  'Other Asian',  'Native Hawaiian',  'Filipino',  'Hispanic', 'Black or African American', 'White', '800', NA)

##  SES_STATUS - MISSING

##  GENDER
levels(al$GENDER) <- c(NA, NA, NA, 'Gender: Female', 'Gender: Male') #  recode fixed NA's but didn't change level labels for some reason...

##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary" and ran basic descriptives:
#  Alliance only has prof levels for 2011.  Will have to construct the other years ourselves?  Year dependent cutscores?

levels(al$PROFICIENCY_LEVEL_PROVIDED) <- c(NA, NA, "1", "2", "3", "4", "5")
summary(al$PROFICIENCY_LEVEL_PROVIDED)
al$PROFICIENCY_LEVEL_PROVIDED <- as.numeric(al$PROFICIENCY_LEVEL_PROVIDED)
summary(as.factor(al$PROFICIENCY_LEVEL_PROVIDED))
al$PROFICIENCY_LEVEL_PROVIDED <- ordered(al$PROFICIENCY_LEVEL_PROVIDED, levels = 1:5, labels=c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

levels(al$Test.Type) <- c("CST", "CST")
## VALID_CASE

al[['VALID_CASE']] <- factor(1, levels=1:2, labels=c("VALID_CASE", "INVALID_CASE"))
#al$VALID_CASE <- factor(al$VALID_CASE, levels=1:2, labels=c("VALID_CASE", "INVALID_CASE")) # above didn't work all the time (because data table - use [[]], not $)

##  ALRIGHT - I THINK THIS IS WHAT FUCKED ME GOOD :
# al[['VALID_CASE']][al[['Test.Type']]!="CST"]  <- "INVALID_CASE"


# Look for duplicates:

#  These are duplicate score for "NON ALLIANCE COURSES" / NA Instructor ID - all else duplicated...
al <- data.table(al, key="YEAR, CONTENT_AREA, CST.Test.Name, INSTRUCTOR_NUMBER_1, GRADE, ID, SCALE_SCORE")
al <- data.table(al, key="YEAR, CONTENT_AREA, CST.Test.Name, GRADE, ID, SCALE_SCORE")
dups <- data.table(al[c(which(duplicated(al))-1, which(duplicated(al))),], key="YEAR, CONTENT_AREA, CST.Test.Name, GRADE, ID, SCALE_SCORE")
al[['VALID_CASE']][which(duplicated(al))-1] <- "INVALID_CASE" #  111 Invalidated

al <- data.table(al, key="VALID_CASE, YEAR, CONTENT_AREA, CST.Test.Name, INSTRUCTOR_NUMBER_1, GRADE, ID, SCALE_SCORE") 
al <- data.table(al, key="VALID_CASE, YEAR, CONTENT_AREA, CST.Test.Name, INSTRUCTOR_NUMBER_1, GRADE, ID") 
dups <- data.table(al[c(which(duplicated(al))-1, which(duplicated(al))),], key="YEAR, CONTENT_AREA, CST.Test.Name, INSTRUCTOR_NUMBER_1, GRADE, ID")
al[['VALID_CASE']][which(duplicated(al))-1] <- "INVALID_CASE" # invalidate the low score from same teacher - 5 dups

al <- data.table(al, key="VALID_CASE, YEAR, CONTENT_AREA, CST.Test.Name, GRADE, ID, SCALE_SCORE") 
al <- data.table(al, key="VALID_CASE, YEAR, CONTENT_AREA, CST.Test.Name, GRADE, ID") 
dups <- data.table(al[c(which(duplicated(al))-1, which(duplicated(al))),], key="YEAR, CONTENT_AREA, CST.Test.Name, GRADE, ID")
al[['VALID_CASE']][which(duplicated(al))-1] <- "INVALID_CASE" # invalidate the low score - also for score not linked to teacher/Alliance - 2 dups

al <- data.table(al, key="VALID_CASE, YEAR, CONTENT_AREA, CST.Test.Name, INSTRUCTOR_NUMBER_1, ID, SCALE_SCORE") 
al <- data.table(al, key="VALID_CASE, YEAR, CONTENT_AREA, CST.Test.Name, ID, SCALE_SCORE") 
dups <- data.table(al[c(which(duplicated(al))-1, which(duplicated(al))),], key="YEAR, CONTENT_AREA, CST.Test.Name, ID")
al[['VALID_CASE']][which(duplicated(al))-1] <- "INVALID_CASE" #  12 dups - non-alliance courses, no teacher/school info, etc

###
###  Aspire
###

asp <- read.delim("./California/Data/Base_Files/Aspire/Aspire_avi_012612.txt", header=TRUE)

asp$CMO <- factor(asp$CMO, levels=c(1, "Aspire", 3:5), labels = c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))  # ? LAUSD as NA?

# Set up a generic system of TEST_NAMES for all CMOs.  
levels(asp$CST.Test.Name) <- c("ALGEBRA_I", "ALGEBRA_II", "BIOLOGY", "CHEMISTRY", "ELA", "GEOMETRY", "HISTORY", "INTEGRATED_SCIENCE_1", "GRADE_LEVEL_MATHEMATICS", "PHYSICS", "SCIENCE", "SUMMATIVE_HS_MATHEMATICS", "WORLD_HISTORY")

##  ID - change to factor.  Will need to make sure there are no duplicates accross CMO's / LAUSD
asp$ID <- factor(asp$ID)
asp$INSTRUCTOR_NUMBER_1 <- factor(asp$INSTRUCTOR_NUMBER_1)

##  YEAR.  Contacted Aspire directly on 11/17/11 to verify
#levels(asp$Year_PROVIDED)
# asp$YEAR <- as.integer(recode(asp$Year_PROVIDED, as.factor.result=FALSE,
								# "'9-Aug'=2009;
								# '10-Sep'=2010;
								# '11-Oct'=2011"))

## CONTENT_AREA - MATH to "MATHEMATICS"
levels(asp$CONTENT_AREA) <- c("ELA", "HISTORY", "MATHEMATICS", "SCIENCE")

## GRADE

# Set 99 to NA
# asp$GRADE[asp$GRADE==99] <- NA # 6 99/NA's records


## EMH_LEVEL
levels(asp$EMH_LEVEL) <- c(NA, "Elementary", "Secondary")

##  SCHOOL_NUMBER
asp$SCHOOL_NUMBER[asp$SCHOOL_NUMBER==-1] <- NA
asp$SCHOOL_NUMBER <- factor(asp$SCHOOL_NUMBER) #  Change these too - some CMOs are numeric, some are factors
levels(asp$SCHOOL_NAME) <- c(NA, levels(asp$SCHOOL_NAME)[-1])

##  ETHNICITY, ELL_STATUS, GENDER & IEP_STATUS
levels(asp$ELL_STATUS) <- c("Unknown", "English Learner", "English Only", "Initially Fluent English Proficient", 
	"Reclassified Fluent English Proficient", "To Be Determined") # Labels as provided by Aspire, matches Cali AYP Definitions of Subgroups.
levels(asp$SES_STATUS) <- c(NA, "Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(asp$IEP_STATUS) <- c(NA, "Student with Disabilities: No", "Student with Disabilities: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(asp$GENDER) <- c('Gender: Female', 'Gender: Male')
levels(asp$ETHNICITY) <- c(NA, levels(asp$ETHNICITY)[-1])

##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary" and ran basic descriptives:

asp$ACHIEVEMENT_LEVEL <- ordered(asp$PROFICIENCY_LEVEL_PROVIDED, levels = 1:5, labels=c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))
asp$PROFICIENCY_LEVEL_PROVIDED <- factor(asp$PROFICIENCY_LEVEL_PROVIDED) #all others are factors - clean this up for rbind.fill

## VALID_CASE
asp$VALID_CASE <- factor(1, levels=1:2, labels=c("VALID_CASE", "INVALID_CASE"))

#  One student with GRADE=0 ?  SID 5138253382
asp$VALID_CASE[asp[['GRADE']] == 0] <- "INVALID_CASE"

#  Scores outside of CST scale range - probably from the CAPA ...
asp$VALID_CASE[asp[['SCALE_SCORE']] < 150 | is.na(asp[['SCALE_SCORE']])] <- "INVALID_CASE"

# Duplicates
# DISTRICT_NUMBER - dups are missing a DISTRICT_NUMBER ID.  All else is == so INVALIDate these records
asp <- data.table(asp, key="VALID_CASE, YEAR, CONTENT_AREA, CST.Test.Name, GRADE, ID, SCALE_SCORE, DISTRICT_NUMBER")
key(asp) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "CST.Test.Name", "GRADE","ID", "SCALE_SCORE")
dups <- data.table(asp[c(which(duplicated(asp))-1, which(duplicated(asp))),], key="YEAR, CONTENT_AREA, CST.Test.Name, GRADE, ID, SCALE_SCORE")
asp$VALID_CASE[which(duplicated(asp))-1] <- "INVALID_CASE"

key(asp) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "CST.Test.Name", "GRADE","ID", "INSTRUCTOR_NUMBER_1")
key(asp) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "CST.Test.Name", "GRADE","ID")
dups <- data.table(asp[c(which(duplicated(asp))-1, which(duplicated(asp))),], key="YEAR, CONTENT_AREA, CST.Test.Name, GRADE, ID, INSTRUCTOR_NUMBER_1")
asp$VALID_CASE[which(duplicated(asp))-1] <- "INVALID_CASE" 
# # 
# key(asp) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "CST.Test.Name","ID", "SCALE_SCORE")
# key(asp) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "CST.Test.Name","ID")
# dups <- data.table(asp[c(which(duplicated(asp))-1, which(duplicated(asp))),], key="YEAR, CONTENT_AREA, CST.Test.Name, GRADE, ID")
# asp$VALID_CASE[which(duplicated(asp))-1] <- "INVALID_CASE" 
# No more dups added.  Without CST.Test.Name the dups are all different subjects, same content (eg science/biology or math/algebra I)

# 113 total INVALID_CASE's

###
###  Green Dot
###

gd <- read.delim("./California/Data/Base_Files/Green Dot Public Schools/Green_Dot_avi_121211.txt", header=TRUE) # New text file

gd$CMO <- factor(gd$CMO, levels=c(1:2, "Green Dot", 4:5), labels = c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))  # ? LAUSD as NA?

# Set up a generic system of TEST_NAMES for all CMOs.  
levels(gd$CST.Test.Name) <- c("ALGEBRA_I", "ALGEBRA_II", "BIOLOGY", "BIOLOGY", "CHEMISTRY", "CHEMISTRY", "EARTH_SCIENCE", "ELA", "ELA", "ELA", "ELA", "ELA", "ELA", "ELA", "GRADE_LEVEL_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "GEOMETRY", "GEOMETRY", "HISTORY", "INTEGRATED_MATHEMATICS_1", "INTEGRATED_MATHEMATICS_2", "INTEGRATED_SCIENCE_1", "LIFE_SCIENCE", "LIFE_SCIENCE", "PHYSICS", "PHYSICS", "SCIENCE", "SCIENCE", "SUMMATIVE_HS_MATHEMATICS", "US_HISTORY", "WORLD_HISTORY", "WORLD_HISTORY") #"CMA_ALGEBRA_I", "CAPA_MATHEMATICS", 

##  ID - change to factor.  Will need to make sure there are no duplicates accross CMO's / LAUSD
gd$ID <- factor(gd$ID)
gd$SCHOOL_NUMBER <- factor(gd$SCHOOL_NUMBER) #  Change these too - some CMOs are numeric, some are factors
#gd$INSTRUCTOR_NUMBER_1 <- factor(gd$INSTRUCTOR_NUMBER_1) #Already a factor

#  YEAR is fine (AVI added to each tab of original .xlsx file)

##  CONTENT_AREA
levels(gd$CONTENT_AREA) <- c("ELA", "HISTORY", "MATHEMATICS", "MATHEMATICS", "SCIENCE", "SCIENCE")

##  ETHNICITY, ELL_STATUS, GIFTED_TALENTED_STATUS & IEP_STATUS
#levels(gd$ETHNICITY)
# gd$ETHNICITY <- recode(gd$ETHNICITY,
								# "'' = NA;
								# 'Am. Indian/Alaskan Native'= 'American Indian or Alaskan Native';
								# 'Black/African American' = 'Black or African American';
								# 'Hispanic/Latino' = 'Hispanic'") #  Get rid of the slashes and conform to the Aspire conventions.
gd$ETHNICITY <- factor(gd$ETHNICITY, levels=c(100, 201, 202, 207, 299, 301, 302, 399, 400, 500, 600, 700, 999), labels=c('American Indian or Alaska Native',  'Chinese', 'Japanese',  'Cambodian',  'Other Asian',  'Native Hawaiian',  'Guamanian',  'Other Pacific Islander',  'Filipino',  'Hispanic', 'Black or African American', 'White', NA))
      
levels(gd$ELL_STATUS) <- c("English Learner", "English Only", "Initially Fluent English Proficient", 
	"Reclassified Fluent English Proficient", "To Be Determined") # Labeled to match Aspire , "Unknown"
levels(gd$SES_STATUS) <- c("Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(gd$IEP_STATUS) <- c("Student with Disabilities: No", "Student with Disabilities: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(gd$GENDER) <- c('Gender: Female', 'Gender: Male') 

##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary" and ran basic descriptives:
gd$ACHIEVEMENT_LEVEL <- ordered(gd$PROFICIENCY_LEVEL_PROVIDED, 
		levels = c("FBB", "BB", "B", "P", "A"), labels = c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced")) 

##  Test Type
gd$Test.Type <- factor(1, labels="CST")

## VALID_CASE
gd$VALID_CASE <- factor(1, levels=1:2, labels=c("VALID_CASE", "INVALID_CASE"))

# Duplicates
#  Two kids with the same ID!  Only found this because they were in same GRADE+YEAR ...  Guess this is the only time repeat IDs would be a problem
#levels(gd$ID) <- c(levels(gd$ID), "33745_1", "33745_2")
#gd$ID[gd$ID == "33745" & gd$ETHNICITY == "Hispanic"] <- "33745_1" 
#gd$ID[gd$ID == "33745"] <- "33745_2" 
#
# Another student had a mislabeled content area - course was from Algebra I, but CA set to ELA::  6054355304          ELA 2010

#  One total duplicate - ID 33196, the others are dups without a teacher ID (remove those records)
# INSTRUCTOR_NUMBER_1 - dups are missing a Teacher ID.  All else is =
gd <- data.table(gd, key="VALID_CASE, YEAR, CONTENT_AREA, CST.Test.Name, GRADE, ID, SCALE_SCORE, INSTRUCTOR_NUMBER_1")
key(gd) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "CST.Test.Name", "GRADE","ID", "SCALE_SCORE")
dup.ids <- which(duplicated(gd))
dups <- gd[c(dup.ids, dup.ids-1),]; key(dups) <- c("ID", "YEAR", "CONTENT_AREA")

gd[['VALID_CASE']][which(duplicated(gd))-1] <- "INVALID_CASE"  # (3,4) 0 invalids now


###
###  PUC
###

##  NOTE:  PUC has teacher names in a seperate lookup table that we could use too if needed for reporting.

puc <- read.delim("./California/Data/Base_Files/PUC/PUC_Data_avi_020912.txt", header=TRUE) #  New .txt file!!!

puc$CMO <- factor(puc$CMO, levels=c(1:3, "PUC", 5), labels = c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))  # ? LAUSD as NA?

# Set up a generic system of TEST_NAMES for all CMOs.  
# Renamed PUC's Test Type variable "CST Test Name" in the .txt file to match other CMO's
levels(puc$CST.Test.Name) <- c("ALGEBRA_I", "ALGEBRA_II", "BIOLOGY", "CHEMISTRY", "ELA", "GEOMETRY", "US HISTORY", "WORLD_HISTORY", "GRADE_LEVEL_MATHEMATICS", 
	"SCIENCE", "SCIENCE", "SUMMATIVE_HS_MATHEMATICS", "WORLD_HISTORY")  # "Science and LIFE_SCIENCE collapsed into the same level-"CST_Science/LifeScience".  Need to seperate by grade.

##  ID - change to factor.  Will need to make sure there are no duplicates accross CMO's / LAUSD
identical(puc$ID, puc$STUDENT_ID)
puc$STUDENT_ID <- NULL
puc$ID <- factor(puc$ID)

puc$SCHOOL_NUMBER <- as.character(puc$SCHOOL_NUMBER) #  Character first - change LAUSD stuff and then convert to factor
puc$SCHOOL_NUMBER[puc$From.LAUSD=="Yes"] <- paste("999", puc$SCHOOL_NUMBER[puc$From.LAUSD=="Yes"], sep="_")
puc$SCHOOL_NUMBER <- factor(puc$SCHOOL_NUMBER) #  Change these too - some CMOs are numeric, some are factors
puc$INSTRUCTOR_NUMBER_1 <- factor(puc$INSTRUCTOR_NUMBER_1) #  Change these too - some CMOs are numeric, some are factors
puc$INSTRUCTOR_NUMBER_2 <- factor(puc$INSTRUCTOR_NUMBER_2) #  Change this too

puc$DISTRICT_NUMBER[puc$From.LAUSD=="Yes"] <- 99999

puc$SCHOOL_NAME <- as.character(puc$SCHOOL_NAME)
puc$SCHOOL_NAME[puc$From.LAUSD=="Yes"] <- paste("LAUSD to",puc$X2012.PUC.School[puc$From.LAUSD=="Yes"])
puc$SCHOOL_NAME <- factor(puc$SCHOOL_NAME)

#  YEAR is fine (AVI added to each tab of original .xlsx file)

##  CONTENT_AREA
levels(puc$CONTENT_AREA) <- c("ELA", "HISTORY", "MATHEMATICS", "SCIENCE")

##  ETHNICITY, ELL_STATUS, GIFTED_TALENTED_STATUS & IEP_STATUS
#levels(puc$ETHNICITY)
puc$ETHNICITY <- recode(puc$ETHNICITY,
								"'' = NA;
								'200' = 'Asian';
								'American Indian or Alaska Native' = 'American Indian or Alaskan Native';
								'Hispanic or Latino' = 'Hispanic'") #  conform to the Aspire conventions.  Leave PUC unique ones. AVI put in 200 = Asian

                 
levels(puc$ELL_STATUS) <- c("Unknown", "English Learner", "English Only", "Initially Fluent English Proficient", "Reclassified Fluent English Proficient") # Labeled to match Aspire
levels(puc$SES_STATUS) <- c(NA, "Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(puc$IEP_STATUS) <- c(NA, "Student with Disabilities: No", "Student with Disabilities: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(puc$GENDER) <- c(NA, 'Gender: Female', 'Gender: Male') 
levels(puc$GIFTED_TALENTED_STATUS) <- c(NA, "Gifted and Talented: No", "Gifted and Talented: Yes") # PUC is the only one that provided this...

##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary" and ran basic descriptives:
levels(puc$PROFICIENCY_LEVEL_PROVIDED) <- c("Advanced", "Advanced", "Basic", "Basic", "Below Basic", "Below Basic", "Far Below Basic", "Far Below Basic", "Proficient", "Proficient")
puc$ACHIEVEMENT_LEVEL <- ordered(puc$PROFICIENCY_LEVEL_PROVIDED, 
		levels = c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

##  Test type
puc$Test.Type <- factor(1, labels="CST")  #all tests are CST based on the CST.Test.Name variable levels

## VALID_CASE
puc$VALID_CASE <- factor(1, levels=1:2, labels=c("VALID_CASE", "INVALID_CASE"))

# Duplicates
# 34 kids have two school IDs associated with each year/content area, but same teacher id score, etc.
# Emailed Matthew Goodlaw to see what the deal is.
puc <- data.table(puc, key="VALID_CASE, YEAR, CONTENT_AREA, CST.Test.Name, GRADE, ID, SCALE_SCORE, SCHOOL_NUMBER")
key(puc) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "CST.Test.Name", "GRADE","ID", "SCALE_SCORE")
dups <- puc[c(which(duplicated(puc))-1, which(duplicated(puc))),]; key(dups) <- c("YEAR", "CONTENT_AREA", "ID")
puc[['VALID_CASE']][which(duplicated(puc))-1] <- "INVALID_CASE"  # 34 cases with 2010 & 2011 data ...  #  1 case AVI "corrected" manually - added one teacher in as the second teacher. - SID 1062972393

# key(puc) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "CST.Test.Name", "GRADE","ID", "SCALE_SCORE")
key(puc) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "CST.Test.Name", "GRADE","ID")
dups <- puc[c(which(duplicated(puc))-1, which(duplicated(puc))),]; key(dups) <- c("YEAR", "CONTENT_AREA", "ID")
puc[['VALID_CASE']][which(duplicated(puc))-1] <- "INVALID_CASE"  

key(puc) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "CST.Test.Name", "GRADE","ID")
dups <- puc[c(which(duplicated(puc))-1, which(duplicated(puc))),]; key(dups) <- c("YEAR", "CONTENT_AREA", "ID")
# puc[['VALID_CASE']][which(duplicated(puc))-1] <- "INVALID_CASE"
#  Only one student with odd records: 6061633694 - double grade in 2009 from LAUSD (7 and 8).  2010 data is for 9th grade, so invalidate low grade???  Leave for now...


#  Checked these, but dups were all duplicate CONTENT_AREA with different test (e.g. General SCIENCE and BIOLOGY)
key(puc) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "SCALE_SCORE") # , "CST.Test.Name"
key(puc) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID")

dups <- puc[c(which(duplicated(puc))-1, which(duplicated(puc))),]; key(dups) <- c("YEAR", "CONTENT_AREA", "ID")

table(puc$From.LAUSD, puc$CONTENT_AREA, puc$GRADE, puc$YEAR)

#  82 invalid cases now  

####
####  COMBINE ALL CMO FILES TOGETHER
####

CMO_Data_LONG <- rbind.fill(puc, asp, gd, al) # put puc first now since they have 2 instructors

# CMO_Data_LONG$INSTRUCTOR_NUMBER_1 <- factor(CMO_Data_LONG$INSTRUCTOR_NUMBER_1)  # Too late here -- add to CMOs above
CMO_Data_LONG$Teacher.1.Weight.Role <- NULL
CMO_Data_LONG$Teacher.2.ID <- NULL #NOTE: PUC now has a INSTRUCTOR_NUMBER_2 and WEIGHT, but renamed in .txt, so this takes it out for other 3 CMOs
CMO_Data_LONG$Teacher.2.Weight.Role <- NULL
CMO_Data_LONG$Teacher.3.ID <- NULL
CMO_Data_LONG$Teacher.3.Weight.Role <- NULL
CMO_Data_LONG$Teacher.4.ID <- NULL 
CMO_Data_LONG$Teacher.4.Weight.Role <- NULL

CMO_Data_LONG$Year_PROVIDED <- NULL
CMO_Data_LONG$PROFICIENCY_LEVEL_PROVIDED <- NULL
CMO_Data_LONG$DOB <- NULL
CMO_Data_LONG$INSTRUCTOR_NAME_1 <- NULL
#CMO_Data_LONG$INSTRUCTOR_1_WEIGHT <- NULL # Don't do this now that PUC has added in 2nd instructor and weights.

CMO_Data_LONG$GIFTED_TALENTED_STATUS <- NULL  #  Get rid of for now.  Only two provided (LAUSD didn't), and they're messed up
CMO_Data_LONG$NSLP <- NULL  #  From Alliance - not sure what this is, get rid of for now.

CMO_Data_LONG$X2012.PUC.School <- NULL  #  From PUC - clear up LAUSD Missing data
CMO_Data_LONG$From.LAUSD <- NULL  #  From PUC - clear up LAUSD Missing data



#  Rename and recode
names(CMO_Data_LONG)[22] <- "TEST_NAME" # "CST.Test.Name"
names(CMO_Data_LONG)[25] <- "TEST_TYPE" # "Test.Type"
names(CMO_Data_LONG)[27] <- "COURSE_NAME_1" # "Alliance.Course.Name" - Will match up with LAUSD

levels(CMO_Data_LONG$EMH_LEVEL) <- c("Elementary", "High School", "Middle School", "Secondary", "High School", "Middle School", NA) #Still not great/consistent ...
#table(CMO_Data_LONG$EMH_LEVEL, CMO_Data_LONG$GRADE)  #  LOT of overlap :)
#CMO_Data_LONG$TEST_TYPE[is.na(CMO_Data_LONG$TEST_TYPE)] <- "CST" #ALL CST or have been invalidated (a few CAPA scores from one CMO)
#  Clean names - Some are all caps
#  Added stuff for LAUSD's Schools, but this function only works on FULL character strings - had to get cleaver if needed.

# "LA",  only for school names
    capwords <- function(x) {
      special.words <- c("ELA", "EMH", "II", "III", "IV", "ACD", "CH", "CHT", "CMNT", "CTR", "CDS", "EL", "ESP", "ESL", "HS", 
      	"MS", "M/S", "M/S/T", "MAG", "LC", "PC", "RFK", "SH", "ST", "YTH")
      if (x %in% special.words) return(x)
      s <- sub("_", " ", x)
      s <- strsplit(s, split=" ")[[1]]
      s <- paste(toupper(substring(s, 1,1)), tolower(substring(s, 2)), sep="", collapse=" ")
      s <- strsplit(s, split="-")[[1]]
      paste(toupper(substring(s, 1,1)), substring(s, 2), sep="", collapse="-")
    }

f.names <- sapply(levels(CMO_Data_LONG$FIRST_NAME), function(x) 
		paste(sapply(strsplit(x, split=" ")[[1]], capwords), collapse=" "), USE.NAMES=FALSE)
levels(CMO_Data_LONG$FIRST_NAME) <- f.names

l.names <- sapply(levels(CMO_Data_LONG$LAST_NAME), function(x) 
		paste(sapply(strsplit(x, split=" ")[[1]], capwords), collapse=" "), USE.NAMES=FALSE)
levels(CMO_Data_LONG$LAST_NAME) <- l.names
levels(CMO_Data_LONG$FIRST_NAME)[1] <- NA
levels(CMO_Data_LONG$LAST_NAME)[1] <- NA
# CMO_Data_LONG$FIRST_NAME <- as.character(CMO_Data_LONG$FIRST_NAME)
# CMO_Data_LONG$FIRST_NAME <- sapply(CMO_Data_LONG$FIRST_NAME, capwords)
# CMO_Data_LONG$FIRST_NAME <- factor(CMO_Data_LONG$FIRST_NAME)

# CMO_Data_LONG$LAST_NAME <- as.character(CMO_Data_LONG$LAST_NAME)
# CMO_Data_LONG$LAST_NAME <- sapply(CMO_Data_LONG$LAST_NAME, capwords)
# CMO_Data_LONG$LAST_NAME <- factor(CMO_Data_LONG$LAST_NAME)

#  Leave SCHOOL_NAME - lots of abreviations there.

save(CMO_Data_LONG, file="./California/Data/CMO_Data_LONG.Rdata", compress="bzip2")

rm(al); rm(asp); rm(gd); rm(puc); gc()

### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ###
###
###			Read in and clean the annual LAUSD files
###
### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ###


###
###  2009 :: Add in Demographic Info, change from wide to long. change Var names/factor values, rinse & repeat 
###

la.2009 <- read.delim("./California/Data/Base_Files/LAUSD/SY2008-09/STAR2009.txt", header=TRUE)
names(la.2009) <- toupper(names(la.2009))

demog.2009 <- read.delim("./California/Data/Base_Files/LAUSD/SY2008-09/Student demographics 2008-2009.txt", header=TRUE)
names(demog.2009) <- toupper(names(demog.2009))

# Merge in the demographic data.  Keep as data frame for column number indexing.  Change to data.table for teacher ID merge.
la.2009 <- merge(la.2009, demog.2009, by="STUDENT_PSEUDO_ID")


##  Wide to long ::
la <- NULL

##  ELA
tmp.la <- la.2009[, c(1:6,9, grep("ELA", names(la.2009)), 27:37)] #Select all columns with "ELA" in the names
names(tmp.la)[8:10] <- c("TEST_TYPE", "SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename generic and to match up with CMO data
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out a few records
tmp.la$TEST_TYPE[tmp.la$RECTYPE==2] <- 3
tmp.la$TEST_TYPE[tmp.la$RECTYPE==3] <- 4
tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CMA_is only in grades 3-9, these are CST_teSTS_in grades 2, 10 & 11
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))
tmp.la$TEST_NAME <- factor(paste(tmp.la$TEST_TYPE, " ELA", sep=""))#  Will later match up with CMO data "CST.Test.Name"
levels(tmp.la$TEST_NAME)[3] <- "ELA"
tmp.la$CONTENT_AREA <- "ELA" #Put in the CONTENT_AREA Field
la <- rbind.fill(tmp.la, la)

##  Math
tmp.la <- la.2009[, c(1:6,9, grep("MATH", names(la.2009)), 27:37)] 
names(tmp.la)[8:11] <- c("LAUSD_TEST_CODE", "TEST_TYPE", "SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename MATH specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out a few records

tmp.la$TEST_TYPE[tmp.la$RECTYPE==2] <- 3
tmp.la$TEST_TYPE[tmp.la$RECTYPE==3] <- 4
tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CMA_is only in grades 3-9, these are CST_teSTS_in grades 2, 10 & 11
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))

#table(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE, tmp.la$GRADE) # through grade 6 all CST_teSTS_are Grade-level.  In 7th grade ~3200 Algebra I tests, and things start getting CRAZY in 8th grade ;)

tmp.la$TEST_NAME <- paste(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE); tmp.la$TEST_NAME <- factor(tmp.la$TEST_NAME)
levels(tmp.la$TEST_NAME) <- c("CAPA_MATHEMATICS", "CMA_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "SUMMATIVE_HS_MATHEMATICS", "ALGEBRA_I", "INTEGRATED_MATHEMATICS_1", "GEOMETRY", "INTEGRATED_MATHEMATICS_2", "ALGEBRA_II", "CST_MATH_CODE_8", "STS_MATHEMATICS") #  Numbers from LAUSD data dictionary.  Labels 
tmp.la$CONTENT_AREA <- "MATHEMATICS" #Put in the CONTENT_AREA Field

la <- rbind.fill(tmp.la, la)

## SCIENCE
grep("SCIENCE", names(la.2009)) # Mispelling in 2009 - EOCSicENCE performance, "Social Science", etc.  Don't use this here!

tmp.la <- la.2009[, c(1:6,9, 11, 14, 17, 23, 27:37)] #Select SCIENCE fields - do this seperately from EOC-SCIENCE...
names(tmp.la)[8:11] <- c("LAUSD_TEST_CODE", "TEST_TYPE", "SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename SCIENCE specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CMA_is only in grade 5
tmp.la$TEST_TYPE[tmp.la$RECTYPE==2] <- 3 # There are a handful of CAPA_tests
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))

#table(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE, tmp.la$GRADE)

tmp.la$TEST_NAME <- paste(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE); tmp.la$TEST_NAME <- factor(tmp.la$TEST_NAME)
levels(tmp.la$TEST_NAME) <- c("CAPA_SCIENCE", "CMA_SCIENCE", "SCIENCE", "MULTIPLE_SCIENCE", "EARTH_SCIENCE", "BIOLOGY", "CHEMISTRY",  "PHYSICS", "INTEGRATED_SCIENCE_1", "INTEGRATED_SCIENCE_2", "INTEGRATED_SCIENCE_3", "INTEGRATED_SCIENCE_4", "UNKNOWN_SCIENCE") #  Numbers from LAUSD data dictionary. 

#table(tmp.la$TEST_TYPE, tmp.la$TEST_NAME, tmp.la$GRADE)

tmp.la$CONTENT_AREA <- "SCIENCE" #Put in the CONTENT_AREA Field

la <- rbind.fill(tmp.la, la)

##  EOC SCIENCE
tmp.la <- la.2009[, c(1:6,9, 11, 14, 20, 26:37)] #Select SCIENCE fields - do this seperately from EOC-SCIENCE...
names(tmp.la)[8:11] <- c("LAUSD_TEST_CODE", "TEST_TYPE", "SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename SCIENCE specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CST_TESTS_ONLY
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))

#table(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE, tmp.la$GRADE)

tmp.la$TEST_NAME <- paste(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE); tmp.la$TEST_NAME <- factor(tmp.la$TEST_NAME)
levels(tmp.la$TEST_NAME) <- c("EARTH_SCIENCE", "BIOLOGY", "CHEMISTRY",  "PHYSICS", "INTEGRATED_SCIENCE_1", "INTEGRATED_SCIENCE_2", "INTEGRATED_SCIENCE_3", "INTEGRATED_SCIENCE_4") #  Numbers from LAUSD data dictionary. 

#table(tmp.la$TEST_TYPE, tmp.la$TEST_NAME, tmp.la$GRADE)

tmp.la$CONTENT_AREA <- "SCIENCE" #Put in the CONTENT_AREA Field
la <- rbind.fill(tmp.la, la)


## History
tmp.la <- la.2009[, c(1:6,9, grep("HISTORYSOC", names(la.2009)), 27:37)] 
names(tmp.la)[8:9] <- c("SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename HISTORY specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE <- factor(1, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))
tmp.la$TEST_NAME <- factor("HISTORY")
tmp.la$CONTENT_AREA <- "HISTORY" #Put in the CONTENT_AREA Field
la <- rbind.fill(tmp.la, la)

##  WORLD_HISTORY

tmp.la <- la.2009[, c(1:6,9, grep("WORLDHISTORY", names(la.2009)), 27:37)] 
names(tmp.la)[8:9] <- c("SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename WORLD_HISTORY specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE <- factor(1, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))
tmp.la$TEST_NAME <- factor("WORLD_HISTORY")
tmp.la$CONTENT_AREA <- "HISTORY" #Put in the CONTENT_AREA Field
la <- rbind.fill(tmp.la, la)

dim(la)

###  Rename Vars, Set factor levels, etc. etc.

#  Which School number?  The one in demog file has lots of NA's...
names(la)[c(1, 4, 10, 14, 17:19)] <- c("ID", "SCHOOL_NUMBER", "YEAR", "SCHOOL_NAME", "ETHNICITY", "ELL_STATUS", "SES_STATUS") # Add IEP_STATUS later
names(la)[20] <- "SPECIFIC_DISABILITY" # Named different in all 3 years

la$OCCOCCURRENCEDESCR <- NULL  # Remove.  All in Spring
la$PRLPREFERREDLOCATIONCODE <- NULL
la$CDSCODE <- NULL #  All LAUSD's state code.

la$GRADECODE <- factor(la$GRADECODE, ordered=TRUE)

la$ID <- factor(la$ID)
la$CONTENT_AREA <- factor(la$CONTENT_AREA)
##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary"
la$ACHIEVEMENT_LEVEL <- ordered(la$PROFICIENCY_LEVEL_PROVIDED, levels = 1:5, labels=c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

##  ETHNICITY, ELL_STATUS, GENDER & IEP_STATUS

levels(la$GENDER) <- c(NA, 'Gender: Female', 'Gender: Male')
levels(la$ETHNICITY) <- c('American Indian or Alaskan Native', 'Asian', 'Black or African American', 'Filipino', 'Hispanic', 'Pacific Islander', 'Unknown', 'White')  # Conform to some of the conventions used in the CMOs.  Still lots of inconsistency - some have more detail than others ...

levels(la$ELL_STATUS) <- c("English Only", "Initially Fluent English Proficient", "English Learner", 
	"Reclassified Fluent English Proficient", "Unknown") # Labels as provided by Aspire, matches Cali AYP Definitions of Subgroups.
levels(la$SES_STATUS) <- c("Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes") # AVI based on Cali AYP Definitions of Subgroups

la$IEP_STATUS <- la$SPECIFIC_DISABILITY #  So much detail in the SPED Code.  Might be interesting to look at different disability groups ...
levels(la$IEP_STATUS) <- c("Student with Disabilities: No", rep("Student with Disabilities: Yes",18)) # AVI based on Cali AYP Definitions of Subgroups


## VALID_CASE
la$VALID_CASE <- factor(1, levels=1:2, labels=c("VALID_CASE", "INVALID_CASE")) # levels(la$VALID_CASE) <- c("VALID_CASE", "INVALID_CASE")

la$VALID_CASE[la$TEST_TYPE != "CST"] <- "INVALID_CASE"

#  Total duplicates
#  Looks like they are all from Science - overlap of EOC Sciencen and Science (what's the difference?  Check with LAUSD if we do SCIENCE in future)
la <- data.table(la, key="VALID_CASE, YEAR, CONTENT_AREA, TEST_NAME, GRADE, ID, SCALE_SCORE, SCHOOL_NUMBER")
la$VALID_CASE[which(duplicated(la))-1] <- "INVALID_CASE"  # 625 cases

# Different Score dups ::  Only one kid in 2009 with different recorded scores, and different school
#  I think these are dups from the Science/EOC Science group, so shouldn't impact us now.  Just going to take the highest score as usual.
key(la) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "TEST_NAME", "GRADE", "ID", "SCHOOL_NUMBER", "SCALE_SCORE") 
key(la) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "TEST_NAME", "GRADE", "ID", "SCHOOL_NUMBER")
la$VALID_CASE[which(duplicated(la))-1] <- "INVALID_CASE"  # 34,400 cases

#  Looks like the demographics file is off?  The test level and grade match up in the STAR test data file ...
#table(la$GRADE, la$GRADECODE, la$VALID_CASE)
#table(la$GRADE, la$TESTGRADELEVEL, la$VALID_CASE)
#grd <- la[la$GRADE != la$GRADECODE & la$VALID_CASE == "VALID_CASE",]
#key(grd) <- c("ID", "YEAR", "CONTENT_AREA")

#summary(grd) #  Lots of students with disabilities, ELLs, and Far Below Basic ...

# GENDER - this is odd ...
#table(la$GENDER, la$GENDERCODE, la$VALID_CASE)
#gend <- la[la$GENDER=="Gender: Female" & la$GENDERCODE=="M",]
#key(gend) <- c("ID", "YEAR", "CONTENT_AREA")

#la$GRADECODE <- factor(la$GRADECODE)
lausd <- la

rm(la.2009)
rm(demog.2009)
gc()

###
###  2010 :: Add in Demographic Info, change from wide to long. change Var names/factor values, rinse & repeat 
###

la.2010 <- read.delim("./California/Data/Base_Files/LAUSD/SY2009-10/STAR2010.txt", header=TRUE)
names(la.2010) <- toupper(names(la.2010))

demog.2010 <- read.delim("./California/Data/Base_Files/LAUSD/SY2009-10/Student demographics 2009-2010.txt", header=TRUE)
names(demog.2010) <- toupper(names(demog.2010))

# Merge in the demographic data.  Keep as data frame for column number indexing.  Change to data.table for teacher ID merge.
la.2010 <- merge(la.2010, demog.2010, by="STUDENT_PSEUDO_ID")


##  Wide to long ::
la <- NULL

##  ELA
tmp.la <- la.2010[, c(1:6,9, grep("ELA", names(la.2010)), 27:37)] #Select all columns with "ELA" in the names
names(tmp.la)[8:10] <- c("TEST_TYPE", "SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename generic and to match up with CMO data
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out a few records
tmp.la$TEST_TYPE[tmp.la$RECTYPE==2] <- 3
tmp.la$TEST_TYPE[tmp.la$RECTYPE==3] <- 4
tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CMA_is only in grades 3-9, these are CST_teSTS_in grades 2, 10 & 11
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))
tmp.la$TEST_NAME <- factor(paste(tmp.la$TEST_TYPE, " ELA", sep=""))#  Will later match up with CMO data "CST.Test.Name"
levels(tmp.la$TEST_NAME)[3] <- "ELA"
tmp.la$CONTENT_AREA <- "ELA" #Put in the CONTENT_AREA Field
la <- rbind.fill(tmp.la, la)

##  Math
tmp.la <- la.2010[, c(1:6,9, grep("MATH", names(la.2010)), 27:37)] 
names(tmp.la)[8:11] <- c("LAUSD_TEST_CODE", "TEST_TYPE", "SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename MATH specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out a few records

tmp.la$TEST_TYPE[tmp.la$RECTYPE==2] <- 3
tmp.la$TEST_TYPE[tmp.la$RECTYPE==3] <- 4
tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CMA_is only in grades 3-9, these are CST_teSTS_in grades 2, 10 & 11
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))

#table(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE, tmp.la$GRADE) # through grade 6 all CST_teSTS_are Grade-level.  In 7th grade ~3200 Algebra I tests, and things start getting CRAZY in 8th grade ;)

tmp.la$TEST_NAME <- paste(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE); tmp.la$TEST_NAME <- factor(tmp.la$TEST_NAME)
levels(tmp.la$TEST_NAME) <- c("CAPA_MATHEMATICS", "CMA_MATHEMATICS", "CMA_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "SUMMATIVE_HS_MATHEMATICS", "ALGEBRA_I", "INTEGRATED_MATHEMATICS_1", "GEOMETRY", "INTEGRATED_MATHEMATICS_2", "ALGEBRA_II", "CST_MATH_CODE_8", "STS_MATHEMATICS", "STS_MATHEMATICS") #  Numbers from LAUSD data dictionary. 
tmp.la$CONTENT_AREA <- "MATHEMATICS" #Put in the CONTENT_AREA Field

la <- rbind.fill(tmp.la, la)

## SCIENCE
grep("SCIENCE", names(la.2010)) # Mispelling in 2010 - EOCSicENCE performance, "Social Science", etc.  Don't use this here!

tmp.la <- la.2010[, c(1:6,9, 11, 14, 17, 23, 27:37)] #Select SCIENCE fields - do this seperately from EOC-SCIENCE...
names(tmp.la)[8:11] <- c("LAUSD_TEST_CODE", "TEST_TYPE", "SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename SCIENCE specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CMA_is only in grade 5
tmp.la$TEST_TYPE[tmp.la$RECTYPE==2] <- 3 # There are a handful of CAPA_tests
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))

#table(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE, tmp.la$GRADE)

tmp.la$TEST_NAME <- paste(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE); tmp.la$TEST_NAME <- factor(tmp.la$TEST_NAME)
levels(tmp.la$TEST_NAME) <- c("CAPA_SCIENCE", "CMA_SCIENCE", "SCIENCE", "MULTIPLE_SCIENCE", "EARTH_SCIENCE", "BIOLOGY", "CHEMISTRY",  "PHYSICS", "INTEGRATED_SCIENCE_1", "INTEGRATED_SCIENCE_2", "INTEGRATED_SCIENCE_3", "INTEGRATED_SCIENCE_4", "UNKNOWN_SCIENCE") #  Numbers from LAUSD data dictionary. 

#table(tmp.la$TEST_TYPE, tmp.la$TEST_NAME, tmp.la$GRADE)

tmp.la$CONTENT_AREA <- "SCIENCE" #Put in the CONTENT_AREA Field

la <- rbind.fill(tmp.la, la)

##  EOC SCIENCE
tmp.la <- la.2010[, c(1:6,9, 11, 14, 20, 26:37)] #Select SCIENCE fields - do this seperately from EOC-SCIENCE...
names(tmp.la)[8:11] <- c("LAUSD_TEST_CODE", "TEST_TYPE", "SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename SCIENCE specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CST_TESTS_ONLY
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))

#table(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE, tmp.la$GRADE)

tmp.la$TEST_NAME <- paste(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE); tmp.la$TEST_NAME <- factor(tmp.la$TEST_NAME)
levels(tmp.la$TEST_NAME) <- c("CMA_EARTH_SCIENCE", "CMA_BIOLOGY", "CMA_CHEMISTRY",  "CMA_INTEGRATED_SCIENCE_1","EARTH_SCIENCE", "BIOLOGY", "CHEMISTRY",  "PHYSICS", "INTEGRATED_SCIENCE_1", "INTEGRATED_SCIENCE_2", "INTEGRATED_SCIENCE_3", "INTEGRATED_SCIENCE_4") #  Numbers from LAUSD data dictionary. 
 
#table(tmp.la$TEST_TYPE, tmp.la$TEST_NAME, tmp.la$GRADE)

tmp.la$CONTENT_AREA <- "SCIENCE" #Put in the CONTENT_AREA Field
la <- rbind.fill(tmp.la, la)


## History
tmp.la <- la.2010[, c(1:6,9, grep("HISTORYSOC", names(la.2010)), 27:37)] 
names(tmp.la)[8:9] <- c("SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename HISTORY specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE <- factor(1, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))
tmp.la$TEST_NAME <- factor("HISTORY")
tmp.la$CONTENT_AREA <- "HISTORY" #Put in the CONTENT_AREA Field
la <- rbind.fill(tmp.la, la)

##  WORLD_HISTORY

tmp.la <- la.2010[, c(1:6,9, grep("WORLDHISTORY", names(la.2010)), 27:37)] 
names(tmp.la)[8:9] <- c("SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename WORLD_HISTORY specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE <- factor(1, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))
tmp.la$TEST_NAME <- factor("WORLD_HISTORY")
tmp.la$CONTENT_AREA <- "HISTORY" #Put in the CONTENT_AREA Field
la <- rbind.fill(tmp.la, la)

dim(la)

###  Rename Vars, Set factor levels, etc. etc.

#  Which School number?  The one in demog file has lots of NA's...
names(la)[c(1, 4, 10, 14, 17:19)] <- c("ID", "SCHOOL_NUMBER", "YEAR", "SCHOOL_NAME", "ETHNICITY", "ELL_STATUS", "SES_STATUS") # Add IEP_STATUS later
names(la)[20] <- "SPECIFIC_DISABILITY" # Named different in all 3 years

la$OCCOCCURRENCEDESCR <- NULL  # Remove.  All in Spring
la$PRLPREFERREDLOCATIONCODE <- NULL
la$CDSCODE <- NULL #  All LAUSD's state code.

la$GRADECODE <- factor(la$GRADECODE) ##  Match up levels too

la$ID <- factor(la$ID)
la$CONTENT_AREA <- factor(la$CONTENT_AREA)
##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary"
la$ACHIEVEMENT_LEVEL <- ordered(la$PROFICIENCY_LEVEL_PROVIDED, levels = 0:5, labels=c(NA,"Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

##  ETHNICITY, ELL_STATUS, GENDER & IEP_STATUS

levels(la$GENDER) <- c(NA, NA, 'Gender: Female', 'Gender: Male')
levels(la$ETHNICITY) <- c('American Indian or Alaskan Native', 'Asian', 'Black or African American', 'Filipino', 'Hispanic', 'Pacific Islander', 'White')  # Conform to some of the conventions used in the CMOs.  Still lots of inconsistency - some have more detail than others ... 'Unknown', 2009

levels(la$ELL_STATUS) <- c("English Only", "Initially Fluent English Proficient", "English Learner", 
	"Reclassified Fluent English Proficient", "Unknown") # Labels as provided by Aspire, matches Cali AYP Definitions of Subgroups.
levels(la$SES_STATUS) <- c("Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes") # AVI based on Cali AYP Definitions of Subgroups

la$IEP_STATUS <- la$SPECIFIC_DISABILITY #  So much detail in the SPED Code.  Might be interesting to look at different disability groups ...
levels(la$IEP_STATUS) <- c("Student with Disabilities: No", rep("Student with Disabilities: Yes",18)) # AVI based on Cali AYP Definitions of Subgroups


## VALID_CASE
la$VALID_CASE <- factor(1, levels=1:2, labels=c("VALID_CASE", "INVALID_CASE")) # levels(la$VALID_CASE) <- c("VALID_CASE", "INVALID_CASE")

la$VALID_CASE[la$TEST_TYPE != "CST"] <- "INVALID_CASE"

#  Total duplicates
#  Looks like they are all from Science - overlap of EOC Sciencen and Science (what's the difference?  Check with LAUSD if we do SCIENCE in future)
la <- data.table(la, key="VALID_CASE, YEAR, CONTENT_AREA, TEST_NAME, GRADE, ID, SCALE_SCORE, SCHOOL_NUMBER")
la$VALID_CASE[which(duplicated(la))-1] <- "INVALID_CASE"  # 430 cases

# Different Score dups ::  Only one kid in 2010 with different recorded scores, and different school
#  I think these are dups from the Science/EOC Science group, so shouldn't impact us now.  Just going to take the highest score as usual.
key(la) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "TEST_NAME", "GRADE", "ID", "SCHOOL_NUMBER", "SCALE_SCORE") 
key(la) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "TEST_NAME", "GRADE", "ID", "SCHOOL_NUMBER")
la$VALID_CASE[which(duplicated(la))-1] <- "INVALID_CASE"  # 35,714 cases

#table(la$VALID_CASE, la$CONTENT_AREA, la$TEST_TYPE)  #only a handful of CST_Math and ELA teSTS_that are invalid.  Should be fine for now.

#key(la) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "TEST_NAME", "GRADE", "ID", "SCHOOL_NUMBER")
#dup.ids <- la$ID[which(duplicated(la))-1]# looks like dups are all in Science - probably the Science and EOC science
#dups <- la[la$ID %in% dup.ids,]; key(dups) <- c("ID", "YEAR", "CONTENT_AREA")
#dim(dups)

#  Looks like the demographics file is off?  The test level and grade match up in the STAR test data file ...
#  Same as above in 2011

#identical(names(lausd), names(la)) ; names(lausd) %in% names(la)
lausd <- rbind(lausd, la)
rm(la.2010)
rm(demog.2010)
gc()

###
###  2011 :: Add in Demographic Info, change from wide to long. change Var names/factor values, rinse & repeat 
###

la.2011 <- read.delim("./California/Data/Base_Files/LAUSD/SY2010-11/STAR2011.txt", header=TRUE)
names(la.2011) <- toupper(names(la.2011))

demog.2011 <- read.delim("./California/Data/Base_Files/LAUSD/SY2010-11/Demographics 2010-11.txt", header=TRUE)
names(demog.2011) <- toupper(names(demog.2011))
names(demog.2011)[3] <- "STUDENT_PSEUDO_ID"
# Merge in the demographic data.  Keep as data frame for column number indexing.  Change to data.table for teacher ID merge.
la.2011 <- merge(la.2011, demog.2011, by="STUDENT_PSEUDO_ID")


##  Wide to long ::
la <- NULL

##  ELA
tmp.la <- la.2011[, c(1:6,9, grep("ELA", names(la.2011)), 27:37)] #Select all columns with "ELA" in the names
names(tmp.la)[8:10] <- c("TEST_TYPE", "SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename generic and to match up with CMO data
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out a few records
tmp.la$TEST_TYPE[tmp.la$RECTYPE==2] <- 3
tmp.la$TEST_TYPE[tmp.la$RECTYPE==3] <- 4
tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CMA_is only in grades 3-9, these are CST_teSTS_in grades 2, 10 & 11
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))
tmp.la$TEST_NAME <- factor(paste(tmp.la$TEST_TYPE, " ELA", sep=""))#  Will later match up with CMO data "CST.Test.Name"
levels(tmp.la$TEST_NAME)[3] <- "ELA"
tmp.la$CONTENT_AREA <- "ELA" #Put in the CONTENT_AREA Field
la <- rbind.fill(tmp.la, la)

##  Math
tmp.la <- la.2011[, c(1:6,9, grep("MATH", names(la.2011)), 27:37)] 
names(tmp.la)[8:11] <- c("LAUSD_TEST_CODE", "TEST_TYPE", "SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename MATH specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out a few records

tmp.la$TEST_TYPE[tmp.la$RECTYPE==2] <- 3
tmp.la$TEST_TYPE[tmp.la$RECTYPE==3] <- 4
tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CMA_is only in grades 3-9, these are CST_teSTS_in grades 2, 10 & 11
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))

#table(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE, tmp.la$GRADE)

tmp.la$TEST_NAME <- paste(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE); tmp.la$TEST_NAME <- factor(tmp.la$TEST_NAME)
levels(tmp.la$TEST_NAME) <- c("CAPA_MATHEMATICS", "CMA_MATHEMATICS", "CMA_MATHEMATICS", "CMA_ALGEBRA I", "GRADE_LEVEL_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "GRADE_LEVEL_MATHEMATICS", "SUMMATIVE_HS_MATHEMATICS", "ALGEBRA_I", "INTEGRATED_MATHEMATICS_1", "GEOMETRY", "INTEGRATED_MATHEMATICS_2", "ALGEBRA_II", "CST_MATH_CODE_8", "STS_MATHEMATICS", "STS_MATHEMATICS") #  Numbers from LAUSD data dictionary. 
tmp.la$CONTENT_AREA <- "MATHEMATICS" #Put in the CONTENT_AREA Field

la <- rbind.fill(tmp.la, la)

## SCIENCE
grep("SCIENCE", names(la.2011)) # Mispelling in 2011 - EOCSicENCE performance, "Social Science", etc.  Don't use this here!

tmp.la <- la.2011[, c(1:6,9, 11, 14, 17, 23, 27:37)] #Select SCIENCE fields - do this seperately from EOC-SCIENCE...
names(tmp.la)[8:11] <- c("LAUSD_TEST_CODE", "TEST_TYPE", "SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename SCIENCE specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CMA_is only in grade 5
tmp.la$TEST_TYPE[tmp.la$RECTYPE==2] <- 3 # There are a handful of CAPA_tests
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))

#table(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE, tmp.la$GRADE)

tmp.la$TEST_NAME <- paste(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE); tmp.la$TEST_NAME <- factor(tmp.la$TEST_NAME)
levels(tmp.la$TEST_NAME) <- c("CAPA_SCIENCE", "CMA_SCIENCE", "CMA_EARTH_SCIENCE", "CMA_BIOLOGY", "CMA_CHEMISTRY", "CMA_PHYSICS", "CMA_INTEGRATED_SCIENCE_1", "CMA_INTEGRATED_SCIENCE_2", "CMA_UNKNOWN_SCIENCE", "SCIENCE", "EARTH_SCIENCE", "BIOLOGY", "CHEMISTRY",  "PHYSICS", "INTEGRATED_SCIENCE_1", "INTEGRATED_SCIENCE_2", "INTEGRATED_SCIENCE_3", "INTEGRATED_SCIENCE_4", "UNKNOWN_SCIENCE") #  Numbers from LAUSD data dictionary. 

#table(tmp.la$TEST_TYPE, tmp.la$TEST_NAME, tmp.la$GRADE)

tmp.la$CONTENT_AREA <- "SCIENCE" #Put in the CONTENT_AREA Field

la <- rbind.fill(tmp.la, la)

##  EOC SCIENCE
tmp.la <- la.2011[, c(1:6,9, 11, 14, 20, 26:37)] #Select SCIENCE fields - do this seperately from EOC-SCIENCE...
names(tmp.la)[8:11] <- c("LAUSD_TEST_CODE", "TEST_TYPE", "SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename SCIENCE specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CST_TESTS_ONLY
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))

#table(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE, tmp.la$GRADE)

tmp.la$TEST_NAME <- paste(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE); tmp.la$TEST_NAME <- factor(tmp.la$TEST_NAME)
levels(tmp.la$TEST_NAME) <- c("CMA_EARTH_SCIENCE", "CMA_BIOLOGY", "CMA_CHEMISTRY",  "CMA_PHYSICS", "CMA_INTEGRATED_SCIENCE_1", "CMA_INTEGRATED_SCIENCE_2", "EARTH_SCIENCE", "BIOLOGY", "CHEMISTRY",  "PHYSICS", "INTEGRATED_SCIENCE_1", "INTEGRATED_SCIENCE_2", "INTEGRATED_SCIENCE_3", "INTEGRATED_SCIENCE_4") #  Numbers from LAUSD data dictionary. 
 
#table(tmp.la$TEST_TYPE, tmp.la$TEST_NAME, tmp.la$GRADE)

tmp.la$CONTENT_AREA <- "SCIENCE" #Put in the CONTENT_AREA Field
la <- rbind.fill(tmp.la, la)


## History
tmp.la <- la.2011[, c(1:6,9, grep("HISTORYSOC", names(la.2011)), 27:37)] 
names(tmp.la)[8:9] <- c("SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename HISTORY specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE <- factor(1, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))
tmp.la$TEST_NAME <- factor("HISTORY")
tmp.la$CONTENT_AREA <- "HISTORY" #Put in the CONTENT_AREA Field
la <- rbind.fill(tmp.la, la)

##  WORLD_HISTORY

tmp.la <- la.2011[, c(1:6,9, grep("WORLDHISTORY", names(la.2011)), 27:37)] 
names(tmp.la)[8:9] <- c("SCALE_SCORE", "PROFICIENCY_LEVEL_PROVIDED") # Rename WORLD_HISTORY specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE <- factor(1, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))
tmp.la$TEST_NAME <- factor("WORLD_HISTORY")
tmp.la$CONTENT_AREA <- "HISTORY" #Put in the CONTENT_AREA Field
la <- rbind.fill(tmp.la, la)

dim(la)

###  Rename Vars, Set factor levels, etc. etc.

#  Which School number?  The one in demog file has lots of NA's...
names(la)[c(1, 4, 10, 14, 17:19)] <- c("ID", "SCHOOL_NUMBER", "YEAR", "SCHOOL_NAME", "ETHNICITY", "ELL_STATUS", "SES_STATUS") # Add IEP_STATUS later
names(la)[20] <- "SPECIFIC_DISABILITY" # Named different in all 3 years

la$OCCOCCURRENCEDESCR <- NULL  # Remove.  All in Spring
la$PRLPREFERREDLOCATIONCODE <- NULL
la$CDSCODE <- NULL #  All LAUSD's state code.

la$ID <- factor(la$ID)
la$CONTENT_AREA <- factor(la$CONTENT_AREA)
##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary"
la$ACHIEVEMENT_LEVEL <- ordered(la$PROFICIENCY_LEVEL_PROVIDED, levels = 0:5, labels=c(NA,"Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

##  ETHNICITY, ELL_STATUS, GENDER & IEP_STATUS
levels(la$GENDER) <- c(NA, 'Gender: Female', 'Gender: Male')
levels(la$ETHNICITY) <- c('American Indian or Alaskan Native', 'Asian', 'Black or African American', 'Filipino', 'Hispanic', 'Pacific Islander', 'White')  # Conform to some of the conventions used in the CMOs.  Still lots of inconsistency - some have more detail than others ... 'Unknown', 2009

levels(la$ELL_STATUS) <- c("Unknown", "English Only", "Initially Fluent English Proficient", "English Learner", 
	"Reclassified Fluent English Proficient") # Labels as provided by Aspire, matches Cali AYP Definitions of Subgroups.
levels(la$SES_STATUS) <- c("Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes") # AVI based on Cali AYP Definitions of Subgroups

la$IEP_STATUS <- la$SPECIFIC_DISABILITY #  So much detail in the SPED Code.  Might be interesting to look at different disability groups ...
levels(la$IEP_STATUS) <- c("Student with Disabilities: No", rep("Student with Disabilities: Yes",17)) 


## VALID_CASE
la$VALID_CASE <- factor(1, levels=1:2, labels=c("VALID_CASE", "INVALID_CASE")) # levels(la$VALID_CASE) <- c("VALID_CASE", "INVALID_CASE")

la$VALID_CASE[la$TEST_TYPE != "CST"] <- "INVALID_CASE"

#  Total duplicates
#  Looks like they are all from Science - overlap of EOC Sciencen and Science (what's the difference?  Check with LAUSD if we do SCIENCE in future)
la <- data.table(la, key="VALID_CASE, YEAR, CONTENT_AREA, TEST_NAME, GRADE, ID, SCALE_SCORE, SCHOOL_NUMBER")
la$VALID_CASE[which(duplicated(la))-1] <- "INVALID_CASE"  # 549 cases

# Different Score dups ::  Only one kid in 2011 with different recorded scores, and different school
#  I think these are dups from the Science/EOC Science group, so shouldn't impact us now.  Just going to take the highest score as usual.
key(la) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "TEST_NAME", "GRADE", "ID", "SCHOOL_NUMBER", "SCALE_SCORE") 
key(la) <- c("VALID_CASE", "YEAR", "CONTENT_AREA", "TEST_NAME", "GRADE", "ID", "SCHOOL_NUMBER")
la$VALID_CASE[which(duplicated(la))-1] <- "INVALID_CASE"  # 34883 cases

#  Looks like the demographics file is off?  The test level and grade match up in the STAR test data file ...
#  Same as above

#levels(la$SPECIFIC_DISABILITY)
levels(lausd$SPECIFIC_DISABILITY) <- c(NA, "AUTISM", "DEAF-BLINDNESS", "DEVELOPMENTAL DELAY", "DEAFNESS", "EMOTIONAL DISTURBANCE", "ESTABLISHED MEDICAL DISABILITY", "HARD OF HEARING", "LAS", "MULTIPLE DISABILITIES - HEARING", "MULTIPLE DISABILITIES - ORTHOPEDIC", "MULTIPLE DISABILITIES - VISION", "MENTALLY RETARDED", "OTHER HEALTH IMPAIRMENT", "ORTHOPEDIC IMPAIRMENT", "SPECIFIC LEARNING DISABILITY", "SPEECH OR LANGUAGE IMPAIRMENT", "TRAUMATIC BRAIN INJURY", "VISUAL IMPAIRMENT")

lausd <- rbind(lausd, la)
rm(la); rm(la.2011); rm(demog.2011)
gc()

LAUSD_Data_LONG <- lausd
save(lausd, file="./California/Data/LAUSD_Data_LONG_no_teacher.Rdata", compress="bzip2")

###
###  Collect & Merge in the TEACHER DATA 
###

####  2011
###  Elementary Schools :: Collect all three periods
##  EP1
tchr.2011 <- read.delim("./California/Data/Base_Files/LAUSD/SY2010-11/ElementaryMarks 2010-11 EP1.txt", header=TRUE)
#table(tchr.2011$CRS_COURSE_CODE, tchr.2011$CRS_COURSE_NAME)

tchr.2011 <- tchr.2011[c(9:8, 2, 5, 7)]
names(tchr.2011) <- c("ID", "INSTRUCTOR_NUMBER", "MARKING_PERIOD", "SCHOOL_NUMBER", "CONTENT_AREA")
tchr.2011 <- tchr.2011[!is.na(tchr.2011$INSTRUCTOR_NUMBER),]
tchr.2011 <- tchr.2011[tchr.2011$CONTENT_AREA %in% c("MATHEMATICS", "READING", "ELD READING", "WRITING", "ELD WRITING", "HIST SOC SCI", "SCIENCE"),]
tchr.2011$CONTENT_AREA<-droplevels(tchr.2011$CONTENT_AREA)
levels(tchr.2011$CONTENT_AREA) <- c("ELA", "ELA", "HISTORY", "MATHEMATICS", "ELA", "SCIENCE", "ELA")

tchr.2011$ID <- factor(tchr.2011$ID)
tchr.2011$INSTRUCTOR_NUMBER <- factor(tchr.2011$INSTRUCTOR_NUMBER)

# Remove duplicates
tchr.2011 <- data.table(tchr.2011, key="CONTENT_AREA, SCHOOL_NUMBER, INSTRUCTOR_NUMBER, ID")
tchr.2011 <- tchr.2011[which(!duplicated(tchr.2011)),]

lausd.tchr <- tchr.2011

## EP2
tchr.2011 <- read.delim("./California/Data/Base_Files/LAUSD/SY2010-11/ElementaryMarks 2010-11 EP2.txt", header=TRUE)

tchr.2011 <- tchr.2011[c(9:8, 2, 5, 7)]
names(tchr.2011) <- c("ID", "INSTRUCTOR_NUMBER", "MARKING_PERIOD", "SCHOOL_NUMBER", "CONTENT_AREA")
tchr.2011 <- tchr.2011[!is.na(tchr.2011$INSTRUCTOR_NUMBER),]
tchr.2011 <- tchr.2011[tchr.2011$CONTENT_AREA %in% c("MATHEMATICS", "READING", "ELD READING", "WRITING", "ELD WRITING", "HIST SOC SCI", "SCIENCE"),]
tchr.2011$CONTENT_AREA<-droplevels(tchr.2011$CONTENT_AREA)
levels(tchr.2011$CONTENT_AREA) <- c("ELA", "ELA", "HISTORY", "MATHEMATICS", "ELA", "SCIENCE", "ELA")

tchr.2011$ID <- factor(tchr.2011$ID)
tchr.2011$INSTRUCTOR_NUMBER <- factor(tchr.2011$INSTRUCTOR_NUMBER)
tchr.2011 <- data.table(tchr.2011, key="CONTENT_AREA, SCHOOL_NUMBER, INSTRUCTOR_NUMBER, ID")
tchr.2011 <- tchr.2011[which(!duplicated(tchr.2011)),]

lausd.tchr <- rbind(lausd.tchr, tchr.2011)

## EP3
tchr.2011 <- read.delim("./California/Data/Base_Files/LAUSD/SY2010-11/ElementaryMarks 2010-11 EP3.txt", header=TRUE)

tchr.2011 <- tchr.2011[c(9:8, 2, 5, 7)]
names(tchr.2011) <- c("ID", "INSTRUCTOR_NUMBER", "MARKING_PERIOD", "SCHOOL_NUMBER", "CONTENT_AREA")
tchr.2011 <- tchr.2011[!is.na(tchr.2011$INSTRUCTOR_NUMBER),]
tchr.2011 <- tchr.2011[tchr.2011$CONTENT_AREA %in% c("MATHEMATICS", "READING", "ELD READING", "WRITING", "ELD WRITING", "HIST SOC SCI", "SCIENCE"),]
tchr.2011$CONTENT_AREA<-droplevels(tchr.2011$CONTENT_AREA)
levels(tchr.2011$CONTENT_AREA) <- c("ELA", "ELA", "HISTORY", "MATHEMATICS", "ELA", "SCIENCE", "ELA")

tchr.2011$ID <- factor(tchr.2011$ID)
tchr.2011$INSTRUCTOR_NUMBER <- factor(tchr.2011$INSTRUCTOR_NUMBER)
tchr.2011 <- data.table(tchr.2011, key="CONTENT_AREA, SCHOOL_NUMBER, INSTRUCTOR_NUMBER, ID")
tchr.2011 <- tchr.2011[which(!duplicated(tchr.2011)),]

lausd.tchr <- rbind(lausd.tchr, tchr.2011)


###  Secondary Schools :: add to Elem.
tchr.2011 <- read.delim("./California/Data/Base_Files/LAUSD/SY2010-11/SecondaryMarks 2010-11.txt", header=TRUE)

tchr.2011 <- tchr.2011[c(11:10, 2, 5, 6, 8)] # ,12
names(tchr.2011) <- c("ID", "INSTRUCTOR_NUMBER", "MARKING_PERIOD", "SCHOOL_NUMBER", "CONTENT_AREA", "COURSE_NAME") #, "MARK"
tchr.2011 <- tchr.2011[!is.na(tchr.2011$INSTRUCTOR_NUMBER),]

#summary(tchr.2011$COURSE_NAME[tchr.2011$CONTENT_AREA == "COMPUTER SCIENCE"])
#summary(tchr.2011$COURSE_NAME[tchr.2011$CONTENT_AREA == "INTERDISCIPLINARY"])
#tchr.2011[tchr.2011$CONTENT_AREA == "INTERDISCIPLINARY",] All "ELA" so add it in
#summary(tchr.2011$CONTENT_AREA[tchr.2011$COURSE_NAME == "HOMEROOM"])
summary(tchr.2011$COURSE_NAME[tchr.2011$CONTENT_AREA == "SP ED:VOC ED F HAND"]) #  Lots of COURSES/INSTRCTORS we could add here.  Some big/obvious:

###  Adds about 25,000 courses
math.index <- grep("MATH",names(summary(tchr.2011$COURSE_NAME[tchr.2011$CONTENT_AREA == "SP ED:VOC ED F HAND"])))
ela.index <- c(grep("ELA",names(summary(tchr.2011$COURSE_NAME[tchr.2011$CONTENT_AREA == "SP ED:VOC ED F HAND"]))),
				grep("ENG",names(summary(tchr.2011$COURSE_NAME[tchr.2011$CONTENT_AREA == "SP ED:VOC ED F HAND"]))),
				grep("READ",names(summary(tchr.2011$COURSE_NAME[tchr.2011$CONTENT_AREA == "SP ED:VOC ED F HAND"]))),
				grep("WRIT",names(summary(tchr.2011$COURSE_NAME[tchr.2011$CONTENT_AREA == "SP ED:VOC ED F HAND"]))))
sci.index <- c(grep("SCI",names(summary(tchr.2011$COURSE_NAME[tchr.2011$CONTENT_AREA == "SP ED:VOC ED F HAND"]))))
hst.index <- c(grep("HIST",names(summary(tchr.2011$COURSE_NAME[tchr.2011$CONTENT_AREA == "SP ED:VOC ED F HAND"]))))
courses <- names(summary(tchr.2011$COURSE_NAME[tchr.2011$CONTENT_AREA == "SP ED:VOC ED F HAND"]))
for (i in math.index) {
	tchr.2011$CONTENT_AREA[tchr.2011$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2011$COURSE_NAME == courses[i] ] <- "MATHEMATICS"
}

for (i in ela.index) {
	tchr.2011$CONTENT_AREA[tchr.2011$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2011$COURSE_NAME == courses[i] ] <- "ENGLISH" # will change to ELA
}

for (i in sci.index) {
	tchr.2011$CONTENT_AREA[tchr.2011$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2011$COURSE_NAME == courses[i] ] <- "SCIENCE"
}

for (i in hst.index) {
	tchr.2011$CONTENT_AREA[tchr.2011$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2011$COURSE_NAME == courses[i] ] <- "SOCIAL SCIENCE"
}


tchr.2011 <- tchr.2011[tchr.2011$CONTENT_AREA %in% c("BILINGUAL-ESL", "ENGLISH", "INTERDISCIPLINARY", "MATHEMATICS", "READING", "SCIENCE", "SOCIAL SCIENCE"),]
tchr.2011$CONTENT_AREA<-droplevels(tchr.2011$CONTENT_AREA)
levels(tchr.2011$CONTENT_AREA) <- c("ELA", "ELA", "ELA", "MATHEMATICS", "ELA", "SCIENCE", "HISTORY")

#summary(tchr.2011$COURSE_NAME[tchr.2011$CONTENT_AREA == "HISTORY"])
#summary(tchr.2011$COURSE_NAME[tchr.2011$CONTENT_AREA == "ELA"])

tchr.2011$ID <- factor(tchr.2011$ID)
tchr.2011$INSTRUCTOR_NUMBER <- factor(tchr.2011$INSTRUCTOR_NUMBER)

#  Remove teachers in same Dept/Content_area in SAME classes in the SAME SEMESTER first
tchr.2011 <- data.table(tchr.2011, key="CONTENT_AREA, COURSE_NAME, MARKING_PERIOD, ID, INSTRUCTOR_NUMBER")
tchr.2011 <- tchr.2011[which(!duplicated(tchr.2011)),]

#  Remove teachers in same Content_area in multiple classes in the SAME SCHOOL & SEMESTER (hopefully similar to above)
key(tchr.2011) <- c("CONTENT_AREA", "SCHOOL_NUMBER", "MARKING_PERIOD", "INSTRUCTOR_NUMBER", "ID") #"COURSE_NAME", 
tchr.2011 <- tchr.2011[which(!duplicated(tchr.2011)),]

#  Remove teachers in same Content_area in multiple classes in the SAME SCHOOL (hopefully similar to above) - Different semester
key(tchr.2011) <- c("CONTENT_AREA", "SCHOOL_NUMBER", "MARKING_PERIOD", "INSTRUCTOR_NUMBER", "ID") # Get Fall period on top
key(tchr.2011) <- c("CONTENT_AREA", "SCHOOL_NUMBER", "INSTRUCTOR_NUMBER", "ID")
tchr.2011 <- tchr.2011[-(which(duplicated(tchr.2011))-1),] #takes the first line out - here FALL b/c alphabetical

#  Remove teachers in same Content_area in multiple classes in Different SCHOOL (looks like most are NA school numbers)
#key(tchr.2011) <- c("CONTENT_AREA", "SCHOOL_NUMBER", "INSTRUCTOR_NUMBER", "ID") # Get SCHOOL_NUMBER on top 
key(tchr.2011) <- c("CONTENT_AREA", "MARKING_PERIOD", "INSTRUCTOR_NUMBER", "ID") 
key(tchr.2011) <- c("CONTENT_AREA", "INSTRUCTOR_NUMBER", "ID") 
tchr.2011 <- tchr.2011[-(which(duplicated(tchr.2011))-1),] # Still take the LATER period - end of year

#  A few dups with same course and time period - different teachers.  Go back and add in Course grades to see if some are NA
#  Nope.  They all lok legit.  Same schools, period, class etc.  Different teachers and different 'marks'.
#  Just keep them and "WIDEN" out the file to put in multiple teachers
#key(tchr.2011) <- c("CONTENT_AREA", "INSTRUCTOR_NUMBER", "ID")

#unq.ids <- which(!duplicated(tchr.2011)); length(unq.ids)
#dup.ids <- which(duplicated(tchr.2011)); length(dup.ids)
#dups <- tchr.2011[c(dup.ids, (dup.ids-1)),]; key(dups) <- c("ID", "CONTENT_AREA")
#dim(dups)

lausd.tchr <- data.table(rbind.fill(lausd.tchr, tchr.2011), key="CONTENT_AREA, ID")

#  Remove teachers that a student had more than one in a year.  Keep the LATEST period available (EP3 and SPRING)
key(lausd.tchr) <- c("ID", "MARKING_PERIOD", "INSTRUCTOR_NUMBER", "CONTENT_AREA") #"SCHOOL_NUMBER", 
key(lausd.tchr) <- c("ID", "INSTRUCTOR_NUMBER", "CONTENT_AREA") #"MARKING_PERIOD", "SCHOOL_NUMBER", 
lausd.tchr <- lausd.tchr[-(which(duplicated(lausd.tchr))-1),]


#  Now "WIDEN" the file by subject area
key(lausd.tchr) <- c("ID", "CONTENT_AREA")

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
#summary(lausd.tchr$TEACHER_COUNT) 
#lausd.tchr[lausd.tchr$TEACHER_COUNT==5,]

lausd.tchr$TEACHER_COUNT <- factor(lausd.tchr$TEACHER_COUNT)
key(lausd.tchr) <- c("CONTENT_AREA", "TEACHER_COUNT")

#LAUSD_Teacher_Links object should be set up already ...
LAUSD_Teacher_Links <- NULL
for (j in c("ELA", "MATHEMATICS", "SCIENCE", "HISTORY")) { 
	tmp.tchr <- reshape(lausd.tchr[J(j), mult='all'],
							idvar='ID',
							timevar='TEACHER_COUNT',
							drop=c('CONTENT_AREA', 'SCHOOL_NUMBER'), # take  'MARK' out above now too
							direction='wide',
							sep="_")

	tmp.tchr$CONTENT_AREA <- j
	tmp.tchr$YEAR <- 2011
	
	LAUSD_Teacher_Links <- rbind.fill(LAUSD_Teacher_Links, tmp.tchr)
}

LAUSD_Teacher_Links$CONTENT_AREA <- factor(LAUSD_Teacher_Links$CONTENT_AREA)
LAUSD_Teacher_Links <- data.table(LAUSD_Teacher_Links, key="ID, CONTENT_AREA")

#unq.ids <- which(!duplicated(LAUSD_Teacher_Links)); length(unq.ids)
#dup.ids <- which(duplicated(LAUSD_Teacher_Links)); length(dup.ids) # Should be 0 duplicates.  2011, Check!

rm(lausd.tchr);rm(tchr.2011); rm(tmp.tchr); rm(dups);gc()


####  2010
###  Elementary Schools :: Collect all three periods
##  EP1

tchr.2010 <- read.delim("./California/Data/Base_Files/LAUSD/SY2009-10/ElementaryMarks2009_2010_EP1.txt", header=TRUE)
#table(tchr.2010$CRS_COURSE_CODE, tchr.2010$CRS_COURSE_NAME)

tchr.2010 <- tchr.2010[c(9:8, 2, 5, 7)]
names(tchr.2010) <- c("ID", "INSTRUCTOR_NUMBER", "MARKING_PERIOD", "SCHOOL_NUMBER", "CONTENT_AREA")
tchr.2010 <- tchr.2010[!is.na(tchr.2010$INSTRUCTOR_NUMBER),]
tchr.2010 <- tchr.2010[tchr.2010$CONTENT_AREA %in% c("MATHEMATICS", "READING", "ELD READING", "WRITING", "ELD WRITING", "HIST SOC SCI", "SCIENCE"),]
tchr.2010$CONTENT_AREA<-droplevels(tchr.2010$CONTENT_AREA)
levels(tchr.2010$CONTENT_AREA) <- c("ELA", "ELA", "HISTORY", "MATHEMATICS", "ELA", "SCIENCE", "ELA")

tchr.2010$ID <- factor(tchr.2010$ID)
tchr.2010$INSTRUCTOR_NUMBER <- factor(tchr.2010$INSTRUCTOR_NUMBER)

# Remove duplicates
tchr.2010 <- data.table(tchr.2010, key="CONTENT_AREA, SCHOOL_NUMBER, INSTRUCTOR_NUMBER, ID")
tchr.2010 <- tchr.2010[which(!duplicated(tchr.2010)),]

lausd.tchr <- tchr.2010

## EP2
tchr.2010 <- read.delim("./California/Data/Base_Files/LAUSD/SY2009-10/ElementaryMarks2009_2010_EP2.txt", header=TRUE)

tchr.2010 <- tchr.2010[c(9:8, 2, 5, 7)]
names(tchr.2010) <- c("ID", "INSTRUCTOR_NUMBER", "MARKING_PERIOD", "SCHOOL_NUMBER", "CONTENT_AREA")
tchr.2010 <- tchr.2010[!is.na(tchr.2010$INSTRUCTOR_NUMBER),]
tchr.2010 <- tchr.2010[tchr.2010$CONTENT_AREA %in% c("MATHEMATICS", "READING", "ELD READING", "WRITING", "ELD WRITING", "HIST SOC SCI", "SCIENCE"),]
tchr.2010$CONTENT_AREA<-droplevels(tchr.2010$CONTENT_AREA)
levels(tchr.2010$CONTENT_AREA) <- c("ELA", "ELA", "HISTORY", "MATHEMATICS", "ELA", "SCIENCE", "ELA")

tchr.2010$ID <- factor(tchr.2010$ID)
tchr.2010$INSTRUCTOR_NUMBER <- factor(tchr.2010$INSTRUCTOR_NUMBER)
tchr.2010 <- data.table(tchr.2010, key="CONTENT_AREA, SCHOOL_NUMBER, INSTRUCTOR_NUMBER, ID")
tchr.2010 <- tchr.2010[which(!duplicated(tchr.2010)),]

lausd.tchr <- rbind(lausd.tchr, tchr.2010)

## EP3
tchr.2010 <- read.delim("./California/Data/Base_Files/LAUSD/SY2009-10/ElementaryMarks2009_2010_EP3.txt", header=TRUE)

tchr.2010 <- tchr.2010[c(9:8, 2, 5, 7)]
names(tchr.2010) <- c("ID", "INSTRUCTOR_NUMBER", "MARKING_PERIOD", "SCHOOL_NUMBER", "CONTENT_AREA")
tchr.2010 <- tchr.2010[!is.na(tchr.2010$INSTRUCTOR_NUMBER),]
tchr.2010 <- tchr.2010[tchr.2010$CONTENT_AREA %in% c("MATHEMATICS", "READING", "ELD READING", "WRITING", "ELD WRITING", "HIST SOC SCI", "SCIENCE"),]
tchr.2010$CONTENT_AREA<-droplevels(tchr.2010$CONTENT_AREA)
levels(tchr.2010$CONTENT_AREA) <- c("ELA", "ELA", "HISTORY", "MATHEMATICS", "ELA", "SCIENCE", "ELA")

tchr.2010$ID <- factor(tchr.2010$ID)
tchr.2010$INSTRUCTOR_NUMBER <- factor(tchr.2010$INSTRUCTOR_NUMBER)
tchr.2010 <- data.table(tchr.2010, key="CONTENT_AREA, SCHOOL_NUMBER, INSTRUCTOR_NUMBER, ID")
tchr.2010 <- tchr.2010[which(!duplicated(tchr.2010)),]

lausd.tchr <- rbind(lausd.tchr, tchr.2010)


###  Secondary Schools :: add to Elem.
tchr.2010 <- read.delim("./California/Data/Base_Files/LAUSD/SY2009-10/SecondaryMarks2009_2010.txt", header=TRUE)

tchr.2010 <- tchr.2010[c(11:10, 2, 5, 6, 8)]
names(tchr.2010) <- c("ID", "INSTRUCTOR_NUMBER", "MARKING_PERIOD", "SCHOOL_NUMBER", "CONTENT_AREA", "COURSE_NAME")
tchr.2010 <- tchr.2010[!is.na(tchr.2010$INSTRUCTOR_NUMBER),]

#summary(tchr.2010$COURSE_NAME[tchr.2010$CONTENT_AREA == "INTERDISCIPLINARY"])
tchr.2010$CONTENT_AREA[tchr.2010$CONTENT_AREA == "INTERDISCIPLINARY"] <- "MATHEMATICS"
#tchr.2010[tchr.2010$CONTENT_AREA == "INTERDISCIPLINARY",] One "MATH" so add it in
#summary(tchr.2010$COURSE_NAME[tchr.2010$CONTENT_AREA == "UNKNOWN DEPARTMENT"]) # 'CAKE DECORATOR' - sign me up for that class!  - Voc classes ...
summary(tchr.2010$COURSE_NAME[tchr.2010$CONTENT_AREA == "SP ED:VOC ED F HAND"]) #  Lots of COURSES/INSTRCTORS we could add here.  Some big/obvious:

###  Adds about 25,000 courses
math.index <- grep("MATH",names(summary(tchr.2010$COURSE_NAME[tchr.2010$CONTENT_AREA == "SP ED:VOC ED F HAND"])))
ela.index <- c(grep("ELA",names(summary(tchr.2010$COURSE_NAME[tchr.2010$CONTENT_AREA == "SP ED:VOC ED F HAND"]))),
				grep("ENG",names(summary(tchr.2010$COURSE_NAME[tchr.2010$CONTENT_AREA == "SP ED:VOC ED F HAND"]))),
				grep("READ",names(summary(tchr.2010$COURSE_NAME[tchr.2010$CONTENT_AREA == "SP ED:VOC ED F HAND"]))),
				grep("WRIT",names(summary(tchr.2010$COURSE_NAME[tchr.2010$CONTENT_AREA == "SP ED:VOC ED F HAND"]))))
sci.index <- c(grep("SCI",names(summary(tchr.2010$COURSE_NAME[tchr.2010$CONTENT_AREA == "SP ED:VOC ED F HAND"]))))
hst.index <- c(grep("HIST",names(summary(tchr.2010$COURSE_NAME[tchr.2010$CONTENT_AREA == "SP ED:VOC ED F HAND"]))))
courses <- names(summary(tchr.2010$COURSE_NAME[tchr.2010$CONTENT_AREA == "SP ED:VOC ED F HAND"]))

for (i in math.index) {
	tchr.2010$CONTENT_AREA[tchr.2010$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2010$COURSE_NAME == courses[i] ] <- "MATHEMATICS"
}

for (i in ela.index) {
	tchr.2010$CONTENT_AREA[tchr.2010$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2010$COURSE_NAME == courses[i] ] <- "ENGLISH" # will change to ELA
}

for (i in sci.index) {
	tchr.2010$CONTENT_AREA[tchr.2010$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2010$COURSE_NAME == courses[i] ] <- "SCIENCE"
}

for (i in hst.index) {
	tchr.2010$CONTENT_AREA[tchr.2010$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2010$COURSE_NAME == courses[i] ] <- "SOCIAL SCIENCE"
}
#summary(tchr.2010$COURSE_NAME[tchr.2010$CONTENT_AREA == "SP ED:VOC ED F HAND"])


tchr.2010 <- tchr.2010[tchr.2010$CONTENT_AREA %in% c("BILINGUAL-ESL", "ENGLISH", "MATHEMATICS", "READING", "SCIENCE", "SOCIAL SCIENCE"),]
tchr.2010$CONTENT_AREA<-droplevels(tchr.2010$CONTENT_AREA)
levels(tchr.2010$CONTENT_AREA) <- c("ELA", "ELA", "MATHEMATICS", "ELA", "SCIENCE", "HISTORY")

tchr.2010$ID <- factor(tchr.2010$ID)
tchr.2010$INSTRUCTOR_NUMBER <- factor(tchr.2010$INSTRUCTOR_NUMBER)

#  Remove teachers in same Dept/Content_area in SAME classes in the SAME SEMESTER first
tchr.2010 <- data.table(tchr.2010, key="CONTENT_AREA, COURSE_NAME, MARKING_PERIOD, ID, INSTRUCTOR_NUMBER")
tchr.2010 <- tchr.2010[which(!duplicated(tchr.2010)),]

#  Remove teachers in same Content_area in multiple classes in the SAME SCHOOL & SEMESTER (hopefully similar to above)
key(tchr.2010) <- c("CONTENT_AREA", "SCHOOL_NUMBER", "MARKING_PERIOD", "INSTRUCTOR_NUMBER", "ID") #"COURSE_NAME", 
tchr.2010 <- tchr.2010[which(!duplicated(tchr.2010)),]

#  Remove teachers in same Content_area in multiple classes in the SAME SCHOOL (hopefully similar to above) - Different semester
key(tchr.2010) <- c("CONTENT_AREA", "SCHOOL_NUMBER", "MARKING_PERIOD", "INSTRUCTOR_NUMBER", "ID") # Get Fall period on top
key(tchr.2010) <- c("CONTENT_AREA", "SCHOOL_NUMBER", "INSTRUCTOR_NUMBER", "ID")
tchr.2010 <- tchr.2010[-(which(duplicated(tchr.2010))-1),] #takes the first line out - here FALL b/c alphabetical

#  Remove teachers in same Content_area in multiple classes in Different SCHOOL (looks like most are NA school numbers)
#key(tchr.2010) <- c("CONTENT_AREA", "SCHOOL_NUMBER", "INSTRUCTOR_NUMBER", "ID") # Get SCHOOL_NUMBER on top 
key(tchr.2010) <- c("CONTENT_AREA", "MARKING_PERIOD", "INSTRUCTOR_NUMBER", "ID") 
key(tchr.2010) <- c("CONTENT_AREA", "INSTRUCTOR_NUMBER", "ID") 
tchr.2010 <- tchr.2010[-(which(duplicated(tchr.2010))-1),] # Still take the LATER period - end of year

#  A few dups with same course and time period - different teachers.  Go back and add in Course grades to see if some are NA
#  Nope.  They all lok legit.  Same schools, period, class etc.  Different teachers and different 'marks'.
#  Just keep them and "WIDEN" out the file to put in multiple teachers

lausd.tchr <- data.table(rbind.fill(lausd.tchr, tchr.2010), key="CONTENT_AREA, ID")

#  Remove teachers that a student had more than one in a year.  Keep the LATEST period available (EP3 and SPRING)
key(lausd.tchr) <- c("ID", "MARKING_PERIOD", "INSTRUCTOR_NUMBER", "CONTENT_AREA") #"SCHOOL_NUMBER", 
key(lausd.tchr) <- c("ID", "INSTRUCTOR_NUMBER", "CONTENT_AREA") #"MARKING_PERIOD", "SCHOOL_NUMBER", 
lausd.tchr <- lausd.tchr[-(which(duplicated(lausd.tchr))-1),]

#  Now "WIDEN" the file by subject area
key(lausd.tchr) <- c("ID", "CONTENT_AREA")

# find unique teachers and "first" of multiple teachers (not sure how to rank these in terms of relevance or importance)
unq.ids <- which(!duplicated(lausd.tchr)); length(unq.ids)
dup.ids <- which(duplicated(lausd.tchr)); length(dup.ids)

lausd.tchr$TEACHER_COUNT <- NA
#  step 1 - assign unique and "first" teachers a 1
lausd.tchr$TEACHER_COUNT[unq.ids] <- 1
# step 2 add 1 to the first "duplicates"
lausd.tchr$TEACHER_COUNT[dup.ids] <- lausd.tchr$TEACHER_COUNT[dup.ids-1]+1
# step 3 add 1 to the NA's  -  Have to repeat up to a count of 7 in 2010 & 11 !!!
#summary(lausd.tchr$TEACHER_COUNT) 
while(any(is.na(lausd.tchr$TEACHER_COUNT))){
	lausd.tchr$TEACHER_COUNT[which(is.na(lausd.tchr$TEACHER_COUNT))] <- lausd.tchr$TEACHER_COUNT[which(is.na(lausd.tchr$TEACHER_COUNT))-1]+1
}
#summary(lausd.tchr$TEACHER_COUNT) 

lausd.tchr$TEACHER_COUNT <- factor(lausd.tchr$TEACHER_COUNT)
key(lausd.tchr) <- c("CONTENT_AREA", "TEACHER_COUNT")

#LAUSD_Teacher_Links object should be set up already ...
#LAUSD_Teacher_Links <- NULL
for (j in c("ELA", "MATHEMATICS", "SCIENCE", "HISTORY")) { 
	tmp.tchr <- reshape(lausd.tchr[J(j), mult='all'],
							idvar='ID',
							timevar='TEACHER_COUNT',
							drop=c('CONTENT_AREA', 'SCHOOL_NUMBER'),
							direction='wide',
							sep="_")

	tmp.tchr$CONTENT_AREA <- j
	tmp.tchr$YEAR <- 2010
	
	LAUSD_Teacher_Links <- rbind.fill(LAUSD_Teacher_Links, tmp.tchr)
}

#  Add year after 2011 to check for dups
LAUSD_Teacher_Links <- data.table(LAUSD_Teacher_Links, key="ID, CONTENT_AREA, YEAR")

rm(lausd.tchr);rm(tchr.2010); rm(tmp.tchr); rm(dups);gc()


####  2009
###  Elementary Schools :: Collect all three periods
##  EP1
tchr.2009 <- read.delim("./California/Data/Base_Files/LAUSD/SY2008-09/ElementaryMarks2008_2009_EP1.txt", header=TRUE)
#table(tchr.2009$CRS_COURSE_CODE, tchr.2009$CRS_COURSE_NAME)

tchr.2009 <- tchr.2009[c(9:8, 2, 5, 7)]
names(tchr.2009) <- c("ID", "INSTRUCTOR_NUMBER", "MARKING_PERIOD", "SCHOOL_NUMBER", "CONTENT_AREA")
tchr.2009 <- tchr.2009[!is.na(tchr.2009$INSTRUCTOR_NUMBER),]
tchr.2009 <- tchr.2009[tchr.2009$CONTENT_AREA %in% c("MATHEMATICS", "READING", "ELD READING", "WRITING", "ELD WRITING", "HIST SOC SCI", "SCIENCE"),]
tchr.2009$CONTENT_AREA<-droplevels(tchr.2009$CONTENT_AREA)
levels(tchr.2009$CONTENT_AREA) <- c("ELA", "ELA", "HISTORY", "MATHEMATICS", "ELA", "SCIENCE", "ELA")

tchr.2009$ID <- factor(tchr.2009$ID)
tchr.2009$INSTRUCTOR_NUMBER <- factor(tchr.2009$INSTRUCTOR_NUMBER)

# Remove duplicates
tchr.2009 <- data.table(tchr.2009, key="CONTENT_AREA, SCHOOL_NUMBER, INSTRUCTOR_NUMBER, ID")
tchr.2009 <- tchr.2009[which(!duplicated(tchr.2009)),]

lausd.tchr <- tchr.2009

## EP2
tchr.2009 <- read.delim("./California/Data/Base_Files/LAUSD/SY2008-09/ElementaryMarks2008_2009_EP2.txt", header=TRUE)

tchr.2009 <- tchr.2009[c(9:8, 2, 5, 7)]
names(tchr.2009) <- c("ID", "INSTRUCTOR_NUMBER", "MARKING_PERIOD", "SCHOOL_NUMBER", "CONTENT_AREA")
tchr.2009 <- tchr.2009[!is.na(tchr.2009$INSTRUCTOR_NUMBER),]
tchr.2009 <- tchr.2009[tchr.2009$CONTENT_AREA %in% c("MATHEMATICS", "READING", "ELD READING", "WRITING", "ELD WRITING", "HIST SOC SCI", "SCIENCE"),]
tchr.2009$CONTENT_AREA<-droplevels(tchr.2009$CONTENT_AREA)
levels(tchr.2009$CONTENT_AREA) <- c("ELA", "ELA", "HISTORY", "MATHEMATICS", "ELA", "SCIENCE", "ELA")

tchr.2009$ID <- factor(tchr.2009$ID)
tchr.2009$INSTRUCTOR_NUMBER <- factor(tchr.2009$INSTRUCTOR_NUMBER)
tchr.2009 <- data.table(tchr.2009, key="CONTENT_AREA, SCHOOL_NUMBER, INSTRUCTOR_NUMBER, ID")
tchr.2009 <- tchr.2009[which(!duplicated(tchr.2009)),]

lausd.tchr <- rbind(lausd.tchr, tchr.2009)

## EP3
tchr.2009 <- read.delim("./California/Data/Base_Files/LAUSD/SY2008-09/ElementaryMarks2008_2009_EP3.txt", header=TRUE)

tchr.2009 <- tchr.2009[c(9:8, 2, 5, 7)]
names(tchr.2009) <- c("ID", "INSTRUCTOR_NUMBER", "MARKING_PERIOD", "SCHOOL_NUMBER", "CONTENT_AREA")
tchr.2009 <- tchr.2009[!is.na(tchr.2009$INSTRUCTOR_NUMBER),]
tchr.2009 <- tchr.2009[tchr.2009$CONTENT_AREA %in% c("MATHEMATICS", "READING", "ELD READING", "WRITING", "ELD WRITING", "HIST SOC SCI", "SCIENCE"),]
tchr.2009$CONTENT_AREA<-droplevels(tchr.2009$CONTENT_AREA)
levels(tchr.2009$CONTENT_AREA) <- c("ELA", "ELA", "HISTORY", "MATHEMATICS", "ELA", "SCIENCE", "ELA")

tchr.2009$ID <- factor(tchr.2009$ID)
tchr.2009$INSTRUCTOR_NUMBER <- factor(tchr.2009$INSTRUCTOR_NUMBER)
tchr.2009 <- data.table(tchr.2009, key="CONTENT_AREA, SCHOOL_NUMBER, INSTRUCTOR_NUMBER, ID")
tchr.2009 <- tchr.2009[which(!duplicated(tchr.2009)),]

lausd.tchr <- rbind(lausd.tchr, tchr.2009)


###  Secondary Schools :: add to Elem.
tchr.2009 <- read.delim("./California/Data/Base_Files/LAUSD/SY2008-09/SecondaryMarks2008_2009.txt", header=TRUE)

tchr.2009 <- tchr.2009[c(11:10, 2, 5, 6, 8)]
names(tchr.2009) <- c("ID", "INSTRUCTOR_NUMBER", "MARKING_PERIOD", "SCHOOL_NUMBER", "CONTENT_AREA", "COURSE_NAME")
tchr.2009 <- tchr.2009[!is.na(tchr.2009$INSTRUCTOR_NUMBER),]

#summary(tchr.2009$COURSE_NAME[tchr.2009$CONTENT_AREA == "INTERDISCIPLINARY"])
#tchr.2009[tchr.2009$CONTENT_AREA == "INTERDISCIPLINARY",] two "ELA" so add it in
tchr.2009$CONTENT_AREA[tchr.2009$CONTENT_AREA == "INTERDISCIPLINARY"] <- "ENGLISH"
#summary(tchr.2009$COURSE_NAME[tchr.2009$CONTENT_AREA == "UNKNOWN DEPARTMENT"]) # 'CAKE DECORATOR' - sign me up for that class!  - Voc classes ...
summary(tchr.2009$COURSE_NAME[tchr.2009$CONTENT_AREA == "SP ED:VOC ED F HAND"]) #  Lots of COURSES/INSTRCTORS we could add here.  Some big/obvious:

###  Adds about 25,000 courses
math.index <- grep("MATH",names(summary(tchr.2009$COURSE_NAME[tchr.2009$CONTENT_AREA == "SP ED:VOC ED F HAND"])))
ela.index <- c(grep("ELA",names(summary(tchr.2009$COURSE_NAME[tchr.2009$CONTENT_AREA == "SP ED:VOC ED F HAND"]))),
				grep("ENG",names(summary(tchr.2009$COURSE_NAME[tchr.2009$CONTENT_AREA == "SP ED:VOC ED F HAND"]))),
				grep("READ",names(summary(tchr.2009$COURSE_NAME[tchr.2009$CONTENT_AREA == "SP ED:VOC ED F HAND"]))),
				grep("WRIT",names(summary(tchr.2009$COURSE_NAME[tchr.2009$CONTENT_AREA == "SP ED:VOC ED F HAND"]))))
sci.index <- c(grep("SCI",names(summary(tchr.2009$COURSE_NAME[tchr.2009$CONTENT_AREA == "SP ED:VOC ED F HAND"]))))
hst.index <- c(grep("HIST",names(summary(tchr.2009$COURSE_NAME[tchr.2009$CONTENT_AREA == "SP ED:VOC ED F HAND"]))))
courses <- names(summary(tchr.2009$COURSE_NAME[tchr.2009$CONTENT_AREA == "SP ED:VOC ED F HAND"]))

for (i in math.index) {
	tchr.2009$CONTENT_AREA[tchr.2009$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2009$COURSE_NAME == courses[i] ] <- "MATHEMATICS"
}

for (i in ela.index) {
	tchr.2009$CONTENT_AREA[tchr.2009$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2009$COURSE_NAME == courses[i] ] <- "ENGLISH" # will change to ELA
}

for (i in sci.index) {
	tchr.2009$CONTENT_AREA[tchr.2009$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2009$COURSE_NAME == courses[i] ] <- "SCIENCE"
}

for (i in hst.index) {
	tchr.2009$CONTENT_AREA[tchr.2009$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2009$COURSE_NAME == courses[i] ] <- "SOCIAL SCIENCE"
}
summary(tchr.2009$COURSE_NAME[tchr.2009$CONTENT_AREA == "SP ED:VOC ED F HAND"])



tchr.2009 <- tchr.2009[tchr.2009$CONTENT_AREA %in% c("BILINGUAL-ESL", "ENGLISH", "MATHEMATICS", "READING", "SCIENCE", "SOCIAL SCIENCE"),]
tchr.2009$CONTENT_AREA<-droplevels(tchr.2009$CONTENT_AREA)
levels(tchr.2009$CONTENT_AREA) <- c("ELA", "ELA", "MATHEMATICS", "ELA", "SCIENCE", "HISTORY")

tchr.2009$ID <- factor(tchr.2009$ID)
tchr.2009$INSTRUCTOR_NUMBER <- factor(tchr.2009$INSTRUCTOR_NUMBER)

#  Remove teachers in same Dept/Content_area in SAME classes in the SAME SEMESTER first
tchr.2009 <- data.table(tchr.2009, key="CONTENT_AREA, COURSE_NAME, MARKING_PERIOD, ID, INSTRUCTOR_NUMBER")
tchr.2009 <- tchr.2009[which(!duplicated(tchr.2009)),]

#  Remove teachers in same Content_area in multiple classes in the SAME SCHOOL & SEMESTER (hopefully similar to above)
key(tchr.2009) <- c("CONTENT_AREA", "SCHOOL_NUMBER", "MARKING_PERIOD", "INSTRUCTOR_NUMBER", "ID") #"COURSE_NAME", 
tchr.2009 <- tchr.2009[which(!duplicated(tchr.2009)),]

#  Remove teachers in same Content_area in multiple classes in the SAME SCHOOL (hopefully similar to above) - Different semester
key(tchr.2009) <- c("CONTENT_AREA", "SCHOOL_NUMBER", "MARKING_PERIOD", "INSTRUCTOR_NUMBER", "ID") # Get Fall period on top
key(tchr.2009) <- c("CONTENT_AREA", "SCHOOL_NUMBER", "INSTRUCTOR_NUMBER", "ID")
tchr.2009 <- tchr.2009[-(which(duplicated(tchr.2009))-1),] #takes the first line out - here FALL b/c alphabetical

#  Remove teachers in same Content_area in multiple classes in Different SCHOOL (looks like most are NA school numbers)
#key(tchr.2009) <- c("CONTENT_AREA", "SCHOOL_NUMBER", "INSTRUCTOR_NUMBER", "ID") # Get SCHOOL_NUMBER on top 
key(tchr.2009) <- c("CONTENT_AREA", "MARKING_PERIOD", "INSTRUCTOR_NUMBER", "ID") 
key(tchr.2009) <- c("CONTENT_AREA", "INSTRUCTOR_NUMBER", "ID") 
tchr.2009 <- tchr.2009[-(which(duplicated(tchr.2009))-1),] # Still take the LATER period - end of year

#  A few dups with same course and time period - different teachers.
#  Just keep them and "WIDEN" out the file to put in multiple teachers

lausd.tchr <- data.table(rbind.fill(lausd.tchr, tchr.2009), key="CONTENT_AREA, ID")

lausd.tchr <- lausd.tchr

#  Remove teachers that a student had more than one in a year.  Keep the LATEST period available (EP3 and SPRING)

# reverse the order of Marking period to get latest on top (i.e. the !duplicated first sorted row)

key(lausd.tchr) <- c("ID", "MARKING_PERIOD", "INSTRUCTOR_NUMBER", "CONTENT_AREA") #"SCHOOL_NUMBER", 
key(lausd.tchr) <- c("ID", "INSTRUCTOR_NUMBER", "CONTENT_AREA") #"MARKING_PERIOD", "SCHOOL_NUMBER", 
lausd.tchr <- lausd.tchr[-(which(duplicated(lausd.tchr))-1),]

#  Now "WIDEN" the file by subject area
key(lausd.tchr) <- c("ID", "CONTENT_AREA")

# find unique teachers and "first" of multiple teachers (not sure how to rank these in terms of relevance or importance)
unq.ids <- which(!duplicated(lausd.tchr)); length(unq.ids)
dup.ids <- which(duplicated(lausd.tchr)); length(dup.ids)

lausd.tchr$TEACHER_COUNT <- NA
#  step 1 - assign unique and "first" teachers a 1
lausd.tchr$TEACHER_COUNT[unq.ids] <- 1
# step 2 add 1 to the first "duplicates"
lausd.tchr$TEACHER_COUNT[dup.ids] <- lausd.tchr$TEACHER_COUNT[dup.ids-1]+1
# step 3 add 1 to the NA's  -  Have to repeat up to a count of 8 in 2009 !!!
#summary(lausd.tchr$TEACHER_COUNT) 
while(any(is.na(lausd.tchr$TEACHER_COUNT))){
	lausd.tchr$TEACHER_COUNT[which(is.na(lausd.tchr$TEACHER_COUNT))] <- lausd.tchr$TEACHER_COUNT[which(is.na(lausd.tchr$TEACHER_COUNT))-1]+1
}
#summary(lausd.tchr$TEACHER_COUNT) 

lausd.tchr$TEACHER_COUNT <- factor(lausd.tchr$TEACHER_COUNT)
key(lausd.tchr) <- c("CONTENT_AREA", "TEACHER_COUNT")

#LAUSD_Teacher_Links object should be set up already ...
#LAUSD_Teacher_Links <- NULL
for (j in c("ELA", "MATHEMATICS", "SCIENCE", "HISTORY")) { 
	tmp.tchr <- reshape(lausd.tchr[J(j), mult='all'],
							idvar='ID',
							timevar='TEACHER_COUNT',
							drop=c('CONTENT_AREA', 'SCHOOL_NUMBER'),
							direction='wide',
							sep="_")

	tmp.tchr$CONTENT_AREA <- j
	tmp.tchr$YEAR <- 2009
	
	LAUSD_Teacher_Links <- rbind.fill(LAUSD_Teacher_Links, tmp.tchr)
}

#  Add year after 2011 to check for dups
LAUSD_Teacher_Links <- data.table(LAUSD_Teacher_Links, key="ID, CONTENT_AREA, YEAR")

rm(lausd.tchr);rm(tchr.2009); rm(tmp.tchr); rm(dups);gc()
save(LAUSD_Teacher_Links, file="./California/Data/LAUSD_Teacher_Links.Rdata", compress="bzip2")


####
####  Merge the Teacher links into LAUSD test data
####

key(LAUSD_Teacher_Links) <- c("ID", "CONTENT_AREA", "YEAR")
key(LAUSD_Data_LONG) <- c("ID", "CONTENT_AREA", "YEAR")

LAUSD_Data_LONG <- LAUSD_Teacher_Links[LAUSD_Data_LONG, mult='all']

#  Some of the sparse teacher links didn't match up (thank god!).  Get rid of them and those related to them:
LAUSD_Data_LONG$INSTRUCTOR_NUMBER_8 <- NULL
LAUSD_Data_LONG$MARKING_PERIOD_8 <- NULL
LAUSD_Data_LONG$COURSE_NAME_8 <- NULL
LAUSD_Data_LONG$SCHCDSCODE <- NULL # Has NA's - use the one from the STAR data file
LAUSD_Data_LONG$TESTGRADELEVEL <- NULL # Same as GRADE - both come from STAR data file
LAUSD_Data_LONG$GRADECODE <- NULL
LAUSD_Data_LONG$RECTYPE <- NULL # information captured in the TEST_NAME and TEST_TYPE
LAUSD_Data_LONG$PROFICIENCY_LEVEL_PROVIDED <- NULL # Recoded into ACHIEVEMENT_LEVEL
LAUSD_Data_LONG$LAUSD_TEST_CODE <- NULL # information captured in the TEST_NAME

LAUSD_Data_LONG$GENDER <- NULL  # Not sure which is "better" - keep the one from the Demographic file?  Data file might be what kids put in?
levels(LAUSD_Data_LONG$GENDERCODE) <- c('Gender: Female', 'Gender: Male')
names(LAUSD_Data_LONG)[29] <- "GENDER" # Check position first!

#  ADD these vars in to match the CMO file
LAUSD_Data_LONG$CMO <- "LAUSD"
LAUSD_Data_LONG$CMO <- factor(LAUSD_Data_LONG$CMO, levels=c(1:4, "LAUSD"), labels = c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))  # ? LAUSD as NA?

LAUSD_Data_LONG$SCHOOL_NUMBER <- factor(LAUSD_Data_LONG$SCHOOL_NUMBER) #  Change these too - some CMOs are numeric, some are factors

LAUSD_Data_LONG$INSTRUCTOR_NUMBER_1 <- factor(LAUSD_Data_LONG$INSTRUCTOR_NUMBER_1) #  added below too
LAUSD_Data_LONG$INSTRUCTOR_NUMBER_2 <- factor(LAUSD_Data_LONG$INSTRUCTOR_NUMBER_2)

LAUSD_Data_LONG$DISTRICT_NAME <- "Los Angeles Unified School District"; LAUSD_Data_LONG$DISTRICT_NAME <- factor(LAUSD_Data_LONG$DISTRICT_NAME)
LAUSD_Data_LONG$DISTRICT_NUMBER<-1964733

#  Added stuff for LAUSD's Schools, but this function only works on FULL character strings (not substrings) - will have to get cleaver if needed.
sch.names <- sapply(levels(LAUSD_Data_LONG$SCHOOL_NAME), function(x) 
		paste(sapply(strsplit(x, split=" ")[[1]], capwords), collapse=" "), USE.NAMES=FALSE)
levels(LAUSD_Data_LONG$SCHOOL_NAME) <- sch.names

LAUSD_Data_LONG$ACHIEVEMENT_LEVEL <- factor(LAUSD_Data_LONG$ACHIEVEMENT_LEVEL, levels = c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"), labels =c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"), ordered=TRUE)

save(LAUSD_Data_LONG, file="./California/Data/LAUSD_Data_LONG.Rdata", compress="bzip2")

#####  See LAUSD_LONG.R for Stuff I did to check out the missing teacher links from the first go-around:




### ### ### ### ### ### ### ### ### ### ### ###
###			Merge the CMO & LAUSD files
### ### ### ### ### ### ### ### ### ### ### ###

###  Final completion of California_Data_LONG

load("./California/Data/LAUSD_Data_LONG.Rdata")
load("./California/Data/CMO_Data_LONG.Rdata")

LAUSD_Data_LONG$INSTRUCTOR_NUMBER_1 <- factor(LAUSD_Data_LONG$INSTRUCTOR_NUMBER_1) #  added above too
LAUSD_Data_LONG$INSTRUCTOR_NUMBER_2 <- factor(LAUSD_Data_LONG$INSTRUCTOR_NUMBER_2)

California_Data_LONG <- rbind.fill(LAUSD_Data_LONG, CMO_Data_LONG)

#  Don't use the changed grade method any more (after 3/11/12)

# #  Eye towards analyses:  What course sequences to look at:
# California_Data_LONG[['ORIGINAL_GRADE']] <- California_Data_LONG[['GRADE']]

# #  Make them totally outside of the range of normal GRADE
# California_Data_LONG[['GRADE']][California_Data_LONG[['TEST_NAME']] == "ALGEBRA_I"] <- 13
# California_Data_LONG[['GRADE']][California_Data_LONG[['TEST_NAME']] == "GEOMETRY"] <- 14
# California_Data_LONG[['GRADE']][California_Data_LONG[['TEST_NAME']] == "ALGEBRA_II"] <- 15
# California_Data_LONG[['GRADE']][California_Data_LONG[['TEST_NAME']] == "SUMMATIVE_HS_MATHEMATICS"] <- 16
# California_Data_LONG[['GRADE']][California_Data_LONG[['TEST_NAME']] == "INTEGRATED_MATHEMATICS_1"] <- 17
# California_Data_LONG[['GRADE']][California_Data_LONG[['TEST_NAME']] == "INTEGRATED_MATHEMATICS_2"] <- 18
# California_Data_LONG[['GRADE']][California_Data_LONG[['TEST_NAME']] == "INTEGRATED_MATHEMATICS_3"] <- 19

summary(California_Data_LONG[['SCALE_SCORE']][California_Data_LONG[['VALID_CASE']]=="VALID_CASE" & California_Data_LONG[['CONTENT_AREA']]=="ELA"])

California_Data_LONG[['VALID_CASE']][California_Data_LONG[['SCALE_SCORE']] < 150 & California_Data_LONG[['CONTENT_AREA']]=="ELA"] <- "INVALID_CASE"
California_Data_LONG[['VALID_CASE']][California_Data_LONG[['CONTENT_AREA']]=="ELA" & California_Data_LONG[['GRADE']]==12] <- "INVALID_CASE"
California_Data_LONG[['VALID_CASE']][California_Data_LONG[['SCALE_SCORE']] < 150 & California_Data_LONG[['CONTENT_AREA']]=="MATHEMATICS"] <- "INVALID_CASE"
California_Data_LONG[['VALID_CASE']][California_Data_LONG[['SCALE_SCORE']] < 150 & California_Data_LONG[['CONTENT_AREA']]=="HISTORY"] <- "INVALID_CASE"
California_Data_LONG[['VALID_CASE']][California_Data_LONG[['SCALE_SCORE']] < 150 & California_Data_LONG[['CONTENT_AREA']]=="SCIENCE"] <- "INVALID_CASE"

California_Data_LONG[['VALID_CASE']][California_Data_LONG[['TEST_TYPE']] !="CST"] <- "INVALID_CASE"

#  this one came back to bite me in the ass in the student growth reports - take the time to change/add these cases in
# California_Data_LONG[["VALID_CASE"]][is.na(California_Data_LONG[["ACHIEVEMENT_LEVEL"]])] <- "INVALID_CASE"

###  Performance Level Coding function

perlev.recode <- function(scale_scores, state, content_area, grade) {
	findInterval(scale_scores, SGPstateData[[state]][["Achievement"]][["Cutscores"]][[as.character(content_area)]][[paste("GRADE_", grade, sep="")]])+1
}

#  Just use the grades transformed after MATH...
#source("/Volumes/Data/Dropbox/CENTER/SGP/California/CA_stateData_2.R") #  CA_stateData_2.R  has the course specific cutscores

#  MUST KEY ON THESE TWO FIRST!!!
California_Data_LONG <- data.table(California_Data_LONG, key="CONTENT_AREA, GRADE") #  Make sure GRADE is transformed first (see above) 

#  First convert ACH_LEVEL back to an integer!
California_Data_LONG[['ACHIEVEMENT_LEVEL_PROVIDED']] <- California_Data_LONG[['ACHIEVEMENT_LEVEL']]
California_Data_LONG[['ACHIEVEMENT_LEVEL']] <- NULL

California_Data_LONG[['ACHIEVEMENT_LEVEL']] <- NA
California_Data_LONG[['ACHIEVEMENT_LEVEL']][California_Data_LONG[['CONTENT_AREA']] %in% c("ELA", "MATHEMATICS") & California_Data_LONG[['VALID_CASE']]=="VALID_CASE" & California_Data_LONG[['TEST_TYPE']]=="CST"] <- California_Data_LONG[, perlev.recode(SCALE_SCORE, "CA", CONTENT_AREA[1], GRADE[1]), 
	by=list(CONTENT_AREA, GRADE)]$V1[California_Data_LONG[['CONTENT_AREA']] %in% c("ELA", "MATHEMATICS") & California_Data_LONG[['VALID_CASE']]=="VALID_CASE"  & California_Data_LONG[['TEST_TYPE']]=="CST"]

#  Weed out the 9th grade (and others) general math scores/prof levels
summary(California_Data_LONG[['ACHIEVEMENT_LEVEL']][California_Data_LONG[['CONTENT_AREA']]=="MATHEMATICS" & California_Data_LONG[['GRADE']] > 8  & California_Data_LONG[['GRADE']] < 13])
California_Data_LONG[['ACHIEVEMENT_LEVEL']][California_Data_LONG[['CONTENT_AREA']]=="MATHEMATICS" & California_Data_LONG[['GRADE']] > 8  & California_Data_LONG[['GRADE']] < 13] <- NA


###################  Fix ACH LEVELS for Hist/SCI:
source('/Volumes/Data/Dropbox/CENTER/SGP/California/CA_stateData_4.R')
source('/home/avi/Dropbox/CENTER/SGP/California/CA_stateData_4.R')

#  Do Grade Level Science and History First:
California_SGP@Data[['ACHIEVEMENT_LEVEL']][California_SGP@Data[['CONTENT_AREA']] %in% c('SCIENCE', 'HISTORY') & California_SGP@Data[['VALID_CASE']]=="VALID_CASE" & California_SGP@Data[['TEST_TYPE']]=="CST"] <- California_SGP@Data[, perlev.recode(SCALE_SCORE, "CA", CONTENT_AREA[1], GRADE[1]), by=list(CONTENT_AREA, GRADE)]$V1[
	California_SGP@Data[['CONTENT_AREA']] %in% c('SCIENCE', 'HISTORY') & California_SGP@Data[['VALID_CASE']]=="VALID_CASE" & California_SGP@Data[['TEST_TYPE']]=="CST"]


#Convert grade to year and 
California_SGP@Data[['TMP_GRADE']] <- California_SGP@Data[['GRADE']] 
California_SGP@Data[['GRADE']] <- California_SGP@Data[['YEAR']] 

setkeyv(California_SGP@Data, c("CONTENT_AREA", "GRADE"))

California_SGP@Data[['ACHIEVEMENT_LEVEL']][is.na(California_SGP@Data[['ACHIEVEMENT_LEVEL']]) & California_SGP@Data[['VALID_CASE']]=="VALID_CASE" & California_SGP@Data[['TEST_TYPE']]=="CST"] <- California_SGP@Data[, perlev.recode(SCALE_SCORE, "CA", CONTENT_AREA[1], GRADE[1]), by=list(CONTENT_AREA, GRADE)]$V1[
	is.na(California_SGP@Data[['ACHIEVEMENT_LEVEL']]) & California_SGP@Data[['VALID_CASE']]=="VALID_CASE" & California_SGP@Data[['TEST_TYPE']]=="CST"]
	
California_SGP@Data[['GRADE']] <- California_SGP@Data[['TMP_GRADE']]

table(as.factor(California_SGP@Data[['ACHIEVEMENT_LEVEL']]), California_SGP@Data[['CONTENT_AREA']])

California_SGP@Data[['ACHIEVEMENT_LEVEL']][California_SGP@Data[['CONTENT_AREA']] %in% c('INTEGRATED_SCIENCE_1', 'INTEGRATED_SCIENCE_2', 'INTEGRATED_SCIENCE_3', 'INTEGRATED_SCIENCE_4', 'EARTH_SCIENCE', 'CST_MATH_CODE_8', 'MULTIPLE_SCIENCE')] <- NA


#  Sanity Checks !!!
table(California_Data_LONG[['ACHIEVEMENT_LEVEL']][California_Data_LONG[['CONTENT_AREA']] %in% c("ELA", "MATHEMATICS") & California_Data_LONG[['TEST_TYPE']]=="CST"], California_Data_LONG[['ACHIEVEMENT_LEVEL_PROVIDED']][California_Data_LONG[['CONTENT_AREA']] %in% c("ELA", "MATHEMATICS") & California_Data_LONG[['TEST_TYPE']]=="CST"], California_Data_LONG[['VALID_CASE']][California_Data_LONG[['CONTENT_AREA']] %in% c("ELA", "MATHEMATICS") & California_Data_LONG[['TEST_TYPE']]=="CST"], 
 California_Data_LONG[['CONTENT_AREA']][California_Data_LONG[['CONTENT_AREA']] %in% c("ELA", "MATHEMATICS") & California_Data_LONG[['TEST_TYPE']]=="CST"])


California_Data_LONG[['ACHIEVEMENT_LEVEL']] <- ordered(California_Data_LONG[['ACHIEVEMENT_LEVEL']], levels = 1:5, labels=c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

cc <- California_Data_LONG[!is.na(California_Data_LONG[['ACHIEVEMENT_LEVEL']]) & California_Data_LONG[['ACHIEVEMENT_LEVEL']] != California_Data_LONG[['ACHIEVEMENT_LEVEL_PROVIDED']] & California_Data_LONG[['CONTENT_AREA']]=="MATHEMATICS",][, c("CMO", "ID", "YEAR", "TEST_NAME", "CONTENT_AREA", "GRADE", "SCALE_SCORE", "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_PROVIDED"), with=FALSE]

# cc[100:156,]

cc <- California_Data_LONG[!is.na(California_Data_LONG[['ACHIEVEMENT_LEVEL']]) & California_Data_LONG[['ACHIEVEMENT_LEVEL']] != California_Data_LONG[['ACHIEVEMENT_LEVEL_PROVIDED']] &  California_Data_LONG[['CONTENT_AREA']]=="ELA",][, c("CMO", "ID", "YEAR", "TEST_NAME", "CONTENT_AREA", "GRADE", "SCALE_SCORE", "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_PROVIDED"), with=FALSE]


###  Make sure all ID factors are the same accross data sets
California_Data_LONG[['ID']][1:15]
California_Data_LONG[['ID']] <- as.character(California_Data_LONG[['ID']])
California_Data_LONG[['ID']][California_Data_LONG$ID== '7104090576' & California_Data_LONG$CMO=='PUC'] <- '7104090576_PUC'
California_Data_LONG[['ID']] <- factor(California_Data_LONG[['ID']])

levels(California_Data_LONG$INSTRUCTOR_NUMBER_1)[25719] <- NA

#  Some duplicates across CMO's  #  AVI - Not seeing it now - 1/20/12  -  not after fixing INST ID to be a factor... (?)
key.og <- c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID")

key(California_Data_LONG) <- c(key.og, "TEST_NAME", "INSTRUCTOR_NUMBER_1", "GRADE", "SCALE_SCORE") # CMOs will not have data on other CMOs teachers, so sort out NA's here
dups <- data.table(California_Data_LONG[c(which(duplicated(California_Data_LONG))-1, which(duplicated(California_Data_LONG))),], key="YEAR, CONTENT_AREA, TEST_NAME, GRADE, ID, SCALE_SCORE") #  All LAUSD
California_Data_LONG[["VALID_CASE"]][which(duplicated(California_Data_LONG))-1] <- "INVALID_CASE"

key(California_Data_LONG) <- c(key.og, "TEST_NAME", "INSTRUCTOR_NUMBER_1", "GRADE")
dups <- data.table(California_Data_LONG[c(which(duplicated(California_Data_LONG))-1, which(duplicated(California_Data_LONG))),], key="ID, YEAR, CONTENT_AREA, TEST_NAME, GRADE") #
California_Data_LONG[["VALID_CASE"]][which(duplicated(California_Data_LONG))-1] <- "INVALID_CASE" #  Only 2 students from Green Dot (all others from LAUSD) - take highest score here

#  Some duplicates with different GRADE levels in the same year, but those should sort themselves out in the analyses

#  Here's where I'm seeing CMO duplicates of students
key(California_Data_LONG) <- c(key.og[-2], "TEST_NAME", "GRADE", "INSTRUCTOR_NUMBER_1")
key(California_Data_LONG) <- c(key.og[-2], "TEST_NAME", "GRADE")
dup.idx <- which(duplicated(California_Data_LONG))
dups1 <- data.table(California_Data_LONG[c(dup.idx-1, dup.idx),], key="ID, TEST_NAME, YEAR")
dups2 <- dups1[dups1[, VALID_CASE=="VALID_CASE"]]
dups1[dups1[,CMO=="Alliance"]]

California_Data_LONG[["VALID_CASE"]][which(duplicated(California_Data_LONG))-1] <- "INVALID_CASE" # Takes out the NA instructors (maybe a handful of others, but hard to say which should stay and which go...)

#  Some duplicates with different GRADE levels in the same year - sort themselves out in the analyses, but screws up combineSGP and projections (makes multiple projections for students)

California_Data_LONG[['VALID_CASE']][California_Data_LONG$ID=='1105319553' & California_Data_LONG$CONTENT_AREA=="ELA" & California_Data_LONG$YEAR==2010  & California_Data_LONG$GRADE==8] <- 'INVALID_CASE'
California_Data_LONG[['VALID_CASE']][California_Data_LONG$ID=='6054956954' & California_Data_LONG$CONTENT_AREA=="ELA" & California_Data_LONG$YEAR==2010  & California_Data_LONG$GRADE==8] <- 'INVALID_CASE'
California_Data_LONG[['VALID_CASE']][California_Data_LONG$ID=='9055137881' & California_Data_LONG$CONTENT_AREA=="ELA" & California_Data_LONG$YEAR==2010  & California_Data_LONG$GRADE==8] <- 'INVALID_CASE'
# California_Data_LONG[['VALID_CASE']][California_Data_LONG$ID== '7104090576'] <- 'VALID_CASE' # Make all cases Valid


key(California_Data_LONG) <- c(key.og, "TEST_NAME", "INSTRUCTOR_NUMBER_1", "GRADE")
key(California_Data_LONG) <- c(key.og, "TEST_NAME", "INSTRUCTOR_NUMBER_1")
dups <- data.table(California_Data_LONG[c(which(duplicated(California_Data_LONG))-1, which(duplicated(California_Data_LONG))),], key="ID, YEAR, CONTENT_AREA, TEST_NAME, GRADE") #
dups[dups[,CMO=="Green Dot"]]

California_Data_LONG[["VALID_CASE"]][which(duplicated(California_Data_LONG))-1] <- "INVALID_CASE" #  take highest grade here - looks like all the duplicate grades in PUC and Green Dot needed to be the highest grade...



# Make names prettier
trimWhiteSpace <- function(line) gsub("(^ +)|( +$)", "", line)
California_Data_LONG[['FIRST_NAME']]<- trimWhiteSpace(California_Data_LONG[['FIRST_NAME']])
California_Data_LONG[['LAST_NAME']] <- trimWhiteSpace(California_Data_LONG[['LAST_NAME']])

California_Data_LONG[['FIRST_NAME']] <- factor(California_Data_LONG[['FIRST_NAME']])
California_Data_LONG[['LAST_NAME']] <- factor(California_Data_LONG[['LAST_NAME']])


#Clean up the SCHOOL NAMES - added 1/03/11
split.sym <- c(" @ ", " @", "@"," # ", " #", "#", "/", "rfk", " (MASS)", "(k-12)")
split.fix <- c(rep(" at ", 3), rep(" No. ", 3), "-", "RFK", "", "K-12")

for (f in 1:length(split.sym)) {
	levels(California_Data_LONG[['SCHOOL_NAME']]) <- gsub(split.sym[f], split.fix[f], levels(California_Data_LONG[['SCHOOL_NAME']]))
}

#######   Changes below made 3/10/12:

#  Just use the original grade
California_Data_LONG[['GRADE']] <- California_Data_LONG[['ORIGINAL_GRADE']] 

setnames(California_Data_LONG, "TEST_NAME", "SUBJECT")

	levels(California_Data_LONG[['SUBJECT']]) <- c(levels(California_Data_LONG[['SUBJECT']])[1:38], "US_HISTORY", "US_HISTORY", "WORLD_HISTORY")
	#  History and US History labeled inconsistently.  This is how it "should" be...
	California_Data_LONG[['SUBJECT']][California_Data_LONG[['SUBJECT']]=="US_HISTORY" & California_Data_LONG[['GRADE']]==8] <- "HISTORY"
	California_Data_LONG[['SUBJECT']][California_Data_LONG[['SUBJECT']]=="HISTORY" & California_Data_LONG[['GRADE']]==11] <- "US_HISTORY"
	
	# Fix 10th grade 'Science' courses (mostly LAUSD)
	California_Data_LONG[['SUBJECT']][California_Data_LONG[['SUBJECT']]=="SCIENCE" & California_Data_LONG[['GRADE']]==10] <- "LIFE_SCIENCE"
	# Opposite problem for Alliance 8th grade
	California_Data_LONG[['SUBJECT']][California_Data_LONG[['SUBJECT']]=="LIFE_SCIENCE" & California_Data_LONG[['GRADE']]==8] <- "SCIENCE"

	#  Change "GRADE_LEVEL_MATHEMATICS" back to "MATHEMATICS" and 8th and 9th grade "GRADE_LEVEL_MATHEMATICS" to "GENERAL_MATHEMATICS"
	levels(California_Data_LONG[['SUBJECT']]) <- c(levels(California_Data_LONG[['SUBJECT']]), "GENERAL_MATHEMATICS")
	California_Data_LONG[['SUBJECT']][California_Data_LONG[['SUBJECT']]=="GRADE_LEVEL_MATHEMATICS" & California_Data_LONG[['GRADE']] %in% c(8,9)] <- "GENERAL_MATHEMATICS"
	levels(California_Data_LONG[['SUBJECT']])[23] <- "MATHEMATICS"

#  Set up Knots and Boundaries
setkeyv(California_Data_LONG, c("VALID_CASE","SUBJECT","YEAR","ID", "SCALE_SCORE"))
setkeyv(California_Data_LONG, c("VALID_CASE","SUBJECT","YEAR","ID"))
dups <- California_Data_LONG[sort(unique(c(which(duplicated(California_Data_LONG))-1, which(duplicated(California_Data_LONG))))),]

California_Data_LONG[['VALID_CASE']][which(duplicated(California_Data_LONG))-1] <- "INVALID_CASE"



setkeyv(California_Data_LONG, c("VALID_CASE", "SUBJECT", "GRADE"))

Ks <- California_Data_LONG[, as.list(as.vector(unlist(round(quantile(SCALE_SCORE, probs=c(0.2,0.4,0.6,0.8), na.rm=TRUE),digits=3)))),
					by=list(VALID_CASE, SUBJECT, GRADE)][VALID_CASE=="VALID_CASE",][!is.na(GRADE)]

Bs <- California_Data_LONG[, as.list(as.vector(round(extendrange(SCALE_SCORE, f=0.1), digits=3))),
 				   by=list(VALID_CASE, SUBJECT, GRADE)][VALID_CASE=="VALID_CASE",][!is.na(GRADE)]

lhoss <- California_Data_LONG[, as.list(as.vector(round(extendrange(SCALE_SCORE, f=0.0), digits=3))),
 				   by=list(VALID_CASE, SUBJECT, GRADE)][VALID_CASE=="VALID_CASE",][!is.na(GRADE)]

Knots_Boundaries <- list()

Ks <- Ks[-which(SUBJECT=="MATHEMATICS" & GRADE>7)]
Bs <- Bs[-which(SUBJECT=="MATHEMATICS" & GRADE>7)]
lhoss <- lhoss[-which(SUBJECT=="MATHEMATICS" & GRADE>7)]

Ks <- Ks[-which(SUBJECT=="SCIENCE" & !GRADE %in% c(5,8))]
Bs <- Bs[-which(SUBJECT=="SCIENCE" & !GRADE %in% c(5,8))]
lhoss <- lhoss[-which(SUBJECT=="SCIENCE" & !GRADE %in% c(5,8))]

#for (ca in c(unique(Ks[["SUBJECT"]]))) {  #Course sequences in Science and History not worked out in GRADE yet
for (ca in c("ELA", "MATHEMATICS", "SCIENCE", "HISTORY")) {
	tmp <- Ks[SUBJECT==ca,]
	for (g in tmp[,GRADE]) {
		Knots_Boundaries[[ca]][[paste("knots_", g, sep="")]] <- c(tmp[GRADE==g,V1], tmp[GRADE==g,V2], tmp[GRADE==g,V3], tmp[GRADE==g,V4])
	}
}
for (ca in c("ELA", "MATHEMATICS", "SCIENCE", "HISTORY")) {
	tmp <- Bs[SUBJECT==ca,]
	for (g in tmp[,GRADE]) {
		Knots_Boundaries[[ca]][[paste("boundaries_", g, sep="")]] <- c(tmp[GRADE==g,V1], tmp[GRADE==g,V2])
	}
}
for (ca in c("ELA", "MATHEMATICS", "SCIENCE", "HISTORY")) {
	tmp <- lhoss[SUBJECT==ca,]
	for (g in tmp[,GRADE]) {
		Knots_Boundaries[[ca]][[paste("loss.hoss_", g, sep="")]] <- c(tmp[GRADE==g,V1], tmp[GRADE==g,V2])
	}
}

Ks <- Ks[c(which(SUBJECT== "MATHEMATICS" & GRADE == 7), which(GRADE == 8))] #  Need science and history 8th grade for other priors.  Also ELA, - take 8th grade for all grades (they are all close anyways)
Bs <- Bs[c(which(SUBJECT== "MATHEMATICS" & GRADE == 7), which(GRADE == 8))]
lhoss <- lhoss[c(which(SUBJECT== "MATHEMATICS" & GRADE == 7), which(GRADE == 8))]

for (ca in c("ELA", "MATHEMATICS", "SCIENCE", "HISTORY")) {
	tmp <- Ks[SUBJECT==ca,]
	for (g in 2009:2010) {
		Knots_Boundaries[[ca]][[paste("knots_", g, sep="")]] <- c(tmp[['V1']], tmp[['V2']], tmp[['V3']], tmp[['V4']])
	}
}
for (ca in c("ELA", "MATHEMATICS", "SCIENCE", "HISTORY")) {
	tmp <- Bs[SUBJECT==ca,]
	for (g in 2009:2010) {
		Knots_Boundaries[[ca]][[paste("boundaries_", g, sep="")]] <- c(tmp[['V1']], tmp[['V2']])
	}
}
for (ca in c("ELA", "MATHEMATICS", "SCIENCE", "HISTORY")) {
	tmp <- lhoss[SUBJECT==ca,]
	for (g in 2009:2010) {
		Knots_Boundaries[[ca]][[paste("loss.hoss_", g, sep="")]] <- c(tmp[['V1']], tmp[['V2']])
	}
}

# HS Courses across years and grades

Ks <- California_Data_LONG[, as.list(as.vector(unlist(round(quantile(SCALE_SCORE, probs=c(0.2,0.4,0.6,0.8), na.rm=TRUE),digits=3)))),
					by=list(VALID_CASE, SUBJECT)][VALID_CASE=="VALID_CASE",]#[GRADE==5 | GRADE==8]#[!is.na(GRADE)]

Bs <- California_Data_LONG[, as.list(as.vector(round(extendrange(SCALE_SCORE, f=0.1), digits=3))),
 				   by=list(VALID_CASE, SUBJECT)][VALID_CASE=="VALID_CASE",]

lhoss <- California_Data_LONG[, as.list(as.vector(round(extendrange(SCALE_SCORE, f=0.0), digits=3))),
 				   by=list(VALID_CASE, SUBJECT)][VALID_CASE=="VALID_CASE",]

for (ca in c('GENERAL_MATHEMATICS')) {
	tmp <- Ks[SUBJECT==ca,]
	for (g in 8:9) {
		Knots_Boundaries[[ca]][[paste("knots_", g, sep="")]] <- c(tmp[['V1']], tmp[['V2']], tmp[['V3']], tmp[['V4']])
	}
}
for (ca in c('GENERAL_MATHEMATICS')) {
	tmp <- Bs[SUBJECT==ca,]
	for (g in 8:9) {
		Knots_Boundaries[[ca]][[paste("boundaries_", g, sep="")]] <- c(tmp[['V1']], tmp[['V2']])
	}
}
for (ca in c('GENERAL_MATHEMATICS')) {
	tmp <- lhoss[SUBJECT==ca,]
	for (g in 8:9) {
		Knots_Boundaries[[ca]][[paste("loss.hoss_", g, sep="")]] <- c(tmp[['V1']], tmp[['V2']])
	}
}


for (ca in 'ALGEBRA_I') {
	tmp <- Ks[SUBJECT==ca,]
	for (g in 7:8) {
		Knots_Boundaries[[ca]][[paste("knots_", g, sep="")]] <- c(tmp[['V1']], tmp[['V2']], tmp[['V3']], tmp[['V4']])
	}
}
for (ca in 'ALGEBRA_I') {
	tmp <- Bs[SUBJECT==ca,]
	for (g in 7:8) {
		Knots_Boundaries[[ca]][[paste("boundaries_", g, sep="")]] <- c(tmp[['V1']], tmp[['V2']])
	}
}
for (ca in 'ALGEBRA_I') {
	tmp <- lhoss[SUBJECT==ca,]
	for (g in 7:8) {
		Knots_Boundaries[[ca]][[paste("loss.hoss_", g, sep="")]] <- c(tmp[['V1']], tmp[['V2']])
	}
}

for (ca in c('WORLD_HISTORY', 'US_HISTORY', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS', 'INTEGRATED_SCIENCE_1', 'LIFE_SCIENCE',
	'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'ALGEBRA_II', 'GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS')) {
	tmp <- Ks[SUBJECT==ca,]
	for (g in 2009:2010) {
		Knots_Boundaries[[ca]][[paste("knots_", g, sep="")]] <- c(tmp[['V1']], tmp[['V2']], tmp[['V3']], tmp[['V4']])
	}
}
for (ca in c('WORLD_HISTORY', 'US_HISTORY', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS', 'INTEGRATED_SCIENCE_1', 'LIFE_SCIENCE', 
	'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'ALGEBRA_II', 'GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS')) {
	tmp <- Bs[SUBJECT==ca,]
	for (g in 2009:2010) {
		Knots_Boundaries[[ca]][[paste("boundaries_", g, sep="")]] <- c(tmp[['V1']], tmp[['V2']])
	}
}
for (ca in c('WORLD_HISTORY', 'US_HISTORY', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS', 'INTEGRATED_SCIENCE_1', 'LIFE_SCIENCE',
	'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'ALGEBRA_II', 'GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS')) {
	tmp <- lhoss[SUBJECT==ca,]
	for (g in 2009:2010) {
		Knots_Boundaries[[ca]][[paste("loss.hoss_", g, sep="")]] <- c(tmp[['V1']], tmp[['V2']])
	}
}

#  Had to add these lines after changes to prepareSGP in 0.9-*.0
SGPstateData[["CA"]][["Achievement"]][["Knots_Boundaries"]] <- Knots_Boundaries
California_Data_LONG$CMO_NUMBER <- as.integer(California_Data_LONG$CMO)
setnames(California_Data_LONG, "CMO", "CMO_NAME")
setnames(California_Data_LONG, "CONTENT_AREA", "CONTENT_GROUP", "CMO")
setnames(California_Data_LONG, "SUBJECT", "CONTENT_AREA", "CMO_NAME")

SGPstateData[["CA"]][["Variable_Name_Lookup"]] <- read.csv("/home/avi/Dropbox/stateData/Variable_Name_Lookup/CA_Variable_Name_Lookup.csv", colClasses=c(rep("character", 4), "logical")
California_SGP <- prepareSGP(California_Data_LONG[,c("VALID_CASE", "ID","LAST_NAME", "FIRST_NAME", "ORIGINAL_GRADE", "GRADE", "CONTENT_AREA", "CONTENT_GROUP", "YEAR", "SCALE_SCORE", "ACHIEVEMENT_LEVEL_PROVIDED", "ACHIEVEMENT_LEVEL", "GENDER", "ETHNICITY", "ELL_STATUS", "SES_STATUS", "SPECIFIC_DISABILITY", "IEP_STATUS", "TEST_TYPE", "CMO_NAME", "SCHOOL_NUMBER", "SCHOOL_NAME", "DISTRICT_NAME", "DISTRICT_NUMBER", "EMH_LEVEL", "INSTRUCTOR_NUMBER_1", "INSTRUCTOR_NUMBER_2", "INSTRUCTOR_1_WEIGHT", "INSTRUCTOR_2_WEIGHT"), with=FALSE], state="CA")
California_SGP <- prepareSGP(California_Data_LONG[,c("VALID_CASE", "ID","LAST_NAME", "FIRST_NAME", "ORIGINAL_GRADE", "GRADE", "CONTENT_AREA", "CONTENT_GROUP", "YEAR", "SCALE_SCORE", "ACHIEVEMENT_LEVEL_PROVIDED", "ACHIEVEMENT_LEVEL", "GENDER", "ETHNICITY", "ELL_STATUS", "SES_STATUS", "SPECIFIC_DISABILITY", "IEP_STATUS", "TEST_TYPE", "CMO_NAME", "SCHOOL_NUMBER", "SCHOOL_NAME", "DISTRICT_NAME", "DISTRICT_NUMBER", "EMH_LEVEL", "INSTRUCTOR_NUMBER_1", "INSTRUCTOR_NUMBER_2", "INSTRUCTOR_1_WEIGHT", "INSTRUCTOR_2_WEIGHT"), with=FALSE], state="CA")

California_SGP@SGP <- list(Knots_Boundaries=Knots_Boundaries)
save(California_SGP, file="Data/California_SGP.Rdata")
save(California_Data_LONG, file="Data/California_Data_LONG.Rdata")



###  Re-factor course progressions to use the SUBJECT:

	# .mergeSGP <- function(list_1, list_2) {
		# for (j in c("Coefficient_Matrices", "Cutscores", "Goodness_of_Fit", "Knots_Boundaries", "SGPercentiles", "SGProjections", "Simulated_SGPs")) {
			# list_1[[j]] <- c(list_1[[j]], list_2[[j]])[!duplicated(names(c(list_1[[j]], list_2[[j]])))]
		# }
		# for (j in c("Coefficient_Matrices", "Goodness_of_Fit", "Knots_Boundaries")) {
			# for (k in names(list_1[[j]])) {
				# list_1[[j]][[k]] <- c(list_1[[j]][[k]], list_2[[j]][[k]])[!duplicated(names(c(list_1[[j]][[k]], list_2[[j]][[k]])))]
			# }
		# }
	# list_1
	# }



# tmp.kb1 <- list()
# tmp.kb2 <- list()
# tmp.kb3 <- list()
# tmp.kb1$Knots_Boundaries$ALGEBRA_I <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("13", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb1$Knots_Boundaries$ALGEBRA_I) <- gsub("13", "2009", names(tmp.kb1$Knots_Boundaries$ALGEBRA_I))
# tmp.kb2$Knots_Boundaries$ALGEBRA_I <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("13", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb2$Knots_Boundaries$ALGEBRA_I) <- gsub("13", "2010", names(tmp.kb2$Knots_Boundaries$ALGEBRA_I))
# tmp.kb3$Knots_Boundaries$ALGEBRA_I <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("13", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb3$Knots_Boundaries$ALGEBRA_I) <- gsub("13", "2011", names(tmp.kb3$Knots_Boundaries$ALGEBRA_I))

# tmp.kb <- .mergeSGP(tmp.kb1, tmp.kb2)
# tmp.kb <- .mergeSGP(tmp.kb, tmp.kb3)

# tmp.kb1 <- list()
# tmp.kb2 <- list()
# tmp.kb3 <- list()
# tmp.kb4 <- list()

# tmp.kb4$Knots_Boundaries$ALGEBRA_I <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("13", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb4$Knots_Boundaries$ALGEBRA_I) <- gsub("13", "7", names(tmp.kb4$Knots_Boundaries$ALGEBRA_I))
# tmp.kb3$Knots_Boundaries$ALGEBRA_I <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("13", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb3$Knots_Boundaries$ALGEBRA_I) <- gsub("13", "8", names(tmp.kb3$Knots_Boundaries$ALGEBRA_I))
# tmp.kb1$Knots_Boundaries$ALGEBRA_I <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("13", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb1$Knots_Boundaries$ALGEBRA_I) <- gsub("13", "9", names(tmp.kb1$Knots_Boundaries$ALGEBRA_I))
# tmp.kb2$Knots_Boundaries$ALGEBRA_I <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("13", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb2$Knots_Boundaries$ALGEBRA_I) <- gsub("13", "10", names(tmp.kb2$Knots_Boundaries$ALGEBRA_I))

# tmp.kb <- .mergeSGP(tmp.kb, tmp.kb4)
# tmp.kb <- .mergeSGP(tmp.kb, tmp.kb3)
# tmp.kb <- .mergeSGP(tmp.kb, tmp.kb1)
# tmp.kb <- .mergeSGP(tmp.kb, tmp.kb2)


# tmp.kb1 <- list()
# tmp.kb2 <- list()
# tmp.kb1$Knots_Boundaries$GEOMETRY <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("14", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb1$Knots_Boundaries$GEOMETRY) <- gsub("14", "9", names(tmp.kb1$Knots_Boundaries$GEOMETRY))
# tmp.kb2$Knots_Boundaries$GEOMETRY <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("14", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb2$Knots_Boundaries$GEOMETRY) <- gsub("14", "10", names(tmp.kb2$Knots_Boundaries$GEOMETRY))

# tmp.kb <- .mergeSGP(tmp.kb, tmp.kb1)
# tmp.kb <- .mergeSGP(tmp.kb, tmp.kb2)


# tmp.kb1 <- list()
# tmp.kb2 <- list()
# tmp.kb3 <- list()
# tmp.kb1$Knots_Boundaries$GEOMETRY <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("14", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb1$Knots_Boundaries$GEOMETRY) <- gsub("14", "2009", names(tmp.kb1$Knots_Boundaries$GEOMETRY))
# tmp.kb2$Knots_Boundaries$GEOMETRY <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("14", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb2$Knots_Boundaries$GEOMETRY) <- gsub("14", "2010", names(tmp.kb2$Knots_Boundaries$GEOMETRY))
# tmp.kb3$Knots_Boundaries$GEOMETRY <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("14", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb3$Knots_Boundaries$GEOMETRY) <- gsub("14", "2011", names(tmp.kb3$Knots_Boundaries$GEOMETRY))
# tmp.kb <- .mergeSGP(tmp.kb, tmp.kb1)
# tmp.kb <- .mergeSGP(tmp.kb, tmp.kb2)
# tmp.kb <- .mergeSGP(tmp.kb, tmp.kb3)


# tmp.kb1 <- list()
# tmp.kb2 <- list()
# tmp.kb3 <- list()
# tmp.kb1$Knots_Boundaries$ALGEBRA_II <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("15", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb1$Knots_Boundaries$ALGEBRA_II) <- gsub("15", "2009", names(tmp.kb1$Knots_Boundaries$ALGEBRA_II))
# tmp.kb2$Knots_Boundaries$ALGEBRA_II <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("15", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb2$Knots_Boundaries$ALGEBRA_II) <- gsub("15", "2010", names(tmp.kb2$Knots_Boundaries$ALGEBRA_II))
# tmp.kb3$Knots_Boundaries$ALGEBRA_II <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("15", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb3$Knots_Boundaries$ALGEBRA_II) <- gsub("15", "2011", names(tmp.kb3$Knots_Boundaries$ALGEBRA_II))
# tmp.kb <- .mergeSGP(tmp.kb, tmp.kb1)
# tmp.kb <- .mergeSGP(tmp.kb, tmp.kb2)
# tmp.kb <- .mergeSGP(tmp.kb, tmp.kb3)


# tmp.kb1 <- list()
# tmp.kb2 <- list()
# tmp.kb3 <- list()
# tmp.kb1$Knots_Boundaries$SUMMATIVE_HS_MATHEMATICS <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("16", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb1$Knots_Boundaries$SUMMATIVE_HS_MATHEMATICS) <- gsub("16", "2009", names(tmp.kb1$Knots_Boundaries$SUMMATIVE_HS_MATHEMATICS))
# tmp.kb2$Knots_Boundaries$SUMMATIVE_HS_MATHEMATICS <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("16", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb2$Knots_Boundaries$SUMMATIVE_HS_MATHEMATICS) <- gsub("16", "2010", names(tmp.kb2$Knots_Boundaries$SUMMATIVE_HS_MATHEMATICS))
# tmp.kb3$Knots_Boundaries$SUMMATIVE_HS_MATHEMATICS <- California_SGP@SGP$Knots_Boundaries$MATHEMATICS[grep("16", names(California_SGP@SGP$Knots_Boundaries$MATHEMATICS))]
# names(tmp.kb3$Knots_Boundaries$SUMMATIVE_HS_MATHEMATICS) <- gsub("16", "2011", names(tmp.kb3$Knots_Boundaries$SUMMATIVE_HS_MATHEMATICS))
# tmp.kb <- .mergeSGP(tmp.kb, tmp.kb1)
# tmp.kb <- .mergeSGP(tmp.kb, tmp.kb2)
# tmp.kb <- .mergeSGP(tmp.kb, tmp.kb3)

# California_SGP@SGP <- .mergeSGP(California_SGP@SGP, tmp.kb)

# ###  GRADE LEVEL SCIENCE COURSES:

