##########################################################
####
####	Code for analysis of California data - FINAL
####
##########################################################

setwd("/media/Data/SGP/California")
library(SGP)
load("Data/California_SGP-2012_Data-ONLY.Rdata")

# California_SGP@Data$YEAR <- as.integer(California_SGP@Data$YEAR)

############################################################
####
####		analyzeSGP
####
############################################################

	California_SGP <- analyzeSGP(California_SGP, state="CA",
                                 content_areas=c("ELA", "MATHEMATICS"),
                                 years=c('2010', '2011'),
                                 sgp.percentiles.baseline= FALSE,
                                 sgp.projections.baseline= FALSE,
                                 sgp.projections.lagged.baseline=FALSE,
                                 simulate.sgps=FALSE,
                                 sgp.use.my.coefficient.matrices=TRUE,
                                 parallel.config=list(
                                     BACKEND="PARALLEL",
                                     WORKERS=list(PERCENTILES=24, PROJECTIONS=24, LAGGED_PROJECTIONS=24)))



	California_SGP <- analyzeSGP(California_SGP, state="CA",
                                 content_areas=c("ELA", "MATHEMATICS"),
                                 years='2012',
                                 # sgp.percentiles= FALSE,
                                 # sgp.projections= FALSE,
                                 # sgp.projections.lagged=FALSE,
                                 sgp.percentiles.baseline= FALSE,
                                 sgp.projections.baseline= FALSE,
                                 sgp.projections.lagged.baseline=FALSE,
                                 simulate.sgps=FALSE,
                                 parallel.config=list(
                                     BACKEND="PARALLEL",
                                     WORKERS=list(PERCENTILES=24, PROJECTIONS=24, LAGGED_PROJECTIONS=24)))


	save(California_SGP, file="Data/California_SGP-Math+ELA-2012.Rdata")


    CA.config <- list(
          HISTORY.2010 = list(
             sgp.content.areas=c("ELA", "HISTORY"),
             sgp.panel.years=c('2009', '2010'),
             sgp.grade.sequences=list(7:8)),

         ALGEBRA_I.2010 = list(
             sgp.content.areas=c("MATHEMATICS", "ALGEBRA_I"),
             sgp.panel.years=c('2009', '2010'),
             sgp.grade.sequences=list(6:7, 7:8)),
         GENERAL_MATHEMATICS.2010 = list(
             sgp.content.areas=c("MATHEMATICS", "GENERAL_MATHEMATICS"),
             sgp.panel.years=c('2009', '2010'),
             sgp.grade.sequences=list(7:8)),

         SCIENCE.2010 = list(
             sgp.content.areas=c("MATHEMATICS", "SCIENCE"),
             sgp.panel.years=c('2009', '2010'),
             sgp.grade.sequences=list(4:5, 7:8)),
             
             
          HISTORY.2011 = list(
             sgp.content.areas=c("ELA", "ELA", "HISTORY"),
             sgp.panel.years=c('2009', '2010', '2011'),
             sgp.grade.sequences=list(6:8)),

         ALGEBRA_I.2011 = list(
             sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "ALGEBRA_I"),
             sgp.panel.years=c('2009', '2010', '2011'),
             sgp.grade.sequences=list(5:7, 6:8)),
         GENERAL_MATHEMATICS.2011 = list(
             sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "GENERAL_MATHEMATICS"),
             sgp.panel.years=c('2009', '2010', '2011'),
             sgp.grade.sequences=list(6:8)),

         SCIENCE.2011 = list(
             sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "SCIENCE"),
             sgp.panel.years=c('2009', '2010', '2011'),
             sgp.grade.sequences=list(3:5, 6:8)))

	California_SGP <- analyzeSGP(California_SGP, state="CA",
                                 sgp.config=CA.config,
                                 # sgp.percentiles= FALSE,
                                 sgp.projections= FALSE,
                                 sgp.projections.lagged=FALSE,
                                 sgp.percentiles.baseline= FALSE,
                                 sgp.projections.baseline= FALSE,
                                 sgp.projections.lagged.baseline=FALSE,
                                 simulate.sgps=FALSE,
                                 sgp.use.my.coefficient.matrices=TRUE,
                                 parallel.config=list(
                                     BACKEND="PARALLEL",
                                     WORKERS=list(PERCENTILES=24)))
                           		

    CA.config <- list(
          HISTORY.2012 = list(
             sgp.content.areas=c("ELA", "ELA", "ELA", "HISTORY"),
             sgp.panel.years=c('2009', '2010', '2011', '2012'),
             sgp.grade.sequences=list(5:8)),

         ALGEBRA_I.2012 = list(
             sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "MATHEMATICS", "ALGEBRA_I"),
             sgp.panel.years=c('2009', '2010', '2011', '2012'),
             sgp.grade.sequences=list(4:7, 5:8)),
         GENERAL_MATHEMATICS.2012 = list(
             sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "MATHEMATICS", "GENERAL_MATHEMATICS"),
             sgp.panel.years=c('2009', '2010', '2011', '2012'),
             sgp.grade.sequences=list(5:8)),

         SCIENCE.2012 = list(
             sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "MATHEMATICS", "SCIENCE"),
             sgp.panel.years=c('2009', '2010', '2011', '2012'),
             sgp.grade.sequences=list(2:5, 5:8)))

	California_SGP <- analyzeSGP(California_SGP, state="CA",
                                 sgp.config=CA.config,
                                 # sgp.percentiles= FALSE,
                                 sgp.projections= FALSE,
                                 sgp.projections.lagged=FALSE,
                                 sgp.percentiles.baseline= FALSE,
                                 sgp.projections.baseline= FALSE,
                                 sgp.projections.lagged.baseline=FALSE,
                                 simulate.sgps=FALSE,
                                 parallel.config=list(
                                     BACKEND="PARALLEL",
                                     WORKERS=list(PERCENTILES=12)))
                           		
	save(California_SGP, file="Data/California_SGP-Math+ELA-2012.Rdata")


###  In the HS Courses, we will be creating a variable called 'SGP_PRIORS_USED' to keep track of what prior was actually used for a student.
###  For consistency, we set that variable up for the MATH and ELA analyses as well.  This variable will be a factor with 24 levels.
###  We establish all those levels (i.e. all the possible priors/prior combinations used) here:

