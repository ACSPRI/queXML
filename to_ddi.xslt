<?xml version="1.0" encoding="UTF-8"?>

<!-- to_ddi

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

	
	Convert queXML to a DDI description of the resulting data

	This stylesheet converts a queXML document to a DDI description of the data.
	(See: http://www.icpsr.umich.edu/DDI/) for information about the DDI

	Also note to_ddi2 which is also required

	
	This stylesheet is used in the DCARF data output process by (see the *):

	
		1. Produce an SPSS data file from the data source (eg CASES, Teleform, phpSurveyor)
			containing all variables
		2. *Produce a DDI Description file from the original queXML instrument using the to_ddi stylesheet
		3. Clean the SPSS data file
		4. Update and edit the DDI file to contain only the variables to be included in the dataset
		5. Use the ddi_to_export_spss stylesheet the DDI file to produce SPSS syntax to export the 
			SPSS data to fixed width format
		6. Use the ddi_to_spss stylesheet to produce a data description of the fixed width file
			to produce an SPSS data file based on the reduced dataset

	
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="questionnaire">
		<!-- basic structure -->
		<xsl:element name="codeBook">
			<xsl:element name="stdyDscr">
				<xsl:element name="citation">
					<xsl:element name="titlStmt">
						<xsl:element name="titl"><xsl:value-of select="title"/></xsl:element>
						<xsl:element name="subTitl"><xsl:value-of select="subtitle"/></xsl:element>
					</xsl:element>
					<xsl:element name="prodStmt">
						<xsl:element name="producer"><xsl:value-of select="dataCollector/organisation"/></xsl:element>
						<xsl:element name="prodPlac"><xsl:value-of select="dataCollector/address/street"/> <xsl:value-of select="dataCollector/address/suburb"/>, <xsl:value-of select="dataCollector/address/postcode"/>. <xsl:value-of select="dataCollector/address/country"/></xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:element>
			<xsl:element name="fileDscr">
				<xsl:attribute name="URI"></xsl:attribute>
				<xsl:element name="fileTxt">
					<xsl:element name="fileStrc">
						<xsl:attribute name="type">rectangular</xsl:attribute>
					</xsl:element>
					<xsl:element name="dimensns">
						<xsl:element name="caseQnty">1</xsl:element>
						<xsl:element name="varQnty">1</xsl:element>						
						<xsl:element name="logRecL">1</xsl:element>
						<xsl:element name="recPrCas">1</xsl:element>
						<xsl:element name="recNumTot">1</xsl:element>	
					</xsl:element>
				</xsl:element>
			</xsl:element>
			<xsl:element name="dataDscr">
				<xsl:call-template name="vargrp"/>
				<xsl:apply-templates select="section"/>
			</xsl:element>

		</xsl:element>

	</xsl:template>
	
	<!-- create the variable groups from the sections-->
	<xsl:template name="vargrp">
		<xsl:for-each select="section">
			<xsl:element name="varGrp">
				<xsl:attribute name="var"><xsl:for-each select=".//@varName"><xsl:value-of select="."/><xsl:if test="position() != last()"><xsl:text> </xsl:text></xsl:if></xsl:for-each></xsl:attribute>
				<xsl:element name="labl">
					<xsl:attribute name="level">VAR GROUP</xsl:attribute>
					<xsl:value-of select="sectionInfo/text"/>
				</xsl:element>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="section">
		<xsl:apply-templates select="question"/>
	</xsl:template>
	

	<!-- for each question in the queXML questionnaire 
				create a ddi var entry for each response variable
				record the question information in variables so as to pass on to the response template
	-->
	
	<xsl:template match="question">
	
		
		<!-- also qualifiers and specifiers -->
		<xsl:variable name="qtext">
			<xsl:choose>
				<xsl:when test="(count(qualifier) + count(specifier)) = 2">
					<xsl:for-each select="text">
						<xsl:if test="not(position() = 1)">.</xsl:if>
						<xsl:value-of select="." />
					 </xsl:for-each><xsl:text> : </xsl:text><xsl:value-of select="qualifier"/><xsl:text> : </xsl:text><xsl:value-of select="specifier"/>
				</xsl:when>
				<xsl:when test="count(qualifier) = 1">
					<xsl:for-each select="text">
						<xsl:if test="not(position() = 1)">.</xsl:if>
						<xsl:value-of select="." />
					 </xsl:for-each><xsl:text> : </xsl:text><xsl:value-of select="qualifier"/>
				</xsl:when>
				<xsl:when test="count(specifier) = 1">
					<xsl:for-each select="text">
						<xsl:if test="not(position() = 1)">.</xsl:if>
						<xsl:value-of select="." />
					 </xsl:for-each><xsl:text> : </xsl:text><xsl:value-of select="specifier"/>				
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="text">
						<xsl:if test="not(position() = 1)">.</xsl:if>
						<xsl:value-of select="." />
					 </xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:variable>
	
		<!-- now consider matrix questions -->
		<xsl:choose>
			<!-- when there is a matrix question
					can assume only one response field applies
					and is copied from each -->			
			<xsl:when test="count(subQuestion) > 0">
				<xsl:apply-templates select="subQuestion">
					<xsl:with-param name="qtext" select="$qtext"/>
				</xsl:apply-templates>				
			</xsl:when>
			
			<!-- when there are multiple responses in a single question with one category each
			 - this is a multiple-multiple choice question -->
			<xsl:when test="(count(response) > 1) and (count(response[1]/fixed/category) = 1)">
				<xsl:apply-templates select="response" mode="multiple">
					<xsl:with-param name="qtext" select="$qtext"/>
				</xsl:apply-templates>
			</xsl:when>
			
			<!-- when there is a simple response question -->
			<xsl:otherwise>
				<xsl:apply-templates select="response" mode="all">
					<xsl:with-param name="qtext" select="$qtext"/>
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
			<xsl:with-param name="qtext" select="text"/>
			<xsl:with-param name="width" select="length"/>
			<xsl:with-param name="type">character</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- subQuestion template deals with each subQuestion in turn -->
	<xsl:template match="subQuestion">
		<xsl:param name="qtext"/>
		
		<!-- use the response template to display the variable data for each response -->
		<xsl:apply-templates select="../response">
			<!-- pass the subQuestion varname as the response varname -->
			<xsl:with-param name="varName" select="@varName"/>
			<xsl:with-param name="preQTxt"><xsl:value-of select="$qtext"/></xsl:with-param>
			<xsl:with-param name="qtext"><xsl:value-of select="text"/></xsl:with-param>
		</xsl:apply-templates>
		
	</xsl:template>

	<!-- applies to all responses the varName variable -->
	<xsl:template match="response" mode="all">
		<xsl:param name="preQTxt"/>
		<xsl:param name="qtext"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="preQTxt" select="$preQTxt"/>
			<xsl:with-param name="qtext" select="$qtext"/>
			<xsl:with-param name="varName" select="@varName"/>
		</xsl:apply-templates>
	</xsl:template>


	<!-- applies to all responses the varName variable -->
	<xsl:template match="response" mode="multiple">
		<xsl:param name="preQTxt"/>
		<xsl:param name="qtext"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="preQTxt" select="$qtext"/>
			<xsl:with-param name="qtext"><xsl:value-of select="fixed/category/label"/></xsl:with-param>
			<xsl:with-param name="varName" select="@varName"/>
		</xsl:apply-templates>
	</xsl:template>

	<!-- template for a variable -->
	<xsl:template name="variable">
		<xsl:param name="varName"/>
		<xsl:param name="preQTxt"/>
		<xsl:param name="qtext"/>
		<xsl:param name="width"/>
		<xsl:param name="label"/>
		<xsl:param name="type">numeric</xsl:param>
		<xsl:param name="ivuInstr"/>

		<!-- The var tag -->
		<xsl:element name="var">
			<xsl:attribute name="ID"><xsl:value-of select="$varName"/></xsl:attribute>
			<xsl:attribute name="name"><xsl:value-of select="$varName"/></xsl:attribute>
			<!-- the amount of decimal places -->
			<xsl:attribute name="dcml"><xsl:value-of select="0"/></xsl:attribute>

			<!-- The location tag -->
			<xsl:element name="location">
				<!-- These elements refer to the record number, start column and width respectively-->
				<xsl:attribute name="RecSegNo">1</xsl:attribute>
				<xsl:attribute name="StartPos"></xsl:attribute>
				<xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
			</xsl:element>

			<!-- labl tag -->
			<xsl:element name="labl">
				<xsl:attribute name="level">variable</xsl:attribute>
				<!--<xsl:if test="$label != ''">
					<xsl:attribute name="sdatrefs"><xsl:value-of select="$label"/></xsl:attribute>
				</xsl:if>-->
				<xsl:value-of select="$qtext"/>
			</xsl:element>

			
			<!-- The qstn tag -->
			<xsl:element name="qstn">
				<xsl:element name="preQTxt">
					<xsl:value-of select="$preQTxt"/>
					<!-- set of conditions on why the question would be asked -->
					<xsl:if test="count(../category) = 1">
						<!-- if this is a contingent question - describe it-->
						<xsl:text> This question is contingent on the category value: </xsl:text><xsl:value-of select="../value"/><xsl:text> : </xsl:text><xsl:value-of select="../label"/><xsl:text> being answered to item: </xsl:text><xsl:value-of select="../../../@varName"/>
					</xsl:if>
				</xsl:element>

				 <!-- The qstnLit tag -->
				 <xsl:element name="qstnLit">
					 <!-- question text -->
					 <xsl:value-of select="$qtext"/>
				 </xsl:element>
				 
				 <xsl:element name="postQTxt">
					 <!-- text after the question -->
				 </xsl:element>

				<!-- qstn attribute contains a space separated list of next questions -->
				<!-- for now - just select the next varName OR if there is a skip - select it -->
				<!--<xsl:element name="forward">
					 <xsl:attribute name="qstn"></xsl:attribute>
				 </xsl:element>-->
				 
				 <xsl:element name="backward">
					 
				 </xsl:element>

				<!-- interviewer instructions -->
				<!-- get the directive... but this applies to only the first directive -->
				<xsl:element name="ivuInstr"><xsl:for-each select="../directive"><xsl:value-of select="administration"/><xsl:text>: </xsl:text><xsl:value-of select="text"/><xsl:text>.</xsl:text></xsl:for-each></xsl:element>

			</xsl:element>
		

			<!-- if this is a fixed response - insert the category labels -->
			<xsl:apply-templates select="fixed/category"/>

			<!-- varFormat tag -->				
			<xsl:element name="varFormat">
				<xsl:choose>
					<xsl:when test="$type = 'numeric'">
						<xsl:attribute name="type">numeric</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="type">character</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>ASCII</xsl:text>
			</xsl:element>

			
		</xsl:element>
		
	</xsl:template>

	<!-- match a response -->
	<xsl:template match="response">
		<xsl:param name="varName"/>
		<xsl:param name="qtext"/>
		<xsl:param name="preQTxt"/>

		<xsl:choose>
			<xsl:when test="count(free)>0">
				
				<xsl:choose>
					
					<xsl:when test="free/format != 'integer'">
						<xsl:call-template name="variable">
							<xsl:with-param name="varName" select="$varName"/>
							<xsl:with-param name="qtext" select="$qtext"/>
							<xsl:with-param name="preQTxt" select="$preQTxt"/>
							<xsl:with-param name="width" select="free/length"/>
							<!-- default is numeric-->
							
								<xsl:with-param name="type">character</xsl:with-param>					
						
							<xsl:with-param name="label"><xsl:value-of select="free/format"/><xsl:text>: </xsl:text><xsl:value-of select="free/label"/></xsl:with-param>
						</xsl:call-template>
					</xsl:when>

					<xsl:otherwise>
						<xsl:call-template name="variable">
							<xsl:with-param name="varName" select="$varName"/>
							<xsl:with-param name="qtext" select="$qtext"/>
							<xsl:with-param name="preQTxt" select="$preQTxt"/>
							<xsl:with-param name="width" select="free/length"/>
							<!-- default is numeric-->
							
							<xsl:with-param name="label"><xsl:value-of select="free/format"/><xsl:text>: </xsl:text><xsl:value-of select="free/label"/></xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
					
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
					
				<!-- find the longest response category value -->
				<!-- currently only works for numeric response codes-->
				<xsl:variable name="the_max">
					<xsl:for-each select="fixed/category">
							<xsl:sort select="value" data-type="number" order="descending"/>
						<xsl:if test="position()=1">
							<!-- return the length of the highest number-->
							<xsl:value-of select="string-length(value)"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>					

				<xsl:call-template name="variable">
					<xsl:with-param name="varName" select="$varName"/>
					<xsl:with-param name="qtext" select="$qtext"/>
					<xsl:with-param name="preQTxt" select="$preQTxt"/>
					<xsl:with-param name="width" select="$the_max"/>
					<!-- default is numeric
										<xsl:with-param name="type">character</xsl:with-param>					-->
					
				</xsl:call-template>

							
			</xsl:otherwise>
		</xsl:choose>
				
	
	</xsl:template>


	<xsl:template match="category">
		<!-- categories tag-->
		<xsl:element name="catgry">
			<xsl:attribute name="missing">N</xsl:attribute>
			
			<xsl:element name="catValu"><xsl:value-of select="value"/></xsl:element>
			<xsl:element name="labl">
				<xsl:attribute name="level">category</xsl:attribute>
				<xsl:value-of select="label"/>
			</xsl:element>
		</xsl:element>

	</xsl:template>

	
</xsl:stylesheet>
