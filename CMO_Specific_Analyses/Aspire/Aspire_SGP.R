###################################################################
####
####	Code for running TCRP (Aspire) 2012 Baseline SGP Analyses
####
###################################################################

library(SGP)
library(data.table)
library(plyr)

setwd("~/CENTER/SGP/California")
load("Data/Aspire_SGP-LONG_ONLY.Rdata")
load("Data/TCRP_Coefficient_Matrices.Rdata")

############################################################
####
####		analyzeSGP
####
############################################################

	###  Add in the TCRP Coefficient Matrices for 2010 - 2012 to the Aspire SGP object.  Need these with sgp.use.my.coefficient.matrices=TRUE
	Aspire_SGP@SGP$Coefficient_Matrices <- TCRP_Coefficient_Matrices
	
	Aspire_SGP <- analyzeSGP(Aspire_SGP,
                             state="CA",
                             content_areas=c("ELA", "MATHEMATICS"),
                             years=c('2010', '2011', '2012'),
                             sgp.percentiles.baseline= FALSE,
                             sgp.projections.baseline= FALSE,
                             sgp.projections.lagged.baseline=FALSE,
                             simulate.sgps=FALSE,
                             sgp.use.my.coefficient.matrices=TRUE,
                             parallel.config=list(
                                 BACKEND="PARALLEL",
                                 WORKERS=list(PERCENTILES=7, PROJECTIONS=7, LAGGED_PROJECTIONS=7)))


###
###		Grade level EOCT Science, andHistory courses progressions 
###  	We use a custom sgp.config list in analyzeSGP for course sequences that include multiple content areas.
###

    CA.config <- list(
          HISTORY.2010 = list(
             sgp.content.areas=c("ELA", "HISTORY"),
             sgp.panel.years=c('2009', '2010'),
             sgp.grade.sequences=list(7:8)),

         ALGEBRA_I.2010 = list(
             sgp.content.areas=c("MATHEMATICS", "ALGEBRA_I"),
             sgp.panel.years=c('2009', '2010'),
             sgp.grade.sequences=list(6:7, 7:8)),
	#  No GENERAL_MATHEMATICS data for Aspire in 2010.
         # GENERAL_MATHEMATICS.2010 = list(
             # sgp.content.areas=c("MATHEMATICS", "GENERAL_MATHEMATICS"),
             # sgp.panel.years=c('2009', '2010'),
             # sgp.grade.sequences=list(7:8)),

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
	#  No GENERAL_MATHEMATICS data for Aspire in 2011.
         # GENERAL_MATHEMATICS.2011 = list(
             # sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "GENERAL_MATHEMATICS"),
             # sgp.panel.years=c('2009', '2010', '2011'),
             # sgp.grade.sequences=list(6:8)),

         SCIENCE.2011 = list(
             sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "SCIENCE"),
             sgp.panel.years=c('2009', '2010', '2011'),
             sgp.grade.sequences=list(3:5, 6:8)),
             
             
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


	Aspire_SGP <- analyzeSGP(Aspire_SGP, state="CA",
                                 sgp.config=CA.config,
                                 # sgp.percentiles= FALSE,
                                 sgp.projections= FALSE,
                                 sgp.projections.lagged=FALSE,
                                 sgp.percentiles.baseline= FALSE,
                                 sgp.projections.baseline= FALSE,
                                 sgp.projections.lagged.baseline=FALSE,
                                 simulate.sgps=FALSE,
                                 sgp.use.my.coefficient.matrices=TRUE)
                                 # parallel.config=list(
                                     # BACKEND="PARALLEL",
                                     # WORKERS=list(PERCENTILES=7)))


###  Here we add in an additional variable called 'PRIOR_PREF', which takes the value 1 for the higher preference prior.
###  Preference is determined by 1) Content Area - 1 (or 2) prior(s) in the same content area are always preferred over use of 
###  a prior from a "DISCIPLINE_AREA" relative.  2) number of priors - more priors are preffered.
###  This variable is used only temporarily to sort out duplicates from the various analyses.  It is not retained in the final LONG data set or results

names(Aspire_SGP@SGP$SGPercentiles)
dim(Aspire_SGP@SGP$SGPercentiles$ALGEBRA_I.2012)

Aspire_SGP@SGP[["SGPercentiles"]][["ALGEBRA_I.2010"]][['PRIOR_PREF']] <- 1
# Aspire_SGP@SGP[["SGPercentiles"]][["GENERAL_MATHEMATICS.2010"]][['PRIOR_PREF']] <- 1
Aspire_SGP@SGP[["SGPercentiles"]][["SCIENCE.2010"]][['PRIOR_PREF']] <- 1

