<?xml version="1.0" encoding="UTF-8"?>

<!-- to_limesurvey

	Copyright Deakin University 2005,2006,2008
	Written by Adam Zammit - adam.zammit@deakin.edu.au
	For the Deakin Computer Assisted Research Facility: http://www.deakin.edu.au/dcarf/

	This file is part of queXML.

	queXML is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	queXML is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with queXML; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
	

	
	Convert queXML to a LimeSurvey CSV import file

	This stylesheet is to be used with the LimeSurvey package (see http://www.limesurvey.org)
		
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" version="1.0" encoding="UTF-8"/>

<!-- escape-apos template by Jeni Tennison
	see: http://www.dpawson.co.uk/xsl/sect2/N7150.html
	
	makes sure apostrophes in text are escaped to be safely used in SQL	
-->
<xsl:template name="escape-quot">
 <xsl:param name="string"/>
<xsl:variable name="apos" select="'&quot;'" />
<xsl:choose>
 <xsl:when test='contains($string, $apos)'>
  <xsl:value-of select="substring-before($string,$apos)" />
	<xsl:text>\"</xsl:text>
	<xsl:call-template name="escape-quot">
	 <xsl:with-param name="string"
          select="substring-after($string, $apos)" />
	</xsl:call-template>
 </xsl:when>
 <xsl:otherwise>
  <xsl:value-of select="$string" />
 </xsl:otherwise>
</xsl:choose>
</xsl:template>



<xsl:template match="questionnaire"># LimeSurvey Survey Dump
# DBVersion 126
# This is a dumped survey from the LimeSurvey Script
# http://www.limesurvey.org/
# Do not change this header!

#
# SURVEYS TABLE
#
"sid","owner_id","admin","active","expires","adminemail","private","faxto","format","template","url","language","additional_languages","datestamp","usecookie","notification","allowregister","attribute1","attribute2","allowsave","autonumber_start","autoredirect","allowprev","printanswers","ipaddr","useexpiry","refurl","datecreated","listpublic","htmlemail","tokenanswerspersistence","usecaptcha","bounce_email"
"1","1","","N","2008-03-28","","Y","","G","default","","en","","Y","N","0","N","","","Y","0","N","Y","N","N","N","N","2008-03-28","N","Y","Y","D",""

#
# GROUPS TABLE
#
"gid","sid","group_name","group_order","description","language"
<xsl:apply-templates select="section"/>
#
# QUESTIONS TABLE
#
"qid","sid","gid","type","title","question","preg","help","other","mandatory","lid","lid1","question_order","language"
<xsl:apply-templates select="section/question"/>
#
# ANSWERS TABLE
#
"qid","code","answer","default_value","sortorder","language"
<xsl:apply-templates select="section/question/subQuestion"/>
#
# CONDITIONS TABLE
#

#
# LABELSETS TABLE
#
"lid","label_name","languages"
<xsl:apply-templates select="section/question/response/fixed"/>
#
# LABELS TABLE
#
"lid","code","title","sortorder","language"
<xsl:apply-templates select="section/question/response/fixed/category"/>
#
# QUESTION_ATTRIBUTES TABLE
#
"qaid","qid","attribute","value"
<xsl:apply-templates select="section/question/response/free"/>
<xsl:apply-templates select="section/question[count(subQuestion) >= 1 and count(response/fixed) = 1]" mode="attributes"/>
#
# ASSESSMENTS TABLE
#

#
# SURVEYS_LANGUAGESETTINGS TABLE
#
"surveyls_survey_id","surveyls_language","surveyls_title","surveyls_description","surveyls_welcometext","surveyls_urldescription","surveyls_email_invite_subj","surveyls_email_invite","surveyls_email_remind_subj","surveyls_email_remind","surveyls_email_register_subj","surveyls_email_register","surveyls_email_confirm_subj","surveyls_email_confirm"
"1","en","<xsl:value-of select="title"/>","<xsl:value-of select="title"/>","<xsl:apply-templates select="questionnaireInfo[position='before']"/>","","","","","","","","",""

#
# QUOTA TABLE
#

#
# QUOTA_MEMBERS TABLE
#

</xsl:template>


<xsl:template match="questionnaire/questionnaireInfo">
	<xsl:value-of select="text"/>
</xsl:template>

<xsl:template match="questionnaire/section">"<xsl:number count="section" level="any" format="1"/>","1","<xsl:apply-templates select="sectionInfo[position='title' and administration='self']"/>","<xsl:number count="section" level="any" format="00001"/>","<xsl:apply-templates select="sectionInfo[position='before' and administration='self']"/>","en"
</xsl:template>


<xsl:template match="questionnaire/section/question">"<xsl:number count="question" level="any" format="1"/>","1","<xsl:number count="section" level="any" format="1"/>","<xsl:choose><xsl:when test="count(subQuestion) >= 1 and count(response/fixed) = 1 and count(response/fixed/category) = 1">M</xsl:when><xsl:when test="count(subQuestion) >= 1 and count(response/fixed) = 1">F</xsl:when><xsl:when test="count(subQuestion) >= 1 and count(response/free[format = 'integer']) = 1">K</xsl:when><xsl:when test="count(subQuestion) >= 1 and count(response/free[format != 'integer']) = 1">Q</xsl:when><xsl:when test="count(response/free[format = 'integer']) = 1">N</xsl:when><xsl:when test="count(response/free[format = 'longtext']) = 1">T</xsl:when><xsl:when test="count(response/free) = 1">S</xsl:when><xsl:when test="count(response/fixed) = 1">Z</xsl:when><xsl:otherwise>$</xsl:otherwise></xsl:choose>","<xsl:value-of select="response/@varName"/>","<xsl:apply-templates select="text"/>","","<xsl:apply-templates select="directive[position='during' and administration='self']"/>","N","N","<xsl:choose><xsl:when test="count(response/fixed) = 1"><xsl:variable name="rf"><xsl:number count="response/fixed" level="any" format="1"/></xsl:variable><xsl:choose><xsl:when test="string(number($rf)) = 'NaN'">1</xsl:when><xsl:otherwise><xsl:value-of select="$rf + 1"/></xsl:otherwise></xsl:choose></xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose>","0","<xsl:number count="question" level="any" format="00001"/>","en"
</xsl:template>

<xsl:template match="questionnaire/section/question/response/fixed">"<xsl:number count="fixed" level="any" format="1"/>","queXMLimport","en"
</xsl:template>
	
<xsl:template match="questionnaire/section/question/response/fixed/category">"<xsl:number count="fixed" level="any" format="1"/>","<xsl:value-of select="value"/>","<xsl:value-of select="label"/>","<xsl:number count="category" level="single" format="00001"/>","en"
</xsl:template>

<xsl:template match="questionnaire/section/question/response/free">"<xsl:number count="free" level="any" format="1"/>","<xsl:number count="question" level="any" format="1"/>","maximum_chars","<xsl:value-of select="length"/>"
</xsl:template>

<xsl:template match="questionnaire/section/question" mode="attributes">"<xsl:variable name="cq"><xsl:number count="question[count(subQuestion) >= 1 and count(response/fixed) = 1]" level="any" format="1"/></xsl:variable><xsl:value-of select="count(/questionnaire/section/question/response/free) + $cq"/>","<xsl:number count="question" level="any" format="1"/>","answer_width","60"
</xsl:template>

<xsl:template match="questionnaire/section/question/subQuestion">"<xsl:number count="question" level="any" format="1"/>","<xsl:number count="subQuestion" level="single" format="a"/>","<xsl:value-of select="text"/>","N","<xsl:number count="subQuestion" level="single" format="00001"/>","en"
</xsl:template>


<xsl:template match="questionnaire/section/sectionInfo"><xsl:for-each select="text"><xsl:value-of select="."/>&lt;br/&gt;</xsl:for-each></xsl:template>

<xsl:template match="questionnaire/section/question/directive">
	<xsl:value-of select="text"/>
</xsl:template>


<xsl:template match="questionnaire/section/question/text"><xsl:value-of select="."/>&lt;br/&gt;</xsl:template>

	
</xsl:stylesheet>
