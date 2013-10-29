##################################################################################
###
### Scripts associated with 2012 HISTORY, and EOCT US HISTORY and WORLD HISTORY
###
##################################################################################

### HISTORY

HISTORY_2012.config <- list(
	 HISTORY.2012 = list(
		sgp.content.areas=c('ELA', 'HISTORY'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(7:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	 HISTORY.2012 = list(
		sgp.content.areas=c('ELA', 'ELA', 'HISTORY'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(6:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	 HISTORY.2012 = list(
		sgp.content.areas=c('ELA', 'ELA', 'ELA', 'HISTORY'),
		sgp.panel.years=c('2009', '2010', '2011', '2012'),
		sgp.grade.sequences=list(5:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
)

### US HISTORY

US_HISTORY_2012.config <- list(
	US_HISTORY.2012 = list(
		sgp.content.areas=c('ELA', 'US_HISTORY'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),		
	US_HISTORY.2012 = list(
		sgp.content.areas=c('ELA', 'ELA', 'US_HISTORY'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),		
	US_HISTORY.2012 = list(
		sgp.content.areas=c('ELA', 'ELA', 'ELA', 'US_HISTORY'),
		sgp.panel.years=c('2009', '2010', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END US_HISTORY_2012.config


### WORLD_HISTORY

WORLD_HISTORY_2012.config <- list(
	WORLD_HISTORY.2012 = list(
		sgp.content.areas=c('ELA', 'WORLD_HISTORY'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	WORLD_HISTORY.2012 = list(
		sgp.content.areas=c('ELA', 'ELA', 'WORLD_HISTORY'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	WORLD_HISTORY.2012 = list(
		sgp.content.areas=c('ELA', 'ELA', 'ELA', 'WORLD_HISTORY'),
		sgp.panel.years=c('2009', '2010', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END WORLD_HISTORY_2012.config
