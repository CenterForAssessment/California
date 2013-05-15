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
###  PUC
###

PUC_Data_LONG <- read.delim("./Data/Base_Files/PUC/PUC_SGP_Data_Schema.11.12.101912.txt", header=TRUE) #

#  Remove NA variables
PUC_Data_LONG$INSTRUCTOR_NUMBER_2 <- NULL 
PUC_Data_LONG$INSTRUCTOR_NUMBER_. <- NULL 
PUC_Data_LONG$INSTRUCTOR_2_WEIGHT <- NULL 
PUC_Data_LONG$INSTRUCTOR_._WEIGHT <- NULL 

# Set up a generic system of CONTENT_AREA for all CMOs.  
# Renamed PUC's Test Type variable "CST Test Name" in the .txt file to match other CMO's
levels(PUC_Data_LONG$CONTENT_AREA) <- c("ALGEBRA_I", "ALGEBRA_II", "BIOLOGY", "CHEMISTRY", "ELA", "GEOMETRY", "US_HISTORY", 
	"MATHEMATICS", "PHYSICS", "SCIENCE", "SUMMATIVE_HS_MATHEMATICS", "WORLD_HISTORY")  

PUC_Data_LONG$TEST_TYPE <- "CST"	

##  ID - change to as.character.
PUC_Data_LONG$ID <- as.character(PUC_Data_LONG$ID)

##  ETHNICITY, ELL_STATUS, GIFTED_TALENTED_STATUS & IEP_STATUS
#   Format these variables to be consistent with other CMOs:

levels(PUC_Data_LONG$ETHNICITY) <- c(NA, levels(PUC_Data_LONG$ETHNICITY)[-c(1,15:16)], NA, NA)
levels(PUC_Data_LONG$ETHNICITY)[6] <- 'Hispanic'

