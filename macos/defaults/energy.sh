#! /bin/sh

###############################################################################
# Energy saving                                                               #
###############################################################################

# Disable the Sudden Motion Sensor as it’s not useful for SSDs
sudo pmset -a sms 0

# Disable hibernation (speeds up entering sleep mode)
sudo pmset -a hibernatemode 0

# Set hibernatefile to `/dev/null` so it will not be recreated
sudo pmset -a hibernatefile /dev/null

# Battery Settings
sudo pmset -b  			\
	sleep 			15 	\
	disksleep 		10	\
	displaysleep 	2	\
	halfdim 		1

# Charging Settings
sudo pmset -c  			\
	sleep 			0 	\
	disksleep 		0	\
	displaysleep 	5	\
	halfdim 		10	\
	womp			1	
