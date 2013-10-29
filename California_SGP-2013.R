#####################################################################################################
#######################################################################################
#########################################################################
####
####	Code for analysis of 2013 TCRP data 
####	October 2013
####
#########################################################################  
#######################################################################################
#####################################################################################################

### Load the required R packages and set the working directory

setwd('/media/Data/Dropbox/SGP/California')

require(SGP)
require(data.table)

#####################################################################################################
#####################################################################################################
###
###		Math and ELA Priors analyses.
###		All Science and History courses (grade level and EOCT) use math or ELA related priors.
###		Grade level Math and ELA will be identical for this and the 'matched' priors analyses.
###
#####################################################################################################
#####################################################################################################

###  Load the required data objects
###  These were produced as revisions of the 2012 data objects (California_SGP-2012_REVISION.R)

load("Data/California_SGP-Math+ELA-2013.Rdata")

############################################################
####
####						analyzeSGP
####
############################################################

	California_SGP <- analyzeSGP(California_SGP,
	                             content_areas=c("ELA", "MATHEMATICS"),
	                             years='2013',
	                             grades = 2:11,
	                             sgp.percentiles = TRUE,
	                             sgp.projections = TRUE,
	                             sgp.projections.lagged = TRUE,
	                             sgp.percentiles.baseline = TRUE,
	                             sgp.projections.baseline = TRUE,
	                             sgp.projections.lagged.baseline = TRUE,
	                             simulate.sgps = FALSE,
	                             parallel.config=list(
	                                     BACKEND="PARALLEL",
	                                     WORKERS=list(
	                                     	PERCENTILES=23, PROJECTIONS=12, LAGGED_PROJECTIONS=12)))

#########
###			Heterogeneous Grade-level and Middle School EOCT progression analyses
#########

	##  Science and History courses use grade-level Math and ELA respectively as priors.  
	##  Because of this heterogeneous CONTENT_AREA progression, we must explicitly specify the sgp.config.
	##  Load ALL 2013 analysis configuration lists and combine all subject level configurations into a single list for the sgp.config argument
	
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2013/MATHEMATICS.R")
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2013/SCIENCE.R")
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2013/SOCIAL_STUDIES.R")


	TCRP_EOCT.config <- c(
		HISTORY_2013.config,
		SCIENCE_2013.config,

		ALGEBRA_I_2013.config, 
		ALGEBRA_II_2013.config, 
		GENERAL_MATHEMATICS_2013.config, 
		GEOMETRY_2013.config, 		
		SUMMATIVE_HS_MATHEMATICS_2013.config,
		
		BIOLOGY_2013.config, 
		CHEMISTRY_2013.config, 
		INTEGRATED_SCIENCE_1.2013.config, 
		LIFE_SCIENCE_2013.config, 
		PHYSICS_2013.config,

		US_HISTORY_2013.config, 
		WORLD_HISTORY_2013.config
	)

	California_SGP <- analyzeSGP(California_SGP,
	                             sgp.config = TCRP_EOCT.config,
	                             sgp.percentiles = TRUE,
	                             sgp.projections = FALSE,
	                             sgp.projections.lagged = FALSE,
	                             sgp.percentiles.baseline = TRUE,
	                             sgp.projections.baseline = FALSE,
	                             sgp.projections.lagged.baseline = FALSE,
	                             simulate.sgps = FALSE,
	                             parallel.config=list(
	                                     BACKEND="PARALLEL",
	                                     WORKERS=list(PERCENTILES=23)))
                           		                          		                          		                          		
	save(California_SGP, file='Data/California_SGP-Math+ELA-2013.Rdata')

#########################################################
####
####					combineSGP
####
#########################################################
	
	California_SGP <- combineSGP(California_SGP, update.all.years = TRUE)

	#  Check the LONG @Data file now:
	sgp.names <- names(California_SGP@SGP[["SGPercentiles"]])
	tot.c<-0
	for(i in match(sgp.names[-grep('BASELINE', sgp.names)], sgp.names)) { # ... paste(sgp.names[i] ...
		print(paste(sgp.names[i], "N =", dim(California_SGP@SGP[['SGPercentiles']][[i]])[1], " :  Median SGP,", median(California_SGP@SGP[['SGPercentiles']][[i]][["SGP"]])))
		tot.c <- tot.c+(dim(California_SGP@SGP[['SGPercentiles']][[i]])[1])
	}
	tot.c
	
	sum(!is.na(California_SGP@Data$SGP)) #  This number should be smaller than the total SGPs produced (tot) - duplicates have been removed.

	tot.b<-0
	for(i in match(sgp.names[grep('BASELINE', sgp.names)], sgp.names)) { # ... paste(sgp.names[i] ...
		print(paste(sgp.names[i], "N =", dim(California_SGP@SGP[['SGPercentiles']][[i]])[1], " :  Median SGP,", median(California_SGP@SGP[['SGPercentiles']][[i]][["SGP_BASELINE"]])))
		tot.b <- tot.b+(dim(California_SGP@SGP[['SGPercentiles']][[i]])[1])
	}
	tot.b
	
	sum(!is.na(California_SGP@Data$SGP_BASELINE)) #  This number should be smaller than the total SGPs produced (tot)
	
			
	tbl <- California_SGP@Data[, list(MEDIAN = median(as.numeric(SGP), na.rm=T), MEDIAN_BASELINE = median(as.numeric(SGP_BASELINE), na.rm=T), N = sum(!is.na(SGP)), N_BASELINE = sum(!is.na(SGP_BASELINE))), by = c("CONTENT_AREA", "GRADE", "YEAR")][!is.na(MEDIAN)]
	
	tbl[YEAR=='2013']
	