# math <- c(c('MATHEMATICS__MATHEMATICS__ALGEBRA_I', 'ALGEBRA_I__GEOMETRY__ALGEBRA_II', 'MATHEMATICS__GENERAL_MATHEMATICS', 'MATHEMATICS__ALGEBRA_I', 'GENERAL_MATHEMATICS__ALGEBRA_I', 'ALGEBRA_I__GEOMETRY', 'GEOMETRY__ALGEBRA_II', 'GENERAL_MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I', 'ALGEBRA_II', 'GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS') #'MATHEMATICS', 
# history <- c('HISTORY__ELA', 'WORLD_HISTORY')
# science <- c('SCIENCE__INTEGRATED_SCIENCE_1', 'SCIENCE__BIOLOGY', 'INTEGRATED_SCIENCE_1__BIOLOGY', 'BIOLOGY__CHEMISTRY', 'SCIENCE', 'INTEGRATED_SCIENCE_1', 'BIOLOGY', 'CHEMISTRY')
# priors <- c('ELA ONLY', math, 'MATHEMATICS ONLY', 'GENERAL_MATHEMATICS__GENERAL_MATHEMATICS')
# priors <- c('ELA', 'ELA ONLY', history, science, math, 'MATHEMATICS__MATHEMATICS', 'GENERAL_MATHEMATICS__GENERAL_MATHEMATICS')

###  Create the 'SGP_PRIORS_USED' variable - only one value for both Math and ELA, but establish all possible levels (to be used subsequently)

#  No longer needed as of SGP version 1.0-0.0

# California_SGP@SGP[["SGPercentiles"]][["ELA.2012"]][['SGP_PRIORS_USED']] <- "ELA ONLY"
# California_SGP@SGP[["SGPercentiles"]][["ELA.2011"]][['SGP_PRIORS_USED']] <- "ELA ONLY"
# California_SGP@SGP[["SGPercentiles"]][["ELA.2010"]][['SGP_PRIORS_USED']] <- "ELA ONLY"
# California_SGP@SGP[["SGPercentiles"]][["MATHEMATICS.2012"]][['SGP_PRIORS_USED']] <- "MATHEMATICS ONLY"
# California_SGP@SGP[["SGPercentiles"]][["MATHEMATICS.2011"]][['SGP_PRIORS_USED']] <- "MATHEMATICS ONLY"
# California_SGP@SGP[["SGPercentiles"]][["MATHEMATICS.2010"]][['SGP_PRIORS_USED']] <- "MATHEMATICS ONLY" 

# California_SGP@SGP[["SGPercentiles"]][["ELA.2012"]][['PRIOR_PREF']] <- 1
# California_SGP@SGP[["SGPercentiles"]][["ELA.2011"]][['PRIOR_PREF']] <- 1
# California_SGP@SGP[["SGPercentiles"]][["ELA.2010"]][['PRIOR_PREF']] <- 1
# California_SGP@SGP[["SGPercentiles"]][["MATHEMATICS.2012"]][['PRIOR_PREF']] <- 1
# California_SGP@SGP[["SGPercentiles"]][["MATHEMATICS.2011"]][['PRIOR_PREF']] <- 1
# California_SGP@SGP[["SGPercentiles"]][["MATHEMATICS.2010"]][['PRIOR_PREF']] <- 1 

####
####  'Typical' HS Course Sequences (use a normal grade progression and fairly standardized set of priors)
####

# #  Do these first since there are two progressions.
# CA.config <- list(
				# HISTORY.2011 = list(
					# sgp.content.areas=c("ELA", "HISTORY"),
					# sgp.panel.years=2010:2011,
					# sgp.grade.sequences=list(7:8)),
				# ALGEBRA_I.2011 = list(
					# sgp.content.areas=c("MATHEMATICS", "ALGEBRA_I"),
					# sgp.panel.years=2010:2011,
					# sgp.grade.sequences=list(6:7, 7:8)),
				# GENERAL_MATHEMATICS.2011 = list(
					# sgp.content.areas=c("MATHEMATICS", "GENERAL_MATHEMATICS"),
					# sgp.panel.years=2010:2011,
					# sgp.grade.sequences=list(7:8)),
				# SCIENCE.2011 = list(
					# sgp.content.areas=c("MATHEMATICS", "SCIENCE"),
					# sgp.panel.years=2010:2011,
					# sgp.grade.sequences=list(4:5, 7:8)))

###  We now run the second set of 2011 analyses for those students with 2 priors available.  We restrict this to
###  include only those students by using the argument 'exact.grade.progression.sequence=TRUE' in analyzeSGP

	# CA.config <- list(
				# HISTORY.2011 = list(
					# sgp.content.areas=c("ELA", "ELA", "HISTORY"),
					# sgp.panel.years=c('2009', '2010', '2011'),
					# sgp.grade.sequences=list(6:8)),
				# ALGEBRA_I.2011 = list(
					# sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "ALGEBRA_I"),
					# sgp.panel.years=c('2009', '2010', '2011'),
					# sgp.grade.sequences=list(5:7, 6:8)),
				# GENERAL_MATHEMATICS.2011 = list(
					# sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "GENERAL_MATHEMATICS"),
					# sgp.panel.years=c('2009', '2010', '2011'),
					# sgp.grade.sequences=list(6:8)),
				# SCIENCE.2011 = list(
					# sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "SCIENCE"),
					# sgp.panel.years=c('2009', '2010', '2011'),
					# sgp.grade.sequences=list(3:5, 6:8)))

	# California_SGP <- analyzeSGP(California_SGP, 
                                     # state="CA",
                                     # sgp.config=CA.config,
                                     # sgp.projections=FALSE,
                                     # sgp.projections.lagged=FALSE,
                                     # sgp.percentiles.baseline= FALSE,
                                     # sgp.projections.baseline= FALSE,
                                     # sgp.projections.lagged.baseline=FALSE,
                                     # simulate.sgps=FALSE,
                                     # parallel.config=list(
                                        # BACKEND="PARALLEL",
                                        # WORKERS=list(PERCENTILES=8)))
                                        
###  Here we add in the 'SGP_PRIORS_USED' variable for these Courses
###  We also add in an additional variable called 'PRIOR_PREF', which takes the value 1 for the higher preference prior.
###  Preference is determined by 1) Content Area - 1 (or 2) prior(s) in the same content area are always preferred over use of 
###  a prior from a "DISCIPLINE_AREA" relative.  2) number of priors - more priors are preffered.
###  This variable is used only temporarily to sort out duplicates from the various analyses.  It is not retained in the final LONG data set or results

