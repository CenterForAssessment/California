##########################################################
####
#### Code for preparation of California LONG data
####
##########################################################

library(SGP)

# Set SGP file as working directory
setwd("/Users/adamvaniwaarden/CENTER/SGP/California")


### ### ### ### ### ### ### ### ### ### ### ###
###	Read in and clean the CMO files seperately
### ### ### ### ### ### ### ### ### ### ### ###

###
###  Alliance
###

al <- rbind.fill(read.delim("./Data/Base_Files/Alliance/Alliance_2012.txt", header=TRUE), 
				 read.delim("./Data/Base_Files/Alliance/Alliance_2011_redux.txt", header=TRUE))

al$CMO_NAME <- "Alliance" # Alliance College-Ready Public Schools

# Set up a generic system of TEST_NAMES for all CMOs.  Collapse all ELA and categories into one - only one course sequence there.  
# Collapse Grade level math  Fix mispellings, etc.
levels(al$CONTENT_AREA) <- c("ALGEBRA_I", "ALGEBRA_II", "BIOLOGY", "CHEMISTRY", "EARTH_SCIENCE", "ELA", "GENERAL_MATHEMATICS", "GEOMETRY", 
	"HISTORY", "INTEGRATED_MATHEMATICS_1", "INTEGRATED_MATHEMATICS_2", "INTEGRATED_SCIENCE_1", "LIFE_SCIENCE", "MATHEMATICS", "PHYSICS", 
	"SUMMATIVE_HS_MATHEMATICS", "US_HISTORY", "WORLD_HISTORY", "INTEGRATED_SCIENCE_2")

##  ID - change to as.character.  
al$ID <- as.character(al$ID)
al$SCHOOL_NUMBER <- as.character(al$SCHOOL_NUMBER) #  Change these too - some CMOs are numeric, some are factors
# al$INSTRUCTOR_NUMBER_1 <- as.character(al$INSTRUCTOR_NUMBER_1) #  No teacher ID yet from Alliance

##  ETHNICITY, ELL_STATUS, GIFTED_TALENTED_STATUS & IEP_STATUS

levels(al$ETHNICITY)[1] <- 'American Indian or Alaskan Native'
levels(al$ETHNICITY)[7] <- 'Hispanic'

levels(al$ELL_STATUS) <- c("Unknown", "English Learner", "English Only", "Initially Fluent English Proficient", "Reclassified Fluent English Proficient")
levels(al$SES_STATUS) <- c(NA, "Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes")
levels(al$IEP_STATUS) <- c(rep("Student with Disabilities: Yes", 8), "Student with Disabilities: No", rep("Student with Disabilities: Yes", 2))  
# al$IEP_STATUS[is.na(al$IEP_STATUS)] <- "Student with Disabilities: No"

levels(al$GENDER) <- c('Gender: Female', 'Gender: Male') #  recode fixed NA's but didn't change level labels for some reason...

##  ACHIEVEMENT_LEVEL

