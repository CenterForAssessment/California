###################################################################################################
###
### Script to convert SGP configurations for EOCT analyses to SGP_NORM_GROUP preference tables
###
###################################################################################################

### Load packages

require("data.table")
options(error=recover)

setwd("~/SGP_Projects/California")

### utility function

configToSGPNormGroup <- function(sgp.config) {
	if ("sgp.norm.group.preference" %in% names(sgp.config)) {
		if ("sgp.exact.grade.progression" %in% names(sgp.config)) {
			tmp.norm.group.baseline <- tmp.norm.group <- paste(sgp.config$sgp.panel.years, paste(sgp.config$sgp.content.areas, 
				unlist(sgp.config$sgp.grade.sequences), sep="_"), sep="/")
			tmp.data.all <- data.table(
				SGP_NORM_GROUP=paste(tmp.norm.group, collapse="; "), 
				SGP_NORM_GROUP_BASELINE=paste(tmp.norm.group.baseline, collapse="; "),
				PREFERENCE=as.integer(sgp.config$sgp.norm.group.preference)
			)
		} else {
			tmp.data.all <- data.table()
			for (g in 1:length(sgp.config$sgp.grade.sequences)) {
				l <- length(sgp.config$sgp.grade.sequences[[g]])
				tmp.norm.group.baseline <- tmp.norm.group <- paste(tail(sgp.config$sgp.panel.years, l), 
					paste(tail(sgp.config$sgp.content.areas, l), unlist(sgp.config$sgp.grade.sequences[[g]]), sep="_"), sep="/") 
		        
		        tmp.data <- data.table(
					SGP_NORM_GROUP=paste(tmp.norm.group, collapse="; "), 
					SGP_NORM_GROUP_BASELINE=paste(tmp.norm.group.baseline, collapse="; "),
					PREFERENCE= sgp.config$sgp.norm.group.preference*100)
							
		        if (length(tmp.norm.group) > 2) {
			        for (n in 1:(length(tmp.norm.group)-2)) {
						tmp.data <- rbind(tmp.data, data.table(
							SGP_NORM_GROUP=paste(tail(tmp.norm.group, -n), collapse="; "), 
							SGP_NORM_GROUP_BASELINE=paste(tmp.norm.group.baseline, collapse="; "),
							PREFERENCE= (sgp.config$sgp.norm.group.preference*100)+n))
					}
				}
				tmp.data.all <- rbind(tmp.data.all, tmp.data)
			}
		}
		return(unique(tmp.data.all))
	} else {
		return(NULL)
	}
}


### Load and create 2010, 2011, 2012 and 2013 EOCT Configuration

source("SGP_CONFIG/EOCT/2010/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2010/SCIENCE.R")
source("SGP_CONFIG/EOCT/2010/SOCIAL_STUDIES.R")

source("SGP_CONFIG/EOCT/2011/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2011/SCIENCE.R")
source("SGP_CONFIG/EOCT/2011/SOCIAL_STUDIES.R")

source("SGP_CONFIG/EOCT/2012/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2012/SCIENCE.R")
source("SGP_CONFIG/EOCT/2012/SOCIAL_STUDIES.R")

source("SGP_CONFIG/EOCT/2013/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2013/SCIENCE.R")
source("SGP_CONFIG/EOCT/2013/SOCIAL_STUDIES.R")


CA_EOCT_2010.config <- c(
		ALGEBRA_I_MS_2010.config, 
		ALGEBRA_I_2010.config, 
		ALGEBRA_II_2010.config, 
		BIOLOGY_2010.config, 
		CHEMISTRY_2010.config, 
		GENERAL_MATHEMATICS_MS_2010.config, 
		GENERAL_MATHEMATICS_2010.config, 
		GEOMETRY_2010.config, 		
		INTEGRATED_SCIENCE_1.2010.config, 
		LIFE_SCIENCE_2010.config, 
		PHYSICS_2010.config, 
		SCIENCE_2010.config, 
		SUMMATIVE_HS_MATHEMATICS_2010.config, 
		HISTORY_2010.config, 
		US_HISTORY_2010.config, 
		WORLD_HISTORY_2010.config)