#########################################################
####
####					summarizeSGP
####
#########################################################

	
	subjects <- c('ELA', 'HISTORY', 'WORLD_HISTORY', 'US_HISTORY', 
		'MATHEMATICS', 'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II', 'SUMMATIVE_HS_MATHEMATICS', 
		'SCIENCE', 'INTEGRATED_SCIENCE_1', 'LIFE_SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS')
	
	California_SGP <- summarizeSGP(California_SGP,
			content_areas = subjects,
			years='2013',
			parallel.config=list(BACKEND="PARALLEL", WORKERS=23))
	
	save(California_SGP, file='Data/California_SGP-Math+ELA-2013.Rdata') 
	
	California_SGP@Data[, list(MEDIAN = median(as.numeric(SGP), na.rm=T), N = sum(!is.na(SGP))), by = c("CONTENT_AREA", "GRADE", "YEAR")]


#########################################################
####
####	Output summary tables and student long files to .txt files (pipe delimited) for the CMOs.
####	Don't use outputSGP because each CMO needs their own files with ONLY their data.
####
#########################################################

	setwd('/media/Data/Dropbox/SGP/California')
	
	for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
		if (is.na(file.info("Results_2013")$isdir)) {
			dir.create("Results_2013")
		}
		dir.create(paste("Results_2013/", cmo, "_Results_2013/Math+ELA/Summaries/Demographic_Groups", sep=""), recursive=TRUE, showWarnings=FALSE)
	}
	
	
	###  CMO by Grade, subject
	s <- data.table(California_SGP@Summary[['CMO_NUMBER']][['CMO_NUMBER__CONTENT_AREA__YEAR__GRADE']])
	table(California_SGP@Data$CMO_NUMBER, California_SGP@Data$CMO_NAME)
	setnames(s, "CMO_NUMBER", "CMO_NAME")
	s[["CMO_NAME"]] <- factor(s[["CMO_NAME"]], levels=1:5, labels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
	s <- s[!is.na(MEDIAN_SGP)]
	
	for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
		tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & CMO_NAME!="NA",], key = c("CMO_NAME", 'CONTENT_AREA', 'YEAR', 'GRADE'))
		write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Math+ELA/Summaries/CMO__CONTENT_AREA__YEAR__GRADE.txt", sep=""), sep="|", row.names=FALSE)
	}
	
	###  School Only, subj
	s <- data.table(California_SGP@Summary[['SCHOOL_NUMBER']][['SCHOOL_NUMBER__CONTENT_AREA__YEAR']])
	cmo <- as.character(s[['SCHOOL_NUMBER']])
	s[["CMO_NAME"]] <- ordered(sapply(cmo, function(x) strsplit(x, "_")[[1]][1], USE.NAMES=FALSE), levels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
	sch <- sapply(levels(s[['SCHOOL_NUMBER']]), function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
	levels(s[['SCHOOL_NUMBER']]) <- sch
	setcolorder(s, c(dim(s)[2],1:(dim(s)[2]-1)))
	
	for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
		tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & SCHOOL_NUMBER!="NA",], key = c('SCHOOL_NUMBER', 'CONTENT_AREA', 'YEAR'))
		setcolorder(tmp, c(dim(tmp)[2],1:(dim(tmp)[2]-1)))
		write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Math+ELA/Summaries/SCHOOL_NUMBER__CONTENT_AREA__YEAR.txt", sep=""), sep="|", row.names=FALSE)
	}
	
	
	###  School + Grade, subj
	s <- data.table(California_SGP@Summary[['SCHOOL_NUMBER']][['SCHOOL_NUMBER__CONTENT_AREA__YEAR__GRADE']])
	cmo <- as.character(s[['SCHOOL_NUMBER']])
	s[["CMO_NAME"]] <- ordered(sapply(cmo, function(x) strsplit(x, "_")[[1]][1], USE.NAMES=FALSE), levels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
	sch.gr <- sapply(levels(s[['SCHOOL_NUMBER']]), function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
	levels(s[['SCHOOL_NUMBER']]) <- sch.gr
	setcolorder(s, c(dim(s)[2],1:(dim(s)[2]-1)))
	
	for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
		tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & SCHOOL_NUMBER!="NA",], key = c('SCHOOL_NUMBER', 'CONTENT_AREA', 'GRADE', 'YEAR'))
		write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Math+ELA/Summaries/SCHOOL_NUMBER__CONTENT_AREA__YEAR__GRADE.txt", sep=""), sep="|", row.names=FALSE)
	}
	
	###  Teacher only
	s <- data.table(California_SGP@Summary[['DISTRICT_NUMBER']][['DISTRICT_NUMBER__INSTRUCTOR_NUMBER__CONTENT_AREA__YEAR__INSTRUCTOR_ENROLLMENT_STATUS']])
	cmo <- as.character(s[['INSTRUCTOR_NUMBER']])
	s[["CMO_NAME"]] <- ordered(sapply(cmo, function(x) strsplit(x, "_")[[1]][1], USE.NAMES=FALSE), levels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
	s[['INSTRUCTOR_NUMBER']] <- sapply(s[['INSTRUCTOR_NUMBER']], function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
	setcolorder(s, c(dim(s)[2],1:(dim(s)[2]-1)))
	
	for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
		tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & INSTRUCTOR_NUMBER!="NA",], key = c('INSTRUCTOR_NUMBER', 'CONTENT_AREA', 'YEAR'))
		write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Math+ELA/Summaries/INSTRUCTOR_NUMBER__CONTENT_AREA__YEAR.txt", sep=""), sep="|", row.names=FALSE)
	}
	
	
	###  Teacher Grade Subject
	s <- data.table(California_SGP@Summary[['DISTRICT_NUMBER']][['DISTRICT_NUMBER__INSTRUCTOR_NUMBER__CONTENT_AREA__YEAR__GRADE__INSTRUCTOR_ENROLLMENT_STATUS']])
	cmo <- as.character(s[['INSTRUCTOR_NUMBER']])
	s[["CMO_NAME"]] <- ordered(sapply(cmo, function(x) strsplit(x, "_")[[1]][1], USE.NAMES=FALSE), levels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
	s[['INSTRUCTOR_NUMBER']] <- sapply(s[['INSTRUCTOR_NUMBER']], function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
	setcolorder(s, c(dim(s)[2],1:(dim(s)[2]-1)))
	
	for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
		tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & INSTRUCTOR_NUMBER!="NA",], key = c('INSTRUCTOR_NUMBER', 'CONTENT_AREA', 'GRADE', 'YEAR'))
		write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Math+ELA/Summaries/INSTRUCTOR_NUMBER__CONTENT_AREA__YEAR__GRADE.txt", sep=""), sep="|", row.names=FALSE)
	}
	
	
	#  Student files 
	s <- data.table(California_SGP@Data[,c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID", "LAST_NAME", "FIRST_NAME", "GRADE", "GRADE_REPORTED", "SCALE_SCORE", "SCALE_SCORE_PRIOR", "SCALE_SCORE_PRIOR_STANDARDIZED", "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_PRIOR", "SGP", "SGP_NORM_GROUP", "SGP_LEVEL", "SGP_TARGET_3_YEAR", "SGP_TARGET_MOVE_UP_STAY_UP_3_YEAR", "CATCH_UP_KEEP_UP_STATUS", "MOVE_UP_STAY_UP_STATUS", "GENDER", "ETHNICITY", "ELL_STATUS", "SES_STATUS", "IEP_STATUS", "CMO_NAME", "DISTRICT_NUMBER", "DISTRICT_NAME", "SCHOOL_NUMBER_PROVIDED", "SCHOOL_NAME"), with=FALSE])
	
	setnames(s, "SCHOOL_NUMBER_PROVIDED", "SCHOOL_NUMBER")
	
	tmp.inst <- data.table(VALID_CASE="VALID_CASE", California_SGP@Data_Supplementary$INSTRUCTOR_NUMBER)
	
	tmp.inst[, INSTRUCTOR_NUMBER := factor(INSTRUCTOR_NUMBER)]
	tmp.inst[, CMO_NAME := INSTRUCTOR_NUMBER]
	
	levels(tmp.inst$CMO_NAME) <- sapply(levels(tmp.inst$CMO_NAME), function(s) strsplit(s, "_")[[1]][1], USE.NAMES=FALSE)
	levels(tmp.inst$INSTRUCTOR_NUMBER) <- sapply(levels(tmp.inst$INSTRUCTOR_NUMBER), function(s) strsplit(s, "_")[[1]][2], USE.NAMES=FALSE)
	
	setkeyv(tmp.inst, c(key(California_SGP@Data), 'CMO_NAME'))
	for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC")) {
		ids <- s[CMO_NAME==cmo & YEAR=='2013']$ID
		tmp.dt <- data.table(s[CMO_NAME==cmo | ID %in% ids], key = c(key(California_SGP@Data), 'CMO_NAME'))
		tmp.dt <- merge(tmp.dt, tmp.inst, all.x=TRUE)
		setkeyv(tmp.dt, c('ID', 'CONTENT_AREA', 'YEAR'))
		write.table(tmp.dt, file=gzfile(paste("Results_2013/", cmo, "_Results_2013/Math+ELA/", cmo, "_Student_Level_SGP-Math+ELA.txt.gz", sep="")), sep="|", row.names=FALSE)
	}
	
	##  Write LAUSD Seperately - only SGPs
	tmp.dt <- data.table(s[CMO_NAME=="LAUSD"][!is.na(SGP),], key = c('ID', 'CONTENT_AREA', 'YEAR'))
	## Remove vars added.  All VALID CASEs here because they all have SGPs.
	tmp.dt[, CMO_NAME := NULL]
	tmp.dt[, VALID_CASE := NULL]
	
	write.table(tmp.dt, file=gzfile("Results_2013/LAUSD_Results_2013/Math+ELA/LAUSD_Student_Level_SGP-Math+ELA.txt.gz"), sep="|", row.names=FALSE)
	
	
	#  Demographic group summaries:

	for (demo in c("GENDER", "ETHNICITY", "ELL_STATUS", "IEP_STATUS", "SES_STATUS", "CATCH_UP_KEEP_UP_STATUS")) { #, "CATCH_UP_KEEP_UP_STATUS_INITIAL"
	
		###  CMO + Grade
		s <- data.table(California_SGP@Summary[['CMO_NUMBER']][[paste("CMO_NUMBER__CONTENT_AREA__YEAR__GRADE__", demo, sep="")]])
		setnames(s, "CMO_NUMBER", "CMO_NAME")
		s[["CMO_NAME"]] <- factor(s[["CMO_NAME"]], levels=1:5, labels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
		s <- s[!is.na(MEDIAN_SGP)]
		
		for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
			tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & CMO_NAME!="NA",], key = c("CMO_NAME", 'CONTENT_AREA', 'YEAR'))
			write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Math+ELA/Summaries/Demographic_Groups/CMO__CONTENT_AREA__YEAR__GRADE__",demo,".txt", sep=""), sep="|", row.names=FALSE)
		}
		s <- NULL
	
		###  CMO + Grade
		s <- data.table(California_SGP@Summary[['CMO_NUMBER']][[paste("CMO_NUMBER__CONTENT_AREA__YEAR__GRADE__", demo, sep="")]])
		setnames(s, "CMO_NUMBER", "CMO_NAME")
		s[["CMO_NAME"]] <- factor(s[["CMO_NAME"]], levels=1:5, labels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
		s <- s[!is.na(MEDIAN_SGP)]
	
		for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
			tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & CMO_NAME!="NA",], key = c("CMO_NAME", 'CONTENT_AREA', 'YEAR'))
			write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Math+ELA/Summaries/Demographic_Groups/CMO__CONTENT_AREA__YEAR__GRADE__", demo, ".txt", sep=""), sep="|", row.names=FALSE)
		}
		s <- NULL
	
		###  School
		s <- data.table(California_SGP@Summary[['SCHOOL_NUMBER']][[paste("SCHOOL_NUMBER__CONTENT_AREA__YEAR__", demo, sep="")]])
		cmo <- as.character(s[['SCHOOL_NUMBER']])
		s[["CMO_NAME"]] <- factor(sapply(cmo, function(x) strsplit(x, "_")[[1]][1], USE.NAMES=FALSE))
		sch <- sapply(levels(s[['SCHOOL_NUMBER']]), function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
		levels(s[['SCHOOL_NUMBER']]) <- sch
		s <- s[!is.na(MEDIAN_SGP)]
		setcolorder(s, c(dim(s)[2],1:(dim(s)[2]-1)))
		
		for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
			tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & !is.na(eval(demo)) & SCHOOL_NUMBER!="NA",], key = c('SCHOOL_NUMBER', 'CONTENT_AREA', 'YEAR'))
			write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Math+ELA/Summaries/Demographic_Groups/SCHOOL_NUMBER__CONTENT_AREA__YEAR__", demo, ".txt", sep=""), sep="|", row.names=FALSE)
		}
		s <- NULL
	
		###  School
		s <- data.table(California_SGP@Summary[['SCHOOL_NUMBER']][[paste("SCHOOL_NUMBER__CONTENT_AREA__YEAR__", demo, sep="")]])
		cmo <- as.character(s[['SCHOOL_NUMBER']])
		s[["CMO_NAME"]] <- factor(sapply(cmo, function(x) strsplit(x, "_")[[1]][1], USE.NAMES=FALSE))
		sch <- sapply(levels(s[['SCHOOL_NUMBER']]), function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
		levels(s[['SCHOOL_NUMBER']]) <- sch
		s <- s[!is.na(MEDIAN_SGP)]
		setcolorder(s, c(dim(s)[2],1:(dim(s)[2]-1)))
	
		for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
			tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & !is.na(eval(demo)) & SCHOOL_NUMBER!="NA",], key = c('SCHOOL_NUMBER', 'CONTENT_AREA', 'YEAR'))
			write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Math+ELA/Summaries/Demographic_Groups/SCHOOL_NUMBER__CONTENT_AREA__YEAR__", demo, ".txt", sep=""), sep="|", row.names=FALSE)
		}
	}