# California_SGP@SGP[["SGPercentiles"]][["HISTORY.2010"]][['PRIOR_PREF']] <- 1
# California_SGP@SGP[["SGPercentiles"]][["HISTORY.2011"]][['PRIOR_PREF']] <- 1
# California_SGP@SGP[["SGPercentiles"]][["HISTORY.2012"]][['PRIOR_PREF']] <- 1

#  No longer needed as of SGP version 1.0-0.0
# California_SGP@SGP[["SGPercentiles"]][["HISTORY.2010"]][['SGP_PRIORS_USED']] <- "ELA ONLY"
# California_SGP@SGP[["SGPercentiles"]][["HISTORY.2011"]][['SGP_PRIORS_USED']] <- "ELA ONLY"
# California_SGP@SGP[["SGPercentiles"]][["HISTORY.2012"]][['SGP_PRIORS_USED']] <- "ELA ONLY"


California_SGP@SGP[["SGPercentiles"]][["ALGEBRA_I.2010"]][['PRIOR_PREF']] <- 1
California_SGP@SGP[["SGPercentiles"]][["GENERAL_MATHEMATICS.2010"]][['PRIOR_PREF']] <- 1
California_SGP@SGP[["SGPercentiles"]][["SCIENCE.2010"]][['PRIOR_PREF']] <- 1
# California_SGP@SGP[["SGPercentiles"]][["ALGEBRA_I.2010"]][['SGP_PRIORS_USED']] <- "MATHEMATICS ONLY"
# California_SGP@SGP[["SGPercentiles"]][["GENERAL_MATHEMATICS.2010"]][['SGP_PRIORS_USED']] <- "MATHEMATICS ONLY"
# California_SGP@SGP[["SGPercentiles"]][["SCIENCE.2010"]][['SGP_PRIORS_USED']] <- "MATHEMATICS ONLY"

California_SGP@SGP[["SGPercentiles"]][["ALGEBRA_I.2011"]][['PRIOR_PREF']] <- 1
California_SGP@SGP[["SGPercentiles"]][["GENERAL_MATHEMATICS.2011"]][['PRIOR_PREF']] <- 1
California_SGP@SGP[["SGPercentiles"]][["SCIENCE.2011"]][['PRIOR_PREF']] <- 1
# California_SGP@SGP[["SGPercentiles"]][["ALGEBRA_I.2011"]][['SGP_PRIORS_USED']] <- "MATHEMATICS ONLY"
# California_SGP@SGP[["SGPercentiles"]][["GENERAL_MATHEMATICS.2011"]][['SGP_PRIORS_USED']] <- "MATHEMATICS ONLY"
# California_SGP@SGP[["SGPercentiles"]][["SCIENCE.2011"]][['SGP_PRIORS_USED']] <- "MATHEMATICS ONLY"

California_SGP@SGP[["SGPercentiles"]][["ALGEBRA_I.2012"]][['PRIOR_PREF']] <- 1
California_SGP@SGP[["SGPercentiles"]][["GENERAL_MATHEMATICS.2012"]][['PRIOR_PREF']] <- 1
California_SGP@SGP[["SGPercentiles"]][["SCIENCE.2012"]][['PRIOR_PREF']] <- 1
# California_SGP@SGP[["SGPercentiles"]][["ALGEBRA_I.2012"]][['SGP_PRIORS_USED']] <- "MATHEMATICS ONLY"
# California_SGP@SGP[["SGPercentiles"]][["GENERAL_MATHEMATICS.2012"]][['SGP_PRIORS_USED']] <- "MATHEMATICS ONLY"
# California_SGP@SGP[["SGPercentiles"]][["SCIENCE.2012"]][['SGP_PRIORS_USED']] <- "MATHEMATICS ONLY"


							
###  Now we move on to the more complex analyses that use various priors for the same Content Areas (e.g. use either ALGEBRA_I or SCIENCE as a prior for BIOLOGY).
###  At this point, the SGP functions will overwrite much of the results that we have already in the @SGP slot - 
###  Coefficient_Matrices, Goodness_of_Fit and Knots_Boundaries  all need to be dealt with carefully and explicitly here.
###  We'll start by saving what we have so far in seperate external lists.  We'll eventually 1) add results to these lists as though they were an SGP object
###  2) Delete (NULL out) these elements of the SGP object, and finally 3) merge (using .mergeSGP) these lists back in to the SGP object when
###  we have all the results completed

	##  Set up the dummy lists by copying the specific elements from the @SGP slot
	# Coefficient_Matrices <- California_SGP@SGP[["Coefficient_Matrices"]]
	SGPercentiles <- California_SGP@SGP[["SGPercentiles"]]
	Goodness_of_Fit <- California_SGP@SGP[["Goodness_of_Fit"]]
	Knots_Boundaries <- California_SGP@SGP[["Knots_Boundaries"]]

	##  NULL the parts of the @SGP slot that will be continually replaced by the repeated call to analyzeSGP:
	# California_SGP@SGP[["Coefficient_Matrices"]] <- NULL
	California_SGP@SGP[["SGPercentiles"]] <- NULL
	California_SGP@SGP[["Goodness_of_Fit"]] <- NULL
	California_SGP@SGP[["Knots_Boundaries"]] <- NULL

	##  Finish establishing the 'PRIOR_PREF' and 'SGP_PRIORS_USED' variables.  (NOTE:  We could have done this before in California_SGP@SGP[["SGPercentiles"]], 
	##	but this was how I originally did it, the code is a bit more readible/short this way and we will NULL out California_SGP@SGP[["SGPercentiles"]] anyway)
	# SGPercentiles[["HISTORY.2011"]][['PRIOR_PREF']][is.na(SGPercentiles[["HISTORY.2011"]][['PRIOR_PREF']])] <- 1
	# SGPercentiles[["HISTORY.2011"]][['SGP_PRIORS_USED']][is.na(SGPercentiles[["HISTORY.2011"]][['SGP_PRIORS_USED']])] <- "ELA ONLY"

	# SGPercentiles[["ALGEBRA_I.2011"]][['PRIOR_PREF']][is.na(SGPercentiles[["ALGEBRA_I.2011"]][['PRIOR_PREF']])] <- 1 
	# SGPercentiles[["ALGEBRA_I.2011"]][['SGP_PRIORS_USED']][is.na(SGPercentiles[["ALGEBRA_I.2011"]][['SGP_PRIORS_USED']])] <- "MATHEMATICS ONLY"
	
	# SGPercentiles[["GENERAL_MATHEMATICS.2011"]][['PRIOR_PREF']][is.na(SGPercentiles[["GENERAL_MATHEMATICS.2011"]][['PRIOR_PREF']])] <- 1
	# SGPercentiles[["GENERAL_MATHEMATICS.2011"]][['SGP_PRIORS_USED']][is.na(SGPercentiles[["GENERAL_MATHEMATICS.2011"]][['SGP_PRIORS_USED']])] <- "MATHEMATICS ONLY"

	# SGPercentiles[["SCIENCE.2011"]][['PRIOR_PREF']][is.na(SGPercentiles[["SCIENCE.2011"]][['PRIOR_PREF']])] <- 1
	# SGPercentiles[["SCIENCE.2011"]][['SGP_PRIORS_USED']][is.na(SGPercentiles[["SCIENCE.2011"]][['SGP_PRIORS_USED']])] <- "MATHEMATICS ONLY"

	##  Weed out duplicates, prefering more priors (PRIOR_TYPE = 1)
	##  We first create a data.table object that is keyed on "ID" and "PRIOR_PREF".  THis orders PRIOR_PREF with the lowest (preferred) value on top
	##  We then re-key the data.table to just use ID to identify the duplicates.  Then we replace the SGPercentiles slot with only those values that are
	##  not duplicated and are the preferred row/SGP if there is a duplicate.  Returned as a data.frame to remain consistent with the typical results.
	
	# sgp.2011 <- data.table(SGPercentiles[["HISTORY.2011"]], key=c("ID", "PRIOR_PREF"))
	# setkeyv(sgp.2011, "ID")
	# SGPercentiles[["HISTORY.2011"]] <- data.frame(sgp.2011[which(!duplicated(sgp.2011)),][,list(ID, SGP, SGP_LEVEL, SGP_PRIORS_USED)])

	# sgp.2011 <- data.table(SGPercentiles[["SCIENCE.2011"]], key=c("ID", "PRIOR_PREF"))
	# setkeyv(sgp.2011, "ID")
	# SGPercentiles[["SCIENCE.2011"]] <- data.frame(sgp.2011[which(!duplicated(sgp.2011)),][,list(ID, SGP, SGP_LEVEL, SGP_PRIORS_USED)])

	# sgp.2011 <- data.table(SGPercentiles[["ALGEBRA_I.2011"]], key=c("ID", "PRIOR_PREF"))
	# setkeyv(sgp.2011, "ID")
	# SGPercentiles[["ALGEBRA_I.2011"]] <- data.frame(sgp.2011[which(!duplicated(sgp.2011)),][,list(ID, SGP, SGP_LEVEL, SGP_PRIORS_USED)])

	# sgp.2011 <- data.table(SGPercentiles[["GENERAL_MATHEMATICS.2011"]], key=c("ID", "PRIOR_PREF"))
	# setkeyv(sgp.2011, "ID")
	# SGPercentiles[["GENERAL_MATHEMATICS.2011"]] <- data.frame(sgp.2011[which(!duplicated(sgp.2011)),][,list(ID, SGP, SGP_LEVEL, SGP_PRIORS_USED)])