Aspire_SGP@SGP[["SGPercentiles"]][["ALGEBRA_I.2011"]][['PRIOR_PREF']] <- 1
# Aspire_SGP@SGP[["SGPercentiles"]][["GENERAL_MATHEMATICS.2011"]][['PRIOR_PREF']] <- 1
Aspire_SGP@SGP[["SGPercentiles"]][["SCIENCE.2011"]][['PRIOR_PREF']] <- 1

Aspire_SGP@SGP[["SGPercentiles"]][["ALGEBRA_I.2012"]][['PRIOR_PREF']] <- 1
Aspire_SGP@SGP[["SGPercentiles"]][["GENERAL_MATHEMATICS.2012"]][['PRIOR_PREF']] <- 1
Aspire_SGP@SGP[["SGPercentiles"]][["SCIENCE.2012"]][['PRIOR_PREF']] <- 1


###
###  'Atypical' HS Course Sequences - more complex analyses with multiple potential priors.
###  At this point, the SGP functions will overwrite much of the results that we have already in the @SGP slot - 
###  Coefficient_Matrices, Goodness_of_Fit and Knots_Boundaries  all need to be dealt with carefully and explicitly here.
###  We'll start by saving what we have so far in seperate external lists.  We'll eventually 1) add results to these lists as though they were an SGP object
###  2) Delete (NULL out) these elements of the SGP object, and finally 3) merge (using .mergeSGP) these lists back in to the SGP object when
###  we have all the results completed
###

	##  Set up the temporary list, copying the specific elements from the @SGP slot

	Elem.MS.results <- list(
		SGPercentiles = Aspire_SGP@SGP[["SGPercentiles"]],
		Goodness_of_Fit = Aspire_SGP@SGP[["Goodness_of_Fit"]],
		Knots_Boundaries = Aspire_SGP@SGP[["Knots_Boundaries"]]
	)

	##  NULL the parts of the @SGP slot that will be continually replaced by the repeated call to analyzeSGP:
	Aspire_SGP@SGP[["SGPercentiles"]] <- NULL
	Aspire_SGP@SGP[["Goodness_of_Fit"]] <- NULL
	Aspire_SGP@SGP[["Knots_Boundaries"]] <- NULL

###	 grades no longer used as source of progression (now just course sequence) and various priors used)
###  Rather than use GRADE as the source of the progression we set the GRADE variable equal to 'EOCT'.
###  Thus, we are comparing ALL students that had a similar grade progression (e.g. ALL students that took Biology (prior) and then Chemistry (Current/analysis), 
###  rather than seperating 10th and 11th graders from 9th and 10th graders with that same course sequence). 
###  We create TMP_GRADE to hold the original GRADE values while we temporarily transform all grades to 'EOCT'.
###  This is not an ideal implimentation of the new code, but it will reproduce what was done already this year.
###  Next year we should use specific grades (7th and 8th) for grade level content area priors (MATH, ELA)

	Aspire_SGP@Data[['TMP_GRADE']] <- Aspire_SGP@Data[['GRADE']] 
	Aspire_SGP@Data[['GRADE']] <- 'EOCT'  

##  The loop I use in this source code was too large to copy and paste into the R console, so I just put it in this script and source it in here:
##  See the file Aspire_Course_Progressions_Math+ELA_*.R for details.

#  First set up a group of empty lists to collect the new results.
	Coefficient_Matrices <- SGPercentiles <- Goodness_of_Fit <- Knots_Boundaries <- list()

	setwd("~/CENTER/SGP/California")
    source('/Volumes/Data/Dropbox/CENTER/SGP/California/Aspire_2012/Aspire_Course_Progressions_Math+ELA.R')

# Switch GRADE back to original grade values
	Aspire_SGP@Data[['GRADE']] <- Aspire_SGP@Data[['TMP_GRADE']]
	Aspire_SGP@Data[['TMP_GRADE']] <- NULL

###
###  Now we need to clean up the results by removing duplicate SGPs (selecting based on preferred values) and then merge the results back into the SGP object.
###

##  First lets take a look at how many SGPs were produced and the Median SGP in them
##  We'll do this again after we weed out the duplicates to make sure that 1) we have fewer results and 2) the median is still ~50

tot<-0
for(i in names(SGPercentiles)) {
	print(paste(i, "N =", dim(SGPercentiles[[i]])[1], " :  Median SGP,", median(SGPercentiles[[i]][["SGP"]])))
	tot <- tot+(dim(SGPercentiles[[i]])[1])
}
tot

