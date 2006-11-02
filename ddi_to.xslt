<?xml version="1.0" encoding="UTF-8"?>

<!-- ddi_to

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
	
	Produces a basic queXML document given a DDI description of data

	Used for speeding up the creation of a queXML document when there is an existing DDI description.
	May also be used to go from CASES Q language by:
		Exporting a DDL file from CASES
		Converting the DDL file to DDI using the ddltox tool in the SDA toolkit
		Converting the DDI to queXML using this stylesheet

	Note: This method will not reproduce the entire questionnaire, manual modification is still necessary
	It may speed up the process.
	
-->


<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	
	<xsl:template match="codeBook">
		<xsl:element name="questionnaire">		
			<xsl:element name="title">
				<xsl:value-of select="normalize-space(stdyDscr/citation/titlStmt/titl)"/>
			</xsl:element>
			<xsl:element name="subtitle">
				<xsl:value-of select="normalize-space(studyDscr/citation/titlStmt/titl)"/>
			</xsl:element>
			<xsl:element name="investigator">
				<xsl:element name="name">
					<xsl:element name="salutation">Dr</xsl:element>
					<xsl:element name="firstName">Betsy</xsl:element>
					<xsl:element name="lastName">Blunsdon</xsl:element>
				</xsl:element>
				<xsl:element name="organisation">Deakin University</xsl:element>
				<xsl:element name="address">
					<xsl:element name="street">221 Burwood Hwy</xsl:element>
					<xsl:element name="suburb">Burwood</xsl:element>
					<xsl:element name="postcode">3125</xsl:element>
					<xsl:element name="country">Australia</xsl:element>
				</xsl:element>
				<xsl:element name="phoneNumber">1234</xsl:element>
				<xsl:element name="faxNumber"></xsl:element>
				<xsl:element name="emailAddress">betsy.blunsdon@deakin.edu.au</xsl:element>
				<xsl:element name="website"></xsl:element>
			</xsl:element>
			<xsl:element name="dataCollector">
				<xsl:element name="name">
					<xsl:element name="salutation">Dr</xsl:element>
					<xsl:element name="firstName">Betsy</xsl:element>
					<xsl:element name="lastName">Blunsdon</xsl:element>
				</xsl:element>
				<xsl:element name="organisation">Deakin University</xsl:element>
				<xsl:element name="address">
					<xsl:element name="street">221 Burwood Hwy</xsl:element>
					<xsl:element name="suburb">Burwood</xsl:element>
					<xsl:element name="postcode">3125</xsl:element>
					<xsl:element name="country">Australia</xsl:element>
				</xsl:element>
				<xsl:element name="phoneNumber">1234</xsl:element>
				<xsl:element name="faxNumber"></xsl:element>
				<xsl:element name="emailAddress">betsy.blunsdon@deakin.edu.au</xsl:element>
				<xsl:element name="website"></xsl:element>
			</xsl:element>
					
			<xsl:apply-templates select="dataDscr"/>
		
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="dataDscr">
		<!-- will only be one section to begin with -->			
		<xsl:element name="section">
			<xsl:apply-templates select="var"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="var">
		<xsl:element name="question">
			<xsl:element name="text"><xsl:value-of select="qstn/qstnLit"/></xsl:element>
			<xsl:element name="response">
				<xsl:attribute name="varName"><xsl:value-of select="normalize-space(@name)"/></xsl:attribute>
				<xsl:choose>
				
					<!-- Fixed respose -->
					<xsl:when test="count(catgry/catValu)>0">
						<xsl:call-template name="fixedresponse"/>
					</xsl:when>
					<!-- Open response -->
					<xsl:otherwise>
						<xsl:call-template name="freeresponse"/>
					</xsl:otherwise>
				</xsl:choose>		
			</xsl:element>
		</xsl:element>	
	</xsl:template>


	<xsl:template match="catgry">
		<xsl:element name="category">
			<xsl:element name="label"><xsl:value-of select="normalize-space(labl)"/></xsl:element>
			<xsl:element name="value"><xsl:value-of select="normalize-space(catValu)"/></xsl:element>
		</xsl:element>	
	</xsl:template>

	<xsl:template name="fixedresponse">

		<xsl:element name="fixed">
			<xsl:apply-templates select="catgry[count(catValu)=1]"/>
		</xsl:element>	
		
	</xsl:template>
	
	<xsl:template name="freeresponse">

		<xsl:element name="free">
			<xsl:element name="format">
				<xsl:choose>
					<xsl:when test="varFormat/@type = 'numeric'">integer</xsl:when>
					<xsl:otherwise>text</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			<xsl:element name="length"><xsl:value-of select="normalize-space(location/@width)"/></xsl:element>
		</xsl:element>
	
	</xsl:template>

</xsl:stylesheet>
