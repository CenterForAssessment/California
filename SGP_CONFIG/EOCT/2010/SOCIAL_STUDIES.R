##################################################################################
###
### Scripts associated with 2010 HISTORY, and EOCT US HISTORY and WORLD HISTORY
###
##################################################################################

### HISTORY

HISTORY_2010.config <- list(
	 HISTORY.2010 = list(
		sgp.content.areas=c("ELA", "HISTORY"),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(7:8),
		sgp.norm.group.preference=1)
)


### US HISTORY

US_HISTORY_2010.config <- list(
	US_HISTORY.2010 = list(
		sgp.content.areas=c("ELA", "US_HISTORY"),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)		
) ### END US_HISTORY_2010.config


### WORLD_HISTORY

WORLD_HISTORY_2010.config <- list(
	WORLD_HISTORY.2010 = list(
		sgp.content.areas=c("ELA", "WORLD_HISTORY"),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END WORLD_HISTORY_2010.config