CA_EOCT_2011.config <- c(
		ALGEBRA_I_MS_2011.config, 
		ALGEBRA_I_2011.config, 
		ALGEBRA_II_2011.config, 
		BIOLOGY_2011.config, 
		CHEMISTRY_2011.config, 
		GENERAL_MATHEMATICS_MS_2011.config, 
		GENERAL_MATHEMATICS_2011.config, 
		GEOMETRY_2011.config, 		
		INTEGRATED_SCIENCE_1.2011.config, 
		LIFE_SCIENCE_2011.config, 
		PHYSICS_2011.config, 
		SCIENCE_2011.config, 
		SUMMATIVE_HS_MATHEMATICS_2011.config, 
		HISTORY_2011.config, 
		US_HISTORY_2011.config, 
		WORLD_HISTORY_2011.config)

CA_EOCT_2012.config <- c(
		ALGEBRA_I_MS_2012.config, 
		ALGEBRA_I_2012.config, 
		ALGEBRA_II_2012.config, 
		BIOLOGY_2012.config, 
		CHEMISTRY_2012.config, 
		GENERAL_MATHEMATICS_MS_2012.config, 
		GENERAL_MATHEMATICS_2012.config, 
		GEOMETRY_2012.config, 		
		INTEGRATED_SCIENCE_1.2012.config, 
		LIFE_SCIENCE_2012.config, 
		PHYSICS_2012.config, 
		SCIENCE_2012.config, 
		SUMMATIVE_HS_MATHEMATICS_2012.config, 
		HISTORY_2012.config, 
		US_HISTORY_2012.config, 
		WORLD_HISTORY_2012.config)

CA_EOCT_2013.config <- c(
		ALGEBRA_I_2013.config, 
		ALGEBRA_II_2013.config, 
		GENERAL_MATHEMATICS_2013.config, 
		GEOMETRY_2013.config, 		
		HISTORY_2013.config,
		SCIENCE_2013.config,
		SUMMATIVE_HS_MATHEMATICS_2013.config,

		BIOLOGY_2013.config, 
		CHEMISTRY_2013.config, 
		INTEGRATED_SCIENCE_1.2013.config, 
		LIFE_SCIENCE_2013.config, 
		PHYSICS_2013.config,

		US_HISTORY_2013.config, 
		WORLD_HISTORY_2013.config)

### Load and create 2010-2013 "Matched Prior" EOCT Configurations

source("SGP_CONFIG/EOCT/2010_Matched/SCIENCE.R")
source("SGP_CONFIG/EOCT/2010_Matched/SOCIAL_STUDIES.R")

source("SGP_CONFIG/EOCT/2011_Matched/SCIENCE.R")
source("SGP_CONFIG/EOCT/2011_Matched/SOCIAL_STUDIES.R")

source("SGP_CONFIG/EOCT/2012_Matched/SCIENCE.R")
source("SGP_CONFIG/EOCT/2012_Matched/SOCIAL_STUDIES.R")

source("SGP_CONFIG/EOCT/2013_Matched/SCIENCE.R")
source("SGP_CONFIG/EOCT/2013_Matched/SOCIAL_STUDIES.R")

	CA_EOCT_Matched_2010.config <- c(
		BIOLOGY_2010_Match.config, 
		CHEMISTRY_2010_Match.config, 
		INTEGRATED_SCIENCE_1.2013_Match.config, 
		LIFE_SCIENCE_2010_Match.config, 
		PHYSICS_2010_Match.config,

		US_HISTORY_2010_Match.config, 
		WORLD_HISTORY_2010_Match.config)

	CA_EOCT_Matched_2011.config <- c(
		BIOLOGY_2011_Match.config, 
		CHEMISTRY_2011_Match.config, 
		INTEGRATED_SCIENCE_1.2013_Match.config, 
		LIFE_SCIENCE_2011_Match.config, 
		PHYSICS_2011_Match.config,

		US_HISTORY_2011_Match.config, 
		WORLD_HISTORY_2011_Match.config)

	CA_EOCT_Matched_2012.config <- c(
		BIOLOGY_2012_Match.config, 
		CHEMISTRY_2012_Match.config, 
		INTEGRATED_SCIENCE_1.2013_Match.config, 
		LIFE_SCIENCE_2012_Match.config, 
		PHYSICS_2012_Match.config,

		US_HISTORY_2012_Match.config, 
		WORLD_HISTORY_2012_Match.config)

	CA_EOCT_Matched_2013.config <- c(
		BIOLOGY_2013_Match.config, 
		CHEMISTRY_2013_Match.config, 
		INTEGRATED_SCIENCE_1.2013_Match.config, 
		LIFE_SCIENCE_2013_Match.config, 
		PHYSICS_2013_Match.config,

		US_HISTORY_2013_Match.config, 
		WORLD_HISTORY_2013_Match.config)

