#  The content areas that will get SGPs produced:
historys <- c('US_HISTORY', 'WORLD_HISTORY')
sciences <- c('INTEGRATED_SCIENCE_1', 'BIOLOGY', 'LIFE_SCIENCE', 'CHEMISTRY', 'PHYSICS') #'EARTH_SCIENCE', 

#  The various prior combinations that will be used:
sci.priors <- c('SCIENCE__INTEGRATED_SCIENCE_1__BIOLOGY', 'SCIENCE__BIOLOGY__CHEMISTRY',
	'INTEGRATED_SCIENCE_1__BIOLOGY', 'BIOLOGY__CHEMISTRY', 'SCIENCE__INTEGRATED_SCIENCE_1', 'BIOLOGY__LIFE_SCIENCE', 'SCIENCE__BIOLOGY',
	'SCIENCE', 'INTEGRATED_SCIENCE_1', 'BIOLOGY', 'CHEMISTRY')
hist.priors <- c('WORLD_HISTORY__NA__HISTORY', 'HISTORY', 'WORLD_HISTORY')

setwd("Goodness_of_Fit")

for (prior in c(sci.priors, hist.priors)) {
	
	### Make new working directory to save GoFit plots
	tmp.dir <- paste(prior, "_AS_PRIOR", sep="")
	if (is.na(file.info(tmp.dir)$isdir)){
		dir.create(tmp.dir)
	}
	setwd(tmp.dir)

###  3 priors

	if (prior == 'SCIENCE__INTEGRATED_SCIENCE_1__BIOLOGY')	{
		CA.config <- list(
				CHEMISTRY.2012 = list(
					sgp.content.areas=c("SCIENCE", "INTEGRATED_SCIENCE_1", "BIOLOGY", "CHEMISTRY"),
					sgp.exact.grade.progression=TRUE,
					sgp.panel.years=c('2009', '2010', '2011', '2012'),
					sgp.grade.sequences=list(101:104)))
	}

	if (prior == 'SCIENCE__BIOLOGY__CHEMISTRY')	{
		CA.config <- list(
				PHYSICS.2012 = list(
					sgp.content.areas=c("SCIENCE", "BIOLOGY", "CHEMISTRY", "PHYSICS"),
					sgp.exact.grade.progression=TRUE,
					sgp.panel.years=c('2009', '2010', '2011', '2012'),
					sgp.grade.sequences=list(101:104)))
	}

###  2 priors

	if (prior == 'INTEGRATED_SCIENCE_1__BIOLOGY')	{
		CA.config <- list(
			CHEMISTRY.2012 = list(
				sgp.content.areas=c("INTEGRATED_SCIENCE_1", "BIOLOGY", "CHEMISTRY"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(102:104)))
	}

	if (prior == 'BIOLOGY__CHEMISTRY')	{
		CA.config <- list(
				PHYSICS.2012 = list(
					sgp.content.areas=c("BIOLOGY", "CHEMISTRY", "PHYSICS"),
					sgp.exact.grade.progression=TRUE,
					sgp.panel.years=c('2010', '2011', '2012'),
					sgp.grade.sequences=list(102:104)))
	}

	if (prior == 'SCIENCE__INTEGRATED_SCIENCE_1')	{
		CA.config <- list(
			BIOLOGY.2012 = list(
				sgp.content.areas=c("SCIENCE", "INTEGRATED_SCIENCE_1", "BIOLOGY"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(102:104)))
	}
					
	if (prior == 'BIOLOGY__LIFE_SCIENCE')	{
		CA.config <- list(
			CHEMISTRY.2012 = list(
				sgp.content.areas=c("BIOLOGY", "LIFE_SCIENCE", "CHEMISTRY"), 
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(102:104)))
	}
 
	if (prior == 'SCIENCE__BIOLOGY')	{
		CA.config <- list(
			CHEMISTRY.2012 = list(
				sgp.content.areas=c("SCIENCE", "BIOLOGY", "CHEMISTRY"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(102:104)))
	}
	
###  1 prior

	if (prior == 'SCIENCE')	{
		CA.config <- list(
			BIOLOGY.2012 = list(
				sgp.content.areas=c("SCIENCE", "BIOLOGY"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(103:104)),
			INTEGRATED_SCIENCE_1.2012 = list(
				sgp.content.areas=c("SCIENCE", "INTEGRATED_SCIENCE_1"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(103:104)))
	}

	if (prior == 'INTEGRATED_SCIENCE_1')	{
		CA.config <- list(
			BIOLOGY.2012 = list(
				sgp.content.areas=c("INTEGRATED_SCIENCE_1", "BIOLOGY"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(103:104)))
	}


	if (prior == 'BIOLOGY')	{
		CA.config <- list(
			BIOLOGY.2012 = list(
				sgp.content.areas=c("BIOLOGY", "BIOLOGY"), # course repeaters
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(103:104)),
			LIFE_SCIENCE.2012 = list(
				sgp.content.areas=c("BIOLOGY", "LIFE_SCIENCE"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(103:104)),
			CHEMISTRY.2012 = list(
				sgp.content.areas=c("BIOLOGY", "CHEMISTRY"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(103:104)),
			PHYSICS.2012 = list(
				sgp.content.areas=c("BIOLOGY", "PHYSICS"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(103:104)))
	}
					

	if (prior == 'CHEMISTRY')	{
		CA.config <- list(
			BIOLOGY.2012 = list(
				sgp.content.areas=c("CHEMISTRY", "BIOLOGY"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(103:104)),
			CHEMISTRY.2012 = list(
				sgp.content.areas=c("CHEMISTRY", "CHEMISTRY"),  # course repeaters
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(103:104)),
			PHYSICS.2012 = list(
				sgp.content.areas=c("CHEMISTRY", "PHYSICS"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(103:104)))
	}
					
					
###
###  History
###

	if (prior == 'WORLD_HISTORY__NA__HISTORY')	{
		CA.config <- list(
			US_HISTORY.2012 = list(
				sgp.content.areas=c("HISTORY", "WORLD_HISTORY", "US_HISTORY"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2009', '2010', '2011', '2012'), #   Gap year
				sgp.grade.sequences=list(c(101, 103:104))))
	}


	if (prior == 'WORLD_HISTORY')	{
		CA.config <- list(
			WORLD_HISTORY.2012 = list(
				sgp.content.areas=c("WORLD_HISTORY", "WORLD_HISTORY"), # Course repeaters
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(103:104)),
			US_HISTORY.2012 = list(
				sgp.content.areas=c("WORLD_HISTORY", "US_HISTORY"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(103:104)))
	}	

	if (prior == 'HISTORY')	{
		CA.config <- list(
			WORLD_HISTORY.2012 = list(
				sgp.content.areas=c("HISTORY", "WORLD_HISTORY"),
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c(102,104))),
			US_HISTORY.2012 = list(
				sgp.content.areas=c("HISTORY", "US_HISTORY"),  #  2 year skip
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2009', '2010', '2011', '2012'),
				sgp.grade.sequences=list(c(101,104))))
	}


######################################################################################################
######################################################################################################

	message(paste("\n\n", prior, "used as PRIOR\n"))

	#  Establish prior preference based on number of priors.
	if (length(strsplit(prior, "__")[[1]])==3) {
		prior.pref <- 1
	} 
	if (length(strsplit(prior, "__")[[1]])==2) {
		prior.pref <- 2
	} 
	if (length(strsplit(prior, "__")[[1]])==1) {
		prior.pref <- 3
	}
	
	#  Take world hist repeaters if they exist (not skip year history), and US hist with World hist vs 2 year skip after History.
	if (prior.pref==3 & prior=='WORLD_HISTORY') prior.pref <- 2
	
        California_SGP <-analyzeSGP(California_SGP, 
                                    state="CA",
                                    sgp.config=CA.config,
                                    sgp.projections=FALSE,
                                    sgp.projections.lagged=FALSE,
                                    sgp.percentiles.baseline= FALSE,
                                    sgp.projections.baseline= FALSE,
                                    sgp.projections.lagged.baseline=FALSE,
                                    simulate.sgps=FALSE,
                                    parallel.config=list(
                                       BACKEND="PARALLEL",
                                       WORKERS=list(PERCENTILES=length(CA.config))))
	
	setwd("../")

	Goodness_of_Fit[["BY_PRIOR"]][[prior]] <- California_SGP@SGP[["Goodness_of_Fit"]]
	Knots_Boundaries[["BY_PRIOR"]][[prior]] <- California_SGP@SGP[["Knots_Boundaries"]]

	California_SGP@SGP[["Goodness_of_Fit"]] <- NULL
	California_SGP@SGP[["Knots_Boundaries"]] <- NULL

	if (prior %in% sci.priors) {
		# for (i in maths) {
			# for (y in c('2010', '2011', '2012')) {
				# tmp.subj<-paste(i, y, sep=".") 
				# if (tmp.subj %in% names(California_SGP@SGP[["SGPercentiles"]])) {
					# # California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['PRIOR_TYPE']] <- 1
					# California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['PRIOR_PREF']] <- prior.pref
					# California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['SGP_PRIORS_USED']] <- prior
					# SGPercentiles[[tmp.subj]] <- rbind.fill(SGPercentiles[[tmp.subj]], California_SGP@SGP[["SGPercentiles"]][[tmp.subj]])
				# }
			# }
		# }
		for (i in c(sciences)) {
			for (y in c('2012')) { # only 2012  --  '2010', '2011', 
				tmp.subj<-paste(i, y, sep=".") 
				if (tmp.subj %in% names(California_SGP@SGP[["SGPercentiles"]])) {
					# California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['PRIOR_TYPE']] <- 2
					California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['PRIOR_PREF']] <- prior.pref
					California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['SGP_PRIORS_USED']] <- prior
					SGPercentiles[[tmp.subj]] <- rbind.fill(SGPercentiles[[tmp.subj]], California_SGP@SGP[["SGPercentiles"]][[tmp.subj]])
				}
			}
		}
	}

	if (prior %in% hist.priors) {
		for (i in historys) {
			for (y in c('2012')) { #'2010', '2011', 
				tmp.subj<-paste(i, y, sep=".") 
				if (tmp.subj %in% names(California_SGP@SGP[["SGPercentiles"]])) {
					# California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['PRIOR_TYPE']] <- 2
					California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['PRIOR_PREF']] <- prior.pref
					California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['SGP_PRIORS_USED']] <- prior
					SGPercentiles[[tmp.subj]] <- rbind.fill(SGPercentiles[[tmp.subj]], California_SGP@SGP[["SGPercentiles"]][[tmp.subj]])
				}
			}
		}
	}

	California_SGP@SGP[["SGPercentiles"]] <- NULL

} # END for (prior in xxx)

	setwd("../")
