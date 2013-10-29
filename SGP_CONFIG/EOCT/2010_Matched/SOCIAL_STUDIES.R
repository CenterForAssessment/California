#####################################################################################
###
###		Scripts associated with 2010 HISTORY, and EOCT US HISTORY and WORLD HISTORY
###
#####################################################################################

### HISTORY - same as other config

HISTORY_2010_Match.config <- list(
	 HISTORY.2010 = list(
		sgp.content.areas=c("ELA", "HISTORY"),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(7:8),
		sgp.norm.group.preference=1)
)


### US HISTORY

US_HISTORY_2010_Match.config <- list(
	US_HISTORY.2010 = list(
		sgp.content.areas=c('WORLD_HISTORY', 'US_HISTORY'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END US_HISTORY_2010_Match.config


### WORLD_HISTORY

WORLD_HISTORY_2010_Match.config <- list(
	# WORLD_HISTORY.2010 = list(  #  Didn't do this in 2010
		# sgp.content.areas=c('HISTORY', 'WORLD_HISTORY'),
		# sgp.panel.years=c('2009', '2010'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),

	###  Not a matched prior, but what would have been included in 2010.
	###  Need to remove duplicate from the TCRP_SGP_Norm_Group_Preference
	WORLD_HISTORY.2010 = list(
		sgp.content.areas=c('ELA', 'WORLD_HISTORY'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	WORLD_HISTORY.2010 = list( # Repeaters
		sgp.content.areas=c('WORLD_HISTORY', 'WORLD_HISTORY'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END WORLD_HISTORY_2010_Match.config
