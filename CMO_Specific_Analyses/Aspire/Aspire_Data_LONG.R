##########################################################
####
#### Code for preparation of California LONG data
####
##########################################################

library(SGP)
library(data.table)

# Set SGP file as working directory
setwd("/Users/adamvaniwaarden/CENTER/SGP/California")


### ### ### ### ### ### ### ### ### ### ### ###
###	Read in and clean base data file
### ### ### ### ### ### ### ### ### ### ### ###

###
###  Aspire
###

#	To Create the Aspire_CST_Test_Scores_2012-No_NULL.txt I did a search and replace of 
#	'NULL' and '-----' with blank cells in the Aspire_CST_Test_Scores_2012.txt file.
Aspire_Data_LONG <- read.delim("./Data/Base_Files/Aspire/Aspire_CST_Test_Scores_2012-No_NULL.txt", header=TRUE) #

names(Aspire_Data_LONG) <- toupper(names(Aspire_Data_LONG))
names(Aspire_Data_LONG)[c(2:4,28)] <- c("LAST_NAME","FIRST_NAME", "CONTENT_GROUP", "CONTENT_AREA")

# Set up a generic system of CONTENT_AREA for all CMOs.  
levels(Aspire_Data_LONG$CONTENT_AREA) <- c("ALGEBRA_I", "ALGEBRA_II", "BIOLOGY", "CHEMISTRY", "ELA", "GENERAL_MATHEMATICS", "GEOMETRY", "HISTORY", "INTEGRATED_SCIENCE_1", "MATHEMATICS", "PHYSICS", "SCIENCE", "SUMMATIVE_HS_MATHEMATICS", "WORLD_HISTORY")


## GRADE

# Set 99 to NA
Aspire_Data_LONG$GRADE[Aspire_Data_LONG$GRADE %in% c(0, 99)] <- NA # 1925 records
summary(Aspire_Data_LONG$GRADE) # 1936 NA's records

## EMH_LEVEL
# table(Aspire_Data_LONG$EMH_LEVEL, Aspire_Data_LONG$GRADE) # MS overlap ...
levels(Aspire_Data_LONG$EMH_LEVEL) <- c(NA, "Elementary", "Secondary")

##  SCHOOL_NUMBER / NAME
Aspire_Data_LONG$SCHOOL_NUMBER[Aspire_Data_LONG$SCHOOL_NUMBER==-1] <- NA
levels(Aspire_Data_LONG$SCHOOL_NAME) <- c(NA, levels(Aspire_Data_LONG$SCHOOL_NAME)[-1])

##  ETHNICITY, ELL_STATUS, GENDER & IEP_STATUS
levels(Aspire_Data_LONG$ELL_STATUS) <- c("Unknown", "English Learner", "English Only", "Initially Fluent English Proficient", 
	"Reclassified Fluent English Proficient", "To Be Determined") # Labels as provided by Aspire, matches Cali AYP Definitions of Subgroups.