summary(al$ACHIEVEMENT_LEVEL)
al$ACHIEVEMENT_LEVEL <- ordered(al$ACHIEVEMENT_LEVEL, levels = c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

#  Scores outside of CST scale range - probably from the CAPA ...
al$TEST_TYPE <- NA
al$TEST_TYPE[al$SCALE_SCORE >= 150 & al$SCALE_SCORE <= 600] <- "CST"

## VALID_CASE

al$VALID_CASE <- "VALID_CASE"

al$VALID_CASE[al$TEST_TYPE != "CST" | is.na(al$TEST_TYPE)] <- "INVALID_CASE"

# Look for duplicates:

#  No INSTRUCTOR ID yet ...
# al <- data.table(al, key=c("YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE", "INSTRUCTOR_NUMBER_1"))
# setkeyv(al, c("YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE")
# dups <- data.table(al[c(which(duplicated(al))-1, which(duplicated(al))),], key="YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE")
# al$VALID_CASE[which(duplicated(al))-1] <- "INVALID_CASE" #  111 Invalidated

# al <- data.table(al, key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE"))
             # setkeyv(al, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID"))
# dups <- data.table(al[c(which(duplicated(al))-1, which(duplicated(al))),], key=key(al))
# al$VALID_CASE[which(duplicated(al))-1] <- "INVALID_CASE" #  0 Invalidated in 2012

# setkeyv(al, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "SCALE_SCORE"))
# setkeyv(al, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
# dups <- data.table(al[c(which(duplicated(al))-1, which(duplicated(al))),], key=key(al))
# al$VALID_CASE[which(duplicated(al))-1] <- "INVALID_CASE" #  0 Invalidated in 2012

summary(as.factor(al$VALID_CASE)) # 13 INVALID


###
###  Aspire
###

#	To Create the Aspire_CST_Test_Scores_2012-No_NULL.txt I did a search and replace of 
#	'NULL' and '-----' with blank cells in the Aspire_CST_Test_Scores_2012.txt file.
asp <- read.delim("./Data/Base_Files/Aspire/Aspire_CST_Test_Scores_2012-No_NULL.txt", header=TRUE, na.strings="NULL")

# asp$CMO_NAME <- factor(2, levels=c(1:5), labels = c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))

names(asp) <- toupper(names(asp))
names(asp)[c(2:4,28)] <- c("LAST_NAME","FIRST_NAME", "CONTENT_GROUP", "CONTENT_AREA")

# Set up a generic system of CONTENT_AREA for all CMOs.  
levels(asp$CONTENT_AREA) <- c("ALGEBRA_I", "ALGEBRA_II", "BIOLOGY", "CHEMISTRY", "ELA", "GENERAL_MATHEMATICS", "GEOMETRY", "HISTORY", "INTEGRATED_SCIENCE_1", "MATHEMATICS", "PHYSICS", "SCIENCE", "SUMMATIVE_HS_MATHEMATICS", "WORLD_HISTORY")


## GRADE

# Set 99 to NA
asp$GRADE[asp$GRADE %in% c(0, 99)] <- NA # 1925 records
summary(asp$GRADE) # 1936 NA's records

## EMH_LEVEL
# table(asp$EMH_LEVEL, asp$GRADE) # MS overlap ...
levels(asp$EMH_LEVEL) <- c(NA, "Elementary", "Secondary")

##  SCHOOL_NUMBER / NAME
asp$SCHOOL_NUMBER[asp$SCHOOL_NUMBER==-1] <- NA
levels(asp$SCHOOL_NAME) <- c(NA, levels(asp$SCHOOL_NAME)[-1])

##  ETHNICITY, ELL_STATUS, GENDER & IEP_STATUS
levels(asp$ELL_STATUS) <- c("Unknown", "English Learner", "English Only", "Initially Fluent English Proficient", 
	"Reclassified Fluent English Proficient", "To Be Determined") # Labels as provided by Aspire, matches Cali AYP Definitions of Subgroups.
levels(asp$SES_STATUS) <- c(NA, "Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(asp$IEP_STATUS) <- c(NA, "Student with Disabilities: No", "Student with Disabilities: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(asp$GENDER) <- c('Gender: Female', 'Gender: Male')
levels(asp$ETHNICITY) <- c(NA, 'Black or African American', "American Indian or Alaskan Native", levels(asp$ETHNICITY)[-(1:3)])

##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary" and ran basic descriptives:
asp$ACHIEVEMENT_LEVEL <- ordered(asp$ACHIEVEMENT_LEVEL, levels = 1:5, labels=c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

##  Set all variables to the correct class for merging:

##  ID - change to as.character.  Will need to make sure there are no duplicates accross CMO's / LAUSD
asp$ID <- as.character(asp$ID)

#  Scores outside of CST scale range - probably from the CAPA ...
asp$TEST_TYPE <- NA
asp$TEST_TYPE[asp$SCALE_SCORE >= 150 & asp$SCALE_SCORE <= 600] <- "CST"

## VALID_CASE
asp$VALID_CASE <- "VALID_CASE"

#  Invalidate students with a missing or non-tested grade
asp$VALID_CASE[is.na(asp$GRADE)] <- "INVALID_CASE"

asp$VALID_CASE[asp$SCALE_SCORE < 150 | is.na(asp$SCALE_SCORE)] <- "INVALID_CASE"

# Duplicates
# DISTRICT_NUMBER - dups are missing a DISTRICT_NUMBER ID.  All else is == so INVALIDate these records
asp <- data.table(asp, key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE", "DISTRICT_NUMBER"))
		      setkeyv(asp, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE"))
dups <- data.table(asp[c(which(duplicated(asp))-1, which(duplicated(asp))),], key=key(asp))
asp$VALID_CASE[which(duplicated(asp))-1] <- "INVALID_CASE"

setkeyv(asp, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE", "INSTRUCTOR_NUMBER_1")) # Add SCORE for kids with both Instructor # == NA (keep highest score)
setkeyv(asp, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID"))
dups <- data.table(asp[c(which(duplicated(asp))-1, which(duplicated(asp))),], key=c("YEAR", "CONTENT_AREA","GRADE", "ID", "INSTRUCTOR_NUMBER_1"))
asp$VALID_CASE[which(duplicated(asp))-1] <- "INVALID_CASE"

## No more dups added.  
# setkeyv(asp, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "SCALE_SCORE"))
# setkeyv(asp, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
# dups <- data.table(asp[c(which(duplicated(asp))-1, which(duplicated(asp))),], key=c("YEAR", "CONTENT_AREA","GRADE", "ID"))
# asp$VALID_CASE[which(duplicated(asp))-1] <- "INVALID_CASE" 

summary(as.factor(asp$VALID_CASE))
# 2068 total INVALID_CASE's

asp$CONTENT_GROUP <- NULL

asp$INSTRUCTOR_NUMBER_2 <- NULL 
asp$INSTRUCTOR_NUMBER_3 <- NULL 
asp$INSTRUCTOR_NUMBER_4 <- NULL 
asp$INSTRUCTOR_4_WEIGHT <- NULL 
asp$INSTRUCTOR_2_WEIGHT <- NULL 
asp$INSTRUCTOR_3_WEIGHT <- NULL 

##  Get variables into proper class for merging
asp$SCHOOL_NUMBER <- as.character(asp$SCHOOL_NUMBER)
asp$SCHOOL_NAME <- as.character(asp$SCHOOL_NAME)
asp$DISTRICT_NUMBER <- as.character(asp$DISTRICT_NUMBER)
asp$DISTRICT_NAME <- as.character(asp$DISTRICT_NAME)
asp$INSTRUCTOR_NUMBER_1 <- as.character(asp$INSTRUCTOR_NUMBER_1)


###
###  Green Dot
###

###  Identify new IDs.  Just add everything (like other CMOs and sort out the duplicates after comparing to OLD data in SGP object.)

# gd.old <- read.delim("./Data/Base_Files/Green Dot Public Schools/Green_Dot_avi_121211.txt", header=TRUE)
# gd.old <- gd.old[gd.old$YEAR==2011,]
# gd.11 <- read.delim("./Data/Base_Files/Green Dot Public Schools/SGP_data_Oct_2012_Green_Dot_Final_Priors.txt", header=TRUE)
# # new.ids1 <- unique(sort(gd.11$ID))[!unique(sort(gd.11$ID)) %in% unique(gd.old$ID)]
# new.ids <- unique(gd.11$ID[!gd.11$ID %in% gd.old$ID])
# old.ids <- unique(gd.11$ID[gd.11$ID %in% gd.old$ID])

# length(new.ids)
# length(old.ids)

# gd <- read.delim("./Data/Base_Files/Green Dot Public Schools/SGP_data_Oct_2012_Green_Dot_Final.txt", header=TRUE) # New text file
# gd$INSTRUCTOR_NUMBER_. <- NULL
# gd$INSTRUCTOR_._WEIGHT <- NULL

# ids12no <- unique(gd$ID[!gd$ID %in% gd.11$ID])
# ids.old.no <- unique(gd$ID[!gd$ID %in% gd.old$ID])
# ids12yes <- unique(gd$ID[gd$ID %in% gd.11$ID])
# ids.old.yes <- unique(gd$ID[gd$ID %in% gd.old$ID])

# new.need <- unique(new.ids[new.ids %in% ids.old.no])
# identical(new.ids, new.need) # [1] TRUE

# no.priors <- unique(ids.old.no[!ids.old.no %in% new.need])

# gd2 <- gd.11[gd.11$ID %in% new.need,]
# gd <- rbind.fill(gd1, gd2)

gd <- rbind.fill(read.delim("./Data/Base_Files/Green Dot Public Schools/SGP_data_Oct_2012_Green_Dot_Final_Priors.txt", header=TRUE), 
				 read.delim("./Data/Base_Files/Green Dot Public Schools/SGP_data_Oct_2012_Green_Dot_Final.txt", header=TRUE))

gd$CMO_NAME <- "Green Dot" # Set to this to match last year's name - submitted as 'Green Dot Public Schools'
gd$INSTRUCTOR_NUMBER_2 <- NULL 
gd$INSTRUCTOR_NUMBER_. <- NULL 
gd$INSTRUCTOR_2_WEIGHT <- NULL 
gd$INSTRUCTOR_._WEIGHT <- NULL 

# Set up a system of TEST_TYPES.  
gd$TEST_TYPE <- gd$CONTENT_AREA
levels(gd$TEST_TYPE)[grep("CMA", levels(gd$TEST_TYPE))] <- "CMA"
levels(gd$TEST_TYPE)[-grep("CMA", levels(gd$TEST_TYPE))] <- "CST"
summary(gd$TEST_TYPE)
gd$TEST_TYPE <- as.character(gd$TEST_TYPE)

# Set up a generic system of CONTENT_AREA for all CMOs.  
levels(gd$CONTENT_AREA)[grep("CMA", levels(gd$CONTENT_AREA))]
levels(gd$CONTENT_AREA) <- gsub("CMA ","", levels(gd$CONTENT_AREA))

for (l in c('Grade 5 ', 'Grade 6 ', 'Grade 7 ', 'Grade 8 ', ' 05', ' 06', ' 07', ' 08', ' 8', ' 09', ' 10', ' 11')) {
	levels(gd$CONTENT_AREA) <- gsub(l, "", levels(gd$CONTENT_AREA))
}
levels(gd$CONTENT_AREA) <- toupper(levels(gd$CONTENT_AREA))
levels(gd$CONTENT_AREA) <- gsub("MATH", "MATHEMATICS", levels(gd$CONTENT_AREA))
levels(gd$CONTENT_AREA) <- gsub(" ", "_", levels(gd$CONTENT_AREA))
levels(gd$CONTENT_AREA) <- gsub("__", "", levels(gd$CONTENT_AREA))
levels(gd$CONTENT_AREA) <- gsub("INTEGRATED/COORDINATED", "INTEGRATED", levels(gd$CONTENT_AREA))
summary(gd$CONTENT_AREA)

##  ID - change to as.character.  Will need to make sure there are no duplicates accross CMO's / LAUSD
gd$ID <- as.character(gd$ID)

levels(gd$ETHNICITY) <- gsub("/", " or ", levels(gd$ETHNICITY))
levels(gd$ETHNICITY)[5] <- "Hispanic"

levels(gd$ELL_STATUS) <- c("English Learner", "English Only", "Initially Fluent English Proficient", 
	"Reclassified Fluent English Proficient", "To Be Determined", "English Learner", "English Only") # Labeled to match Aspire , "Unknown"
levels(gd$SES_STATUS) <- c("Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(gd$IEP_STATUS) <- c("Student with Disabilities: No", "Student with Disabilities: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(gd$GENDER) <- c('Gender: Female', 'Gender: Male') 

##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary" and ran basic descriptives:
gd$ACHIEVEMENT_LEVEL <- ordered(gd$ACHIEVEMENT_LEVEL, levels = c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced")) 


## VALID_CASE
gd$VALID_CASE <- "VALID_CASE"
gd$VALID_CASE[gd$TEST_TYPE!="CST"] <- "INVALID_CASE"

# Two kids with duplicate IDs.  Only one has 2011 and 12 data so take that one
# GD also confirmed that they don't know who this kid is
gd$VALID_CASE[gd$ID=="6054360974" & gd$LAST_NAME=="SMITH      "] <- "INVALID_CASE"


# This also gets the two kids with some duplicate cases, so order by highest score too
gd <- data.table(gd, key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE"))
setkeyv(gd,  c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID"))
dups <- data.table(gd[c(which(duplicated(gd))-1, which(duplicated(gd))),], key=c("ID", "YEAR", "CONTENT_AREA"))

gd$VALID_CASE[which(duplicated(gd))-1] <- "INVALID_CASE"

setkeyv(gd,  c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "SCALE_SCORE"))
setkeyv(gd,  c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
dups <- data.table(gd[c(which(duplicated(gd))-1, which(duplicated(gd))),], key=key(gd))

gd$VALID_CASE[gd$ID=="6054193394" & gd$CONTENT_AREA=="ELA" & gd$GRADE==10] <- "INVALID_CASE" # student is 8th grader in 2011 ...  duplicate with grade 9 & 10 in 2012.
gd$VALID_CASE[gd$ID=="9107644601" & gd$CONTENT_AREA=="INTEGRATED_MATHEMATICS_1" & gd$GRADE==9] <- "INVALID_CASE" # student is 9th-11th grader in 2012

summary(as.factor(gd$VALID_CASE)) #448 after including both 11 & 12 data

##  Get variables into proper class for merging
gd$SCHOOL_NUMBER <- as.character(gd$SCHOOL_NUMBER)
levels(gd$SCHOOL_NAME)[1] <- NA
gd$SCHOOL_NAME <- as.character(gd$SCHOOL_NAME)
gd$DISTRICT_NUMBER <- NULL #  All blank or "n/a"
gd$DISTRICT_NAME <- NULL #  All blank or "n/a"
gd$INSTRUCTOR_NUMBER_1 <- as.character(gd$INSTRUCTOR_NUMBER_1)
gd$INSTRUCTOR_1_WEIGHT <- NULL


###
###  PUC
###

puc <- read.delim("./Data/Base_Files/PUC/PUC_SGP_Data_Schema.11.12.101912.txt", header=TRUE) #
# puc.old <- read.delim("./Data/Base_Files/PUC/PUC_Data_avi_020912.txt", header=TRUE) #  New .txt file!!!

puc$CMO_NAME <- "PUC"  #  Change from "PUC Schools" to match last year

puc$INSTRUCTOR_NUMBER_2 <- NULL 
puc$INSTRUCTOR_NUMBER_. <- NULL 
puc$INSTRUCTOR_2_WEIGHT <- NULL 
puc$INSTRUCTOR_._WEIGHT <- NULL 

# Set up a generic system of CONTENT_AREA for all CMOs.  
# Renamed PUC's Test Type variable "CST Test Name" in the .txt file to match other CMO's
# "Science and LIFE_SCIENCE collapsed into the same level-"CST_Science/LifeScience".  Need to seperate by grade.
# levels(puc$CONTENT_AREA) <- c("ALGEBRA_I", "ALGEBRA_I", "ALGEBRA_II", "BIOLOGY", "BIOLOGY", "CHEMISTRY", "CHEMISTRY", "ELA", "GENERAL_MATHEMATICS", 
	# "GEOMETRY", "GEOMETRY", "HISTORY", "US HISTORY", "INTEGRATED_MATHEMATICS_1", "MATHEMATICS", "MATHEMATICS",
	# "PHYSICS", "SCIENCE", "SCIENCE", "SCIENCE", "SUMMATIVE_HS_MATHEMATICS", "WORLD_HISTORY", "WORLD_HISTORY")  
levels(puc$CONTENT_AREA) <- c("ALGEBRA_I", "ALGEBRA_II", "BIOLOGY", "CHEMISTRY", "ELA", "GEOMETRY", "US_HISTORY", 
	"MATHEMATICS", "PHYSICS", "SCIENCE", "SUMMATIVE_HS_MATHEMATICS", "WORLD_HISTORY")  

puc$TEST_TYPE <- "CST"	

##  ID - change to as.character.
puc$ID <- as.character(puc$ID)

##  ETHNICITY, ELL_STATUS, GIFTED_TALENTED_STATUS & IEP_STATUS

levels(puc$ETHNICITY) <- c(NA, levels(puc$ETHNICITY)[-c(1,15:16)], NA, NA)
levels(puc$ETHNICITY)[6] <- 'Hispanic'

levels(puc$ELL_STATUS) <- c("Unknown", "English Learner", "English Only", "Initially Fluent English Proficient", "Reclassified Fluent English Proficient") # Labeled to match Aspire
levels(puc$SES_STATUS) <- c(NA, "Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(puc$IEP_STATUS) <- c(NA, "Student with Disabilities: No", "Student with Disabilities: Yes") # AVI based on Cali AYP Definitions of Subgroups
levels(puc$GENDER) <- c(NA, 'Gender: Female', 'Gender: Male') 

##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary" and ran basic descriptives:
puc$ACHIEVEMENT_LEVEL <- ordered(puc$ACHIEVEMENT_LEVEL, levels = c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

## VALID_CASE
puc$VALID_CASE <- "VALID_CASE"

puc$VALID_CASE[is.na(puc$SCALE_SCORE)] <- "INVALID_CASE"

# Duplicates  -  same scores and INSTRUCTOR_NUMBER_1
puc <- data.table(puc, key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE", "INSTRUCTOR_NUMBER_1"))
dups <- data.table(puc[c(which(duplicated(puc))-1, which(duplicated(puc))),], key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
puc$VALID_CASE[which(duplicated(puc))-1] <- "INVALID_CASE"  #  Doesn't seem to matter which.  Most LAUSD, ~13 PUC, all but one of those has the same school number too

setkeyv(puc, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE","ID", "SCALE_SCORE"))
setkeyv(puc, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE","ID"))
dups <- data.table(puc[c(which(duplicated(puc))-1, which(duplicated(puc))),], key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
puc$VALID_CASE[which(duplicated(puc))-1] <- "INVALID_CASE"  

#  handful of students from 2009 with more than one student given a ID and one student with multiple grade levels in 2009
setkeyv(puc, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "SCALE_SCORE"))
setkeyv(puc, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
dups <- data.table(puc[c(which(duplicated(puc))-1, which(duplicated(puc))),], key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
puc$VALID_CASE[which(duplicated(puc))-1] <- "INVALID_CASE"  # just invalidate one for now...

summary(as.factor(puc$VALID_CASE))
#  144 invalid cases now  

##  Get variables into proper class for merging
puc$SCHOOL_NUMBER <- as.character(puc$SCHOOL_NUMBER)
puc$SCHOOL_NAME <- as.character(puc$SCHOOL_NAME)
puc$DISTRICT_NAME <- as.character(puc$DISTRICT_NAME)
puc$DISTRICT_NUMBER <- as.character(puc$DISTRICT_NUMBER)
puc$INSTRUCTOR_NUMBER_1 <- as.character(puc$INSTRUCTOR_NUMBER_1)


####
####  COMBINE ALL CMO FILES TOGETHER
####

CMO_Data_LONG <- rbind.fill(asp, gd, puc, al)

CMO_Data_LONG$CONTENT_AREA <- as.character(CMO_Data_LONG$CONTENT_AREA)

levels(CMO_Data_LONG$EMH_LEVEL) <- c("Elementary", "Secondary", "Elementary", "High School", "Middle School", "High School", "Middle School") #Still not great/consistent ...

#  Clean names - Some are all caps
#  Added stuff for LAUSD's Schools, but this function only works on FULL character strings - had to get cleaver if needed.

# "LA",  only for school names
    capwords <- function(x) {
      special.words <- c("ELA", "EMH", "II", "III", "IV", "ACD", "CH", "CHT", "CMNT", "CTR", "CDS", "EL", "ESP", "ESL", "HS", "MS", "M/S", "M/S/T",
      	"LC", "PC", "RFK", "SH", 'SJ:', "YTH", 'CALSECHS','CALSMS','CCECHS','CCMS','eCALS','LCA','LCHS','NECA','SRCA','TCA','TCHS','LAUSD', 'CRHS')
		.capwords_internal <- function(x) {
			if (x %in% special.words) return(x)
			s <- gsub("_", " ", x)
			s <- gsub("[.]", " ", s)
			s <- strsplit(s, split=" ")[[1]]
			s <- paste(toupper(substring(s, 1,1)), tolower(substring(s, 2)), sep="", collapse=" ")
			s <- strsplit(s, split="-")[[1]]
			paste(toupper(substring(s, 1,1)), substring(s, 2), sep="", collapse="-")
		}
		if (length(strsplit(x, split="_")[[1]]) > 1) {
			x <- gsub("_", " ", x)
		}
		if (length(strsplit(x, split="[.]")[[1]]) > 1) {
			x <- gsub("[.]", " ", x)
		}
		return(sapply(x, function(x) paste(sapply(strsplit(x, split=" ")[[1]], .capwords_internal), collapse=" "), USE.NAMES=FALSE))
	}

trimWhiteSpace <- function(line) gsub("(^ +)|( +$)", "", line)

f.names <- capwords(levels(CMO_Data_LONG$FIRST_NAME))
levels(CMO_Data_LONG$FIRST_NAME) <- trimWhiteSpace(f.names)

l.names <- capwords(levels(CMO_Data_LONG$LAST_NAME))
levels(CMO_Data_LONG$LAST_NAME) <- trimWhiteSpace(l.names)

# levels(CMO_Data_LONG$FIRST_NAME)[1] <- NA
levels(CMO_Data_LONG$LAST_NAME)[1] <- NA

save(CMO_Data_LONG, file="./Data/CMO_Data_LONG-2012.Rdata")

rm(al); rm(asp); rm(gd); rm(puc); gc()


### ### ### ### ### ### ### ### ### ### ### ### ### ###
###			Read in and clean the annual LAUSD files
### ### ### ### ### ### ### ### ### ### ### ### ### ###

###
###  2012 :: Add in Demographic Info, change from wide to long. change Var names/factor values, rinse & repeat 
###

la.2012 <- read.delim("./Data/Base_Files/LAUSD/SY2011-12/Star 2012.txt", header=TRUE)
names(la.2012) <- toupper(names(la.2012))

demog.2012 <- read.delim("./Data/Base_Files/LAUSD/SY2011-12/Demographics 2012.txt", header=TRUE)
names(demog.2012) <- toupper(names(demog.2012))

# Merge in the demographic data.  Keep as data frame for column number indexing.  Change to data.table for teacher ID merge.
la.2012 <- merge(la.2012, demog.2012, by="STUDENT_PSEUDO_ID")


###  Wide to long ::

##  ELA
tmp.la <- la.2012[, c(1:6,9, grep("ELA", names(la.2012)), 27:37)] #Select all columns with "ELA" in the names
names(tmp.la)[8:10] <- c("TEST_TYPE", "SCALE_SCORE", "ACHIEVEMENT_LEVEL") # Rename generic and to match up with CMO data
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out a few records
tmp.la$TEST_TYPE[tmp.la$RECTYPE==2] <- 3
tmp.la$TEST_TYPE[tmp.la$RECTYPE==3] <- 4
tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CMA_is only in grades 3-9, these are CST_teSTS_in grades 2, 10 & 11
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))
tmp.la$CONTENT_AREA <- factor(paste(tmp.la$TEST_TYPE, " ELA", sep=""))#  Will later match up with CMO data "CONTENT_AREA"
levels(tmp.la$CONTENT_AREA)[3] <- "ELA"
# tmp.la$CONTENT_AREA <- "ELA" #Put in the CONTENT_AREA Field

la <- tmp.la

##  Math
tmp.la <- la.2012[, c(1:6,9, grep("MATH", names(la.2012)), 27:37)] 
names(tmp.la)[8:11] <- c("LAUSD_TEST_CODE", "TEST_TYPE", "SCALE_SCORE", "ACHIEVEMENT_LEVEL") # Rename MATH specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out a few records

tmp.la$TEST_TYPE[tmp.la$RECTYPE==2] <- 3
tmp.la$TEST_TYPE[tmp.la$RECTYPE==3] <- 4
tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CMA_is only in grades 3-9, these are CST_teSTS_in grades 2, 10 & 11
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))

#table(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE, tmp.la$GRADE)

tmp.la$CONTENT_AREA <- paste(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE); tmp.la$CONTENT_AREA <- factor(tmp.la$CONTENT_AREA)
levels(tmp.la$CONTENT_AREA) <- c("CAPA_MATHEMATICS", "CMA_MATHEMATICS", "CMA_MATHEMATICS", "CMA_ALGEBRA I", "CMA_GEOMETRY", "MATHEMATICS", "MATHEMATICS", "GENERAL_MATHEMATICS", "SUMMATIVE_HS_MATHEMATICS", "ALGEBRA_I", "INTEGRATED_MATHEMATICS_1", "GEOMETRY", "INTEGRATED_MATHEMATICS_2", "ALGEBRA_II", "CST_MATH_CODE_8", "STS_MATHEMATICS", "STS_MATHEMATICS") #  Numbers from LAUSD data dictionary. 
# tmp.la$CONTENT_AREA <- "MATHEMATICS" #Put in the CONTENT_AREA Field

la <- rbind.fill(tmp.la, la)

## SCIENCE
grep("SCIENCE", names(la.2012)) # EOCSCIENCE, "Social Science", etc.  Don't use this here!

tmp.la <- la.2012[, c(1:6,9, 11, 14, 17, 23, 27:37)] #Select SCIENCE fields - do this seperately from EOC-SCIENCE...
names(tmp.la)[8:11] <- c("LAUSD_TEST_CODE", "TEST_TYPE", "SCALE_SCORE", "ACHIEVEMENT_LEVEL") # Rename SCIENCE specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out missing records

tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CMA_is only in grade 5
tmp.la$TEST_TYPE[tmp.la$RECTYPE==2] <- 3 # There are a handful of CAPA_tests
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))

tmp.la$CONTENT_AREA <- paste(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE); tmp.la$CONTENT_AREA <- factor(tmp.la$CONTENT_AREA)
levels(tmp.la$CONTENT_AREA) <- c("CAPA_SCIENCE", "CMA_SCIENCE", "CMA_EARTH_SCIENCE", "CMA_BIOLOGY", "CMA_CHEMISTRY", "CMA_PHYSICS", "CMA_INTEGRATED_SCIENCE_1", "CMA_INTEGRATED_SCIENCE_2", "CMA_UNKNOWN_SCIENCE", "SCIENCE", "EARTH_SCIENCE", "BIOLOGY", "CHEMISTRY",  "PHYSICS", "INTEGRATED_SCIENCE_1", "INTEGRATED_SCIENCE_2", "INTEGRATED_SCIENCE_3", "INTEGRATED_SCIENCE_4", "UNKNOWN_SCIENCE") #  Numbers from LAUSD data dictionary. 

# table(tmp.la$TEST_TYPE, tmp.la$CONTENT_AREA, tmp.la$GRADE)

# tmp.la$CONTENT_AREA <- "SCIENCE" #Put in the CONTENT_AREA Field

la <- rbind.fill(tmp.la, la)

##  EOC SCIENCE
tmp.la <- la.2012[, c(1:6,9, 11, 14, 20, 26:37)] #Select SCIENCE fields - do this seperately from EOC-SCIENCE...
names(tmp.la)[8:11] <- c("LAUSD_TEST_CODE", "TEST_TYPE", "SCALE_SCORE", "ACHIEVEMENT_LEVEL") # Rename SCIENCE specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE[is.na(tmp.la$TEST_TYPE) & tmp.la$RECTYPE==1] <- 1  #  CST_TESTS_ONLY
tmp.la$TEST_TYPE <- factor(tmp.la$TEST_TYPE, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))

#table(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE, tmp.la$GRADE)

tmp.la$CONTENT_AREA <- paste(tmp.la$TEST_TYPE, tmp.la$LAUSD_TEST_CODE); tmp.la$CONTENT_AREA <- factor(tmp.la$CONTENT_AREA)
levels(tmp.la$CONTENT_AREA) <- c("CMA_EARTH_SCIENCE", "CMA_BIOLOGY", "CMA_CHEMISTRY",  "CMA_PHYSICS", "CMA_INTEGRATED_SCIENCE_1", "CMA_INTEGRATED_SCIENCE_2", "EARTH_SCIENCE", "BIOLOGY", "CHEMISTRY",  "PHYSICS", "INTEGRATED_SCIENCE_1", "INTEGRATED_SCIENCE_2", "INTEGRATED_SCIENCE_3", "INTEGRATED_SCIENCE_4") #  Numbers from LAUSD data dictionary. 
 
#table(tmp.la$TEST_TYPE, tmp.la$CONTENT_AREA, tmp.la$GRADE)

# tmp.la$CONTENT_AREA <- "SCIENCE" #Put in the CONTENT_AREA Field

la <- rbind.fill(tmp.la, la)

## History
tmp.la <- la.2012[, c(1:6,9, grep("SOCIALSCIENCE", names(la.2012)), 27:37)] 
names(tmp.la)[8:9] <- c("SCALE_SCORE", "ACHIEVEMENT_LEVEL") # Rename HISTORY specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE <- factor(1, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))
tmp.la$CONTENT_AREA <- factor("HISTORY")
#tmp.la$CONTENT_AREA <- "HISTORY" #Put in the CONTENT_AREA Field

la <- rbind.fill(tmp.la, la)

##  WORLD_HISTORY

tmp.la <- la.2012[, c(1:6,9, grep("WORLDHISTORY", names(la.2012)), 27:37)] 
names(tmp.la)[8:9] <- c("SCALE_SCORE", "ACHIEVEMENT_LEVEL") # Rename WORLD_HISTORY specific vars to generic
tmp.la <- tmp.la[!is.na(tmp.la$SCALE_SCORE),] # weed out MANY records

tmp.la$TEST_TYPE <- factor(1, levels=1:4, labels=c("CST", "CMA", "CAPA", "STS"))
tmp.la$CONTENT_AREA <- factor("WORLD_HISTORY")
# tmp.la$CONTENT_AREA <- "HISTORY" #Put in the CONTENT_AREA Field

la <- rbind.fill(tmp.la, la)

dim(la)

###  Rename Vars, Set factor levels, etc. etc.

#  Which School number?  The one in demog file has lots of NA's...
names(la)[c(1, 4, 10, 14, 17:20)] <- c("ID", "SCHOOL_NUMBER", "YEAR", "SCHOOL_NAME", "ETHNICITY", "ELL_STATUS", "SES_STATUS", "SPECIFIC_DISABILITY") # Add IEP_STATUS later

la$OCCOCCURRENCEDESCR <- NULL  # Remove.  All in Spring
# la$PRLPREFERREDLOCATIONCODE <- NULL
la$CDSCODE <- NULL #  All LAUSD's state code.

# la$GRADECODE <- factor(la$GRADECODE, ordered=TRUE)

la$ID <- as.character(la$ID)

##  ACHIEVEMENT_LEVEL # based levels/labels info off of what is in the LAUSD "data dictionary"
la$ACHIEVEMENT_LEVEL <- ordered(la$ACHIEVEMENT_LEVEL, levels = 1:5, labels=c("Far Below Basic", "Below Basic", "Basic", "Proficient", "Advanced"))

##  ETHNICITY, ELL_STATUS, GENDER & IEP_STATUS

levels(la$GENDER) <- c(NA, NA, 'Gender: Female', 'Gender: Male')
levels(la$ETHNICITY) <- c('American Indian or Alaskan Native', 'Asian', 'Black or African American', 'Filipino', 'Hispanic', 'Pacific Islander', 'Unknown', 'White')  # Conform to some of the conventions used in the CMOs.  Still lots of inconsistency - some have more detail than others ...

levels(la$ELL_STATUS) <- c("English Only", "Initially Fluent English Proficient", "English Learner", "Reclassified Fluent English Proficient", "Unknown")
levels(la$SES_STATUS) <- c("Socioeconomically Disadvantaged: No", "Socioeconomically Disadvantaged: Yes") # AVI based on Cali AYP Definitions of Subgroups

la$IEP_STATUS <- la$SPECIFIC_DISABILITY #  So much detail in the SPED Code.  Might be interesting to look at different disability groups ...
levels(la$IEP_STATUS) <- c("Student with Disabilities: No", rep("Student with Disabilities: Yes", 17)) # AVI based on Cali AYP Definitions of Subgroups


## VALID_CASE
la$VALID_CASE <- "VALID_CASE"

la$VALID_CASE[la$TEST_TYPE != "CST"] <- "INVALID_CASE"

#  Total duplicates
#  Almost are all from Science - overlap of EOC Science and Science?
la <- data.table(la, key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCALE_SCORE", "SCHOOL_NUMBER"))
dups <- data.table(la[c(which(duplicated(la))-1, which(duplicated(la))),], key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))

la$VALID_CASE[which(duplicated(la))-1] <- "INVALID_CASE"  # 436 cases - checked again and some triplicates, but all are invalid already.

# Different Score dups ::  Only one kid in 2012 with different recorded scores, and different school
#  I think these are dups from the Science/EOC Science group
setkeyv(la, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCHOOL_NUMBER", "SCALE_SCORE"))
setkeyv(la, c("VALID_CASE", "YEAR", "CONTENT_AREA", "GRADE", "ID", "SCHOOL_NUMBER"))
dups <- data.table(la[c(which(duplicated(la))-1, which(duplicated(la))),], key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
dim(dups["VALID_CASE"])
la$VALID_CASE[which(duplicated(la))-1] <- "INVALID_CASE"  # 32,197 cases

setkeyv(la, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "SCALE_SCORE"))
setkeyv(la, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
dups <- data.table(la[c(which(duplicated(la))-1, which(duplicated(la))),], key=c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
dim(dups["VALID_CASE"])
la$VALID_CASE[which(duplicated(la))-1] <- "INVALID_CASE"  # 66 (valid) cases

summary(as.factor(la$VALID_CASE)) #91,286

#  Another set???  - All INVALID arealdy


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

rm(la.2012)
rm(demog.2012)
gc()

###
###  Collect & Merge in the TEACHER DATA 
###

####  2012
###  Elementary Schools :: Collect all three periods
##  EP1
tchr.2012 <- read.delim("./Data/Base_Files/LAUSD/SY2011-12/ElementaryMarks 2011-12_EP1.txt", header=TRUE)
#table(tchr.2012$CRS_COURSE_CODE, tchr.2012$CRS_COURSE_NAME)

tchr.2012 <- tchr.2012[c(9:8, 2:3, 5, 7)] #"student_pseudo_id"   "teacher_pseudo_id"   "MARKING_PERIOD_CODE" "SCH_CDS_CODE" "PRL_PREFERRED_LOCATION_CODE" "CRS_COURSE_NAME"
names(tchr.2012) <- c("ID", "INSTRUCTOR_NUMBER_1", "MARKING_PERIOD", "PRLPREFERREDLOCATIONCODE", "SCHOOL_NUMBER", "CONTENT_AREA")
tchr.2012 <- tchr.2012[!is.na(tchr.2012$INSTRUCTOR_NUMBER_1),]
tchr.2012 <- tchr.2012[tchr.2012$CONTENT_AREA %in% c("MATHEMA", "READING", "ELD REA", "WRITING", "ELD WRI", "HIST SO", "SCIENCE"),]
tchr.2012$CONTENT_AREA<-droplevels(tchr.2012$CONTENT_AREA)
levels(tchr.2012$CONTENT_AREA) <- c("ELA", "ELA", "HISTORY", "MATHEMATICS", "ELA", "SCIENCE", "ELA")

tchr.2012$ID <- as.character(tchr.2012$ID)
tchr.2012$INSTRUCTOR_NUMBER_1 <- as.character(tchr.2012$INSTRUCTOR_NUMBER_1)

# Remove duplicates
tchr.2012 <- data.table(tchr.2012, key=c("CONTENT_AREA", "SCHOOL_NUMBER", "INSTRUCTOR_NUMBER_1", "ID"))
tchr.2012 <- tchr.2012[which(!duplicated(tchr.2012)),]

lausd.tchr <- tchr.2012

## EP2
tchr.2012 <- read.delim("./Data/Base_Files/LAUSD/SY2011-12/ElementaryMarks 2011-12_EP2.txt", header=TRUE)

tchr.2012 <- tchr.2012[c(9:8, 2:3, 5, 7)]
names(tchr.2012) <- c("ID", "INSTRUCTOR_NUMBER_1", "MARKING_PERIOD", "PRLPREFERREDLOCATIONCODE", "SCHOOL_NUMBER", "CONTENT_AREA")
tchr.2012 <- tchr.2012[!is.na(tchr.2012$INSTRUCTOR_NUMBER_1),]
tchr.2012 <- tchr.2012[tchr.2012$CONTENT_AREA %in% c("MATHEMATICS", "READING", "ELD READING", "WRITING", "ELD WRITING", "HIST SOC SCI", "SCIENCE"),]
tchr.2012$CONTENT_AREA<-droplevels(tchr.2012$CONTENT_AREA)
levels(tchr.2012$CONTENT_AREA) <- c("ELA", "ELA", "HISTORY", "MATHEMATICS", "ELA", "SCIENCE", "ELA")

tchr.2012$ID <- as.character(tchr.2012$ID)
tchr.2012$INSTRUCTOR_NUMBER_1 <- as.character(tchr.2012$INSTRUCTOR_NUMBER_1)
tchr.2012 <- data.table(tchr.2012, key=c("CONTENT_AREA", "SCHOOL_NUMBER", "INSTRUCTOR_NUMBER_1", "ID"))
tchr.2012 <- tchr.2012[which(!duplicated(tchr.2012)),]

lausd.tchr <- rbind(lausd.tchr, tchr.2012)

## EP3
tchr.2012 <- read.delim("./Data/Base_Files/LAUSD/SY2011-12/ElementaryMarks 2011-12_EP3.txt", header=TRUE)

tchr.2012 <- tchr.2012[c(9:8, 2:3, 5, 7)]
names(tchr.2012) <- c("ID", "INSTRUCTOR_NUMBER_1", "MARKING_PERIOD", "PRLPREFERREDLOCATIONCODE", "SCHOOL_NUMBER", "CONTENT_AREA")
tchr.2012 <- tchr.2012[!is.na(tchr.2012$INSTRUCTOR_NUMBER_1),]
tchr.2012 <- tchr.2012[tchr.2012$CONTENT_AREA %in% c("MATHEMATICS", "READING", "ELD READING", "WRITING", "ELD WRITING", "HIST SOC SCI", "SCIENCE"),]
tchr.2012$CONTENT_AREA<-droplevels(tchr.2012$CONTENT_AREA)
levels(tchr.2012$CONTENT_AREA) <- c("ELA", "ELA", "HISTORY", "MATHEMATICS", "ELA", "SCIENCE", "ELA")

tchr.2012$ID <- as.character(tchr.2012$ID)
tchr.2012$INSTRUCTOR_NUMBER_1 <- as.character(tchr.2012$INSTRUCTOR_NUMBER_1)
tchr.2012 <- data.table(tchr.2012, key=c("CONTENT_AREA", "SCHOOL_NUMBER", "INSTRUCTOR_NUMBER_1", "ID"))
tchr.2012 <- tchr.2012[which(!duplicated(tchr.2012)),]

lausd.tchr <- rbind(lausd.tchr, tchr.2012)


###  Secondary Schools :: add to Elem.
tchr.2012 <- read.delim("./Data/Base_Files/LAUSD/SY2011-12/SecondaryMarks 2011-12.txt", header=TRUE)

tchr.2012 <- tchr.2012[c(11:10, 2:3, 5, 6, 8)] # ,12
names(tchr.2012) <- c("ID", "INSTRUCTOR_NUMBER_1", "MARKING_PERIOD", "PRLPREFERREDLOCATIONCODE", "SCHOOL_NUMBER", "CONTENT_AREA", "COURSE_NAME")
tchr.2012 <- tchr.2012[!is.na(tchr.2012$INSTRUCTOR_NUMBER_1),]

# summary(tchr.2012$COURSE_NAME[tchr.2012$CONTENT_AREA == "COMPUTER SCIENCE"])
# summary(tchr.2012$COURSE_NAME[tchr.2012$CONTENT_AREA == "INTERDISCIPLINARY"])
# tchr.2012[tchr.2012$CONTENT_AREA == "INTERDISCIPLINARY",] All "ELA" so add it in
# summary(tchr.2012$CONTENT_AREA[tchr.2012$COURSE_NAME == "HOMEROOM"])
# summary(tchr.2012$COURSE_NAME[tchr.2012$CONTENT_AREA == "SP ED:VOC ED F HAND"]) #  Lots of COURSES/INSTRCTORS we could add here.  Some big/obvious:

###  Adds about 25,000 courses
math.index <- grep("MATH",names(summary(tchr.2012$COURSE_NAME[tchr.2012$CONTENT_AREA == "SP ED:VOC ED F HAND"])))
ela.index <- c(grep("ELA",names(summary(tchr.2012$COURSE_NAME[tchr.2012$CONTENT_AREA == "SP ED:VOC ED F HAND"]))),
				grep("ENG",names(summary(tchr.2012$COURSE_NAME[tchr.2012$CONTENT_AREA == "SP ED:VOC ED F HAND"]))),
				grep("READ",names(summary(tchr.2012$COURSE_NAME[tchr.2012$CONTENT_AREA == "SP ED:VOC ED F HAND"]))),
				grep("WRIT",names(summary(tchr.2012$COURSE_NAME[tchr.2012$CONTENT_AREA == "SP ED:VOC ED F HAND"]))))
sci.index <- c(grep("SCI",names(summary(tchr.2012$COURSE_NAME[tchr.2012$CONTENT_AREA == "SP ED:VOC ED F HAND"]))))
hst.index <- c(grep("HIST",names(summary(tchr.2012$COURSE_NAME[tchr.2012$CONTENT_AREA == "SP ED:VOC ED F HAND"]))))
courses <- names(summary(tchr.2012$COURSE_NAME[tchr.2012$CONTENT_AREA == "SP ED:VOC ED F HAND"]))
for (i in math.index) {
	tchr.2012$CONTENT_AREA[tchr.2012$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2012$COURSE_NAME == courses[i] ] <- "MATHEMATICS"
}

for (i in ela.index) {
	tchr.2012$CONTENT_AREA[tchr.2012$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2012$COURSE_NAME == courses[i] ] <- "ENGLISH" # will change to ELA
}

for (i in sci.index) {
	tchr.2012$CONTENT_AREA[tchr.2012$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2012$COURSE_NAME == courses[i] ] <- "SCIENCE"
}

for (i in hst.index) {
	tchr.2012$CONTENT_AREA[tchr.2012$CONTENT_AREA == "SP ED:VOC ED F HAND" & tchr.2012$COURSE_NAME == courses[i] ] <- "SOCIAL SCIENCE"
}


tchr.2012 <- tchr.2012[tchr.2012$CONTENT_AREA %in% c("BILINGUAL-ESL", "ENGLISH", "INTERDISCIPLINARY", "MATHEMATICS", "READING", "SCIENCE", "SOCIAL SCIENCE"),]
tchr.2012$CONTENT_AREA<-droplevels(tchr.2012$CONTENT_AREA)
levels(tchr.2012$CONTENT_AREA) <- c("ELA", "ELA", "ELA", "MATHEMATICS", "ELA", "SCIENCE", "HISTORY")

tchr.2012$CA2 <- tchr.2012$COURSE_NAME
levels(tchr.2012$CA2)[grep("ALGEBRA 1", levels(tchr.2012$CA2))] <- 'ALGEBRA_I'
levels(tchr.2012$CA2)[grep("ALG 1", levels(tchr.2012$CA2))] <- 'ALGEBRA_I'
levels(tchr.2012$CA2)[grep("ALG1", levels(tchr.2012$CA2))] <- 'ALGEBRA_I'
levels(tchr.2012$CA2)[grep("ALG 2", levels(tchr.2012$CA2))] <- 'ALGEBRA_II'
levels(tchr.2012$CA2)[grep("ALGEBRA 2", levels(tchr.2012$CA2))] <- 'ALGEBRA_II'
levels(tchr.2012$CA2)[grep("ALGEBRA READ", levels(tchr.2012$CA2))] <- 'ALGEBRA_I' # why not?
levels(tchr.2012$CA2)[grep("GEOMETRY", levels(tchr.2012$CA2))] <- 'GEOMETRY'
levels(tchr.2012$CA2)[grep("GEOM ", levels(tchr.2012$CA2))] <- 'GEOMETRY'

levels(tchr.2012$CA2)[grep('INTEGR MATH 1', levels(tchr.2012$CA2))] <- "INTEGRATED_MATHEMATICS_1"
levels(tchr.2012$CA2)[grep('INTEGR MATH 2', levels(tchr.2012$CA2))] <- "INTEGRATED_MATHEMATICS_2"
levels(tchr.2012$CA2)[grep('INTEGR MATH 3', levels(tchr.2012$CA2))] <- "INTEGRATED_MATHEMATICS_3"

levels(tchr.2012$CA2)[grep("MATH 4", levels(tchr.2012$CA2))] <- 'MATHEMATICS'
levels(tchr.2012$CA2)[grep("MATH 5", levels(tchr.2012$CA2))] <- 'MATHEMATICS'
levels(tchr.2012$CA2)[grep("MATH 6", levels(tchr.2012$CA2))] <- 'MATHEMATICS'
levels(tchr.2012$CA2)[grep("MATH 7", levels(tchr.2012$CA2))] <- 'MATHEMATICS'
levels(tchr.2012$CA2)[grep("MATH ", levels(tchr.2012$CA2))] <- 'GENERAL_MATHEMATICS'


levels(tchr.2012$CA2)[grep("BIO", levels(tchr.2012$CA2))] <- 'BIOLOGY'
levels(tchr.2012$CA2)[grep("CHEM", levels(tchr.2012$CA2))] <- 'CHEMISTRY'
levels(tchr.2012$CA2)[grep("PHYSICS", levels(tchr.2012$CA2))] <- 'PHYSICS'
levels(tchr.2012$CA2)[grep("EARTH", levels(tchr.2012$CA2))] <- 'EARTH_SCIENCE'
levels(tchr.2012$CA2)[grep("SCI ", levels(tchr.2012$CA2))] <- 'SCIENCE'

levels(tchr.2012$CA2)[grep("SPAN", levels(tchr.2012$CA2))] <- 'SPANISH' # Just to get rid of it later/seperate from ELA
levels(tchr.2012$CA2)[grep("ENGLISH", levels(tchr.2012$CA2))] <- 'ELA'
levels(tchr.2012$CA2)[grep("ENG ", levels(tchr.2012$CA2))] <- 'ELA'
levels(tchr.2012$CA2)[grep("WRIT", levels(tchr.2012$CA2))] <- 'ELA'
levels(tchr.2012$CA2)[grep("WR COMM", levels(tchr.2012$CA2))] <- 'ELA'
levels(tchr.2012$CA2)[grep("LIT", levels(tchr.2012$CA2))] <- 'ELA'
levels(tchr.2012$CA2)[grep("READ", levels(tchr.2012$CA2))] <- 'ELA'

levels(tchr.2012$CA2)[grep("U.S. HIST", levels(tchr.2012$CA2))] <- 'US_HISTORY'
levels(tchr.2012$CA2)[grep("US HIST", levels(tchr.2012$CA2))] <- 'US_HISTORY'
levels(tchr.2012$CA2)[grep("WLD HIST", levels(tchr.2012$CA2))] <- 'WORLD_HISTORY'
levels(tchr.2012$CA2)[grep("SS HIST", levels(tchr.2012$CA2))] <- 'HISTORY'
levels(tchr.2012$CA2)[grep("ESL HIST", levels(tchr.2012$CA2))] <- 'HISTORY'
levels(tchr.2012$CA2)[grep("HIST ALT", levels(tchr.2012$CA2))] <- 'HISTORY'

levels(tchr.2012$CA2)[grep("ESL", levels(tchr.2012$CA2))] <- 'ELA' # Do this after ESL HIST

subjects <- c("ELA", "MATHEMATICS", "GENERAL_MATHEMATICS", 'INTEGRATED_MATHEMATICS_1', 'INTEGRATED_MATHEMATICS_2', 'GEOMETRY',  'ALGEBRA_I', 'ALGEBRA_II', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS', "EARTH_SCIENCE", "SCIENCE", "HISTORY", "US_HISTORY", 'WORLD_HISTORY')

tchr.2012$CA2[!tchr.2012$CA2 %in% subjects] <- NA
tchr.2012$CA2 <- droplevels(tchr.2012$CA2)

table(tchr.2012$CONTENT_AREA, tchr.2012$CA2)
table(tchr.2012$CONTENT_AREA, is.na(tchr.2012$CA2))

tchr.2012$CA2[is.na(tchr.2012$CA2)] <- tchr.2012$CONTENT_AREA[is.na(tchr.2012$CA2)] 
# tchr.2012 <- data.table(tchr.2012[tchr.2012$CA2 %in% subjects,])

tchr.2012 <- data.table(tchr.2012)
setnames(tchr.2012, 'CONTENT_AREA', 'CONTENT_GROUP')
setnames(tchr.2012, 'CA2', 'CONTENT_AREA')

tchr.2012$ID <- as.character(tchr.2012$ID)
tchr.2012$INSTRUCTOR_NUMBER_1 <- as.character(tchr.2012$INSTRUCTOR_NUMBER_1)

#  Remove teachers in same Dept/Content_area in SAME classes in the SAME SCHOOL & SEMESTER first
setkeyv(tchr.2012, c("CONTENT_AREA", "SCHOOL_NUMBER", "MARKING_PERIOD", "INSTRUCTOR_NUMBER_1", "ID"))
tchr.2012 <- tchr.2012[which(!duplicated(tchr.2012)),]

#  Remove teachers in same Content_area in multiple classes in the SAME SCHOOL (hopefully similar to above)
setkeyv(tchr.2012, c("CONTENT_AREA", "SCHOOL_NUMBER", "INSTRUCTOR_NUMBER_1", "ID"))
tchr.2012 <- tchr.2012[which(!duplicated(tchr.2012)),]

#  Remove teachers in same Content_area in multiple classes in Different SCHOOL (looks like most are NA school numbers)
#setkeyv(tchr.2012, c("CONTENT_AREA", "SCHOOL_NUMBER", "INSTRUCTOR_NUMBER_1", "ID") # Get SCHOOL_NUMBER on top 
setkeyv(tchr.2012, c("CONTENT_AREA", "MARKING_PERIOD", "INSTRUCTOR_NUMBER_1", "ID"))
setkeyv(tchr.2012, c("CONTENT_AREA", "INSTRUCTOR_NUMBER_1", "ID"))
tchr.2012 <- tchr.2012[-(which(duplicated(tchr.2012))-1),] # Still take the LATER period - end of year

#  A few dups with same course and time period - different teachers.  Go back and add in Course grades to see if some are NA
#  Nope.  They all lok legit.  Same schools, period, class etc.  Different teachers and different 'marks'.
#  Just keep them and "WIDEN" out the file to put in multiple teachers
#setkeyv(tchr.2012, c("CONTENT_AREA", "INSTRUCTOR_NUMBER_1", "ID")

#unq.ids <- which(!duplicated(tchr.2012)); length(unq.ids)
#dup.ids <- which(duplicated(tchr.2012)); length(dup.ids)
#dups <- tchr.2012[c(dup.ids, (dup.ids-1)),]; key(dups) <- c("ID", "CONTENT_AREA")
#dim(dups)

table(tchr.2012$CONTENT_AREA, tchr.2012$CONTENT_GROUP)
tchr.2012$CONTENT_GROUP <- NULL
tchr.2012$COURSE_NAME <- NULL

lausd.tchr <- data.table(rbind.fill(lausd.tchr, tchr.2012), key=c("CONTENT_AREA", "ID"))

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
#summary(lausd.tchr$TEACHER_COUNT) 
#lausd.tchr[lausd.tchr$TEACHER_COUNT==5,]

lausd.tchr$TEACHER_COUNT <- factor(lausd.tchr$TEACHER_COUNT)
lausd.tchr$CONTENT_AREA <- as.character(lausd.tchr$CONTENT_AREA)
lausd.tchr$ID <- factor(paste(lausd.tchr$ID, lausd.tchr$PRLPREFERREDLOCATIONCODE))
setnames(lausd.tchr, 'INSTRUCTOR_NUMBER_1', 'INSTRUCTOR_NUMBER')
setkeyv(lausd.tchr, c("CONTENT_AREA", "TEACHER_COUNT"))
lausd.tchr$MARKING_PERIOD <- NULL

#LAUSD_Teacher_Links object should be set up already ...
LAUSD_Teacher_Links <- NULL
for (j in subjects) {
	# tmp.tchr <- reshape(lausd.tchr[j],
	tmp.tchr <- reshape(data.frame(subset(lausd.tchr, CONTENT_AREA==j)),
							idvar='ID',
							timevar='TEACHER_COUNT',
							drop=c('CONTENT_AREA', 'SCHOOL_NUMBER', 'PRLPREFERREDLOCATIONCODE'), # take  'MARK' out above now too
							direction='wide',
							sep="_")

	tmp.tchr$CONTENT_AREA <- j
	tmp.tchr$YEAR <- 2012
	
	LAUSD_Teacher_Links <- rbind.fill(LAUSD_Teacher_Links, tmp.tchr)
}

LAUSD_Teacher_Links$PRLPREFERREDLOCATIONCODE <- LAUSD_Teacher_Links$ID
levels(LAUSD_Teacher_Links$ID) <- sapply(levels(LAUSD_Teacher_Links$ID), function(s) strsplit(s, " ")[[1]][1], USE.NAMES=FALSE)
levels(LAUSD_Teacher_Links$PRLPREFERREDLOCATIONCODE) <- sapply(levels(LAUSD_Teacher_Links$PRLPREFERREDLOCATIONCODE), function(s) strsplit(s, " ")[[1]][2], USE.NAMES=FALSE)

LAUSD_Teacher_Links$ID <- as.character(LAUSD_Teacher_Links$ID)
LAUSD_Teacher_Links$PRLPREFERREDLOCATIONCODE <- as.character(LAUSD_Teacher_Links$PRLPREFERREDLOCATIONCODE)

LAUSD_Teacher_Links <- data.table(LAUSD_Teacher_Links, key=c("ID", "CONTENT_AREA"))

#unq.ids <- which(!duplicated(LAUSD_Teacher_Links)); length(unq.ids)
#dup.ids <- which(duplicated(LAUSD_Teacher_Links)); length(dup.ids) # Should be 0 duplicates.  2011, Check!

rm(lausd.tchr);rm(tchr.2012); rm(tmp.tchr); rm(dups);gc()

save(LAUSD_Teacher_Links, file="./Data/LAUSD_Teacher_Links-2012.Rdata", compress="bzip2")


####
####  Merge the Teacher links into LAUSD test data
####

#  Only keep 2 teachers
LAUSD_Teacher_Links$INSTRUCTOR_NUMBER_3 <- NULL
LAUSD_Teacher_Links$INSTRUCTOR_NUMBER_4 <- NULL
LAUSD_Teacher_Links$INSTRUCTOR_NUMBER_5 <- NULL
LAUSD_Teacher_Links$INSTRUCTOR_NUMBER_6 <- NULL
LAUSD_Teacher_Links$INSTRUCTOR_NUMBER_7 <- NULL
LAUSD_Teacher_Links$INSTRUCTOR_NUMBER_8 <- NULL


lausd$CONTENT_AREA <- as.character(lausd$CONTENT_AREA)
# lausd$PRLPREFERREDLOCATIONCODE <- as.character(lausd$PRLPREFERREDLOCATIONCODE)
lausd$PRLPREFERREDLOCATIONCODE <- NULL
LAUSD_Teacher_Links$PRLPREFERREDLOCATIONCODE <- NULL
lausd$CONTENT_AREA[lausd$CONTENT_AREA=="HISTORY" & lausd$GRADE==11] <- "US_HISTORY"

setkeyv(LAUSD_Teacher_Links, c("ID", "CONTENT_AREA", "YEAR")) #, "PRLPREFERREDLOCATIONCODE"
setkeyv(lausd, c("ID", "CONTENT_AREA", "YEAR"))

LAUSD_Data_LONG <- LAUSD_Teacher_Links[lausd, mult='first']
# sum(!is.na(LAUSD_Data_LONG$INSTRUCTOR_NUMBER_1))
# table(is.na(LAUSD_Data_LONG$INSTRUCTOR_NUMBER_1), LAUSD_Data_LONG$CONTENT_AREA) #  Good enough for now.  No matches for some tests...
LAUSD_Data_LONG$GENDER <- NULL  # Not sure which is "better" - keep the one from the Demographic file?  Data file might be what kids put in?
levels(LAUSD_Data_LONG$GENDERCODE) <- c('Gender: Female', 'Gender: Male')
setnames(LAUSD_Data_LONG, "GENDERCODE", "GENDER") # Check position first!

#  ADD these vars in to match the CMO file
LAUSD_Data_LONG$CMO_NAME <- "LAUSD"
LAUSD_Data_LONG$SCHOOL_NUMBER <- as.character(LAUSD_Data_LONG$SCHOOL_NUMBER) #  Change these too - some CMOs are numeric, some are factors

LAUSD_Data_LONG$DISTRICT_NAME <- "Los Angeles Unified School District"
LAUSD_Data_LONG$DISTRICT_NUMBER <- '1964733'

#  Added stuff for LAUSD's Schools, but this function only works on FULL character strings (not substrings) - will have to get cleaver if needed.

sch.names <- levels(LAUSD_Data_LONG$SCHOOL_NAME)
sch.names[grep(":", sch.names)] <- gsub(":", ": ", sch.names[grep(":", sch.names)])
sch.names <- capwords(sch.names)
levels(LAUSD_Data_LONG$SCHOOL_NAME) <- sch.names

LAUSD_Data_LONG$RECTYPE <- NULL
LAUSD_Data_LONG$LAUSD_TEST_CODE <- NULL
LAUSD_Data_LONG$GRADECODE <- NULL
LAUSD_Data_LONG$TESTGRADELEVEL <- NULL
LAUSD_Data_LONG$SPECIFIC_DISABILITY <- NULL
# LAUSD_Data_LONG$PRLPREFERREDLOCATIONCODE <- NULL
# LAUSD_Data_LONG$PRLPREFERREDLOCATIONCODE.1 <- NULL
LAUSD_Data_LONG$SCHCDSCODE <- NULL

save(LAUSD_Data_LONG, file="./Data/LAUSD_Data_LONG-2012.Rdata")


### ### ### ### ### ### ### ### ### ### ### ###
###			Merge the CMO & LAUSD files
### ### ### ### ### ### ### ### ### ### ### ###

###  Final completion of CA_2012

load("./Data/LAUSD_Data_LONG-2012.Rdata")
load("./Data/CMO_Data_LONG-2012.Rdata")

CA_2012 <- data.table(rbind.fill(CMO_Data_LONG, LAUSD_Data_LONG))

key.og <- c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID")

setkeyv(CA_2012, c(key.og, "INSTRUCTOR_NUMBER_1", "GRADE", "SCALE_SCORE")) # CMOs will not have data on other CMOs teachers, so sort out NA's here
dups <- data.table(CA_2012[c(which(duplicated(CA_2012))-1, which(duplicated(CA_2012))),], key=key(CA_2012)) #  All LAUSD
CA_2012$VALID_CASE[which(duplicated(CA_2012))] <- "INVALID_CASE" #  Alliance and GD overlap.  Invalidate Alliance - fewer Demogs

# setkeyv(CA_2012, c(key.og, "INSTRUCTOR_NUMBER_1", "GRADE"))
# dups <- data.table(CA_2012[c(which(duplicated(CA_2012))-1, which(duplicated(CA_2012))),], key=c("ID", "YEAR", "CONTENT_AREA", "GRADE"))
# CA_2012$VALID_CASE[which(duplicated(CA_2012))-1] <- "INVALID_CASE" #  All already INVALID

#  Some duplicates with different GRADE levels in the same year, but those should sort themselves out in the analyses

#  Here's where I'm seeing CMO duplicates of students
setkeyv(CA_2012, c(key.og, "GRADE", "INSTRUCTOR_NUMBER_1")) # Puts NA on BOTTOM!  Because its a character string???
setkeyv(CA_2012, c(key.og, "GRADE"))
dup.idx <- which(duplicated(CA_2012))
dups1 <- data.table(CA_2012[sort(c(dup.idx-1, dup.idx)),], key=key(CA_2012))
dups2 <- dups1["VALID_CASE"]

CA_2012$VALID_CASE[which(duplicated(CA_2012))] <- "INVALID_CASE" # Takes out the NA instructors 

#  No more dups based on SGP key
setkeyv(CA_2012, c(key.og))
dups <- data.table(CA_2012[sort(c(which(duplicated(CA_2012))-1, which(duplicated(CA_2012)))),], key=key(CA_2012))
dim(dups["VALID_CASE"])
CA_2012$VALID_CASE[which(duplicated(CA_2012))] <- "INVALID_CASE" # Takes out LAUSD for SSID 7104090576 - wrong grade

summary(as.factor(CA_2012$VALID_CASE)) # 93961 prior to Alliance, 94135 after

# Make names prettier
trimWhiteSpace <- function(line) gsub("(^ +)|( +$)", "", line)
CA_2012$FIRST_NAME<- trimWhiteSpace(CA_2012$FIRST_NAME)
CA_2012$LAST_NAME <- trimWhiteSpace(CA_2012$LAST_NAME)

CA_2012$FIRST_NAME <- factor(CA_2012$FIRST_NAME)
CA_2012$LAST_NAME <- factor(CA_2012$LAST_NAME)

CA_2012$SCHOOL_NAME <- trimWhiteSpace(CA_2012$SCHOOL_NAME)
CA_2012$SCHOOL_NUMBER_PROVIDED <- CA_2012$SCHOOL_NUMBER
CA_2012$SCHOOL_NUMBER[!is.na(CA_2012$SCHOOL_NUMBER)] <- paste(CA_2012$CMO_NAME[!is.na(CA_2012$SCHOOL_NUMBER)], CA_2012$SCHOOL_NUMBER[!is.na(CA_2012$SCHOOL_NUMBER)], sep="_")

CA_2012$DISTRICT_NAME[CA_2012$DISTRICT_NAME=="1"] <- 'Alliance College-Ready Public Schools'
CA_2012$DISTRICT_NAME[CA_2012$DISTRICT_NAME==""] <- NA
CA_2012$DISTRICT_NAME[CA_2012$DISTRICT_NAME=="LAUSD"] <- 'Los Angeles Unified School District'

#Clean up the SCHOOL NAMES - added 1/03/11
split.sym <- c(" @ ", " @", "@"," # ", " #", "#", "/", "rfk", " (MASS)", "(k-12)")
split.fix <- c(rep(" at ", 3), rep(" No. ", 3), "-", "RFK", "", "K-12")

for (f in 1:length(split.sym)) {
	levels(CA_2012$SCHOOL_NAME) <- gsub(split.sym[f], split.fix[f], levels(CA_2012$SCHOOL_NAME))
}

load("/Users/adamvaniwaarden/CENTER/SGP/California/2011_Analyses/Data_2011/California_SGP_MATH_ELA_Priors_ONLY_2.0.Rdata")
CA_0911 <- California_SGP@Data

CA_2012$CONTENT_AREA[CA_2012$CONTENT_AREA=='GRADE_LEVEL_MATHEMATICS'] <- 'MATHEMATICS'
setnames(CA_2012, c('DISTRICT_NUMBER', 'DISTRICT_NAME'), c('CA_DISTRICT_NUMBER', 'CA_DISTRICT_NAME'))
CA_2012$YEAR <- as.character(CA_2012$YEAR)

CA_0911$SPECIFIC_DISABILITY <- NULL
CA_0911$ORIGINAL_GRADE <- NULL
CA_0911$SCHOOL_NUMBER <- as.character(CA_0911$SCHOOL_NUMBER)
CA_0911$DISTRICT_NUMBER <- as.character(CA_0911$DISTRICT_NUMBER)
CA_0911$CMO_NAME <- as.character(CA_0911$CMO_NAME)

CA_0911$INSTRUCTOR_NUMBER_1 <- as.character(CA_0911$INSTRUCTOR_NUMBER_1)
CA_0911$INSTRUCTOR_NUMBER_2 <- as.character(CA_0911$INSTRUCTOR_NUMBER_2)
levels(CA_0911$INSTRUCTOR_1_WEIGHT) <- c(NA, '0.5', NA)
CA_0911$INSTRUCTOR_1_WEIGHT <- as.numeric(as.character(CA_0911$INSTRUCTOR_1_WEIGHT))
CA_0911$INSTRUCTOR_1_WEIGHT[is.na(CA_0911$INSTRUCTOR_1_WEIGHT) & !is.na(CA_0911$INSTRUCTOR_NUMBER_1)] <- 1
CA_0911$INSTRUCTOR_2_WEIGHT[!is.na(CA_0911$INSTRUCTOR_NUMBER_2)] <- 1


CA_0911$NEW_DATA <- FALSE
CA_2012$NEW_DATA <- TRUE

CA_LONG <- data.table(rbind.fill(CA_0911, CA_2012))

	#  History and US History labeled inconsistently.  This is how it "should" be...
	CA_LONG$CONTENT_AREA[CA_LONG$CONTENT_AREA=="US_HISTORY" & CA_LONG$GRADE==8] <- "HISTORY"
	CA_LONG$CONTENT_AREA[CA_LONG$CONTENT_AREA=="HISTORY" & CA_LONG$GRADE==11] <- "US_HISTORY"
	
	# Fix 10th grade 'Science' courses (mostly LAUSD)
	CA_LONG$CONTENT_AREA[CA_LONG$CONTENT_AREA=="SCIENCE" & CA_LONG$GRADE==10] <- "LIFE_SCIENCE"
	# Opposite problem for Alliance 8th grade
	CA_LONG$CONTENT_AREA[CA_LONG$CONTENT_AREA=="LIFE_SCIENCE" & CA_LONG$GRADE==8] <- "SCIENCE"

	#  Change "MATHEMATICS" back to "MATHEMATICS" and 8th and 9th grade "MATHEMATICS" to "GENERAL_MATHEMATICS"
	CA_LONG$CONTENT_AREA[CA_LONG$CONTENT_AREA=="MATHEMATICS" & CA_LONG$GRADE %in% c(8,9)] <- "GENERAL_MATHEMATICS"

#  Clean up grades and content areas:

CA_LONG$VALID_CASE[CA_LONG$CONTENT_AREA=="ELA" & !CA_LONG$GRADE %in% 2:11] <- "INVALID_CASE"
CA_LONG$VALID_CASE[CA_LONG$CONTENT_AREA=="MATHEMATICS" & !CA_LONG$GRADE %in% 2:7] <- "INVALID_CASE"
CA_LONG$VALID_CASE[CA_LONG$CONTENT_AREA=="GENERAL_MATHEMATICS" & !CA_LONG$GRADE %in% 8:9] <- "INVALID_CASE"
CA_LONG$VALID_CASE[CA_LONG$CONTENT_AREA=="SCIENCE" & !CA_LONG$GRADE %in% c(5,8)] <- "INVALID_CASE"


table(CA_LONG$VALID_CASE) #302245

###  Remove duplicate cases.  Some keep old data, others (where test scores have changed) keep the new
setkeyv(CA_LONG, c(key.og, "GRADE", "INSTRUCTOR_NUMBER_1", "SCALE_SCORE", "NEW_DATA"))
setkeyv(CA_LONG, c(key.og, "GRADE", "INSTRUCTOR_NUMBER_1", "SCALE_SCORE"))
dups <- data.table(CA_LONG[c(which(duplicated(CA_LONG))-1, which(duplicated(CA_LONG))),], key=key(CA_LONG))

CA_LONG <- CA_LONG[-(which(duplicated(CA_LONG))),] # Completely remove the NEW duplicates since no change to Scale score or Teacher
dim(CA_LONG)

setkeyv(CA_LONG, c(key.og, "GRADE", "SCALE_SCORE", "NEW_DATA"))
setkeyv(CA_LONG, c(key.og, "GRADE", "SCALE_SCORE"))
dups <- data.table(CA_LONG[c(which(duplicated(CA_LONG))-1, which(duplicated(CA_LONG))),], key=key(CA_LONG))

CA_LONG <- CA_LONG[-(which(duplicated(CA_LONG))),] # Completely remove the NEW duplicates since no change to Scale score or GRADE
dim(CA_LONG)

# setkeyv(CA_LONG, c(key.og, "SCALE_SCORE", "NEW_DATA")) 
# setkeyv(CA_LONG, c(key.og, "SCALE_SCORE"))
# dups <- data.table(CA_LONG[c(which(duplicated(CA_LONG))-1, which(duplicated(CA_LONG))),], key=key(CA_LONG))
#  A couple duplicates here, but hopefully the grade level differences will sort themselves out in the analyses...
# CA_LONG <- CA_LONG[-(which(duplicated(CA_LONG))-1),] # Completely remove these duplicates
# dim(CA_LONG)

#  New Data that has a changed score.  Probably the most concerning!  Only 12 cases though... 
setkeyv(CA_LONG, c(key.og, "NEW_DATA"))
setkeyv(CA_LONG, c(key.og))
dups <- data.table(CA_LONG[c(which(duplicated(CA_LONG))-1, which(duplicated(CA_LONG))),], key=key(CA_LONG))
CA_LONG <- CA_LONG[-(which(duplicated(CA_LONG))-1),] # Completely remove the OLD data duplicates here

CA_LONG <- CA_LONG[, c(1:26, 28, 31, 44:47), with = FALSE]

table(CA_LONG$CONTENT_AREA)

CA_LONG$CMO_NUMBER <- as.numeric(ordered(CA_LONG$CMO_NAME, levels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")))
CA_LONG$DISTRICT_NUMBER <- NULL
setnames(CA_LONG, c("CA_DISTRICT_NUMBER", "CA_DISTRICT_NAME", "SGP", "SGP_PRIORS_USED"), c("DISTRICT_NUMBER", "DISTRICT_NAME", "ORIGINAL_SGP","ORIGINAL_SGP_PRIORS_USED"))
# CA_2012[ID=='6055359164',]
# CA_LONG[ID=='6054193394',]

# projs <- names(California_SGP@SGP$SGProjections)[grep("2011", names(California_SGP@SGP$SGProjections))]
# for (g in projs) {
	# California_SGP@SGP$SGProjections[[g]] <- NULL
	# gc()
# }

# pctls <- names(California_SGP@SGP$SGPercentiles)[grep("2011", names(California_SGP@SGP$SGPercentiles))]
# for (g in pctls) {
	# California_SGP@SGP$SGPercentiles[[g]] <- NULL
	# gc()
# }

#  Remove all previous analyses
California_SGP@SGP$SGPercentiles <- NULL
California_SGP@SGP$SGProjections <- NULL

California_SGP@Data <- CA_LONG
California_SGP <- prepareSGP(California_SGP)

California_SGP@SGP$Goodness_of_Fit <- NULL
California_SGP@SGP$Knots_Boundaries <-NULL
California_SGP@SGP$Cutscores <- NULL

#  Grade level tests and EOCT cohorts
coef.mtx <- California_SGP@SGP$Coefficient_Matrices[1:12]

coef.mtx$HISTORY.2010[[1]]@Content_Areas[[1]] <- c("ELA", "HISTORY") # grade 7-8
coef.mtx$HISTORY.2011[[1]]@Content_Areas[[1]] <- c("ELA", "HISTORY") # grade 7-8
coef.mtx$HISTORY.2011[[2]]@Content_Areas[[1]] <- c("ELA", "ELA", "HISTORY") # grade 6-8

names(coef.mtx[[7]]) #$ALGEBRA_I.2010
coef.mtx[[7]][[1]]@Content_Areas[[1]] <- c("MATHEMATICS", "ALGEBRA_I") # grade 6-7
coef.mtx[[7]][[2]]@Content_Areas[[1]] <- c("MATHEMATICS", "ALGEBRA_I") # grade 7-8

names(coef.mtx[[8]]) #$ALGEBRA_I.2011
coef.mtx[[8]][[1]]@Content_Areas[[1]] <- c("MATHEMATICS", "ALGEBRA_I")
coef.mtx[[8]][[2]]@Content_Areas[[1]] <- c("MATHEMATICS", "ALGEBRA_I")
coef.mtx[[8]][[3]]@Content_Areas[[1]] <- c("MATHEMATICS", "MATHEMATICS", "ALGEBRA_I")
coef.mtx[[8]][[4]]@Content_Areas[[1]] <- c("MATHEMATICS", "MATHEMATICS", "ALGEBRA_I")

coef.mtx$GENERAL_MATHEMATICS.2010[[1]]@Content_Areas[[1]] <- c("MATHEMATICS", "GENERAL_MATHEMATICS")
coef.mtx$GENERAL_MATHEMATICS.2011[[1]]@Content_Areas[[1]] <- c("MATHEMATICS", "GENERAL_MATHEMATICS")
coef.mtx$GENERAL_MATHEMATICS.2011[[2]]@Content_Areas[[1]] <- c("MATHEMATICS", "MATHEMATICS", "GENERAL_MATHEMATICS")

coef.mtx$SCIENCE.2010[[1]]@Content_Areas[[1]] <- c("MATHEMATICS", "SCIENCE")
coef.mtx$SCIENCE.2010[[2]]@Content_Areas[[1]] <- c("MATHEMATICS", "SCIENCE")
coef.mtx$SCIENCE.2011[[1]]@Content_Areas[[1]] <- c("MATHEMATICS", "SCIENCE")
coef.mtx$SCIENCE.2011[[2]]@Content_Areas[[1]] <- c("MATHEMATICS", "SCIENCE")
coef.mtx$SCIENCE.2011[[3]]@Content_Areas[[1]] <- c("MATHEMATICS", "MATHEMATICS", "SCIENCE")
coef.mtx$SCIENCE.2011[[4]]@Content_Areas[[1]] <- c("MATHEMATICS", "MATHEMATICS", "SCIENCE")

mtx.num <- length(California_SGP@SGP$Coefficient_Matrices)-12 # 67, 12 matrices above
tmp.coef.mtx <- vector("list", length = mtx.num) 
for (j in 1:mtx.num) tmp.coef.mtx[[j]][['Coefficient_Matrices']] <- California_SGP@SGP$Coefficient_Matrices[12+j]

coefs <- sapply(1:mtx.num, function(n) strsplit(names(tmp.coef.mtx[[n]][['Coefficient_Matrices']]), "___"), USE.NAMES=F)
coefs2 <- vector("list", length = length(coefs))
for (i in 1:length(coefs)) if (length(coefs[[i]]) > 1) coefs2[[i]] <- strsplit(coefs[[i]][1], "[.]")[[1]][1] else coefs2[[i]] <- "as is"
for (i in 1:length(coefs)) if (coefs2[[i]] != "as is") coefs2[[i]] <- c(strsplit(coefs[[i]][2], "__")[[1]], coefs2[[i]])
for (i in 1:length(coefs)) {
	if (any(coefs2[[i]] != "as is")) {
		j <- names(tmp.coef.mtx[[i]][['Coefficient_Matrices']]); k <- names(tmp.coef.mtx[[i]][['Coefficient_Matrices']][[j]])
		tmp.coef.mtx[[i]][['Coefficient_Matrices']][[j]][[k]]@Content_Areas[[1]] <- coefs2[[i]]
		tmp.name <- k; for (f in 101:104) tmp.name <- gsub(as.character(f), 'EOCT', tmp.name)
		tmp.coef.mtx[[i]][['Coefficient_Matrices']][[j]][[k]]@Grade_Progression[[1]] <- strsplit(strsplit(tmp.name, "_")[[1]][4], "[.]")[[1]]
		rname <- rownames(tmp.coef.mtx[[i]][['Coefficient_Matrices']][[j]][[k]])
		for (f in 101:104) rname <- gsub(as.character(f), 'EOCT', rname)
		rname -> rownames(tmp.coef.mtx[[i]][['Coefficient_Matrices']][[j]][[k]])
		names(tmp.coef.mtx[[i]][['Coefficient_Matrices']][[j]]) <- paste(strsplit(tmp.name, "_")[[1]][-4], collapse="_")
	}
}
nm <- NULL
nm <- sapply(1:mtx.num, function(n) c(nm, strsplit(names(tmp.coef.mtx[[n]][['Coefficient_Matrices']]), "___")[[1]][1]), USE.NAMES=F)
for (j in 1:mtx.num) names(tmp.coef.mtx[[j]][['Coefficient_Matrices']]) <- nm[j]

for (eoc in (5:12)) { # ELA and math are fine
	names(coef.mtx[[eoc]]) <- sapply(names(coef.mtx[[eoc]]), function(f) paste(strsplit(f, "_")[[1]][-4], collapse="_"), USE.NAMES=F)
}
tmp.coef.mtx1 <- list(Coefficient_Matrices=coef.mtx)
tmp.coef.mtx2 <- Reduce(mergeSGP, tmp.coef.mtx)
coef.mtx <- mergeSGP(tmp.coef.mtx1, tmp.coef.mtx2)

coef.mtx$Coefficient_Matrices -> California_SGP@SGP$Coefficient_Matrices

save(CA_LONG, file="./Data/California_Data_LONG-2012.Rdata")
save(California_SGP, file="./Data/California_SGP-2012_Data-ONLY.Rdata")


###
###  Examine Course Progressions for TCRP
###

source('/Volumes/Data/Dropbox/CENTER/Application_Projects/EOC Course progressions/courseProgressionSGP.R', chdir = TRUE)

levels(as.factor(CA_LONG$CONTENT_AREA))
eoc.subj <- c("ALGEBRA_I", "ALGEBRA_II", "BIOLOGY", "CHEMISTRY", "EARTH_SCIENCE" ,"GENERAL_MATHEMATICS", "GEOMETRY", "INTEGRATED_SCIENCE_1", "LIFE_SCIENCE" ,"PHYSICS" ,"SUMMATIVE_HS_MATHEMATICS", "US_HISTORY", "WORLD_HISTORY")
CA_LONG <- CA_LONG[CA_LONG$CONTENT_AREA %in% c("ELA", "MATHEMATICS", eoc.subj)]
CA_LONG <- as.data.table(subset(CA_LONG, VALID_CASE=="VALID_CASE", select=c("ID", "YEAR", "CONTENT_AREA", "GRADE", "VALID_CASE")))
ca.prog <- courseProgressionSGP(CA_LONG)

no.ela <- grep("ELA", ca.prog$BACKWARD[['2011']]$ALGEBRA_I.08$CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)
no.na <- which(is.na(ca.prog$BACKWARD[['2011']]$ALGEBRA_I.08$CONTENT_AREA_by_GRADE_PRIOR_YEAR.1))
ca.prog$BACKWARD[['2011']]$ALGEBRA_I.08[-(sort(c(no.ela, no.na))),][COUNT > 1000]

CA_HUMN <- CA_LONG[CONTENT_AREA %in% c('ELA', "US_HISTORY", "WORLD_HISTORY")]
CA_HUMN <- CA_HUMN[GRADE > 5] # 6th grade is lowest in which we'd see for 9th graders in 2012

CA_MATH <- CA_LONG[CONTENT_AREA %in% c('MATHEMATICS', "ALGEBRA_I", "ALGEBRA_II", "BIOLOGY", "CHEMISTRY", "EARTH_SCIENCE" ,"GENERAL_MATHEMATICS", "GEOMETRY", "INTEGRATED_SCIENCE_1", "LIFE_SCIENCE" ,"PHYSICS" ,"SUMMATIVE_HS_MATHEMATICS")]
summary(CA_MATH$GRADE)

CA_MATH <- CA_MATH[GRADE > 4] # 5th grade is lowest in which we'd see for 8th graders in 2012 (for ALG I)
CA_MATH$GRADE <- as.numeric(CA_MATH$YEAR)-1908
ca.math.prog <- courseProgressionSGP(CA_MATH)
ca.humn.prog <- courseProgressionSGP(CA_HUMN)


###
###  Maths
###

##  ALG I.  This is probably the only one that makes sense to make it complicated with MS math...
ca.math.prog$BACKWARD[['2012']]$ALGEBRA_I.04[COUNT > 1000]
ca.math.prog$BACKWARD[['2012']]$ALGEBRA_I.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_I.03"]
ca.math.prog$BACKWARD[['2012']]$ALGEBRA_I.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="GENERAL_MATHEMATICS.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="MATHEMATICS.02"]

# ALGEBRA_I.04			MATHEMATICS.03			MATHEMATICS.02			MATHEMATICS.01 #  01 Assummed
# ALGEBRA_I.04			ALGEBRA_I.03 #  Compare all repeaters to each other regardless of grade
# ALGEBRA_I.04			GENERAL_MATHEMATICS.03			MATHEMATICS.02			MATHEMATICS.01


## GEOM
ca.math.prog$BACKWARD[['2012']]$GEOMETRY.04[COUNT > 1000]
ca.math.prog$BACKWARD[['2012']]$GEOMETRY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_I.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='MATHEMATICS.02']
ca.math.prog$BACKWARD[['2012']]$GEOMETRY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_I.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='GENERAL_MATHEMATICS.02']
ca.math.prog$BACKWARD[['2012']]$GEOMETRY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="GEOMETRY.03"]
ca.math.prog$BACKWARD[['2012']]$GEOMETRY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_II.03"]

# GEOMETRY.04			ALGEBRA_I.03			MATHEMATICS.02
# GEOMETRY.04			ALGEBRA_I.03			GENERAL_MATHEMATICS.02
# GEOMETRY.04			GEOMETRY.03
# GEOMETRY.04			ALGEBRA_II.03


##  ALG II.  Keep it simple, stupd...
ca.math.prog$BACKWARD[['2012']]$ALGEBRA_II.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="GEOMETRY.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='ALGEBRA_I.02'][COUNT > 1000]
# ALGEBRA_II.04			GEOMETRY.03			ALGEBRA_I.02
ca.math.prog$BACKWARD[['2012']]$ALGEBRA_II.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_I.03"][COUNT > 1000]
# ALGEBRA_II.04			ALGEBRA_I.03
# ...
ca.math.prog$BACKWARD[['2012']]$ALGEBRA_II.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_II.03"]
# ca.math.prog$BACKWARD[['2012']]$ALGEBRA_II.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_II.03"& CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='GEOMETRY.02']
# ALGEBRA_II.04			 ALGEBRA_II.03  #  Possible, but not promising... ~ 2000


## GENERAL_MATHEMATICS  -  Leave this to 8th grade analysis in typical sets...

# ca.math.prog$BACKWARD[['2012']]$GENERAL_MATHEMATICS.04[COUNT > 1000]
# # ca.math.prog$BACKWARD[['2012']]$GENERAL_MATHEMATICS.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="GENERAL_MATHEMATICS.03"] # Not enough this year
# # ca.math.prog$BACKWARD[['2011']]$GENERAL_MATHEMATICS.03[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="GENERAL_MATHEMATICS.02"] # There was enough last year
# ca.math.prog$BACKWARD[['2012']]$GENERAL_MATHEMATICS.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="MATHEMATICS.03"]
# GENERAL_MATHEMATICS.04			MATHEMATICS.01   MATHEMATICS.02  MATHEMATICS.01

ca.math.prog$BACKWARD[['2012']]$GENERAL_MATHEMATICS.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="MATHEMATICS.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="MATHEMATICS.02"]

##  SUMMATIVE_HS_MATHEMATICS
ca.math.prog$BACKWARD[['2012']]$SUMMATIVE_HS_MATHEMATICS.04[COUNT > 1000]
ca.math.prog$BACKWARD[['2012']]$SUMMATIVE_HS_MATHEMATICS.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_II.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='GEOMETRY.02']
ca.math.prog$BACKWARD[['2012']]$SUMMATIVE_HS_MATHEMATICS.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="GEOMETRY.03"]
ca.math.prog$BACKWARD[['2012']]$SUMMATIVE_HS_MATHEMATICS.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="SUMMATIVE_HS_MATHEMATICS.03"]
#  SUMMATIVE_HS_MATHEMATICS.04			 ALGEBRA_II.03   GEOMETRY.02   ALGEBRA_I.01
#  SUMMATIVE_HS_MATHEMATICS.04			 GEOMETRY.03


###
###  Sciences
###

##  BIO - probably mostly 9th graders.  Reach into MS Math for priors here

ca.math.prog$BACKWARD[['2012']]$BIOLOGY.04[COUNT>1000]
ca.math.prog$BACKWARD[['2012']]$BIOLOGY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="GENERAL_MATHEMATICS.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='MATHEMATICS.02']
ca.math.prog$BACKWARD[['2012']]$BIOLOGY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_I.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='MATHEMATICS.02']
ca.math.prog$BACKWARD[['2012']]$BIOLOGY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_I.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='GENERAL_MATHEMATICS.02']
ca.math.prog$BACKWARD[['2012']]$BIOLOGY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_II.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='GEOMETRY.02']
ca.math.prog$BACKWARD[['2012']]$BIOLOGY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="GEOMETRY.03"]
ca.math.prog$BACKWARD[['2012']]$BIOLOGY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="GENERAL_MATHEMATICS.03"]

# GENERAL_MATHEMATICS.03           MATHEMATICS.02 MATHEMATICS.01

# ALGEBRA_I.03			MATHEMATICS.02			MATHEMATICS.01 #  MATH.01 Fine here
# ALGEBRA_I.03			GENERAL_MATHEMATICS.02             (((MATHEMATICS.01))) # EXCLUDE MATH HERE...

# ALGEBRA_II.03                    GEOMETRY.02  
# NO ALG II - ALG I (only ~1000) - better to include in just ALG II

# GEOMETRY.03			 ALGEBRA_I.02                MATHEMATICS.01  #  Again exclude MATH so that we have a full HS cohort

##  FINAL:
# GENERAL_MATHEMATICS.03           MATHEMATICS.02
# ALGEBRA_I.03			MATHEMATICS.02			MATHEMATICS.01
# ALGEBRA_I.03			GENERAL_MATHEMATICS.02
# ALGEBRA_II.03                    GEOMETRY.02  
# GEOMETRY.03			 ALGEBRA_I.02


##  PHYS
ca.math.prog$BACKWARD[['2012']]$PHYSICS.04[COUNT>1000]
#
# PHYSICS.04			 ALGEBRA_II.03			 GEOMETRY.02			###  only several hundred without ALG I too.  Add it.
ca.math.prog$BACKWARD[['2012']]$PHYSICS.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_II.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='GEOMETRY.02']
# PHYSICS.04			 ALGEBRA_II.03			 GEOMETRY.02			ALGEBRA_I.01 # YES!
# PHYSICS.04			 ALGEBRA_II.03			 ALGEBRA_I.02

sum(ca.math.prog$BACKWARD[['2012']]$PHYSICS.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_I.03"]$COUNT)
[1] 2033
# PHYSICS.04			 ALGEBRA_I.03

ca.math.prog$BACKWARD[['2012']]$PHYSICS.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="GEOMETRY.03"]
tmp.phys$COUNT
[1] 4648
# ADD 'ALGEBRA_I.02' too:
ca.math.prog$BACKWARD[['2012']]$PHYSICS.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="GEOMETRY.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='ALGEBRA_I.02']
# PHYSICS.04			 GEOMETRY.03
# PHYSICS.04			 GEOMETRY.03			ALGEBRA_I.02


## CHEM
ca.math.prog$BACKWARD[['2012']]$CHEMISTRY.04[COUNT>1000]
ca.math.prog$BACKWARD[['2012']]$CHEMISTRY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="GEOMETRY.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='ALGEBRA_I.02']
ca.math.prog$BACKWARD[['2012']]$CHEMISTRY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_II.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='GEOMETRY.02']
ca.math.prog$BACKWARD[['2012']]$CHEMISTRY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_II.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='ALGEBRA_I.02']
ca.math.prog$BACKWARD[['2012']]$CHEMISTRY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_I.03"]

##  Better to exclude the GENERAL_MATHEMATICS and MATHEMATICS ???  Make a bigger cohort with HS only courses...
# GEOMETRY.03			ALGEBRA_I.02			MATHEMATICS.01
# GEOMETRY.03			ALGEBRA_I.02			GENERAL_MATHEMATICS.01

# ALGEBRA_II.03			GEOMETRY.02			ALGEBRA_I.01
# ALGEBRA_II.03			ALGEBRA_I.02 ~ +2100 kids ...  Maybe better to just include them in ALG II (this might just be 1 CMO...  Not LAUSD too?)

#  FINAL:
# GEOMETRY.03			ALGEBRA_I.02
# ALGEBRA_II.03			GEOMETRY.02			ALGEBRA_I.01
# ALGEBRA_I.03 


##  LIFE SCI

ca.math.prog$BACKWARD[['2012']]$LIFE_SCIENCE.04[COUNT>1000] # not enough this year?  There where several thousand last year and enough (it seems) to do ALG I and GEOM priors
ca.math.prog$BACKWARD[['2012']]$LIFE_SCIENCE.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_I.03"]
# LIFE_SCIENCE.04			ALGEBRA_I.03


## INTEG SCI 1
ca.math.prog$BACKWARD[['2012']]$INTEGRATED_SCIENCE_1.04[COUNT>1000]
ca.math.prog$BACKWARD[['2012']]$INTEGRATED_SCIENCE_1.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_I.03"]
# ca.math.prog$BACKWARD[['2012']]$INTEGRATED_SCIENCE_1.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_I.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='GENERAL_MATHEMATICS.02']
ca.math.prog$BACKWARD[['2012']]$INTEGRATED_SCIENCE_1.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="GENERAL_MATHEMATICS.03"]
sum(ca.math.prog$BACKWARD[['2012']]$INTEGRATED_SCIENCE_1.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="GEOMETRY.03"]$COUNT)  # +1000 give it a try ...
# INTEGRATED_SCIENCE_1.04			ALGEBRA_I.03   
# INTEGRATED_SCIENCE_1.04			GENERAL_MATHEMATICS.03 # No other math priors - too messy...
# INTEGRATED_SCIENCE_1.04			GEOMETRY.03  #  don't hold breath...


##  EARTH_SCIENCE
ca.math.prog$BACKWARD[['2012']]$EARTH_SCIENCE.04[COUNT>1000]
sum(ca.math.prog$BACKWARD[['2012']]$EARTH_SCIENCE.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ALGEBRA_I.03"]$COUNT)
#  EARTH_SCIENCE.04			ALGEBRA_I.03  # +1000 give it a try ...
#  EARTH_SCIENCE.04			GEOMETRY.03   # +1000 give it a try ...



###
###  History
###

names(ca.humn.prog$BACKWARD[['2012']])

head(ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.11, 10)
ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.09[COUNT>1000]
ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.10[COUNT>1000]
ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.11[COUNT>1000]
sum(ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.11$COUNT)


## US Hist
ca.humn.prog$BACKWARD[['2012']]$US_HISTORY.11[COUNT>1000]
#  US_HISTORY.11                   WORLD_HISTORY.10			      ELA.09			      ELA.08
#  US_HISTORY.11			      ELA.10			      ELA.09			      ELA.08


###
###  'Matched Priors'
###

load("/Users/adamvaniwaarden/CENTER/SGP/California/Data/California_Data_LONG-2012.Rdata")
source('/Volumes/Data/Dropbox/CENTER/Application_Projects/EOC Course progressions/courseProgressionSGP.R', chdir = TRUE)

levels(as.factor(CA_LONG$CONTENT_AREA))
eoc.subj <- c("ALGEBRA_I", "ALGEBRA_II", "BIOLOGY", "CHEMISTRY", "EARTH_SCIENCE" ,"GENERAL_MATHEMATICS", "GEOMETRY", "INTEGRATED_SCIENCE_1", "LIFE_SCIENCE" ,"PHYSICS" ,"SUMMATIVE_HS_MATHEMATICS", "US_HISTORY", "WORLD_HISTORY")
CA_LONG <- CA_LONG[CA_LONG$CONTENT_AREA %in% c("ELA", 'HISTORY', "MATHEMATICS", "SCIENCE", eoc.subj)]
CA_LONG <- as.data.table(subset(CA_LONG, VALID_CASE=="VALID_CASE", select=c("ID", "YEAR", "CONTENT_AREA", "GRADE", "VALID_CASE")))

CA_HUMN <- CA_LONG[CONTENT_AREA %in% c('ELA', 'HISTORY', "US_HISTORY", "WORLD_HISTORY")]
CA_HUMN <- CA_HUMN[GRADE > 5] # 6th grade is lowest in which we'd see for 9th graders in 2012
CA_HUMN$GRADE <- as.numeric(CA_HUMN$YEAR)-1908

CA_SCI <- CA_LONG[CONTENT_AREA %in% c("BIOLOGY", "CHEMISTRY", "EARTH_SCIENCE", "INTEGRATED_SCIENCE_1", "LIFE_SCIENCE" ,"PHYSICS", "SCIENCE")] # add SCI
summary(CA_SCI$GRADE)

CA_SCI <- CA_SCI[GRADE > 4] # 5th grade is lowest in which we'd see for 8th graders in 2012 (for ALG I)
CA_SCI$GRADE <- as.numeric(CA_SCI$YEAR)-1908
ca.scie.prog <- courseProgressionSGP(CA_SCI)
ca.humn.prog <- courseProgressionSGP(CA_HUMN)



###
###  Sciences
###

##  BIO - probably mostly 9th graders.  Reach into MS Math for priors here

ca.scie.prog$BACKWARD[['2012']]$BIOLOGY.04[COUNT>1000]
ca.scie.prog$BACKWARD[['2012']]$BIOLOGY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="CHEMISTRY.03"]
ca.scie.prog$BACKWARD[['2012']]$BIOLOGY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="SCIENCE.03"]
ca.scie.prog$BACKWARD[['2012']]$BIOLOGY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="BIOLOGY.03"]
ca.scie.prog$BACKWARD[['2012']]$BIOLOGY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="INTEGRATED_SCIENCE_1.03"]
ca.scie.prog$BACKWARD[['2012']]$BIOLOGY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="INTEGRATED_SCIENCE_1.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='SCIENCE.02']

