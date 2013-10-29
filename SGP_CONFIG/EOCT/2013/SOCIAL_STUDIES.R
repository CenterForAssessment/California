#####################################################################################
###
###		Scripts associated with 2013 HISTORY, and EOCT US HISTORY and WORLD HISTORY
###
#####################################################################################

### HISTORY

HISTORY_2013.config <- list(
	 HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'HISTORY'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(7:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	 HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'ELA', 'HISTORY'),
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(6:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	 HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'ELA', 'ELA', 'HISTORY'),
		sgp.panel.years=c('2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(5:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	 HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'ELA', 'ELA', 'ELA', 'HISTORY'),
		sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(4:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
)

### US HISTORY

US_HISTORY_2013.config <- list(
	US_HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'US_HISTORY'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c(10, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),		
	US_HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'ELA', 'US_HISTORY'),
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(c(9:10, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),		
	US_HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'ELA', 'ELA', 'US_HISTORY'),
		sgp.panel.years=c('2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(8:10, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	US_HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'ELA', 'ELA', 'ELA', 'US_HISTORY'),
		sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(7:10, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END US_HISTORY_2013.config


### WORLD_HISTORY

WORLD_HISTORY_2013.config <- list(
	WORLD_HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'WORLD_HISTORY'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	WORLD_HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'ELA', 'WORLD_HISTORY'),
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(c(7:8, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	WORLD_HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'ELA', 'ELA', 'WORLD_HISTORY'),
		sgp.panel.years=c('2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(6:8, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	WORLD_HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'ELA', 'ELA', 'ELA', 'WORLD_HISTORY'),
		sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(5:8, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	WORLD_HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'WORLD_HISTORY'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c(9, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	WORLD_HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'ELA', 'WORLD_HISTORY'),
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(c(8:9, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	WORLD_HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'ELA', 'ELA', 'WORLD_HISTORY'),
		sgp.panel.years=c('2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(7:9, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	WORLD_HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'ELA', 'ELA', 'ELA', 'WORLD_HISTORY'),
		sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(6:9, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

##  11th grade WH only has enough
	WORLD_HISTORY.2013 = list(
		sgp.content.areas=c('ELA', 'WORLD_HISTORY'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c(10, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4)# ,
	# WORLD_HISTORY.2013 = list(
		# sgp.content.areas=c('ELA', 'ELA', 'WORLD_HISTORY'),
		# sgp.panel.years=c('2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(9:10, 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=3),
	# WORLD_HISTORY.2013 = list(
		# sgp.content.areas=c('ELA', 'ELA', 'ELA', 'WORLD_HISTORY'),
		# sgp.panel.years=c('2010', '2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(8:10, 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),
	# WORLD_HISTORY.2013 = list(
		# sgp.content.areas=c('ELA', 'ELA', 'ELA', 'ELA', 'WORLD_HISTORY'),
		# sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(7:10, 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1)
) ### END WORLD_HISTORY_2013.config