levels(Aspire_Data_LONG$SES_STATUS) <- c(NA, "Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(Aspire_Data_LONG$IEP_STATUS) <- c(NA, "Student with Disabilities: No", "Student with Disabilities: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(Aspire_Data_LONG$GENDER) <- c('Gender: Female', 'Gender: Male')
levels(Aspire_Data_LONG$ETHNICITY) <- c(NA, 'Black or African American', "American Indian or Alaskan Native", levels(Aspire_Data_LONG$ETHNICITY)[-(1:3)])

#  Change some of the CONTENT_AREA labels

Aspire_Data_LONG$CONTENT_AREA <- as.character(Aspire_Data_LONG$CONTENT_AREA)

#  History and US History labeled inconsistently.  This is how it should be...
# Aspire_Data_LONG$CONTENT_AREA[Aspire_Data_LONG$CONTENT_AREA=="US_HISTORY" & Aspire_Data_LONG$GRADE==8] <- "HISTORY" # Not an issue for Aspire
Aspire_Data_LONG$CONTENT_AREA[Aspire_Data_LONG$CONTENT_AREA=="HISTORY" & Aspire_Data_LONG$GRADE==11] <- "US_HISTORY"

# Fix 10th grade 'Science' courses (mostly LAUSD)
Aspire_Data_LONG$CONTENT_AREA[Aspire_Data_LONG$CONTENT_AREA=="SCIENCE" & Aspire_Data_LONG$GRADE==10] <- "LIFE_SCIENCE"
# Opposite problem for Alliance 8th grade
# Aspire_Data_LONG$CONTENT_AREA[Aspire_Data_LONG$CONTENT_AREA=="LIFE_SCIENCE" & Aspire_Data_LONG$GRADE==8] <- "SCIENCE" # Not an issue for Aspire

#  Change "MATHEMATICS" back to "MATHEMATICS" and 8th and 9th grade "MATHEMATICS" to "GENERAL_MATHEMATICS"
# Aspire_Data_LONG$CONTENT_AREA[Aspire_Data_LONG$CONTENT_AREA=="MATHEMATICS" & Aspire_Data_LONG$GRADE %in% c(8,9)] <- "GENERAL_MATHEMATICS" # Not an issue for Aspire

##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary" and ran basic descriptives:
Aspire_Data_LONG$ACHIEVEMENT_LEVEL <- ordered(Aspire_Data_LONG$ACHIEVEMENT_LEVEL, levels = 1:5, labels=c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

##  Set all variables to the correct class for merging:

##  ID - change to as.character.  Will need to make sure there are no duplicates accross CMO's / LAUSD
Aspire_Data_LONG$ID <- as.character(Aspire_Data_LONG$ID)

#  Scores outside of CST scale range - probably from the CAPA ...
Aspire_Data_LONG$TEST_TYPE <- NA
Aspire_Data_LONG$TEST_TYPE[Aspire_Data_LONG$SCALE_SCORE >= 150 & Aspire_Data_LONG$SCALE_SCORE <= 600] <- "CST"

## VALID_CASE
Aspire_Data_LONG$VALID_CASE <- "VALID_CASE"

#  Invalidate students with a missing or non-tested grade
Aspire_Data_LONG$VALID_CASE[is.na(Aspire_Data_LONG$GRADE)] <- "INVALID_CASE"

Aspire_Data_LONG$VALID_CASE[Aspire_Data_LONG$SCALE_SCORE < 150 | is.na(Aspire_Data_LONG$SCALE_SCORE)] <- "INVALID_CASE"

#  Clean up grades and content areas:

Aspire_Data_LONG$VALID_CASE[Aspire_Data_LONG$CONTENT_AREA=="ELA" & !Aspire_Data_LONG$GRADE %in% 2:11] <- "INVALID_CASE"
Aspire_Data_LONG$VALID_CASE[Aspire_Data_LONG$CONTENT_AREA=="MATHEMATICS" & !Aspire_Data_LONG$GRADE %in% 2:7] <- "INVALID_CASE"
Aspire_Data_LONG$VALID_CASE[Aspire_Data_LONG$CONTENT_AREA=="GENERAL_MATHEMATICS" & !Aspire_Data_LONG$GRADE %in% 8:9] <- "INVALID_CASE"
Aspire_Data_LONG$VALID_CASE[Aspire_Data_LONG$CONTENT_AREA=="SCIENCE" & !Aspire_Data_LONG$GRADE %in% c(5,8)] <- "INVALID_CASE"


# Duplicates
# DISTRICT_NUMBER - dups are missing a DISTRICT_NUMBER ID.  All else is == so INVALIDate these records
Aspire_Data_LONG <- data.table(Aspire_Data_LONG, key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE", "DISTRICT_NUMBER"))
		      setkeyv(Aspire_Data_LONG, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE"))
dups <- data.table(Aspire_Data_LONG[c(which(duplicated(Aspire_Data_LONG))-1, which(duplicated(Aspire_Data_LONG))),], key=key(Aspire_Data_LONG))
Aspire_Data_LONG$VALID_CASE[which(duplicated(Aspire_Data_LONG))-1] <- "INVALID_CASE"

setkeyv(Aspire_Data_LONG, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE", "INSTRUCTOR_NUMBER_1")) # Add SCORE for kids with both Instructor # == NA (keep highest score)
setkeyv(Aspire_Data_LONG, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID"))
dups <- data.table(Aspire_Data_LONG[c(which(duplicated(Aspire_Data_LONG))-1, which(duplicated(Aspire_Data_LONG))),], key=c("YEAR", "CONTENT_AREA","GRADE", "ID", "INSTRUCTOR_NUMBER_1"))
Aspire_Data_LONG$VALID_CASE[which(duplicated(Aspire_Data_LONG))-1] <- "INVALID_CASE"

## No more dups added.  
# setkeyv(Aspire_Data_LONG, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "SCALE_SCORE"))
# setkeyv(Aspire_Data_LONG, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
# dups <- data.table(Aspire_Data_LONG[c(which(duplicated(Aspire_Data_LONG))-1, which(duplicated(Aspire_Data_LONG))),], key=c("YEAR", "CONTENT_AREA","GRADE", "ID"))
# Aspire_Data_LONG$VALID_CASE[which(duplicated(Aspire_Data_LONG))-1] <- "INVALID_CASE" 

table(Aspire_Data_LONG$VALID_CASE)
# 2223 total INVALID_CASE's

#  Remove NA and unnecessary variables
Aspire_Data_LONG$CONTENT_GROUP <- NULL

Aspire_Data_LONG$INSTRUCTOR_NUMBER_2 <- NULL 
Aspire_Data_LONG$INSTRUCTOR_NUMBER_3 <- NULL 
Aspire_Data_LONG$INSTRUCTOR_NUMBER_4 <- NULL 
Aspire_Data_LONG$INSTRUCTOR_4_WEIGHT <- NULL 
Aspire_Data_LONG$INSTRUCTOR_2_WEIGHT <- NULL 
Aspire_Data_LONG$INSTRUCTOR_3_WEIGHT <- NULL 

##  Get variables into proper class for merging
Aspire_Data_LONG$SCHOOL_NUMBER <- as.character(Aspire_Data_LONG$SCHOOL_NUMBER)
Aspire_Data_LONG$SCHOOL_NAME <- as.character(Aspire_Data_LONG$SCHOOL_NAME)
Aspire_Data_LONG$DISTRICT_NUMBER <- as.character(Aspire_Data_LONG$DISTRICT_NUMBER)
Aspire_Data_LONG$DISTRICT_NAME <- as.character(Aspire_Data_LONG$DISTRICT_NAME)
Aspire_Data_LONG$INSTRUCTOR_NUMBER_1 <- as.character(Aspire_Data_LONG$INSTRUCTOR_NUMBER_1)


###  Performance Level Coding function

perlev.recode <- function(scale_scores, state, content_area, grade) {
	findInterval(scale_scores, SGPstateData[[state]][["Achievement"]][["Cutscores"]][[as.character(content_area)]][[paste("GRADE_", grade, sep="")]])+1
}

Aspire_Data_LONG$CONTENT_AREA[Aspire_Data_LONG$CONTENT_AREA=="MATHEMATICS" & Aspire_Data_LONG[['GRADE']] > 7] <- "GENERAL_MATHEMATICS"

#  KEY ON THESE TWO VARIABLES FIRST
setkeyv(Aspire_Data_LONG, c("CONTENT_AREA", "GRADE"))

#  First save old ACH_LEVEL in the *_PROVIDED variable, and then set old var to NA
Aspire_Data_LONG$ACHIEVEMENT_LEVEL_PROVIDED <- Aspire_Data_LONG$ACHIEVEMENT_LEVEL
Aspire_Data_LONG$ACHIEVEMENT_LEVEL <- NULL
Aspire_Data_LONG$ACHIEVEMENT_LEVEL <- NA

Aspire_Data_LONG$ACHIEVEMENT_LEVEL[Aspire_Data_LONG[['VALID_CASE']]=="VALID_CASE" & Aspire_Data_LONG[['TEST_TYPE']]=="CST"] <- Aspire_Data_LONG[, perlev.recode(SCALE_SCORE, state="CA", CONTENT_AREA[1], GRADE[1]), 
	by=list(CONTENT_AREA, GRADE)]$V1[Aspire_Data_LONG[['VALID_CASE']]=="VALID_CASE"  & Aspire_Data_LONG[['TEST_TYPE']]=="CST"]

#  Aspire doesn't have any of these Content areas
# Aspire_Data_LONG$ACHIEVEMENT_LEVEL[Aspire_Data_LONG$CONTENT_AREA %in% c('INTEGRATED_SCIENCE_1', 'INTEGRATED_SCIENCE_2', 'INTEGRATED_SCIENCE_3', 'INTEGRATED_SCIENCE_4', 'EARTH_SCIENCE', 'CST_MATH_CODE_8', 'MULTIPLE_SCIENCE')] <- NA

Aspire_Data_LONG$ACHIEVEMENT_LEVEL <- ordered(Aspire_Data_LONG$ACHIEVEMENT_LEVEL, levels = 1:5, labels=c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

#  Sanity Checks
table(Aspire_Data_LONG$ACHIEVEMENT_LEVEL, Aspire_Data_LONG$ACHIEVEMENT_LEVEL_PROVIDED)

#  There are a few scores mislabeled. Here is the breakdown.
table(as.factor(Aspire_Data_LONG$ACHIEVEMENT_LEVEL_PROVIDED), Aspire_Data_LONG$CONTENT_AREA)
table(as.factor(Aspire_Data_LONG$ACHIEVEMENT_LEVEL), Aspire_Data_LONG$CONTENT_AREA)

###
###   Create the Aspire_SGP SGP class object
###


Aspire_SGP <- prepareSGP(Aspire_Data_LONG, state='CA') 

save(Aspire_SGP, file="Data/Aspire_SGP-LONG_ONLY.Rdata")
save(Aspire_Data_LONG, file="Data/Aspire_Data_LONG.Rdata")

