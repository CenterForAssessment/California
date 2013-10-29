##########################################################
####
####	Code for analysis of CMO data 
####	Revised June/October 2013
####
##########################################################

### Load the required R packages and set the working directory

setwd('/media/Data/Dropbox/SGP/California')

require(SGP)
require(data.table)

###   Load the required data objects

load("Data/California_SGP-Data_ONLY.Rdata") # Set up for 2013 analyses - California_Data_LONG-2013.R
load('/home/avi/TCRP_Cohort_Matrices_2010-12.Rdata') #  Cleaned and updated coefficient matrices from previous analyses.

############################################################
####
####		analyzeSGP
####
############################################################

	##  Add the previously calculated TCRP Coefficient Matrices for 2010 - 2012 to the SGP object.  
	##  We need these to use the argument 'sgp.use.my.coefficient.matrices=TRUE'
	
	California_SGP@SGP[["Coefficient_Matrices"]] <- TCRP_Cohort_Matrices

	California_SGP <- analyzeSGP(California_SGP,
                             content_areas=c("ELA", "MATHEMATICS"),
                             years=c('2012', '2011', '2010'),
                             grades = 2:11,
                             sgp.percentiles = TRUE,
                             sgp.projections = TRUE,
                             sgp.projections.lagged = TRUE,
                             sgp.percentiles.baseline = TRUE,
                             sgp.projections.baseline = TRUE,
                             sgp.projections.lagged.baseline = TRUE,
                             simulate.sgps = FALSE,
                             sgp.use.my.coefficient.matrices=TRUE,
                             parallel.config=list(
                                 BACKEND="PARALLEL",
                                 WORKERS=list(PERCENTILES=23, PROJECTIONS=12, LAGGED_PROJECTIONS=12)))

###
###			Heterogeneous Grade-level and Middle School EOCT progression analyses
###

	##  Science and History courses use grade-level Math and ELA respectively as priors.  
	##  Because of this heterogeneous CONTENT_AREA progression, we must explicitly specify the sgp.config.
	##  In the section above (homogeneous course progressions), the analyzeSGP function can produce these 
	##  lists of analyses internally.  Along with these two subjects, many middle school students take
	##  Algebra I or General Math as well
	##  rather than separating 10th and 11th graders from 9th and 10th graders with that same course sequence)

	## Load ALL 2012 analysis configuration lists and create the Grade Level specific sgp.config
	
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2010/MATHEMATICS.R")
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2010/SCIENCE.R")
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2010/SOCIAL_STUDIES.R")

	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2011/MATHEMATICS.R")
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2011/SCIENCE.R")
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2011/SOCIAL_STUDIES.R")

	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2012/MATHEMATICS.R")
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2012/SCIENCE.R")
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2012/SOCIAL_STUDIES.R")

	TCRP_Grade_Level.config <- c(
		HISTORY_2012.config, 
		SCIENCE_2012.config,
		ALGEBRA_I_MS_2012.config,
		GENERAL_MATHEMATICS_MS_2012.config,

		HISTORY_2011.config, 
		SCIENCE_2011.config,
		ALGEBRA_I_MS_2011.config,
		GENERAL_MATHEMATICS_MS_2011.config,

		HISTORY_2010.config, 
		SCIENCE_2010.config,
		ALGEBRA_I_MS_2010.config,
		GENERAL_MATHEMATICS_MS_2010.config
	)

	California_SGP <- analyzeSGP(California_SGP,
                             sgp.config = TCRP_Grade_Level.config,
                             sgp.percentiles = TRUE,
                             sgp.projections = FALSE,
                             sgp.projections.lagged = FALSE,
                             sgp.percentiles.baseline = TRUE,
                             sgp.projections.baseline = FALSE,
                             sgp.projections.lagged.baseline = FALSE,
                             simulate.sgps = FALSE,
                             sgp.use.my.coefficient.matrices = TRUE,
                             parallel.config=list(
                                     BACKEND="PARALLEL",
                                     WORKERS=list(PERCENTILES=23)))