####
####  'Atypical' HS Course Sequences (grades no longer used as source of progression (now just course sequence) and various priors used)
####

###  Rather than use GRADE as the source of the progression we set up the GRADE variable as the YEAR.
###  Thus, we are comparing ALL students that had a similar grade progression (e.g. ALL students that took Biology (prior) and then Chemistry (Current/analysis), 
###  rather than seperating 10th and 11th graders from 9th and 10th graders with that same course sequence)
###  We still need a 'GRADE' variable that is sequential/numeric.  We use the YEAR variable as a proxy and create TMP_GRADE to hold the original GRADE values

California_SGP@Data[['TMP_GRADE']] <- California_SGP@Data[['GRADE']] 
# California_SGP@Data[['GRADE']] <- as.numeric(California_SGP@Data[['YEAR']])-1908
#  This is not an ideal implimentation of the new code, but it will reproduce what was done already this year.
#  Next year we should use specific grades (7th and 8th) for grade level content area priors (MATH, ELA)
California_SGP@Data[['GRADE']] <- 'EOCT'  


##  The loop I use in this source code was too large to copy and paste into the R console, so I just put it in this script and source it in here:
##  See the CA_Courses_Source.R for details.

source('/home/avi/Dropbox/CENTER/SGP/California/CA_Courses_Source-Math+ELA_ONLY_2012.R')

# Switch GRADE back to original grade values
California_SGP@Data[['GRADE']] <- California_SGP@Data[['TMP_GRADE']]
California_SGP@Data[['TMP_GRADE']] <- NULL

###
###  Now we need to clean up the results by removing duplicate SGPs (selecting based on preferred values) and then merge the results back into the SGP object.
###

##  Create a single list with all the SGP analysis elements.
tmp <- list(SGPercentiles = SGPercentiles, Goodness_of_Fit= Goodness_of_Fit, Knots_Boundaries = Knots_Boundaries) #  Coefficient_Matrices = Coefficient_Matrices, 
#save(tmp, file="Data/CA_Courses_FINAL.Rdata") #  Save results just in case something goes wrong below :)
save(tmp, file="Data/CA_Courses-Math+ELA_Priors_ONLY_2012.Rdata") #  Save results just in case something goes wrong below :)

##  First lets take a look at how many SGPs were produced and the Median SGP in them
##  We'll do this again after we weed out the duplicates to make sure that 1) we have fewer results and 2) the median is still ~50

tot<-0
for(i in names(SGPercentiles)) {
	print(paste(i, "N =", dim(SGPercentiles[[i]])[1], " :  Median SGP,", median(SGPercentiles[[i]][["SGP"]])))
	tot <- tot+(dim(SGPercentiles[[i]])[1])
}
tot

