<?xml version="1.0" encoding="UTF-8"?>

<!-- to_phpsurveyor2

	Copyright Deakin University 2005,2006
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
	along with Foobar; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA


	
	Convert the intermediate XML description to SQL commands

	See the to_phpsurveyor script for further information

	This script produces the SQL commands in text form and requires 
	the following parameters to be entered:
		surveyid - an available surveyid in the database
		lastqid - the last qid in the questions table
		lastlid - the last lid in the labelsets table
		lastgid - the last gid in the groups table
		lastcid - the last cid in the conditions table

	
	
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>

	<xsl:param name="surveyid">1</xsl:param>
	<xsl:param name="lastqid">0</xsl:param>
	<xsl:param name="lastlid">0</xsl:param>
	<xsl:param name="lastgid">0</xsl:param>
	<xsl:param name="lastcid">0</xsl:param>

	<!--
		phpSurveyor
			group
				question
					cquestion

	-->
	<xsl:template match="phpSurveyor">
		<xsl:text>START TRANSACTION;</xsl:text>
		<xsl:text>&#xa;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#xa;</xsl:text>
		<xsl:text>COMMIT;</xsl:text>
		<xsl:text>&#xa;</xsl:text>
	</xsl:template>


	<xsl:template match="//comment">
		<xsl:text>-- </xsl:text><xsl:text>&#xa;</xsl:text><xsl:text>-- </xsl:text><xsl:value-of select="."/><xsl:text>&#xa;</xsl:text><xsl:text>-- </xsl:text><xsl:text>&#xa;</xsl:text>
	</xsl:template>

	<xsl:template match="//insert">
		<xsl:apply-templates/><xsl:text>&#xa;</xsl:text>
	</xsl:template>

	<xsl:template match="//surveyid">
				<xsl:value-of select="$surveyid"/>
	</xsl:template>

	<xsl:template match="//position">
		<xsl:number count="position" level="any" format="0001"/>
	</xsl:template>
	
	<xsl:template match="//qid">
		<xsl:variable name="c"><xsl:number count="qid" level="any" format="1"/></xsl:variable>
		<xsl:value-of select="$c + $lastqid"/>
	</xsl:template>
	
	<xsl:template match="/phpSurveyor/group/question/cquestion/insert/cqid">
		<xsl:variable name="c"><xsl:number count="qid" level="any" format="1"/></xsl:variable>
			<!-- value of qid - the  positition it is as cquestion -->
			<xsl:value-of select="($c + $lastqid) - 1"/>
	</xsl:template>
	

	<xsl:template match="//cid">
		<xsl:variable name="c"><xsl:number count="cid" level="any" format="1"/></xsl:variable>
		<xsl:value-of select="$c + $lastcid"/>
	</xsl:template>

	<xsl:template match="//tqid">
		<xsl:variable name="c"><xsl:number count="qid" level="any" format="1"/></xsl:variable>
		<xsl:value-of select="$c + $lastqid"/>

	</xsl:template>
	
	<xsl:template match="//qidchoice">
		<xsl:variable name="c"><xsl:number count="qid" level="any" format="1"/></xsl:variable>
		<xsl:value-of select="$c + $lastqid"/>

	</xsl:template>
	
	<xsl:template match="//lid">
		<xsl:variable name="c"><xsl:number count="lid" level="any" format="1"/></xsl:variable>
		<xsl:value-of select="$c + $lastlid"/>
	</xsl:template>

	<xsl:template match="//br">
		<xsl:text>&lt;br/&gt;</xsl:text>
	</xsl:template>


	<xsl:template match="//lidchoice">
		<xsl:variable name="c"><xsl:number count="lid" level="any" format="1"/></xsl:variable>
		<xsl:value-of select="$c + $lastlid"/>
	</xsl:template>

	<xsl:template match="//groupid">
		<xsl:variable name="c"><xsl:number count="groupid" level="any" format="1"/></xsl:variable>
		<xsl:value-of select="$c + $lastgid"/>
	</xsl:template>	
	
	<xsl:template match="//groupidchoice">
		<xsl:variable name="c"><xsl:number count="groupid" level="any" format="1"/></xsl:variable>
		<xsl:value-of select="$c + $lastgid"/>
	</xsl:template>	
	
</xsl:stylesheet>
