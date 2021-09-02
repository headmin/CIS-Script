#!/bin/zsh

projectfolder=$(dirname "${0:A}")

source ${projectfolder}/Header.sh

CISLevel="1"
audit="2.4.5 Disable Remote Login (Automated)"
orgScore="OrgScore2_4_5"
emptyVariables
method="Script"
remediate="Script > sudo /usr/sbin/systemsetup -setremotelogin off"
# Verify organizational score
runAudit
# If organizational score is 1 or true, check status of client
if [[ "${auditResult}" == "1" ]]; then
	screenSharing=$(systemsetup -getremotelogin | grep -c 'Remote Login: Off')
	if [[ "$screenSharing" == "1" ]]; then
		result="Passed"
		comment="Remote Login: Disabled"
	else
		result="Failed"
		comment="Remote Login: Enabled"
	fi
fi
printReport