##  This loops over all the subjects that we have new results for and weeds out the duplicates just as we did above for the "typical" sequences/priors.
for (subj in c('WORLD_HISTORY', 'US_HISTORY', 'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'ALGEBRA_II', 'GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS', 
	'SCIENCE', 'INTEGRATED_SCIENCE_1', 'LIFE_SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS')) {
	# sgp.2011 <- data.table(SGPercentiles[[paste(subj, '.2011', sep='')]], key=c("ID", "PRIOR_TYPE", "PRIOR_PREF"))
	# sgp.2012 <- data.table(SGPercentiles[[paste(subj, '.2012', sep='')]], key=c("ID", "PRIOR_TYPE", "PRIOR_PREF"))
	sgp.2010 <- data.table(SGPercentiles[[paste(subj, '.2010', sep='')]], key=c("ID", "PRIOR_PREF"))
	sgp.2011 <- data.table(SGPercentiles[[paste(subj, '.2011', sep='')]], key=c("ID", "PRIOR_PREF"))
	sgp.2012 <- data.table(SGPercentiles[[paste(subj, '.2012', sep='')]], key=c("ID", "PRIOR_PREF"))
	setkeyv(sgp.2010, "ID")
	setkeyv(sgp.2011, "ID")
	setkeyv(sgp.2012, "ID")

#  MAKE SURE THIS IS ALL THE Vars  -  PRIOR Score too? ...  ANything else?

	SGPercentiles[[paste(subj, '.2010', sep='')]] <- data.frame(sgp.2010[which(!duplicated(sgp.2010)),][,list(ID, SGP, SGP_LEVEL, SCALE_SCORE_PRIOR)]) # SGP_PRIORS_USED
	SGPercentiles[[paste(subj, '.2011', sep='')]] <- data.frame(sgp.2011[which(!duplicated(sgp.2011)),][,list(ID, SGP, SGP_LEVEL, SCALE_SCORE_PRIOR)])
	SGPercentiles[[paste(subj, '.2012', sep='')]] <- data.frame(sgp.2012[which(!duplicated(sgp.2012)),][,list(ID, SGP, SGP_LEVEL, SCALE_SCORE_PRIOR)])
}

	# sgp.2012 <- data.table(SGPercentiles[['EARTH_SCIENCE.2012']], key=c("ID", "PRIOR_PREF"))
	# setkeyv(sgp.2012, "ID")

	# SGPercentiles[['EARTH_SCIENCE.2012']] <- data.frame(sgp.2012[which(!duplicated(sgp.2012)),][,list(ID, SGP, SGP_LEVEL, SGP_PRIORS_USED, SCALE_SCORE_PRIOR)])


tot<-0
for(i in names(SGPercentiles)) {
	print(paste(i, "N =", dim(SGPercentiles[[i]])[1], " :  Median SGP,", median(SGPercentiles[[i]][["SGP"]])))
	tot <- tot+(dim(SGPercentiles[[i]])[1])
}
tot

#  This is a utility function used to merge SGP results into an SGP object.  We'll need to source this in here
#  We should make this a utility function that is available to the user...

	.mergeSGP <- function(list_1, list_2) {
		if (is.null(names(list_1))) return(list_2)
		if (!is.null(names(list_2))) {
			for (j in c("Coefficient_Matrices", "Cutscores", "Goodness_of_Fit", "Knots_Boundaries", "SGPercentiles", "SGProjections", "Simulated_SGPs", "Error_Reports")) {
				list_1[[j]] <- c(list_1[[j]], list_2[[j]])[!duplicated(names(c(list_1[[j]], list_2[[j]])))]
			}
			for (j in c("SGPercentiles", "SGProjections", "Simulated_SGPs")) {
				if (all(names(list_2[[j]]) %in% names(list_1[[j]]))) {
					for (k in names(list_2[[j]])) { # merging list_2 in with list_1, so use it here
						if (!identical(list_1[[j]][[k]], list_2[[j]][[k]])) { # keeps it from copying first set of results
							list_1[[j]][[k]] <- rbind.fill(list_1[[j]][[k]], list_2[[j]][[k]])
						}
					}
				}
			}
			for (j in c("Coefficient_Matrices", "Goodness_of_Fit", "Knots_Boundaries")) {
				for (k in names(list_2[[j]])) {
					if (!identical(list_1[[j]][[k]], list_2[[j]][[k]])) {
 						names.list <- c(unique(names(list_1[[j]][[k]])), unique(names(list_2[[j]][[k]]))) # Get list of (unique) names first.
						list_1[[j]][[k]] <- c(list_1[[j]][[k]], list_2[[j]][[k]][!names(list_2[[j]][[k]]) %in% names(list_1[[j]][[k]])]) #new.elements
						if (any(duplicated(names.list))) {
							dups <- names.list[which(duplicated(names.list))]
							for (l in seq(dups)) {
								if (!identical(list_1[[j]][[k]][[dups[l]]], list_2[[j]][[k]][[dups[l]]])) { # could be same matrices, different @Version (???)
									x <- length(list_1[[j]][[k]])+1
									list_1[[j]][[k]][[x]] <- list_2[[j]][[k]][[dups[l]]]
									names(list_1[[j]][[k]]) <- c(names(list_1[[j]][[k]])[-x], dups[l])
								}
							}
						}
					}
				}
			}
		}
	list_1[which(names(list_1) != "Panel_Data")]
	}


#  Re-create the tmp list here now that we've weeded out the duplicates:
tmp <- list(SGPercentiles=SGPercentiles, Knots_Boundaries=Knots_Boundaries, Goodness_of_Fit= Goodness_of_Fit)#Coefficient_Matrices=Coefficient_Matrices, 

#  Merge this tmp list in with the California_SGP object:
California_SGP@SGP <- .mergeSGP(California_SGP@SGP, tmp)

#  Verify that we have the results:
tot<-0
for(i in names(California_SGP@SGP[["SGPercentiles"]])[order(names(California_SGP@SGP[["SGPercentiles"]]))]) {
	print(paste(i, "N =", dim(California_SGP@SGP[["SGPercentiles"]][[i]])[1], " :  Median SGP,", median(California_SGP@SGP[["SGPercentiles"]][[i]][["SGP"]])))
	tot <- tot+(dim(California_SGP@SGP[["SGPercentiles"]][[i]])[1])
}
tot

save(California_SGP, file="Data/California_SGP-Math+ELA-2012.Rdata")

#  Save TCRP_Coefficient_Matrices for Aspire and PUC (others?) use down the road.
TCRP_Coefficient_Matrices <- California_SGP@SGP$Coefficient_Matrices
save(TCRP_Coefficient_Matrices, file="Data/TCRP_Coefficient_Matrices.Rdata")

#########################################################
####
####	combineSGP
####
#########################################################

# Make sure no VALID duplicates:

# setkeyv(California_SGP@Data, c("VALID_CASE","CONTENT_AREA","YEAR","ID", "SCALE_SCORE"))
# setkeyv(California_SGP@Data, c("VALID_CASE","CONTENT_AREA","YEAR","ID"))
dups <- California_SGP@Data[sort(c(which(duplicated(California_SGP@Data))-1, which(duplicated(California_SGP@Data)))),]