#  SCIENCE.03
#  INTEGRATED_SCIENCE_1.03             SCIENCE.02 # Only add this is we used it last year ...  otherwise just IS1
#  INTEGRATED_SCIENCE_1.03
#  BIOLOGY.03
#  CHEMISTRY.03

##  PHYS
ca.scie.prog$BACKWARD[['2012']]$PHYSICS.04[COUNT>1000]
ca.scie.prog$BACKWARD[['2012']]$PHYSICS.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="CHEMISTRY.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='BIOLOGY.02']
ca.scie.prog$BACKWARD[['2012']]$PHYSICS.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="PHYSICS.03"] # Nope
ca.scie.prog$BACKWARD[['2012']]$PHYSICS.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="BIOLOGY.03"] # Try it?

#  CHEMISTRY.03          BIOLOGY.02        SCIENCE.01  #  Not sure adding the third prior is good here...
#  BIOLOGY.03


## CHEM
ca.scie.prog$BACKWARD[['2012']]$CHEMISTRY.04[COUNT>1000]
ca.scie.prog$BACKWARD[['2012']]$CHEMISTRY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="BIOLOGY.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=='INTEGRATED_SCIENCE_1.02']
ca.scie.prog$BACKWARD[['2012']]$CHEMISTRY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="BIOLOGY.03"]
ca.scie.prog$BACKWARD[['2012']]$CHEMISTRY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="LIFE_SCIENCE.03"]
ca.scie.prog$BACKWARD[['2012']]$CHEMISTRY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="CHEMISTRY.03"]