levels(PUC_Data_LONG$ELL_STATUS) <- c("Unknown", "English Learner", "English Only", "Initially Fluent English Proficient", "Reclassified Fluent English Proficient") # Labeled to match Aspire
levels(PUC_Data_LONG$SES_STATUS) <- c(NA, "Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(PUC_Data_LONG$IEP_STATUS) <- c(NA, "Student with Disabilities: No", "Student with Disabilities: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(PUC_Data_LONG$GENDER) <- c(NA, 'Gender: Female', 'Gender: Male') 

#  Change some of the CONTENT_AREA labels

PUC_Data_LONG$CONTENT_AREA <- as.character(PUC_Data_LONG$CONTENT_AREA)

#  History and US History labeled inconsistently.  This is how it 'should' be...
PUC_Data_LONG$CONTENT_AREA[PUC_Data_LONG$CONTENT_AREA=="US_HISTORY" & PUC_Data_LONG$GRADE==8] <- "HISTORY"
# PUC_Data_LONG$CONTENT_AREA[PUC_Data_LONG$CONTENT_AREA=="HISTORY" & PUC_Data_LONG$GRADE==11] <- "US_HISTORY" # Not an issue for PUC

# Fix 10th grade 'Science' courses (mostly LAUSD)
PUC_Data_LONG$CONTENT_AREA[PUC_Data_LONG$CONTENT_AREA=="SCIENCE" & PUC_Data_LONG$GRADE==10] <- "LIFE_SCIENCE"
# Opposite problem for Alliance 8th grade
# PUC_Data_LONG$CONTENT_AREA[PUC_Data_LONG$CONTENT_AREA=="LIFE_SCIENCE" & PUC_Data_LONG$GRADE==8] <- "SCIENCE" # Not an issue for PUC

#  Change "MATHEMATICS" back to "MATHEMATICS" and 8th and 9th grade "MATHEMATICS" to "GENERAL_MATHEMATICS"
PUC_Data_LONG$CONTENT_AREA[PUC_Data_LONG$CONTENT_AREA=="MATHEMATICS" & PUC_Data_LONG$GRADE %in% c(8,9)] <- "GENERAL_MATHEMATICS"


##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary" and ran basic descriptives:
#   PUC has correct lables, but need to produce an "ordered" factor (default factor is alphabetical)
PUC_Data_LONG$ACHIEVEMENT_LEVEL <- ordered(PUC_Data_LONG$ACHIEVEMENT_LEVEL, levels = c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

## VALID_CASE
PUC_Data_LONG$VALID_CASE <- "VALID_CASE"

PUC_Data_LONG$VALID_CASE[is.na(PUC_Data_LONG$SCALE_SCORE)] <- "INVALID_CASE"
PUC_Data_LONG$VALID_CASE[PUC_Data_LONG$CONTENT_AREA == "ELA" & PUC_Data_LONG$GRADE==12] <- "INVALID_CASE"

# Duplicates  -  same scores and INSTRUCTOR_NUMBER_1
PUC_Data_LONG <- data.table(PUC_Data_LONG, key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE", "INSTRUCTOR_NUMBER_1"))
dups <- data.table(PUC_Data_LONG[c(which(duplicated(PUC_Data_LONG))-1, which(duplicated(PUC_Data_LONG))),], key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
PUC_Data_LONG$VALID_CASE[which(duplicated(PUC_Data_LONG))-1] <- "INVALID_CASE"  #  Doesn't seem to matter which.  Most LAUSD, ~13 PUC, all but one of those has the same school number too

setkeyv(PUC_Data_LONG, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE","ID", "SCALE_SCORE"))
setkeyv(PUC_Data_LONG, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE","ID"))
dups <- data.table(PUC_Data_LONG[c(which(duplicated(PUC_Data_LONG))-1, which(duplicated(PUC_Data_LONG))),], key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
PUC_Data_LONG$VALID_CASE[which(duplicated(PUC_Data_LONG))-1] <- "INVALID_CASE"  

#  handful of students from 2009 with more than one student given a ID and one student with multiple grade levels in 2009
setkeyv(PUC_Data_LONG, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "SCALE_SCORE"))
setkeyv(PUC_Data_LONG, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
dups <- data.table(PUC_Data_LONG[c(which(duplicated(PUC_Data_LONG))-1, which(duplicated(PUC_Data_LONG))),], key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
PUC_Data_LONG$VALID_CASE[which(duplicated(PUC_Data_LONG))-1] <- "INVALID_CASE"  # just invalidate one for now...

table(PUC_Data_LONG$VALID_CASE)
#  150 invalid cases now  

##  Get variables into proper class for merging
PUC_Data_LONG$SCHOOL_NUMBER <- as.character(PUC_Data_LONG$SCHOOL_NUMBER)
PUC_Data_LONG$SCHOOL_NAME <- as.character(PUC_Data_LONG$SCHOOL_NAME)
PUC_Data_LONG$DISTRICT_NAME <- as.character(PUC_Data_LONG$DISTRICT_NAME)
PUC_Data_LONG$DISTRICT_NUMBER <- as.character(PUC_Data_LONG$DISTRICT_NUMBER)
PUC_Data_LONG$INSTRUCTOR_NUMBER_1 <- as.character(PUC_Data_LONG$INSTRUCTOR_NUMBER_1)


###  Make LAST_NAME and FIRST_NAME all 'Camel' case

f.names <- sapply(levels(PUC_Data_LONG$FIRST_NAME), function(x) 
		paste(sapply(strsplit(x, split=" ")[[1]], capwords), collapse=" "), USE.NAMES=FALSE)
levels(PUC_Data_LONG$FIRST_NAME) <- f.names

l.names <- sapply(levels(PUC_Data_LONG$LAST_NAME), function(x) 
		paste(sapply(strsplit(x, split=" ")[[1]], capwords), collapse=" "), USE.NAMES=FALSE)
levels(PUC_Data_LONG$LAST_NAME) <- l.names


###  Performance Level Coding function

perlev.recode <- function(scale_scores, state, content_area, grade) {
	findInterval(scale_scores, SGPstateData[[state]][["Achievement"]][["Cutscores"]][[as.character(content_area)]][[paste("GRADE_", grade, sep="")]])+1
}

PUC_Data_LONG$CONTENT_AREA[PUC_Data_LONG$CONTENT_AREA=="MATHEMATICS" & PUC_Data_LONG[['GRADE']] > 7] <- "GENERAL_MATHEMATICS"

#  KEY ON THESE TWO VARIABLES FIRST
setkeyv(PUC_Data_LONG, c("CONTENT_AREA", "GRADE"))

#  First save old ACH_LEVEL in the *_PROVIDED variable, and then set old var to NA
PUC_Data_LONG$ACHIEVEMENT_LEVEL_PROVIDED <- PUC_Data_LONG$ACHIEVEMENT_LEVEL
PUC_Data_LONG$ACHIEVEMENT_LEVEL <- NULL
PUC_Data_LONG$ACHIEVEMENT_LEVEL <- NA

PUC_Data_LONG$ACHIEVEMENT_LEVEL[PUC_Data_LONG[['VALID_CASE']]=="VALID_CASE" & PUC_Data_LONG[['TEST_TYPE']]=="CST"] <- PUC_Data_LONG[, perlev.recode(SCALE_SCORE, state="CA", CONTENT_AREA[1], GRADE[1]), 
	by=list(CONTENT_AREA, GRADE)]$V1[PUC_Data_LONG[['VALID_CASE']]=="VALID_CASE"  & PUC_Data_LONG[['TEST_TYPE']]=="CST"]

#  PUC doesn't have any of these Content areas
# PUC_Data_LONG$ACHIEVEMENT_LEVEL[PUC_Data_LONG$CONTENT_AREA %in% c('INTEGRATED_SCIENCE_1', 'INTEGRATED_SCIENCE_2', 'INTEGRATED_SCIENCE_3', 'INTEGRATED_SCIENCE_4', 'EARTH_SCIENCE', 'CST_MATH_CODE_8', 'MULTIPLE_SCIENCE')] <- NA

PUC_Data_LONG$ACHIEVEMENT_LEVEL <- ordered(PUC_Data_LONG$ACHIEVEMENT_LEVEL, levels = 1:5, labels=c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

#  Sanity Checks
table(PUC_Data_LONG$ACHIEVEMENT_LEVEL, PUC_Data_LONG$ACHIEVEMENT_LEVEL_PROVIDED)

#  There are a few scores mislabeled. Here is the breakdown.
table(as.factor(PUC_Data_LONG$ACHIEVEMENT_LEVEL_PROVIDED), PUC_Data_LONG$CONTENT_AREA)
table(as.factor(PUC_Data_LONG$ACHIEVEMENT_LEVEL), PUC_Data_LONG$CONTENT_AREA)

###
###   Create the PUC_SGP SGP class object
###


PUC_SGP <- prepareSGP(PUC_Data_LONG, state='CA') 

save(PUC_SGP, file="Data/PUC_SGP-LONG_ONLY.Rdata")
save(PUC_Data_LONG, file="Data/PUC_Data_LONG.Rdata")