#California_SGP@Data[['VALID_CASE']][which(duplicated(California_SGP@Data))-1] <- "INVALID_CASE"


	California_SGP <- combineSGP(California_SGP, state="CA")

#  Check the LONG @Data file now:
tot<-0
for(i in names(California_SGP@SGP[["SGPercentiles"]])[order(names(California_SGP@SGP[["SGPercentiles"]]))]) {
	print(paste(dim(eval(parse(text=paste("California_SGP@SGP[['SGPercentiles']]$", i, sep=""))))[1], ": ", i))
	tot <- tot+(dim(eval(parse(text=paste("California_SGP@SGP[['SGPercentiles']]$", i, sep=""))))[1])
}
tot 
sum(!is.na(California_SGP@Data$SGP))

California_SGP@Data$DIFF <- NA
California_SGP@Data$DIFF[!is.na(California_SGP@Data$ORIGINAL_SGP)] <- California_SGP@Data$SGP[!is.na(California_SGP@Data$ORIGINAL_SGP)] - California_SGP@Data$ORIGINAL_SGP[!is.na(California_SGP@Data$ORIGINAL_SGP)]

table(California_SGP@Data$DIFF, California_SGP@Data$CMO_NAME)
table(is.na(California_SGP@Data$SGP), is.na(California_SGP@Data$ORIGINAL_SGP), California_SGP@Data$CMO_NAME) #  8 of PUCs old SGPs missing.
save(California_SGP, file="Data/California_SGP-Math+ELA-2012.Rdata")

#########################################################
####
####	summarizeSGP
####
#########################################################


setkeyv(California_SGP@Data, c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID"))

California_SGP@Data[["INSTRUCTOR_ID_1_PROVIDED"]] <- California_SGP@Data[["INSTRUCTOR_NUMBER_1"]] # Don't use "NUMBER" here.  Confuses bubblePlots
California_SGP@Data[["INSTRUCTOR_ID_2_PROVIDED"]] <- California_SGP@Data[["INSTRUCTOR_NUMBER_2"]]
California_SGP@Data[["INSTRUCTOR_NUMBER_1"]] <- factor(paste(California_SGP@Data[["CMO_NAME"]], California_SGP@Data[["INSTRUCTOR_NUMBER_1"]], sep="_"))
California_SGP@Data[["INSTRUCTOR_NUMBER_2"]] <- factor(paste(California_SGP@Data[["CMO_NAME"]], California_SGP@Data[["INSTRUCTOR_NUMBER_2"]], sep="_"))

subjects <- c('ELA', 'HISTORY', 'WORLD_HISTORY', 'US_HISTORY', 'MATHEMATICS', 'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'ALGEBRA_II', 'GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS', 'SCIENCE', 'INTEGRATED_SCIENCE_1', 'LIFE_SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS')

California_SGP <- summarizeSGP(California_SGP, state="CA",
		content_areas = subjects,
		years=2010:2012,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=24))

save(California_SGP, file="Data/California_SGP-Math+ELA.Rdata-2012.Rdata")


###  Output summary tables to .txt files (pipe delimited) for the CMOs  

setwd("/media/Data/SGP/California")

for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
	if (is.na(file.info("Results_2012")$isdir)) {
		dir.create("Results_2012")
	}
	dir.create(paste("Results_2012/", cmo, "/Summaries/Demographic_Groups", sep=""), recursive=TRUE, showWarnings=FALSE)
}


###  CMO by Grade, subject
s <- data.table(California_SGP@Summary[['CMO_NUMBER']][['CMO_NUMBER__CONTENT_AREA__YEAR__GRADE']])
table(California_SGP@Data$CMO_NUMBER, California_SGP@Data$CMO_NAME)
setnames(s, "CMO_NUMBER", "CMO_NAME")
s[["CMO_NAME"]] <- factor(s[["CMO_NAME"]], levels=1:5, labels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
s <- s[!is.na(MEDIAN_SGP)]

for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
	tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & CMO_NAME!="NA",], key = c("CMO_NAME", 'CONTENT_AREA', 'YEAR', 'GRADE'))
	write.table(tmp, file=paste("Results_2012/", cmo, "/Summaries/CMO__CONTENT_AREA__YEAR__GRADE.txt", sep=""), sep="|", row.names=FALSE)
}

###  School Only, subj
s <- data.table(California_SGP@Summary[['SCHOOL_NUMBER']][['SCHOOL_NUMBER__CONTENT_AREA__YEAR']])
cmo <- as.character(s[['SCHOOL_NUMBER']])
s[["CMO_NAME"]] <- ordered(sapply(cmo, function(x) strsplit(x, "_")[[1]][1], USE.NAMES=FALSE), levels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
sch <- sapply(levels(s[['SCHOOL_NUMBER']]), function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
levels(s[['SCHOOL_NUMBER']]) <- sch
# s[,grep("CONFIDENCE_BOUND", colnames(s))] <- round(s[,grep("CONFIDENCE_BOUND", colnames(s)), with=FALSE])
# setnames(s, "CONTENT_AREA", "SUBJECT")
setcolorder(s, c(dim(s)[2],1:(dim(s)[2]-1)))

for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
	tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & SCHOOL_NUMBER!="NA",], key = c('SCHOOL_NUMBER', 'CONTENT_AREA', 'YEAR'))
	setcolorder(tmp, c(dim(tmp)[2],1:(dim(tmp)[2]-1)))
	write.table(tmp, file=paste("Results_2012/", cmo, "/Summaries/SCHOOL_NUMBER__CONTENT_AREA__YEAR.txt", sep=""), sep="|", row.names=FALSE)
}


###  School + Grade, subj
s <- data.table(California_SGP@Summary[['SCHOOL_NUMBER']][['SCHOOL_NUMBER__CONTENT_AREA__YEAR__GRADE']])
cmo <- as.character(s[['SCHOOL_NUMBER']])
s[["CMO_NAME"]] <- ordered(sapply(cmo, function(x) strsplit(x, "_")[[1]][1], USE.NAMES=FALSE), levels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
sch.gr <- sapply(levels(s[['SCHOOL_NUMBER']]), function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
levels(s[['SCHOOL_NUMBER']]) <- sch.gr
# s[,grep("CONFIDENCE_BOUND", colnames(s))] <- round(s[,grep("CONFIDENCE_BOUND", colnames(s)), with=FALSE])
setcolorder(s, c(dim(s)[2],1:(dim(s)[2]-1)))
# setnames(s, "CONTENT_AREA", "SUBJECT")

for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
	tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & SCHOOL_NUMBER!="NA",], key = c('SCHOOL_NUMBER', 'CONTENT_AREA', 'GRADE', 'YEAR'))
	write.table(tmp, file=paste("Results_2012/", cmo, "/Summaries/SCHOOL_NUMBER__CONTENT_AREA__YEAR__GRADE.txt", sep=""), sep="|", row.names=FALSE)
}