##  This loops over all the subjects that we have new results for and weeds out the duplicates.
for (subj in c('WORLD_HISTORY', 'US_HISTORY', 'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'ALGEBRA_II', 'GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS', 
	'SCIENCE', 'INTEGRATED_SCIENCE_1', 'LIFE_SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS')) {
	if (!is.null(SGPercentiles[[paste(subj, '.2010', sep='')]])) {
		sgp.2010 <- data.table(SGPercentiles[[paste(subj, '.2010', sep='')]], key=c("ID", "PRIOR_PREF"))
		setkeyv(sgp.2010, "ID")
		SGPercentiles[[paste(subj, '.2010', sep='')]] <- data.frame(sgp.2010[which(!duplicated(sgp.2010)),][,list(ID, SGP, SGP_LEVEL, SCALE_SCORE_PRIOR)])
	}		
	if (!is.null(SGPercentiles[[paste(subj, '.2011', sep='')]])) {
		sgp.2011 <- data.table(SGPercentiles[[paste(subj, '.2011', sep='')]], key=c("ID", "PRIOR_PREF"))
		setkeyv(sgp.2011, "ID")
		SGPercentiles[[paste(subj, '.2011', sep='')]] <- data.frame(sgp.2011[which(!duplicated(sgp.2011)),][,list(ID, SGP, SGP_LEVEL, SCALE_SCORE_PRIOR)])
	}
	if (!is.null(SGPercentiles[[paste(subj, '.2012', sep='')]])) {
		sgp.2012 <- data.table(SGPercentiles[[paste(subj, '.2012', sep='')]], key=c("ID", "PRIOR_PREF"))
		setkeyv(sgp.2012, "ID")
		SGPercentiles[[paste(subj, '.2012', sep='')]] <- data.frame(sgp.2012[which(!duplicated(sgp.2012)),][,list(ID, SGP, SGP_LEVEL, SCALE_SCORE_PRIOR)])
	}
}


##  Take another look at how many SGPs we still have after the duplicates have been weeded out.
tot<-0
for(i in names(SGPercentiles)) {
	print(paste(i, "N =", dim(SGPercentiles[[i]])[1], " :  Median SGP,", median(SGPercentiles[[i]][["SGP"]])))
	tot <- tot+(dim(SGPercentiles[[i]])[1])
}
tot # NOTE: this is just the HS EOCT courses

#  This is a utility function used to merge SGP results into an SGP object.  We'll need to source this in here

	.mergeSGP <- function(list_1, list_2) {
		if (is.null(names(list_1))) return(list_2)
		if (!is.null(names(list_2))) {
			for (j in c("Coefficient_Matrices", "Cutscores", "Goodness_of_Fit", "Knots_Boundaries", "SGPercentiles", "SGProjections", "Simulated_SGPs")) {
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
				for (k in names(list_1[[j]])) {
					list_1[[j]][[k]] <- c(list_1[[j]][[k]], list_2[[j]][[k]])[!duplicated(names(c(list_1[[j]][[k]], list_2[[j]][[k]])))]
				}
			}
		}
	list_1
	}

##  Create a single list with all the SGP analysis elements.
HS.results <- list(Coefficient_Matrices=Coefficient_Matrices, SGPercentiles=SGPercentiles, Goodness_of_Fit=Goodness_of_Fit, Knots_Boundaries=Knots_Boundaries) 
Aspire.results <- .mergeSGP(HS.results, Elem.MS.results) # we'll put the HS results first

#  Merge this tmp list in with the Aspire_SGP object:
Aspire_SGP@SGP <- .mergeSGP(Aspire_SGP@SGP, Aspire.results)

#  Verify that we have the same results:
tot<-0
for(i in names(Aspire_SGP@SGP[["SGPercentiles"]])[order(names(Aspire_SGP@SGP[["SGPercentiles"]]))]) {
	print(paste(i, "N =", dim(Aspire_SGP@SGP[["SGPercentiles"]][[i]])[1], " :  Median SGP,", median(Aspire_SGP@SGP[["SGPercentiles"]][[i]][["SGP"]])))
	tot <- tot+(dim(Aspire_SGP@SGP[["SGPercentiles"]][[i]])[1])
}
tot


#########################################################
####
####	combineSGP
####
#########################################################

	Aspire_SGP <- combineSGP(Aspire_SGP, state="CA")

