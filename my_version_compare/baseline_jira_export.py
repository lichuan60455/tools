#-*- coding=utf-8 -*-
#!/usr/bin/python

import requests as r
from jira import JIRA
import sys

JIRA_IDS=sys.argv[1]
REPORTS=sys.argv[2]

jira = JIRA(server='https://jira.cvte.com',
            basic_auth=('lichuan', 'Lichuan604556772'))
issue_details=dict()

def getJiraDetail(jiraId):
    if jiraId == "":
        return
    res=jira.search_issues("issue = " + jiraId)
    for i in res:
        issue_details[jiraId]=i.fields.summary

#【<a href="https://jira.cvte.com/browse/PDT3AT-2457">PDT3AT-2457</a>】AT F1 复位数据保存问题<br>
def outputReport():
    reportFile = open(REPORTS, "w")
    for issue in issue_details:
        oneLine=unicode('''【<a href="https://jira.cvte.com/browse/''' + issue + '''">''' + issue + '''</a>】''' + issue_details[issue] + '''<br>\n''')
        reportFile.write(oneLine)


if __name__ == "__main__":
    if sys.getdefaultencoding() != 'utf-8':
        reload(sys)
        sys.setdefaultencoding('utf-8')

    f=open(JIRA_IDS, "r")
    lines=f.readlines()
    for l in lines:
        jiraId=l.rstrip("\n")
        getJiraDetail(jiraId)

    outputReport()