###  Teacher only
#s <- data.table(California_SGP@Summary[['INSTRUCTOR_NUMBER_1']][['INSTRUCTOR_NUMBER_1__CONTENT_AREA__YEAR']])
s <- data.table(California_SGP@Summary[['DISTRICT_NUMBER']][['DISTRICT_NUMBER__INSTRUCTOR_NUMBER__CONTENT_AREA__YEAR']])
cmo <- as.character(s[['INSTRUCTOR_NUMBER']])
s[["CMO_NAME"]] <- ordered(sapply(cmo, function(x) strsplit(x, "_")[[1]][1], USE.NAMES=FALSE), levels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
s[['INSTRUCTOR_NUMBER']] <- sapply(s[['INSTRUCTOR_NUMBER']], function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
setcolorder(s, c(dim(s)[2],1:(dim(s)[2]-1)))
# setnames(s, "CONTENT_AREA", "SUBJECT")

for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
	tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & INSTRUCTOR_NUMBER!="NA",], key = c('INSTRUCTOR_NUMBER', 'CONTENT_AREA', 'YEAR'))
	write.table(tmp, file=paste("Results_2012/", cmo, "/Summaries/INSTRUCTOR_NUMBER__CONTENT_AREA__YEAR.txt", sep=""), sep="|", row.names=FALSE)
}


###  Teacher Grade Subject
s <- data.table(California_SGP@Summary[['DISTRICT_NUMBER']][['DISTRICT_NUMBER__INSTRUCTOR_NUMBER__CONTENT_AREA__YEAR__GRADE']])
cmo <- as.character(s[['INSTRUCTOR_NUMBER']])
s[["CMO_NAME"]] <- ordered(sapply(cmo, function(x) strsplit(x, "_")[[1]][1], USE.NAMES=FALSE), levels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
# inst.subj <- sapply(levels(s[['INSTRUCTOR_NUMBER']]), function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
# levels(s[['INSTRUCTOR_NUMBER']]) <- inst.subj
# s[,grep("CONFIDENCE_BOUND", colnames(s))] <- round(s[,grep("CONFIDENCE_BOUND", colnames(s)), with=FALSE])
s[['INSTRUCTOR_NUMBER']] <- sapply(s[['INSTRUCTOR_NUMBER']], function(x) strsplit(x, "_")[[1]][2], USE.NAMES=FALSE)
setcolorder(s, c(dim(s)[2],1:(dim(s)[2]-1)))
# setnames(s, "CONTENT_AREA", "SUBJECT")

for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
	tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & INSTRUCTOR_NUMBER!="NA",], key = c('INSTRUCTOR_NUMBER', 'CONTENT_AREA', 'GRADE', 'YEAR'))
	write.table(tmp, file=paste("Results_2012/", cmo, "/Summaries/INSTRUCTOR_NUMBER__CONTENT_AREA__YEAR__GRADE.txt", sep=""), sep="|", row.names=FALSE)
}


#  Student files 
s <- data.table(California_SGP@Data[,c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID", "LAST_NAME", "FIRST_NAME", "GRADE", "SCALE_SCORE", "SCALE_SCORE_PRIOR", "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_PRIOR", "SGP", "SGP_PRIORS_USED", "SGP_LEVEL", "SGP_TARGET", "SGP_TARGET_MOVE_UP_STAY_UP", "CATCH_UP_KEEP_UP_STATUS", "MOVE_UP_STAY_UP_STATUS", "GENDER", "ETHNICITY", "ELL_STATUS", "SES_STATUS", "IEP_STATUS", "HIGH_NEED_STATUS", "CMO_NAME", "DISTRICT_NUMBER", "DISTRICT_NAME", "SCHOOL_NUMBER_PROVIDED", "SCHOOL_NAME", "INSTRUCTOR_ID_1_PROVIDED", "INSTRUCTOR_ID_2_PROVIDED"), with=FALSE])
#	setnames(s, "CONTENT_GROUP", "CONTENT_AREA")
#	setnames(s, "CONTENT_AREA", "SUBJECT")
	setnames(s, "SCHOOL_NUMBER_PROVIDED", "SCHOOL_NUMBER")
	setnames(s, "INSTRUCTOR_ID_1_PROVIDED", "INSTRUCTOR_NUMBER_1")
	setnames(s, "INSTRUCTOR_ID_2_PROVIDED", "INSTRUCTOR_NUMBER_2")


for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
	tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(SGP),], key = c('ID', 'CONTENT_AREA', 'YEAR'))#[VALID_CASE=="VALID_CASE",]
	write.table(tmp, file=paste("Results_2012/", cmo, "/", cmo, "_Student_Level_SGP.txt", sep=""), sep="|", row.names=FALSE)
}


#  Demographic group summaries:

	for (demo in c("GENDER", "ETHNICITY", "ELL_STATUS", "IEP_STATUS", "SES_STATUS", "HIGH_NEED_STATUS", "CATCH_UP_KEEP_UP_STATUS")) { #, "CATCH_UP_KEEP_UP_STATUS_INITIAL"
	
		###  CMO + Grade
		s <- data.table(California_SGP@Summary[['CMO_NUMBER']][[paste("CMO_NUMBER__CONTENT_AREA__YEAR__GRADE__", demo, sep="")]])
		setnames(s, "CMO_NUMBER", "CMO_NAME")
		s[["CMO_NAME"]] <- factor(s[["CMO_NAME"]], levels=1:5, labels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
		s <- s[!is.na(MEDIAN_SGP)]
		
		for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
			tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & CMO_NAME!="NA",], key = c("CMO_NAME", 'CONTENT_AREA', 'YEAR'))
			write.table(tmp, file=paste("Results_2012/",cmo,"/Summaries/Demographic_Groups/CMO__CONTENT_AREA__YEAR__GRADE__",demo,".txt", sep=""), sep="|", row.names=FALSE)
		}
		s <- NULL
	
		###  CMO + Grade
		s <- data.table(California_SGP@Summary[['CMO_NUMBER']][[paste("CMO_NUMBER__CONTENT_AREA__YEAR__GRADE__", demo, sep="")]])
		setnames(s, "CMO_NUMBER", "CMO_NAME")
		s[["CMO_NAME"]] <- factor(s[["CMO_NAME"]], levels=1:5, labels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
		s <- s[!is.na(MEDIAN_SGP)]
	
		for (cmo in c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD")) {
			tmp <- data.table(s[s[["CMO_NAME"]]==cmo][!is.na(MEDIAN_SGP) & CMO_NAME!="NA",], key = c("CMO_NAME", 'CONTENT_AREA', 'YEAR'))
			write.table(tmp, file=paste("Results_2012/", cmo, "/Summaries/Demographic_Groups/CMO__CONTENT_AREA__YEAR__GRADE__", demo, ".txt", sep=""), sep="|", row.names=FALSE)
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
			write.table(tmp, file=paste("Results_2012/", cmo, "/Summaries/Demographic_Groups/SCHOOL_NUMBER__CONTENT_AREA__YEAR__", demo, ".txt", sep=""), sep="|", row.names=FALSE)
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
			write.table(tmp, file=paste("Results_2012/", cmo, "/Summaries/Demographic_Groups/SCHOOL_NUMBER__CONTENT_AREA__YEAR__", demo, ".txt", sep=""), sep="|", row.names=FALSE)
		}
	}