#  Check the LONG @Data file now:
tot<-0
for(i in names(Aspire_SGP@SGP[["SGPercentiles"]])[order(names(Aspire_SGP@SGP[["SGPercentiles"]]))]) {
	print(paste(dim(eval(parse(text=paste("Aspire_SGP@SGP[['SGPercentiles']]$", i, sep=""))))[1], ": ", i))
	tot <- tot+(dim(eval(parse(text=paste("Aspire_SGP@SGP[['SGPercentiles']]$", i, sep=""))))[1])
}
tot
sum(!is.na(Aspire_SGP@Data$SGP)) # Should match up with 'tot' - 42,959

table(!is.na(Aspire_SGP@Data$SGP), Aspire_SGP@Data$CONTENT_AREA, Aspire_SGP@Data$YEAR)


#########################################################
####
####	summarizeSGP
####
#########################################################

subjects <- c('ELA', 'HISTORY', 'US_HISTORY', 'WORLD_HISTORY', 'MATHEMATICS', 'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'ALGEBRA_II', 'GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS', 'SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS', 'INTEGRATED_SCIENCE_1', 'LIFE_SCIENCE') #   

Aspire_SGP <- summarizeSGP(Aspire_SGP, state="CA",
		content_areas = subjects,
		years='2012', # might want more than just 2012 here?
		parallel.config=list(BACKEND="PARALLEL", WORKERS=8))

save(Aspire_SGP, file="Data/Aspire_SGP.Rdata", compress="bzip2")

#########################################################
####
####	outputSGP
####
#########################################################

##  Write the @Data out to pipe ("|") delimited .txt file:
##  NOTE:  this produces a file named California_SGP_LONG_Data.txt, which I've renamed Aspire_SGP_LONG_Data.txt

outputSGP(Aspire_SGP, state="CA", output.type="LONG_Data", outputSGP.directory="Aspire_Results_2012")

###  Output summary tables

dir.create(paste("Aspire_Results_2012/Summaries", sep=""), recursive=TRUE, showWarnings=FALSE)

###  Teacher only
s <- data.table(Aspire_SGP@Summary[['DISTRICT_NUMBER']][['DISTRICT_NUMBER__INSTRUCTOR_NUMBER__CONTENT_AREA__YEAR']])
tmp <- data.table(s[!is.na(MEDIAN_SGP) & INSTRUCTOR_NUMBER!="NA",], key = c('INSTRUCTOR_NUMBER', 'CONTENT_AREA', 'YEAR'))
write.table(tmp, file=paste("Aspire_Results_2012/Summaries/INSTRUCTOR_NUMBER__CONTENT_AREA__YEAR.txt", sep=""), sep="|", row.names=FALSE)

###  Teacher Grade Subject
s <- data.table(Aspire_SGP@Summary[['DISTRICT_NUMBER']][['DISTRICT_NUMBER__INSTRUCTOR_NUMBER__CONTENT_AREA__YEAR__GRADE']])
tmp <- data.table(s[!is.na(MEDIAN_SGP) & INSTRUCTOR_NUMBER!="NA",], key = c('INSTRUCTOR_NUMBER', 'CONTENT_AREA', 'GRADE', 'YEAR'))
write.table(tmp, file=paste("Aspire_Results_2012/Summaries/INSTRUCTOR_NUMBER__CONTENT_AREA__YEAR__GRADE.txt", sep=""), sep="|", row.names=FALSE)

#########################################################
####
####	visualizeSGP  
####
#########################################################

	setnames(Aspire_SGP@Data, 'DISTRICT_NAME', 'CA_DISTRICT_NAME')
	setnames(Aspire_SGP@Data, 'CMO_NAME', 'DISTRICT_NAME')
	
	visualizeSGP(sgp_object=Aspire_SGP, state="CA", 
			plot.types="bubblePlot",
			bPlot.styles=c(10),
			bPlot.years=c('2010', '2011', '2012'),
			bPlot.content_areas=c("ELA", "MATHEMATICS"),
			bPlot.full.academic.year=FALSE) #  Need the bPlot.full.academic.year=TRUE because there is no *_ENROLLMENT_STATUS variables
			
	visualizeSGP(Aspire_SGP, state="CA", 
			plot.types="bubblePlot",
			bPlot.styles=c(10),
			bPlot.years=c('2010', '2011', '2012'),
			bPlot.content_areas=c('HISTORY', 'WORLD_HISTORY', 'US_HISTORY', "SCIENCE", 'BIOLOGY', 'CHEMISTRY', 'PHYSICS',
				'ALGEBRA_I', 'ALGEBRA_II', 'GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS'),
			bPlot.prior.achievement=FALSE,
			bPlot.full.academic.year=FALSE)

