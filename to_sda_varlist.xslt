<?xml version="1.0" encoding="UTF-8"?>

<!-- to_sda_varlist

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

	
	Convert queXML to an SDA varlist

	Used to produce a varlist, useful for when creating an SDA Archive
	
	See: http://sda.berkeley.edu:7502/ for information about SDA

-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dcarf="http://www.deakin.edu.au/dcarf" xmlns:redirect="http://xml.apache.org/xalan/redirect" extension-element-prefixes="redirect">
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>


	<!-- Templates -->
	<xsl:strip-space elements="*"/>
	
	<xsl:template match="questionnaire">
				<xsl:apply-templates select="section"/>
	</xsl:template>
	
	<xsl:template match="section">
		<xsl:text>**</xsl:text><xsl:value-of select="sectionInfo/text"/><xsl:text>&#xa;</xsl:text>
		<xsl:apply-templates select="question"/>
	</xsl:template>
	

	<!-- for each question in the queXML questionnaire 
				create a ddi var entry for each response variable
				record the question information in variables so as to pass on to the response template
	-->
	
	<xsl:template match="question">
	
		<!-- now consider matrix questions -->
		<xsl:choose>
			<!-- when there is a matrix question
					can assume only one response field applies
					and is copied from each -->			
			<xsl:when test="count(subQuestion) > 0">
				<xsl:apply-templates select="subQuestion">
				</xsl:apply-templates>				
			</xsl:when>
			
			<!-- when there is a simple response question -->
			<xsl:otherwise>
				<xsl:apply-templates select="response" mode="all">
				</xsl:apply-templates>				
			</xsl:otherwise>
		</xsl:choose>
	
		<!-- contingent questions -->
		<xsl:apply-templates select="response/fixed/category/contingentQuestion"/>
	
	</xsl:template>
	
	
	<!-- contingent question template -->
	<xsl:template match="contingentQuestion">
		<xsl:call-template name="variable">
			<xsl:with-param name="varName" select="@varName"/>
		</xsl:call-template>
	</xsl:template>
	
	<!-- subQuestion template deals with each subQuestion in turn -->
	<xsl:template match="subQuestion">
		<!-- use the response template to display the variable data for each response -->
		<xsl:apply-templates select="../response">
			<!-- pass the subQuestion varname as the response varname -->
			<xsl:with-param name="varName" select="@varName"/>
		</xsl:apply-templates>
		
	</xsl:template>

	<!-- applies to all responses the varName variable -->
	<xsl:template match="response" mode="all">
		<xsl:apply-templates select=".">
			<xsl:with-param name="varName" select="@varName"/>
		</xsl:apply-templates>
	</xsl:template>


	<!-- template for a variable -->
	<xsl:template name="variable">
		<xsl:param name="varName"/>
		<xsl:value-of select="$varName"/><xsl:text>&#xa;</xsl:text>
	</xsl:template>


	<!-- match a response -->
	<xsl:template match="response">
		<xsl:param name="varName"/>

		<xsl:call-template name="variable">
			<xsl:with-param name="varName" select="$varName"/>
		</xsl:call-template>

	</xsl:template>


	
</xsl:stylesheet>