for (demo in c("SES_STATUS", "IEP_STATUS", "CATCH_UP_KEEP_UP_STATUS")) {
	s <- data.table(California_SGP@Summary[['CMO_NUMBER']][[paste("CMO_NUMBER__CONTENT_AREA__YEAR__GRADE__", demo, sep="")]])
	setnames(s, "CMO_NUMBER", "CMO_NAME")
	s[["CMO_NAME"]] <- factor(s[["CMO_NAME"]], levels=1:5, labels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
	s <- s[!is.na(MEDIAN_SGP)]
	if (demo == "CATCH_UP_KEEP_UP_STATUS") s <- s[!is.na(MEDIAN_SGP_TARGET)]
	setkeyv(s, c("CMO_NAME", "YEAR", "CONTENT_AREA", demo))
	setkeyv(s, c("CMO_NAME", "YEAR", "CONTENT_AREA", "GRADE"))

	write.table(s, file=paste("Results_2012/ALL_SYSTEM_CMO__CONTENT_AREA__YEAR__GRADE__", demo, ".txt", sep=""), sep="|", row.names=FALSE)
}


for (demo in c("SES_STATUS", "IEP_STATUS", "CATCH_UP_KEEP_UP_STATUS")) {
	s <- data.table(California_SGP@Summary[['CMO_NUMBER']][[paste("CMO_NUMBER__CONTENT_AREA__YEAR__GRADE__", demo, sep="")]])
	setnames(s, "CMO_NUMBER", "CMO_NAME")
	s[["CMO_NAME"]] <- factor(s[["CMO_NAME"]], levels=1:5, labels=c("Alliance", "Aspire", "Green Dot", "PUC", "LAUSD"))
	s <- s[!is.na(MEDIAN_SGP)]
	if (demo == "CATCH_UP_KEEP_UP_STATUS") s <- s[!is.na(MEDIAN_SGP_TARGET)]
	setkeyv(s, c("CMO_NAME", "YEAR", "CONTENT_AREA", demo))
	setkeyv(s, c("CMO_NAME", "YEAR", "CONTENT_AREA", "GRADE"))

	write.table(s, file=paste("Results_2012/ALL_SYSTEM_CMO__CONTENT_AREA__YEAR__GRADE__", demo, ".txt", sep=""), sep="|", row.names=FALSE)
}


#########################################################
####
####	visualizeSGP  
####
#########################################################


#  
subjects <- c('ELA', 'HISTORY', 'WORLD_HISTORY', 'US_HISTORY', 'MATHEMATICS', 'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'ALGEBRA_II', 'GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS', 'SCIENCE', 'INTEGRATED_SCIENCE_1', 'LIFE_SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS')

	visualizeSGP(California_SGP,
			plot.types=c("growthAchievementPlot"), 
			gaPlot.content_areas=c("ELA", "MATHEMATICS"),
			gaPlot.years='2012',
			gaPlot.format="presentation",
			parallel.config=list(
				BACKEND="PARALLEL",
				WORKERS=list(GA_PLOTS=2))

#  Do these plots with LAUSD included
	visualizeSGP(sgp_object=California_SGP,
			plot.types="bubblePlot",
			bPlot.content_areas=c("ELA", "MATHEMATICS"),
			bPlot.styles=c(1, 10, 11),
			bPlot.levels=c("SES_STATUS", "IEP_STATUS"),
			bPlot.level.cuts=list(seq(0,100,by=20),c(0,5,10,20,80,100)),
			bPlot.years='2012',
			bPlot.full.academic.year=FALSE)

	visualizeSGP(sgp_object=California_SGP,
			plot.types="bubblePlot",
			bPlot.content_areas=c("ELA", "MATHEMATICS"),
			bPlot.styles=c(53, 57, 150),  # don't do , 153 with ELA and Math
			bPlot.districts=1:4,
			bPlot.levels=c("SES_STATUS", "IEP_STATUS"),
			bPlot.level.cuts=list(seq(0,100,by=20),c(0,5,10,20,80,100)),
			bPlot.years='2012',
			bPlot.full.academic.year=FALSE)


	visualizeSGP(sgp_object=California_SGP,
			plot.types="bubblePlot",
			bPlot.content_areas=c('HISTORY', 'WORLD_HISTORY', 'US_HISTORY', 'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'ALGEBRA_II', 'GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS', 
				'SCIENCE', 'LIFE_SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS', 'INTEGRATED_SCIENCE_1'),
			bPlot.styles=c(1, 10, 11, 53, 57, 153),
			bPlot.districts=1:4,
			bPlot.levels=c("SES_STATUS", "IEP_STATUS"),
			bPlot.level.cuts=list(seq(0,100,by=20),c(0,5,10,20,80,100)),
			bPlot.years='2012',
			bPlot.prior.achievement=FALSE,
			bPlot.full.academic.year=FALSE)

	visualizeSGP(California_SGP,
			plot.types="studentGrowthPlot",
			sgPlot.content_areas=c("ELA", "MATHEMATICS"),
			sgPlot.years='2012',
			sgPlot.districts=1:4,
		#	sgPlot.demo.report= TRUE,
			parallel.config=list(
				BACKEND="FOREACH", TYPE="doParallel",
				WORKERS=list(SG_PLOTS=8)))