#  BIOLOGY.03            INTEGRATED_SCIENCE_1.02  # Only add this is we used it last year ...  otherwise just BIO
#  BIOLOGY.03            INTEGRATED_SCIENCE_1.02          SCIENCE.01  # Almost all have SCI too... 850/8500 - 1/10th don't have SCI too
#  BIOLOGY.03            SCIENCE.02
#  LIFE_SCIENCE.03       BIOLOGY.02  # Borderline
#  CHEMISTRY.03  # Only add this is we used it last year ...


##  LIFE SCI

ca.scie.prog$BACKWARD[['2012']]$LIFE_SCIENCE.04[COUNT>1000] 
ca.scie.prog$BACKWARD[['2012']]$LIFE_SCIENCE.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="BIOLOGY.03"]

#  BIOLOGY.03		#  Not enough to add a second prior


## INTEG SCI 1
ca.scie.prog$BACKWARD[['2012']]$INTEGRATED_SCIENCE_1.04[COUNT>1000]
ca.scie.prog$BACKWARD[['2012']]$INTEGRATED_SCIENCE_1.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="SCIENCE.03"]

#  SCIENCE.03  
#  INTEGRATED_SCIENCE_1 - not enough repeaters
#  BIOLOGY  - not enough ~1000


##  EARTH_SCIENCE
ca.scie.prog$BACKWARD[['2012']]$EARTH_SCIENCE.04[COUNT>1000]
sum(ca.scie.prog$BACKWARD[['2012']]$EARTH_SCIENCE.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="SCIENCE.03"]$COUNT) # 1065
sum(ca.scie.prog$BACKWARD[['2012']]$EARTH_SCIENCE.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="BIOLOGY.03"]$COUNT) # 1241