###  Save the object here to continue later with "Matched" analyses.
###  Up to this point they have been the same (used identical priors)

	save(California_SGP, file='Data/California_SGP-Matched_Priors-2013.Rdata') # save as 2013 in Oct. when preping for 2013 analyses
	
###
###			High school EOCT progressions
###

	##  Rather than use GRADE as a source of the progression we now set all values of the GRADE variable to 'EOCT'.  This will focus the 
	##  analysis on the CONTENT_AREA progression rather than the GRADE progression.  Thus, we are comparing ALL students that had
	##  the same course progression (e.g. ALL students that took Geometry (2011 prior) and then Chemistry (2012 current), 
	##  rather than separating 10th and 11th graders from 9th and 10th graders with that same course sequence into two seperate analyses)

	##  Change all GRADE values of the ELA and Math priors to 'EOCT'
	
	California_SGP@Data$TMP_GRADE <- California_SGP@Data$GRADE
	California_SGP@Data[, GRADE := 'EOCT'] # table(California_SGP@Data$GRADE)

	##  Combine all the year and subject level configurations into a single list for the sgp.config argument

	TCRP_EOCT.config <- c(
	# 2012
		ALGEBRA_I_2012.config, 
		ALGEBRA_II_2012.config, 
		BIOLOGY_2012.config, 
		CHEMISTRY_2012.config, 
		GENERAL_MATHEMATICS_2012.config, 
		GEOMETRY_2012.config, 		
		INTEGRATED_SCIENCE_1.2012.config, 
		LIFE_SCIENCE_2012.config, 
		PHYSICS_2012.config, 
		SUMMATIVE_HS_MATHEMATICS_2012.config, 
		US_HISTORY_2012.config, 
		WORLD_HISTORY_2012.config,

	# 2011
		ALGEBRA_I_2011.config, 
		ALGEBRA_II_2011.config, 
		BIOLOGY_2011.config, 
		CHEMISTRY_2011.config, 
		GENERAL_MATHEMATICS_2011.config, 
		GEOMETRY_2011.config, 		
		INTEGRATED_SCIENCE_1.2011.config, 
		LIFE_SCIENCE_2011.config, 
		PHYSICS_2011.config, 
		SUMMATIVE_HS_MATHEMATICS_2011.config, 
		US_HISTORY_2011.config, 
		WORLD_HISTORY_2011.config,

	# 2010
		ALGEBRA_I_2010.config, 
		ALGEBRA_II_2010.config, 
		BIOLOGY_2010.config, 
		CHEMISTRY_2010.config, 
		GENERAL_MATHEMATICS_2010.config, 
		GEOMETRY_2010.config, 		
		INTEGRATED_SCIENCE_1.2010.config, 
		LIFE_SCIENCE_2010.config, 
		PHYSICS_2010.config, 
		SUMMATIVE_HS_MATHEMATICS_2010.config, 
		US_HISTORY_2010.config, 
		WORLD_HISTORY_2010.config
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
                             sgp.use.my.coefficient.matrices = TRUE,
                             parallel.config=list(
                                     BACKEND="PARALLEL",
                                     WORKERS=list(PERCENTILES=23)))
                           		                          		
	###  For reporting/summarization purposes, we will return the GRADE variable to its original form:
	
	California_SGP@Data[, GRADE := TMP_GRADE]
	California_SGP@Data[, TMP_GRADE := NULL] # table(California_SGP@Data$GRADE)
	
	save(California_SGP, file='Data/California_SGP-Math+ELA-2013.Rdata')


###
###			Matched Priors EOCT progression analyses
###			Science and History courses with priors from other Science and History subjects
###