for (demo in c("SES_STATUS", "IEP_STATUS", "CATCH_UP_KEEP_UP_STATUS")) {
	s <- data.table(California_SGP@Summary[['CMO_NUMBER']][[paste("CMO_NUMBER__CONTENT_AREA__YEAR__GRADE__", demo, sep="")]])
	setnames(s, "CMO_NUMBER", "CMO_NAME")
	s[["CMO_NAME"]] <- factor(s[["CMO_NAME"]], levels=1:5, labels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
	s <- s[!is.na(MEDIAN_SGP)]
	if (demo == "CATCH_UP_KEEP_UP_STATUS") s <- s[!is.na(MEDIAN_SGP_TARGET_3_YEAR)]
	setkeyv(s, c("CMO_NAME", "YEAR", "CONTENT_AREA", demo))
	setkeyv(s, c("CMO_NAME", "YEAR", "CONTENT_AREA", "GRADE"))

	write.table(s, file=paste("Results_2013/ALL_SYSTEM_CMO__CONTENT_AREA__YEAR__GRADE__", demo, ".txt", sep=""), sep="|", row.names=FALSE)
}

for (demo in c("SES_STATUS", "IEP_STATUS", "CATCH_UP_KEEP_UP_STATUS")) {
	s <- data.table(California_SGP@Summary[['CMO_NUMBER']][[paste("CMO_NUMBER__CONTENT_AREA__YEAR__GRADE__", demo, sep="")]])
	setnames(s, "CMO_NUMBER", "CMO_NAME")
	s[["CMO_NAME"]] <- factor(s[["CMO_NAME"]], levels=1:5, labels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
	s <- s[!is.na(MEDIAN_SGP)]
	if (demo == "CATCH_UP_KEEP_UP_STATUS") s <- s[!is.na(MEDIAN_SGP_TARGET_3_YEAR)]
	setkeyv(s, c("CMO_NAME", "YEAR", "CONTENT_AREA", demo))
	setkeyv(s, c("CMO_NAME", "YEAR", "CONTENT_AREA", "GRADE"))

	write.table(s, file=paste("Results_2013/ALL_SYSTEM_CMO__CONTENT_AREA__YEAR__GRADE__", demo, ".txt", sep=""), sep="|", row.names=FALSE)
}


#####################################################################################################
#####################################################################################################
###
###		Matched Priors EOCT progression analyses
###		Science and History courses with priors from other Science and History subjects
###		Math and ELA EOCT subjects use the same config scripts as above.
###		Grade level Math and ELA needs to be re-run for this object as well.
###
#####################################################################################################
#####################################################################################################

###  Load the required data objects
###  These were produced as revisions of the 2012 data objects (California_SGP-2012_REVISION.R)

load("Data/California_SGP-Matched_Priors-2013.Rdata")

############################################################
####
####					analyzeSGP
####
############################################################

	California_SGP <- analyzeSGP(California_SGP,
	                             content_areas=c("ELA", "MATHEMATICS"),
	                             years='2013',
	                             grades = 2:11,
	                             sgp.percentiles = TRUE,
	                             sgp.projections = TRUE,
	                             sgp.projections.lagged = TRUE,
	                             sgp.percentiles.baseline = TRUE,
	                             sgp.projections.baseline = TRUE,
	                             sgp.projections.lagged.baseline = TRUE,
	                             simulate.sgps = FALSE,
	                             parallel.config=list(
	                                     BACKEND="PARALLEL",
	                                     WORKERS=list(
	                                     	PERCENTILES=23, PROJECTIONS=12, LAGGED_PROJECTIONS=12)))


	#########
	###			Heterogeneous Grade-level and Middle School EOCT progression analyses
	#########

	##  Science and History courses use MATCHED content area priors (same content area, but different subjects).  
	##  Because the CONTENT_AREA progression is still heterogeneous, we must again manually specify the sgp.config.
	##  Load ALL 2013 analysis configuration lists and create the Grade Level specific sgp.config

	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2013_Matched/SCIENCE.R")
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2013_Matched/SOCIAL_STUDIES.R")

	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2013/MATHEMATICS.R") # Same as above - already "Matched"		

	##  Combine all subject level configurations into a single list for the sgp.config argument

	TCRP_EOCT_Matched.config <- c(
		HISTORY_2013_Match.config,
		SCIENCE_2013_Match.config,

		ALGEBRA_I_2013.config, 
		ALGEBRA_II_2013.config, 
		GENERAL_MATHEMATICS_2013.config, 
		GEOMETRY_2013.config, 		
		SUMMATIVE_HS_MATHEMATICS_2013.config,

		BIOLOGY_2013_Match.config, 
		CHEMISTRY_2013_Match.config, 
		INTEGRATED_SCIENCE_1.2013_Match.config, 
		LIFE_SCIENCE_2013_Match.config, 
		PHYSICS_2013_Match.config,

		US_HISTORY_2013_Match.config, 
		WORLD_HISTORY_2013_Match.config
	)
	
	California_SGP <- analyzeSGP(California_SGP,
	                             sgp.config = TCRP_EOCT_Matched.config,
	                             sgp.percentiles = TRUE,
	                             sgp.projections = FALSE,
	                             sgp.projections.lagged = FALSE,
	                             sgp.percentiles.baseline = TRUE,
	                             sgp.projections.baseline = FALSE,
	                             sgp.projections.lagged.baseline = FALSE,
	                             simulate.sgps = FALSE,
	                             parallel.config=list(
	                                     BACKEND="PARALLEL",
	                                     WORKERS=list(PERCENTILES=20)))

	save(California_SGP, file='Data/California_SGP-Matched_Priors_2013.Rdata')

#########################################################
####
####					combineSGP
####
#########################################################

	California_SGP <- combineSGP(California_SGP)

	#  Check the LONG @Data file now:
	sgp.names <- names(California_SGP@SGP[["SGPercentiles"]])
	tot.c<-0
	for(i in match(sgp.names[-grep('BASELINE', sgp.names)], sgp.names)) { # ... paste(sgp.names[i] ...
		print(paste(sgp.names[i], "N =", dim(California_SGP@SGP[['SGPercentiles']][[i]])[1], " :  Median SGP,", median(California_SGP@SGP[['SGPercentiles']][[i]][["SGP"]])))
		tot.c <- tot.c+(dim(California_SGP@SGP[['SGPercentiles']][[i]])[1])
	}
	tot.c
	
	sum(!is.na(California_SGP@Data$SGP)) #  This number should be smaller than the total SGPs produced (tot) - duplicates have been removed.

	tot.b<-0
	for(i in match(sgp.names[grep('BASELINE', sgp.names)], sgp.names)) { # ... paste(sgp.names[i] ...
		print(paste(sgp.names[i], "N =", dim(California_SGP@SGP[['SGPercentiles']][[i]])[1], " :  Median SGP,", median(California_SGP@SGP[['SGPercentiles']][[i]][["SGP_BASELINE"]])))
		tot.b <- tot.b+(dim(California_SGP@SGP[['SGPercentiles']][[i]])[1])
	}
	tot.b
	
	sum(!is.na(California_SGP@Data$SGP_BASELINE)) #  This number should be smaller than the total SGPs produced (tot)
	
			
	tbl <- California_SGP@Data[, list(MEDIAN = median(as.numeric(SGP), na.rm=T), MEDIAN_BASELINE = median(as.numeric(SGP_BASELINE), na.rm=T), N = sum(!is.na(SGP)), N_BASELINE = sum(!is.na(SGP_BASELINE))), by = c("CONTENT_AREA", "GRADE", "YEAR")][!is.na(MEDIAN)]
	
	tbl[YEAR=='2013']
	
	
#########################################################
####
####					summarizeSGP
####
#########################################################

	###  Identify the Content areas that have SGPs (some CST tests did not have enough kids/progresions to analyze)
	
	subjects <- c('ELA', 'HISTORY', 'WORLD_HISTORY', 'US_HISTORY', 
		'MATHEMATICS', 'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II', 'SUMMATIVE_HS_MATHEMATICS', 
		'SCIENCE', 'INTEGRATED_SCIENCE_1', 'LIFE_SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS')
	
	California_SGP <- summarizeSGP(California_SGP,
			content_areas = subjects,
			years='2013',
			parallel.config=list(BACKEND="PARALLEL", WORKERS=6))
	
		save(California_SGP, file='Data/California_SGP-Matched_Priors_2013.Rdata')


#########################################################
####
####	Output summary tables and student long files to .txt files (pipe delimited) for the CMOs.
####	Don't use outputSGP because each CMO needs their own files with ONLY their data.
####
#########################################################
	
	setwd('/media/Data/Dropbox/SGP/California')
	
	for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
		if (is.na(file.info("Results_2013")$isdir)) {
			dir.create("Results_2013")
		}
		dir.create(paste("Results_2013/", cmo, "_Results_2013/Matched/Summaries/Demographic_Groups", sep=""), recursive=TRUE, showWarnings=FALSE)
	}
	
	
	###  CMO by Grade, subject
	s <- data.table(California_SGP@Summary[['CMO_NUMBER']][['CMO_NUMBER__CONTENT_AREA__YEAR__GRADE']])
	table(California_SGP@Data$CMO_NUMBER, California_SGP@Data$CMO_NAME)
	setnames(s, "CMO_NUMBER", "CMO_NAME")
	s[["CMO_NAME"]] <- factor(s[["CMO_NAME"]], levels=1:5, labels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
	s <- s[!is.na(MEDIAN_SGP)]
	
	for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
		tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & CMO_NAME!="NA",], key = c("CMO_NAME", 'CONTENT_AREA', 'YEAR', 'GRADE'))
		write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Matched/Summaries/CMO__CONTENT_AREA__YEAR__GRADE.txt", sep=""), sep="|", row.names=FALSE)
	}
	
	###  School Only, subj
	s <- data.table(California_SGP@Summary[['SCHOOL_NUMBER']][['SCHOOL_NUMBER__CONTENT_AREA__YEAR']])
	cmo <- as.character(s[['SCHOOL_NUMBER']])
	s[["CMO_NAME"]] <- ordered(sapply(cmo, function(x) strsplit(x, "_")[[1]][1], USE.NAMES=FALSE), levels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
	sch <- sapply(levels(s[['SCHOOL_NUMBER']]), function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
	levels(s[['SCHOOL_NUMBER']]) <- sch
	setcolorder(s, c(dim(s)[2],1:(dim(s)[2]-1)))
	
	for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
		tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & SCHOOL_NUMBER!="NA",], key = c('SCHOOL_NUMBER', 'CONTENT_AREA', 'YEAR'))
		setcolorder(tmp, c(dim(tmp)[2],1:(dim(tmp)[2]-1)))
		write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Matched/Summaries/SCHOOL_NUMBER__CONTENT_AREA__YEAR.txt", sep=""), sep="|", row.names=FALSE)
	}
	
	
	###  School + Grade, subj
	s <- data.table(California_SGP@Summary[['SCHOOL_NUMBER']][['SCHOOL_NUMBER__CONTENT_AREA__YEAR__GRADE']])
	cmo <- as.character(s[['SCHOOL_NUMBER']])
	s[["CMO_NAME"]] <- ordered(sapply(cmo, function(x) strsplit(x, "_")[[1]][1], USE.NAMES=FALSE), levels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
	sch.gr <- sapply(levels(s[['SCHOOL_NUMBER']]), function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
	levels(s[['SCHOOL_NUMBER']]) <- sch.gr
	setcolorder(s, c(dim(s)[2],1:(dim(s)[2]-1)))
	
	for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
		tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & SCHOOL_NUMBER!="NA",], key = c('SCHOOL_NUMBER', 'CONTENT_AREA', 'GRADE', 'YEAR'))
		write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Matched/Summaries/SCHOOL_NUMBER__CONTENT_AREA__YEAR__GRADE.txt", sep=""), sep="|", row.names=FALSE)
	}
	
	###  Teacher only
	s <- data.table(California_SGP@Summary[['DISTRICT_NUMBER']][['DISTRICT_NUMBER__INSTRUCTOR_NUMBER__CONTENT_AREA__YEAR__INSTRUCTOR_ENROLLMENT_STATUS']])
	cmo <- as.character(s[['INSTRUCTOR_NUMBER']])
	s[["CMO_NAME"]] <- ordered(sapply(cmo, function(x) strsplit(x, "_")[[1]][1], USE.NAMES=FALSE), levels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
	s[['INSTRUCTOR_NUMBER']] <- sapply(s[['INSTRUCTOR_NUMBER']], function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
	setcolorder(s, c(dim(s)[2],1:(dim(s)[2]-1)))
	
	for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
		tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & INSTRUCTOR_NUMBER!="NA",], key = c('INSTRUCTOR_NUMBER', 'CONTENT_AREA', 'YEAR'))
		write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Matched/Summaries/INSTRUCTOR_NUMBER__CONTENT_AREA__YEAR.txt", sep=""), sep="|", row.names=FALSE)
	}
	
	
	###  Teacher Grade Subject
	s <- data.table(California_SGP@Summary[['DISTRICT_NUMBER']][['DISTRICT_NUMBER__INSTRUCTOR_NUMBER__CONTENT_AREA__YEAR__GRADE__INSTRUCTOR_ENROLLMENT_STATUS']])
	cmo <- as.character(s[['INSTRUCTOR_NUMBER']])
	s[["CMO_NAME"]] <- ordered(sapply(cmo, function(x) strsplit(x, "_")[[1]][1], USE.NAMES=FALSE), levels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
	s[['INSTRUCTOR_NUMBER']] <- sapply(s[['INSTRUCTOR_NUMBER']], function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
	setcolorder(s, c(dim(s)[2],1:(dim(s)[2]-1)))
	
	for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
		tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & INSTRUCTOR_NUMBER!="NA",], key = c('INSTRUCTOR_NUMBER', 'CONTENT_AREA', 'GRADE', 'YEAR'))
		write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Matched/Summaries/INSTRUCTOR_NUMBER__CONTENT_AREA__YEAR__GRADE.txt", sep=""), sep="|", row.names=FALSE)
	}
	
	
	#  Student files 
	s <- data.table(California_SGP@Data[,c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID", "LAST_NAME", "FIRST_NAME", "GRADE", "GRADE_REPORTED", "SCALE_SCORE", "SCALE_SCORE_PRIOR", "SCALE_SCORE_PRIOR_STANDARDIZED", "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_PRIOR", "SGP", "SGP_NORM_GROUP", "SGP_LEVEL", "SGP_TARGET_3_YEAR", "SGP_TARGET_MOVE_UP_STAY_UP_3_YEAR", "CATCH_UP_KEEP_UP_STATUS", "MOVE_UP_STAY_UP_STATUS", "GENDER", "ETHNICITY", "ELL_STATUS", "SES_STATUS", "IEP_STATUS", "CMO_NAME", "DISTRICT_NUMBER", "DISTRICT_NAME", "SCHOOL_NUMBER_PROVIDED", "SCHOOL_NAME"), with=FALSE])
	
	setnames(s, "SCHOOL_NUMBER_PROVIDED", "SCHOOL_NUMBER")
	
	tmp.inst <- data.table(VALID_CASE="VALID_CASE", California_SGP@Data_Supplementary$INSTRUCTOR_NUMBER)
	
	tmp.inst[, INSTRUCTOR_NUMBER := factor(INSTRUCTOR_NUMBER)]
	tmp.inst[, CMO_NAME := INSTRUCTOR_NUMBER]
	
	levels(tmp.inst$CMO_NAME) <- sapply(levels(tmp.inst$CMO_NAME), function(s) strsplit(s, "_")[[1]][1], USE.NAMES=FALSE)
	levels(tmp.inst$INSTRUCTOR_NUMBER) <- sapply(levels(tmp.inst$INSTRUCTOR_NUMBER), function(s) strsplit(s, "_")[[1]][2], USE.NAMES=FALSE)
	
	setkeyv(tmp.inst, c(key(California_SGP@Data), 'CMO_NAME'))
	for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC")) {
		ids <- s[CMO_NAME==cmo & YEAR=='2013']$ID
		tmp.dt <- data.table(s[CMO_NAME==cmo | ID %in% ids], key = c(key(California_SGP@Data), 'CMO_NAME'))
		tmp.dt <- merge(tmp.dt, tmp.inst, all.x=TRUE)
		setkeyv(tmp.dt, c('ID', 'CONTENT_AREA', 'YEAR'))
		write.table(tmp.dt, file=gzfile(paste("Results_2013/", cmo, "_Results_2013/Matched/", cmo, "_Student_Level_SGP-Matched.txt.gz", sep="")), sep="|", row.names=FALSE)
	}
	
	##  Write LAUSD Seperately - only SGPs
	tmp <- data.table(s[CMO_NAME=="LAUSD"][!is.na(SGP),], key = c('ID', 'CONTENT_AREA', 'YEAR'))
	## Remove vars added.  All VALID CASEs here because they all have SGPs.
	tmp[, CMO_NAME := NULL]
	tmp[, VALID_CASE := NULL]
	
	write.table(tmp, file=gzfile("Results_2013/LAUSD_Results_2013/Matched/LAUSD_Student_Level_SGP-Matched.txt.gz"), sep="|", row.names=FALSE)
	
	
	#  Demographic group summaries:
	
	for (demo in c("GENDER", "ETHNICITY", "ELL_STATUS", "IEP_STATUS", "SES_STATUS", "CATCH_UP_KEEP_UP_STATUS")) { #, "CATCH_UP_KEEP_UP_STATUS_INITIAL"
	
		###  CMO + Grade
		s <- data.table(California_SGP@Summary[['CMO_NUMBER']][[paste("CMO_NUMBER__CONTENT_AREA__YEAR__GRADE__", demo, sep="")]])
		setnames(s, "CMO_NUMBER", "CMO_NAME")
		s[["CMO_NAME"]] <- factor(s[["CMO_NAME"]], levels=1:5, labels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
		s <- s[!is.na(MEDIAN_SGP)]
		
		for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
			tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & CMO_NAME!="NA",], key = c("CMO_NAME", 'CONTENT_AREA', 'YEAR'))
			write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Matched/Summaries/Demographic_Groups/CMO__CONTENT_AREA__YEAR__GRADE__",demo,".txt", sep=""), sep="|", row.names=FALSE)
		}
		s <- NULL
	
		###  CMO + Grade
		s <- data.table(California_SGP@Summary[['CMO_NUMBER']][[paste("CMO_NUMBER__CONTENT_AREA__YEAR__GRADE__", demo, sep="")]])
		setnames(s, "CMO_NUMBER", "CMO_NAME")
		s[["CMO_NAME"]] <- factor(s[["CMO_NAME"]], levels=1:5, labels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
		s <- s[!is.na(MEDIAN_SGP)]
	
		for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
			tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & CMO_NAME!="NA",], key = c("CMO_NAME", 'CONTENT_AREA', 'YEAR'))
			write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Matched/Summaries/Demographic_Groups/CMO__CONTENT_AREA__YEAR__GRADE__", demo, ".txt", sep=""), sep="|", row.names=FALSE)
		}
		s <- NULL
	
		###  School
		s <- data.table(California_SGP@Summary[['SCHOOL_NUMBER']][[paste("SCHOOL_NUMBER__CONTENT_AREA__YEAR__", demo, sep="")]])
		cmo <- as.character(s[['SCHOOL_NUMBER']])
		s[["CMO_NAME"]] <- factor(sapply(cmo, function(x) strsplit(x, "_")[[1]][1], USE.NAMES=FALSE))
		sch <- sapply(levels(s[['SCHOOL_NUMBER']]), function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
		levels(s[['SCHOOL_NUMBER']]) <- sch
		s <- s[!is.na(MEDIAN_SGP)]
		setcolorder(s, c(dim(s)[2],1:(dim(s)[2]-1)))
		
		for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
			tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & !is.na(eval(demo)) & SCHOOL_NUMBER!="NA",], key = c('SCHOOL_NUMBER', 'CONTENT_AREA', 'YEAR'))
			write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Matched/Summaries/Demographic_Groups/SCHOOL_NUMBER__CONTENT_AREA__YEAR__", demo, ".txt", sep=""), sep="|", row.names=FALSE)
		}
		s <- NULL
	
		###  School
		s <- data.table(California_SGP@Summary[['SCHOOL_NUMBER']][[paste("SCHOOL_NUMBER__CONTENT_AREA__YEAR__", demo, sep="")]])
		cmo <- as.character(s[['SCHOOL_NUMBER']])
		s[["CMO_NAME"]] <- factor(sapply(cmo, function(x) strsplit(x, "_")[[1]][1], USE.NAMES=FALSE))
		sch <- sapply(levels(s[['SCHOOL_NUMBER']]), function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
		levels(s[['SCHOOL_NUMBER']]) <- sch
		s <- s[!is.na(MEDIAN_SGP)]
		setcolorder(s, c(dim(s)[2],1:(dim(s)[2]-1)))
	
		for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
			tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & !is.na(eval(demo)) & SCHOOL_NUMBER!="NA",], key = c('SCHOOL_NUMBER', 'CONTENT_AREA', 'YEAR'))
			write.table(tmp, file=paste("Results_2013/", cmo, "_Results_2013/Matched/Summaries/Demographic_Groups/SCHOOL_NUMBER__CONTENT_AREA__YEAR__", demo, ".txt", sep=""), sep="|", row.names=FALSE)
		}
	}
	
	for (demo in c("SES_STATUS", "IEP_STATUS", "CATCH_UP_KEEP_UP_STATUS")) {
		s <- data.table(California_SGP@Summary[['CMO_NUMBER']][[paste("CMO_NUMBER__CONTENT_AREA__YEAR__GRADE__", demo, sep="")]])
		setnames(s, "CMO_NUMBER", "CMO_NAME")
		s[["CMO_NAME"]] <- factor(s[["CMO_NAME"]], levels=1:5, labels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
		s <- s[!is.na(MEDIAN_SGP)]
		if (demo == "CATCH_UP_KEEP_UP_STATUS") s <- s[!is.na(MEDIAN_SGP_TARGET_3_YEAR)]
		setkeyv(s, c("CMO_NAME", "YEAR", "CONTENT_AREA", demo))
		setkeyv(s, c("CMO_NAME", "YEAR", "CONTENT_AREA", "GRADE"))
	
		write.table(s, file=paste("Results_2013/ALL_SYSTEM_CMO__CONTENT_AREA__YEAR__GRADE__", demo, "-Matched.txt", sep=""), sep="|", row.names=FALSE)
	}
	
	
	for (demo in c("SES_STATUS", "IEP_STATUS", "CATCH_UP_KEEP_UP_STATUS")) {
		s <- data.table(California_SGP@Summary[['CMO_NUMBER']][[paste("CMO_NUMBER__CONTENT_AREA__YEAR__GRADE__", demo, sep="")]])
		setnames(s, "CMO_NUMBER", "CMO_NAME")
		s[["CMO_NAME"]] <- factor(s[["CMO_NAME"]], levels=1:5, labels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
		s <- s[!is.na(MEDIAN_SGP)]
		if (demo == "CATCH_UP_KEEP_UP_STATUS") s <- s[!is.na(MEDIAN_SGP_TARGET_3_YEAR)]
		setkeyv(s, c("CMO_NAME", "YEAR", "CONTENT_AREA", demo))
		setkeyv(s, c("CMO_NAME", "YEAR", "CONTENT_AREA", "GRADE"))
	
		write.table(s, file=paste("Results_2013/ALL_SYSTEM_CMO__CONTENT_AREA__YEAR__GRADE__", demo, "-Matched.txt", sep=""), sep="|", row.names=FALSE)
	}
	