#  BIOLOGY.03  # +1000 :: Didn't provide Earth sci with math, so don't do it here.
#  SCIENCE.03  


###
###  History
###

names(ca.humn.prog$BACKWARD[['2012']])

ca.humn.prog$BACKWARD[['2012']]$HISTORY.08[COUNT>1000] #  ELA Only again


ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.09[COUNT>1000]
ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.09[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="HISTORY.08"]


ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.10[COUNT>1000]
ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.10[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.09" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="HISTORY.08"]
ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.10[CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="HISTORY.08"]
ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.10[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="WORLD_HISTORY.09"]

#  Provide ELA in 09 too?  Or just HISTORY.08 with a gap year?
# ELA.09                         HISTORY.08


ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.11[COUNT>1000]
sum(ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.11$COUNT)
ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.11[CONTENT_AREA_by_GRADE_PRIOR_YEAR.3=="HISTORY.08"]
ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.11[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="WORLD_HISTORY.10"]

###
###  Change to same grade:

ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.04[COUNT>1000]
ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="WORLD_HISTORY.03"]
ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.03" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="HISTORY.02"]
ca.humn.prog$BACKWARD[['2012']]$WORLD_HISTORY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="HISTORY.02"]

#  Provide ELA in 09 too?  Or just HISTORY.08 with a gap year?
#  ELA.03                         HISTORY.02
#  WORLD_HISTORY.03  #  Make this a prior pref 1 to keep them out of comparisons with a gap year...


## US Hist
ca.humn.prog$BACKWARD[['2012']]$US_HISTORY.04[COUNT>1000]
ca.humn.prog$BACKWARD[['2012']]$US_HISTORY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="WORLD_HISTORY.03"]
ca.humn.prog$BACKWARD[['2012']]$US_HISTORY.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.3=="HISTORY.01"]
#  Provide ELA too?  Or just HISTORY with a gap year?
#  WORLD_HISTORY.03			ELA.02			HISTORY.01

save(ca.humn.prog, file="Data/CA_HUMANITIES_Progressions.Rdata")
save(ca.math.prog, file="Data/CA_MATH+SCI_Progressions.Rdata")
save(ca.scie.prog, file="Data/CA_SCIENCE_Progressions.Rdata")