### Load ALL 2013 analysis configuration lists and create the Grade Level specific sgp.config

	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2010_Matched/SCIENCE.R")
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2010_Matched/SOCIAL_STUDIES.R")
	
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2011_Matched/SCIENCE.R")
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2011_Matched/SOCIAL_STUDIES.R")
	
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2012_Matched/SCIENCE.R")
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2012_Matched/SOCIAL_STUDIES.R")

	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2010/MATHEMATICS.R") # Same as above - already "Matched"
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2011/MATHEMATICS.R")
	source("/media/Data/Dropbox/Github_Repos/Projects/California/SGP_CONFIG/EOCT/2012/MATHEMATICS.R")

###
###			High school EOCT progressions
###

	##  Rather than use GRADE as a source of the progression we now set all values of the GRADE variable to 'EOCT'.  This will focus the 
	##  analysis on the CONTENT_AREA progression rather than the GRADE progression.  Thus, we are comparing ALL students that had
	##  the same course progression (e.g. ALL students that took Geometry (2011 prior) and then Chemistry (2013 current), 
	##  rather than separating 10th and 11th graders from 9th and 10th graders with that same course sequence into two seperate analyses)

	load('Data/California_SGP-Matched_Priors_2013.Rdata')
	
	California_SGP@Data$TMP_GRADE <- California_SGP@Data$GRADE
	California_SGP@Data[, GRADE := 'EOCT']

	##  Combine all subject level configurations into a single list for the sgp.config argument


	TCRP_EOCT_Matched.config <- c(
	# 2012
		ALGEBRA_I_2012.config, 
		ALGEBRA_II_2012.config, 
		GENERAL_MATHEMATICS_2012.config, 
		GEOMETRY_2012.config, 		
		SUMMATIVE_HS_MATHEMATICS_2012.config, 

		BIOLOGY_2012_Match.config, 
		CHEMISTRY_2012_Match.config, 
		INTEGRATED_SCIENCE_1.2012_Match.config, 
		LIFE_SCIENCE_2012_Match.config, 
		PHYSICS_2012_Match.config, 

		US_HISTORY_2012_Match.config, 
		WORLD_HISTORY_2012_Match.config,

	# 2011
		ALGEBRA_I_2011.config, 
		ALGEBRA_II_2011.config, 
		GENERAL_MATHEMATICS_2011.config, 
		GEOMETRY_2011.config, 		
		SUMMATIVE_HS_MATHEMATICS_2011.config, 

		BIOLOGY_2011_Match.config, 
		CHEMISTRY_2011_Match.config, 
		INTEGRATED_SCIENCE_1.2011_Match.config, 
		LIFE_SCIENCE_2011_Match.config, 
		PHYSICS_2011_Match.config, 

		US_HISTORY_2011_Match.config, 
		WORLD_HISTORY_2011_Match.config,

	# 2010
		ALGEBRA_I_2010.config, 
		ALGEBRA_II_2010.config, 
		GENERAL_MATHEMATICS_2010.config, 
		GEOMETRY_2010.config, 		
		SUMMATIVE_HS_MATHEMATICS_2010.config, 

		BIOLOGY_2010_Match.config, 
		CHEMISTRY_2010_Match.config, 
		INTEGRATED_SCIENCE_1.2010_Match.config, 
		LIFE_SCIENCE_2010_Match.config, 
		PHYSICS_2010_Match.config, 

		US_HISTORY_2010_Match.config, 
		WORLD_HISTORY_2010_Match.config
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
                                 sgp.use.my.coefficient.matrices = TRUE,
	                             parallel.config=list(
	                                     BACKEND="PARALLEL",
	                                     # WORKERS=list(TAUS=6)))
	                                     WORKERS=list(PERCENTILES=20)))

	###  For reporting/summarization purposes, we will return the GRADE variable to its original form:
	
	California_SGP@Data[, GRADE := TMP_GRADE]
	California_SGP@Data[, TMP_GRADE := NULL]
	
	save(California_SGP, file='Data/California_SGP-Matched_Priors_2013.Rdata')