### Create configToNormGroup data.frame

tmp.configToNormGroup <- lapply(CA_EOCT_2010.config, configToSGPNormGroup)

TCRP_SGP_Norm_Group_Preference_2010 <- data.table(
			YEAR="2010",
			rbindlist(tmp.configToNormGroup))


tmp.configToNormGroup <- lapply(CA_EOCT_2011.config, configToSGPNormGroup)

TCRP_SGP_Norm_Group_Preference_2011 <- data.table(
			YEAR="2011",
			rbindlist(tmp.configToNormGroup))


tmp.configToNormGroup <- lapply(CA_EOCT_2012.config, configToSGPNormGroup)

TCRP_SGP_Norm_Group_Preference_2012 <- data.table(
			YEAR="2012",
			rbindlist(tmp.configToNormGroup))

tmp.configToNormGroup <- lapply(CA_EOCT_2013.config, configToSGPNormGroup)

TCRP_SGP_Norm_Group_Preference_2013 <- data.table(
			YEAR="2013",
			rbindlist(tmp.configToNormGroup))

###
tmp.configToNormGroup <- lapply(CA_EOCT_Matched_2010.config, configToSGPNormGroup)

TCRP_SGP_Norm_Group_Preference_Matched_2010 <- data.table(
			YEAR="2010",
			rbindlist(tmp.configToNormGroup))

tmp.configToNormGroup <- lapply(CA_EOCT_Matched_2011.config, configToSGPNormGroup)

TCRP_SGP_Norm_Group_Preference_Matched_2011 <- data.table(
			YEAR="2011",
			rbindlist(tmp.configToNormGroup))

tmp.configToNormGroup <- lapply(CA_EOCT_Matched_2012.config, configToSGPNormGroup)

TCRP_SGP_Norm_Group_Preference_Matched_2012 <- data.table(
			YEAR="2012",
			rbindlist(tmp.configToNormGroup))

tmp.configToNormGroup <- lapply(CA_EOCT_Matched_2013.config, configToSGPNormGroup)

TCRP_SGP_Norm_Group_Preference_Matched_2013 <- data.table(
			YEAR="2013",
			rbindlist(tmp.configToNormGroup))

TCRP_SGP_Norm_Group_Preference <- rbind(
			TCRP_SGP_Norm_Group_Preference_2010,
			TCRP_SGP_Norm_Group_Preference_2011,
			TCRP_SGP_Norm_Group_Preference_2012,
			TCRP_SGP_Norm_Group_Preference_2013,
			TCRP_SGP_Norm_Group_Preference_Matched_2010,
			TCRP_SGP_Norm_Group_Preference_Matched_2011,
			TCRP_SGP_Norm_Group_Preference_Matched_2012,
			TCRP_SGP_Norm_Group_Preference_Matched_2013)

TCRP_SGP_Norm_Group_Preference$SGP_NORM_GROUP <- as.factor(TCRP_SGP_Norm_Group_Preference$SGP_NORM_GROUP)
TCRP_SGP_Norm_Group_Preference$SGP_NORM_GROUP_BASELINE <- as.factor(TCRP_SGP_Norm_Group_Preference$SGP_NORM_GROUP_BASELINE)

TCRP_SGP_Norm_Group_Preference <- TCRP_SGP_Norm_Group_Preference[!duplicated(TCRP_SGP_Norm_Group_Preference)]

### Save result

setkey(TCRP_SGP_Norm_Group_Preference, YEAR, SGP_NORM_GROUP)
save(TCRP_SGP_Norm_Group_Preference, file="SGP_CONFIG/TCRP_SGP_Norm_Group_Preference.Rdata")
