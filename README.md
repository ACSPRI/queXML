#queXML

An Open Source, XML, multi-mode questionnaire description toolkit

queXML is a simple XML schema for designing questionnaires. Included are stylesheets to administer a questionnaire on paper (then scanned and verified using queXF), CATI using queXS and on the Web using LimeSurvey. queXML is compatible with the DDI standard for data description.

queXML is an XML schema that describes a questionnaire. queXML also includes related XML stylesheets. A questionnaire written in queXML can be "exported" to multiple modes of questionnaire administration/execution such as paper based (by exporting to XSL:FO and then PDF - and then verifying data using the queXF system), web based by exporting to a CSV file which is compatible with Limesurvey or CATI based (Computer Assisted Telephone Interviewing) using queXS software.

The advantage of queXML is that by writing a stylesheet for your particular survey execution system, you may use existing queXML questionnaires - and be able to execute your questionnaire in multiple modes either simultaneously or separately. Also, queXML is compatible with the DDI standard - there is a stylesheet to convert an instrument in queXML to a description of that data that the survey execution system will collect. This means that the survey execution system need not be modified to be DDI compliant if the questionnaire was originally described in queXML.

Development for queXML occurs on Launchpad: https://launchpad.net/quexml
