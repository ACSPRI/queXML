<?xml version="1.0" encoding="UTF-8"?>

<!-- to_form

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
	along with Foobar; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA



	
	Converts queXML to XSL:FO.
	XSL:FO is best rendered to PDF using the renderx toolkit (see http://www.renderx.com)

	This form design attempts to follow the guidelines and principles in 
	Barnett, Robert "The Form Designer's Quick Reference Guide" 1994

	Including:
		Using white boxes on a light coloured background (grey)
		Ideal box size being 4-5mm squared
		Ideal line weight being 0.2 to 0.5 points
		Using a serif font of at least 12 points
		Using "Eye guides" to determine what responses need to be selected
		Using "dotted" delimiters for filling out specific width text fields
		
	
	This form also attempts to be useful for the Teleform form recognition program by:
		Using "Guides" (the black corners on each page) to allow the page to be aligned
		Using barcodes in a format that Teleform can recognise
		Using a unique barcode on each page to allow for automatic page ordering
		
-->	


<!-- This is the main stylesheet -->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:dcarf="http://www.deakin.edu.au/dcarf">
	
	<xsl:import href="to_form_page_layout.xslt"/>
	<xsl:import href="to_form_property_sets.xslt"/>

    
	<xsl:template match="questionnaire">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- The first page that isn't the cover -->
	<xsl:template name="firstpage">


		<!-- 'during' the survey (first page) info -->
		<!--		<xsl:if test="count(/questionnaire/questionnaireInfo[position='during' and administration='self'])>=1">
			<fo:block-container xsl:use-attribute-sets="questionnaireInfoBeforeContainer">
				<xsl:for-each select="/questionnaire/questionnaireInfo[position='during' and administration='self']">
					<xsl:call-template name="questionnaireInfoBefore"/>
				</xsl:for-each>
			</fo:block-container>
		</xsl:if>-->


	</xsl:template>








	<!-- template for images -->
	<xsl:template match="//image">
		<fo:block>
				<fo:external-graphic>
					<!--<xsl:attribute name ="content-height"><xsl:value-of select="@height"/></xsl:attribute>-->
					<xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
			</fo:external-graphic>
			</fo:block>
	</xsl:template>
		
	<!-- template for text -->
	<xsl:template match="//text/bold">
		<fo:inline font-weight="bold">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	
	<xsl:template match="//text[@indent='true']">
		<fo:block margin-left="3mm">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="//text[(@indent = 'false' or not(@indent)) and (@title = 'false' or not(@title))]">
		<fo:block>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="//text[(@indent = 'false' or not(@indent)) and (@title = 'false' or not(@title))]" mode="information_symbol">
		<fo:block>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	

	<!-- The Front Page -->
	<xsl:template name="coverpage">


		<!-- The page title -->
		<fo:block-container xsl:use-attribute-sets="titleContainer">
		
			<fo:block xsl:use-attribute-sets="titleFont">
				<xsl:value-of select="/questionnaire/title"/>
			</fo:block>

		</fo:block-container>
		
		<xsl:if test="$logo != 'false'">
		<!-- The Main logo - this can be FIXED POSITION -->
		<fo:block-container xsl:use-attribute-sets="logoContainer">

			<fo:block>
				<fo:external-graphic
				content-height="25mm">
					<xsl:attribute name="src"><xsl:value-of select="$logo"/></xsl:attribute>
				</fo:external-graphic>
				
			</fo:block> 
			
		</fo:block-container>
		</xsl:if>
		
		<!-- Another logo -->
		<xsl:if test="$logo2 != 'false'">
		<fo:block-container xsl:use-attribute-sets="logo2Container">

			<fo:block>
				<fo:external-graphic
				content-height="25mm">
					<xsl:attribute name="src"><xsl:value-of select="$logo2"/></xsl:attribute>
			</fo:external-graphic>
			</fo:block> 
			
		</fo:block-container>
		</xsl:if>
		
		
		<!-- The data collector organisation -->
		<fo:block-container xsl:use-attribute-sets="organisationContainer">
			<fo:block xsl:use-attribute-sets="organisationFont">
				Deakin Computer Assisted Research Facility DCARF
			</fo:block>
		</fo:block-container>
		
		<!-- The return box -->
		<fo:block-container xsl:use-attribute-sets="returnContainer">
			<fo:block xsl:use-attribute-sets="returnHeadingFont">
				Return
			</fo:block>

			<fo:block xsl:use-attribute-sets="returnFont">
				Please return your completed questionnaire to:
			</fo:block>
		
			
			<fo:block xsl:use-attribute-sets="returnFont" margin-top="8mm">

					<xsl:value-of select="/questionnaire/dataCollector/name/salutation"/><xsl:text> </xsl:text>

					 <xsl:value-of select="/questionnaire/dataCollector/name/firstName"/><xsl:text> </xsl:text>

					<xsl:value-of select="/questionnaire/dataCollector/name/lastName"/>

			</fo:block>
						
			<fo:block xsl:use-attribute-sets="returnFont">
				<xsl:value-of select="/questionnaire/dataCollector/organisation"/>
			</fo:block>	
			
			<fo:block xsl:use-attribute-sets="returnFont">
				<xsl:value-of select="/questionnaire/dataCollector/address/street"/>
			</fo:block>
			<fo:block xsl:use-attribute-sets="returnFont">			

					<xsl:value-of select="/questionnaire/dataCollector/address/suburb"/><xsl:text> </xsl:text>
			
					<xsl:value-of select="/questionnaire/dataCollector/address/postcode"/><xsl:text> </xsl:text>

					<xsl:value-of select="/questionnaire/dataCollector/address/country"/>

			</fo:block>
			
		</fo:block-container>


		<!-- Optional web link -->
		<xsl:if test="count(/questionnaire/investigator/website)=1">
			<fo:block-container xsl:use-attribute-sets="webContainer">
				<fo:block xsl:use-attribute-sets="webHeadingFont">
					Optional Web Completion
				</fo:block>
	
				<fo:block xsl:use-attribute-sets="webFont">
					If you would prefer to complete this questionnaire online
				</fo:block>
				<fo:block xsl:use-attribute-sets="webFont">
					please go to the following website:
				</fo:block>
				
				
				<fo:block xsl:use-attribute-sets="webFont" margin-top="8mm">
	
						<xsl:value-of select="/questionnaire/investigator/website"/><xsl:text> </xsl:text>
	
				</fo:block>	
			</fo:block-container>
		</xsl:if>


		<fo:block-container xsl:use-attribute-sets="instructionsContainer">
			<fo:block xsl:use-attribute-sets="instructionsHeadingFont">
				Instructions
			</fo:block>
				<fo:block xsl:use-attribute-sets="instructionsFont">
						Please cross the single most appropriate box like this: <xsl:call-template name="drawboxcrossed"/>
				</fo:block>
		</fo:block-container>


		<!-- temporary images on front page -->
		
		<!--
		<fo:block-container top="190mm" left="25mm" absolute-position="fixed" width="150mm">
			<fo:block>
			<fo:table inline-progression-dimension="100%" table-layout="fixed">
				<fo:table-column column-width="proportional-column-width(1)"/> 
				<fo:table-column column-width="proportional-column-width(1)"/> 
				<fo:table-column column-width="proportional-column-width(1)"/> 
				<fo:table-body>
				<fo:table-row>
					<fo:table-cell text-align="center"><fo:block><fo:external-graphic content-height="25mm" src="url(file://mnt/iss/tmp/walk.png)"/></fo:block></fo:table-cell>
					<fo:table-cell text-align="center"><fo:block><fo:external-graphic content-height="25mm" src="url(file://mnt/iss/tmp/crossing.png)"/></fo:block></fo:table-cell>
					<fo:table-cell text-align="center"><fo:block><fo:external-graphic content-height="25mm" src="url(file://mnt/iss/tmp/drive.png)"/></fo:block></fo:table-cell>
				</fo:table-row>
				</fo:table-body>
			</fo:table>		
			</fo:block>
		</fo:block-container>
		-->


		

		
		<xsl:if test="count(/questionnaire/investigator/phoneNumber)>=1">
		
		<!-- The help box -->
		<fo:block-container xsl:use-attribute-sets="helpContainer">
			<fo:block xsl:use-attribute-sets="helpHeadingFont">
				Help Available
			</fo:block>

			<fo:block xsl:use-attribute-sets="helpFont">
				If you need any help to answer the questions
			</fo:block>
			<fo:block xsl:use-attribute-sets="helpFont">
				please phone:
			</fo:block>
			
			
			<fo:block xsl:use-attribute-sets="helpFont" margin-top="8mm">

					<xsl:value-of select="/questionnaire/investigator/name/salutation"/><xsl:text> </xsl:text>

					 <xsl:value-of select="/questionnaire/investigator/name/firstName"/><xsl:text> </xsl:text>

					<xsl:value-of select="/questionnaire/investigator/name/lastName"/>
 
			</fo:block>
			
			<fo:block xsl:use-attribute-sets="helpFont">
				<xsl:value-of select="/questionnaire/investigator/phoneNumber"/>
			</fo:block>			
		</fo:block-container>

		</xsl:if>

	</xsl:template>
	
	<!-- For each section ... -->
	<xsl:template name="sections">

		<!-- start of the survey info -->
		<xsl:if test="count(/questionnaire/questionnaireInfo[position='before' and administration='self'])>=1">
			<fo:block-container xsl:use-attribute-sets="questionnaireInfoAfterContainer">
				<xsl:for-each select="/questionnaire/questionnaireInfo[position='before' and administration='self']">
					<xsl:call-template name="questionnaireInfoAfter"/>
				</xsl:for-each>
			</fo:block-container>
		</xsl:if>

		


		<xsl:apply-templates select="/questionnaire/section[@last = 'false' or not(@last)]"/>
		
		<!-- end of the survey info -->
		<xsl:if test="count(/questionnaire/questionnaireInfo[position='after' and administration='self'])>=1">
			<fo:block-container xsl:use-attribute-sets="questionnaireInfoAfterContainer">
				<xsl:for-each select="/questionnaire/questionnaireInfo[position='after' and administration='self']">
					<xsl:call-template name="questionnaireInfoAfter"/>
				</xsl:for-each>
			</fo:block-container>
		</xsl:if>
		
		<!-- If this is the "last" section, then put it on a new page -->
		<xsl:if test="count(questionnaire/section[@last = 'true'])>0">
			<fo:block-container break-before="page">
				<xsl:apply-templates select="/questionnaire/section[@last = 'true']"/>
			</fo:block-container>
		</xsl:if>

		<!--  appendix  - on a new page too -->
		<xsl:if test="count(questionnaire/questionnaireInfo[position='appendix'])>=1">
			<fo:block-container break-before="page">
				<xsl:apply-templates select="/questionnaire/questionnaireInfo[position='appendix']"/>
			</fo:block-container>
		</xsl:if>
		
	</xsl:template>

	<!-- Draw up a box with the questionnaire info text centered -->
	<xsl:template name="questionnaireInfoAfter">
			<fo:block xsl:use-attribute-sets="questionnaireInfoAfterFont">
			<xsl:apply-templates select="image"/>	
				<xsl:apply-templates select="text"/>
			</fo:block>		
	</xsl:template>

	<!-- Draw up a box with the questionnaire info text centered -->
	<xsl:template name="questionnaireInfoBefore">
			<xsl:apply-templates select="image"/>	
			<fo:block xsl:use-attribute-sets="questionnaireInfoBeforeFont">
				<xsl:apply-templates select="text"/>
			</fo:block>		
	</xsl:template>


	<xsl:template match="/questionnaire/questionnaireInfo/text[@title='true']">
		<fo:block-container xsl:use-attribute-sets="section_info_beforeContainer">
			<fo:block xsl:use-attribute-sets="section_info_beforeFont">
				<xsl:value-of select="."/>
			</fo:block>
		</fo:block-container>
	</xsl:template>

	<xsl:template match="/questionnaire/questionnaireInfo[position='appendix']">
		<fo:block-container xsl:use-attribute-sets="sectionContainer">
			<fo:block xsl:use-attribute-sets="sectionFont sectiontextContainer">

			<!-- Show the appendix title -->
			Appendix <xsl:value-of select="position()"/>

			</fo:block>

			<xsl:apply-templates select="text[@title='true']"/>

		</fo:block-container>
		
			

		<fo:block xsl:use-attribute-sets="questionnaireInfoAppendixFont">
			<xsl:apply-templates select="text[@title='false' or not(@title)]"/>
		</fo:block>		

	</xsl:template>

	
	<!-- In each section... -->
	<xsl:template match="/questionnaire/section">

		<!-- 	This must be terminated by the first question in the section so that the section
				and the first question will always remain on the same page -->
		<fo:block-container xsl:use-attribute-sets="firstQuestionContainer">
		
			<fo:block-container xsl:use-attribute-sets="sectionContainer">
				<fo:block xsl:use-attribute-sets="sectionFont sectiontextContainer">

					<!-- This is an option not to display the section title -->
					<xsl:if test="$show_section_title='true'">
					Section <xsl:number count="section" level="any" format="A"/>
					</xsl:if>
					
					<xsl:for-each select="sectionInfo[position='title' and administration='self']">
						<xsl:call-template name="sectionInfoTitle"/>
					</xsl:for-each>					
				</fo:block>
					
				<xsl:for-each select="sectionInfo">
					<xsl:choose>
						<xsl:when test="position='before' and administration='self'">
							<xsl:call-template name="sectionInfoBefore"/>
						</xsl:when>
						<xsl:when test="position='during' and administration='self'">
							<xsl:call-template name="sectionInfoDuring"/>
						</xsl:when>
				</xsl:choose>
				</xsl:for-each>
			</fo:block-container>
		
			<xsl:apply-templates select="question[position()=1]"/>

		</fo:block-container>

		<xsl:apply-templates select="question[position()>1]"/>
		
		<xsl:for-each select="sectionInfo[position='after' and administration='self']">
					<xsl:call-template name="sectionInfoAfter"/>
		</xsl:for-each>
		
	</xsl:template>

	<!-- Draws the question qualifier (inline) -->
	<xsl:template match="/questionnaire/section/question/qualifier">
		<fo:inline xsl:use-attribute-sets="questionQualifierFont">		
			<xsl:value-of select="."/>
		</fo:inline>
	</xsl:template>


	<!-- Draws the question specifier (new block) -->
	<xsl:template match="/questionnaire/section/question/specifier">
		<!--<fo:block-container xsl:use-attribute-sets="questionTextContainer">-->
			<fo:block xsl:use-attribute-sets="questionSpecifierFont">
				<fo:external-graphic content-height="3mm" src="url(file://mnt/iss/quexml/information.svg)"/>
				<xsl:value-of select="."/>
			</fo:block>
		<!--</fo:block-container>-->
	</xsl:template>


	<!-- Draws the question information -->
	<xsl:template match="/questionnaire/section/question">

		<fo:block-container xsl:use-attribute-sets="questionContainer">

			<!-- If there is a before directive -->
			<xsl:for-each select="directive[position = 'before' and administration = 'self']">
				<fo:block xsl:use-attribute-sets="directive_beforeFont">
					<xsl:choose>
						<xsl:when test="$show_information_symbol='true'">
							<xsl:apply-templates select="text" mode="information_symbol"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="text"/>
						</xsl:otherwise>
					</xsl:choose>

				</fo:block>
			</xsl:for-each>

			<!-- The question text in a "list" -->
			<fo:block xsl:use-attribute-sets="questionTextContainer">

				<!-- If there is a skip to this question, then the font should be bigger -->
				<fo:list-block provisional-label-separation="2mm" provisional-distance-between-starts="11mm">
					<fo:list-item>
						<fo:list-item-label end-indent="label-end()">
						
							<!-- This is an option not to display the section number-->
							<xsl:if test="$show_section_number='true'">
								<fo:block xsl:use-attribute-sets="questionNumberFont">
									<xsl:if test="$show_question_letter='true'">
										<xsl:number count="section" level="any" format="A"/>
									</xsl:if>
									<xsl:number count="question" level="single" format="1. "/>
								</fo:block>
							</xsl:if>
							
						</fo:list-item-label>



							<fo:list-item-body start-indent="body-start()" end-indent="45mm">
								<xsl:for-each select="text">
									<fo:block xsl:use-attribute-sets="questionFont">
										<xsl:value-of select="."/>

										<xsl:if test="position() = last()">
											<xsl:apply-templates select="../qualifier"/>									
										</xsl:if>
									</fo:block>
								</xsl:for-each>
								
								
								<!-- If there is a specifier -->
								<xsl:apply-templates select="specifier"/>

							</fo:list-item-body>



						

					</fo:list-item>
				</fo:list-block>
			</fo:block>

			
			
			<!-- If there is a during directive -->
			<xsl:for-each select="directive[position = 'during' and administration = 'self']">
				<fo:block xsl:use-attribute-sets="directive_duringFont">
					<xsl:choose>
						<xsl:when test="$show_information_symbol='true'">
							<xsl:apply-templates select="text" mode="information_symbol"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="text"/>
						</xsl:otherwise>
					</xsl:choose>

				</fo:block>
			</xsl:for-each>
			
			<!-- The response choices - matrix, fixed or free -->
			<xsl:choose>
				<xsl:when test="count(subQuestion)>=1 and count(response/fixed)>=1">
					<!-- matrix -->
					<xsl:choose>
						<xsl:when test="response/fixed/@rotate='true'">
							<xsl:call-template name="matrixRotate"/>
						</xsl:when>
						<xsl:when test="count(response/fixed/category)>=15">
							<xsl:call-template name="matrixRotate"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="matrix"/>					
						</xsl:otherwise>
					</xsl:choose>
	
				</xsl:when>
				
				<xsl:when test="count(subQuestion)>=1 and count(response/free)>=1">
					<!-- matrix of free -->
					<xsl:call-template name="matrixFree"/>
				</xsl:when>

				<xsl:when test="count(subQuestion)>=1 and count(response/vas)>=1">
					<!-- matrix of VAS -->
					<xsl:call-template name="matrixvas"/>
				</xsl:when>



				<xsl:when test="count(subQuestion)=0">
					<!-- non matrix - apply normal response template -->
					<xsl:apply-templates select="response"/>
				</xsl:when>
			</xsl:choose>
			<!-- If there is an after directive -->
			<xsl:for-each select="directive[position = 'after' and administration = 'self']">
				<fo:block xsl:use-attribute-sets="directive_afterFont">
					<xsl:choose>
						<xsl:when test="$show_information_symbol='true'">
							<xsl:apply-templates select="text" mode="information_symbol"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="text"/>
						</xsl:otherwise>
					</xsl:choose>

				</fo:block>
			</xsl:for-each>

			
		</fo:block-container>
		
	</xsl:template>

	<!-- Handles responses -->
	<xsl:template match="/questionnaire/section/question/response">
		<!-- apply either the free or fixed response template -->

		<xsl:choose>
			<xsl:when test="$show_variables = 'true'">

				<fo:block-container xsl:use-attribute-sets="responseContainer"
												border="solid"
												border-width="1mm">

					<fo:block>
						<xsl:value-of select="@varName"/>
					</fo:block>

					<xsl:choose>
						<xsl:when test="count(free)=1">
							<xsl:apply-templates select="free"/>
						</xsl:when>
						<xsl:when test="count(fixed)=1">
							<xsl:apply-templates select="fixed"/>
						</xsl:when>
		
					</xsl:choose>
		
				</fo:block-container>
						
			</xsl:when>
			
			<xsl:otherwise>
				<fo:block-container xsl:use-attribute-sets="responseContainer">

					<xsl:choose>
						<xsl:when test="count(free)=1">
							<xsl:apply-templates select="free"/>
						</xsl:when>
						<xsl:when test="count(fixed)=1">
							<xsl:apply-templates select="fixed"/>
						</xsl:when>
						<xsl:when test="count(vas)=1">
							<xsl:apply-templates select="vas"/>
						</xsl:when>
						<xsl:when test="count(dvas)=1">
							<xsl:apply-templates select="dvas"/>
						</xsl:when>


					</xsl:choose>
		
				</fo:block-container>
						
			</xsl:otherwise>
			
			
		</xsl:choose>
		
				
	</xsl:template>



	<!-- Handle fixed responses that are not rotated-->
	<xsl:template match="/questionnaire/section/question/response/fixed[@rotate = 'false' or not(@rotate)]">
		<!-- Draw a vertical table of category labels and response boxes -->

		<fo:table inline-progression-dimension="100%" table-layout="fixed"  width="100%">

			<xsl:choose>
				<xsl:when test="$leftalign = 'false'">
					<fo:table-column column-width="proportional-column-width(1)"/> <!-- for the text -->
					<fo:table-column xsl:use-attribute-sets="fixedResponseColumn"/> <!-- for the response boxes -->
					<fo:table-column xsl:use-attribute-sets="skipColumn"/> <!-- for the empty space after -->

				</xsl:when>
				<xsl:otherwise>
					<fo:table-column xsl:use-attribute-sets="skipColumn"/> 
					<fo:table-column xsl:use-attribute-sets="fixedResponseColumn"/>
					<fo:table-column column-width="proportional-column-width(1)"/> <!-- for the text -->
				</xsl:otherwise>
			</xsl:choose>

			
			<fo:table-body>
				<xsl:for-each select="category">
					<fo:table-row xsl:use-attribute-sets="tableRow">


					<xsl:choose>
						<xsl:when test="$leftalign = 'false'">
							<fo:table-cell padding="0">
								<fo:block-container xsl:use-attribute-sets="category_labelContainer">
									<xsl:apply-templates select="image"/>
									<fo:block xsl:use-attribute-sets="category_labelFont">
										<xsl:value-of select="label"/>
									</fo:block>
								</fo:block-container>
							</fo:table-cell>
						</xsl:when>
						<xsl:otherwise>
							<!-- If there is a question to skip to -->
							<xsl:choose>
								<xsl:when test="count(skipTo)=1">
									<fo:table-cell>
										<xsl:call-template name="drawSkipTo">
											<xsl:with-param name="variableName" select="skipTo"/>
										</xsl:call-template>
									</fo:table-cell>
								</xsl:when>
								<xsl:otherwise>
									<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>


						
						
						<fo:table-cell padding="0">
							<fo:block-container xsl:use-attribute-sets="category_boxContainer">
								<fo:block>
									<xsl:choose>
										<xsl:when test="(position()=1 and position()=last()) and (count(contingentQuestion)=1)">
											<xsl:call-template name="drawboxarrowbottom"/>
										</xsl:when>										
										<xsl:when test="position()=1 and position()=last()">
											<xsl:call-template name="drawbox"/>
										</xsl:when>
										<xsl:when test="position()=1">
											<xsl:call-template name="drawboxlinebottom"/>
										</xsl:when>
										<xsl:when test="(position()=last()) and (count(contingentQuestion)=1)">
											<xsl:call-template name="drawboxlinetoparrowbottom"/>
										</xsl:when>
										<xsl:when test="position()=last()">
											<xsl:call-template name="drawboxlinetop"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="drawboxlinevertical"/>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:block-container>
						</fo:table-cell>


					<xsl:choose>
						<xsl:when test="$leftalign = 'false'">
							<!-- If there is a question to skip to -->
							<xsl:choose>
								<xsl:when test="count(skipTo)=1">
									<fo:table-cell>
										<xsl:call-template name="drawSkipTo">
											<xsl:with-param name="variableName" select="skipTo"/>
										</xsl:call-template>
									</fo:table-cell>
								</xsl:when>
								<xsl:otherwise>
									<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<fo:table-cell padding="0">
								<fo:block-container xsl:use-attribute-sets="category_labelContainer">
									<xsl:apply-templates select="image"/>
									<fo:block xsl:use-attribute-sets="category_labelFont">
										<xsl:value-of select="label"/>
									</fo:block>
								</fo:block-container>
							</fo:table-cell>
						</xsl:otherwise>
					</xsl:choose>

						

				
					</fo:table-row>
				</xsl:for-each>
			</fo:table-body>
		</fo:table>

		<!-- Check for contingent questions -->
		<xsl:apply-templates select="category/contingentQuestion"/>

	</xsl:template>





	<!-- Handle fixed responses that ARE rotated-->
	<xsl:template match="/questionnaire/section/question/response/fixed[@rotate = 'true']">
		<!-- Draw a HORIZONTAL table of category labels and response boxes -->

		<fo:table inline-progression-dimension="100%" table-layout="fixed" table-omit-header-at-break="false"  width="100%">

			<xsl:choose>
				<xsl:when test="$leftalign = 'false'">
					<fo:table-column column-width="proportional-column-width(1)"/> <!-- the empty cell -->
					<xsl:choose>
						<xsl:when test="count(category)>10">
		
							<xsl:for-each select="category">	
								<fo:table-column column-width="11mm"/>
							</xsl:for-each>	
							<fo:table-column xsl:use-attribute-sets="skipColumn"/> <!-- The empty space cell for skips -->

							
						</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="category">	
								<fo:table-column xsl:use-attribute-sets="matrixResponseColumn"/>
							</xsl:for-each>	
							<fo:table-column xsl:use-attribute-sets="matrixSkipColumn"/> <!-- The empty space cell for skips -->

							
						</xsl:otherwise>
					</xsl:choose>
					

				</xsl:when>
				<xsl:otherwise>
					<fo:table-column xsl:use-attribute-sets="matrixSkipColumn"/> <!-- The empty space cell for skips -->
					<xsl:for-each select="category">	
						<fo:table-column xsl:use-attribute-sets="matrixResponseColumn"/>
					</xsl:for-each>	
					<fo:table-column column-width="proportional-column-width(1)"/> <!-- the empty cell -->
				</xsl:otherwise>
			</xsl:choose>

			
			
			<fo:table-header>
				<fo:table-row>

				<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell> <!-- the empty corner cell -->
				

				
				<!-- draw in the category labels -->
				<xsl:for-each select="category">
					<fo:table-cell>
						<fo:block-container xsl:use-attribute-sets="labelContainer">
								<xsl:apply-templates select="image"/>
							<fo:block xsl:use-attribute-sets="labelFont">
								<xsl:value-of select="label"/>
								
							</fo:block>
						</fo:block-container>
					</fo:table-cell>
				</xsl:for-each>


				<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell> <!-- the empty corner cell -->

				
				</fo:table-row>
			</fo:table-header>
	
			<fo:table-body>
	
			<!-- Now draw the response boxes-->
			<fo:table-row xsl:use-attribute-sets="tableRow">

				<xsl:choose>
				<xsl:when test="$leftalign = 'false'">
					<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
				</xsl:when>
				<xsl:otherwise>
				<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
				</xsl:otherwise>
				</xsl:choose>

				

				<!-- When there is only one category - no lines are needed -->
				<xsl:choose>
					<xsl:when test="count(category)=1">
					
					<!-- Draw the response boxes -->
					<xsl:for-each select="category">
						<fo:table-cell>
							<fo:block xsl:use-attribute-sets="subquestionboxContainer">
									<xsl:call-template name="drawbox"/>
								</fo:block>
							</fo:table-cell>
						</xsl:for-each>
						
					</xsl:when>


					<xsl:when test="count(category)>10">

						<!-- Draw the response boxes -->
						<xsl:for-each select="category">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="subquestionboxContainer">
									<xsl:choose>
										<xsl:when test="position()=1">
											<xsl:call-template name="drawboxlineaftershort"/>
										</xsl:when>
										<!--<xsl:when test="(position()=last()) and (count(contingentQuestion)=1)">
											<xsl:call-template name="drawboxarrowbottom"/>
										</xsl:when>-->
										<xsl:when test="position()=last()">
											<xsl:call-template name="drawboxlinebeforeshort"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="drawboxlineshort"/>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</xsl:for-each>

						


					</xsl:when>

						
					<xsl:otherwise>

						<!-- Draw the response boxes -->
						<xsl:for-each select="category">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="subquestionboxContainer">
									<xsl:choose>
										<xsl:when test="position()=1">
											<xsl:call-template name="drawboxlineafter"/>
										</xsl:when>
										<!--<xsl:when test="(position()=last()) and (count(contingentQuestion)=1)">
											<xsl:call-template name="drawboxarrowbottom"/>
										</xsl:when>-->
										<xsl:when test="position()=last()">
											<xsl:call-template name="drawboxlinebefore"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="drawboxline"/>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</xsl:for-each>

						</xsl:otherwise>
					</xsl:choose>


				<xsl:choose>
				<xsl:when test="$leftalign = 'false'">
				<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
				</xsl:choose>


					
					
				</fo:table-row>
		
		</fo:table-body>
		</fo:table>

	</xsl:template>




	
	<!-- Loop template (recursive loop) for free response length -->
	<xsl:template name="drawFreeResponseLoop">
		 <xsl:param name="repeat">0</xsl:param>
		 <xsl:param name="last">0</xsl:param>
		 <xsl:param name="format">none</xsl:param>
		 <xsl:if test="number($repeat) >= 1">
			
			<!-- Draw a delimiter box in a table cell -->
			<fo:table-cell >
				<fo:block xsl:use-attribute-sets="category_labelContainer">

					<!-- If this is the first ...etc-->
					
					<xsl:choose>
						<xsl:when test="$repeat=$last and $repeat = 1">
							<xsl:call-template name="drawDelimiterSingle"/>
						</xsl:when>
						<xsl:when test="$repeat=1">
							<xsl:call-template name="drawDelimiterAfter"/>							
						</xsl:when>
						<xsl:when test="$repeat=$last">
							<xsl:call-template name="drawDelimiterBefore"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="$format = 'currency' and (($repeat mod 3) = 0)">
									<xsl:call-template name="drawDelimiterMiddleComma"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="drawDelimiterMiddle"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</fo:block>
			</fo:table-cell>			
			
			<xsl:call-template name="drawFreeResponseLoop">
			   <xsl:with-param name="repeat" select="$repeat - 1"/>
			   <xsl:with-param name="last" select="$last"/>
			   <xsl:with-param name="format" select="$format"/>
			 </xsl:call-template>
		 </xsl:if>
	</xsl:template>

	<!-- Loop template (recursive loop) for free response length -->
	<xsl:template name="defineFreeResponseLoop">
		 <xsl:param name="repeat">0</xsl:param>
		 <xsl:if test="number($repeat) >= 1">
			<xsl:call-template name="defineFreeResponseColumn"/>
			<xsl:call-template name="defineFreeResponseLoop">
			   <xsl:with-param name="repeat" select="$repeat - 1"/>
			 </xsl:call-template>
		 </xsl:if>
	</xsl:template>


	<!-- Loop template (recursive loop) for each row -->
	<xsl:template name="freeResponseRowLoop">
		 <xsl:param name="repeat">0</xsl:param>
		 <xsl:param name="lastrow">0</xsl:param>
		 <xsl:param name="matrix">0</xsl:param>
		 <xsl:param name="format">none</xsl:param>
		 
		 <xsl:if test="number($repeat) >= 1">
			<xsl:choose>
				<xsl:when test="($repeat = 1) and ($lastrow > 0)">
					<xsl:call-template name="defineFreeResponseRow">
						<xsl:with-param name="num">
							<xsl:value-of select="$lastrow"/>
						</xsl:with-param>
						<xsl:with-param name="matrix" select="$matrix"/>
						<xsl:with-param name="format" select="$format"/>
					</xsl:call-template>					
				</xsl:when>
				<xsl:when test="$repeat > 1">
					<xsl:call-template name="defineFreeResponseRow">
						<xsl:with-param name="num">
							<xsl:value-of select="$delimiterMaxPerRow"/>
						</xsl:with-param>
						<xsl:with-param name="matrix" select="$matrix"/>
						<xsl:with-param name="format" select="$format"/>
					</xsl:call-template>									
				</xsl:when>
			</xsl:choose>

				
			<xsl:call-template name="freeResponseRowLoop">
			   <xsl:with-param name="repeat" select="$repeat - 1"/>
			   <xsl:with-param name="lastrow" select="$lastrow"/>
   			   <xsl:with-param name="matrix" select="$matrix"/>
   			   <xsl:with-param name="format" select="$format"/>
			 </xsl:call-template>
		 </xsl:if>
	</xsl:template>


	<!-- Creates a new row for each line -->
	<xsl:template name="defineFreeResponseRow">
		<xsl:param name="num">0</xsl:param>
		<xsl:param name="matrix">0</xsl:param>
		<xsl:param name="format">none</xsl:param>
		
		<fo:table-row>

			
			<!-- If this is a matrix question - draw the subquestion else show the subquestion -->
			<xsl:choose>
				<xsl:when test="$matrix = -1"/>

				<xsl:when test="$matrix != 0 and $leftalign = 'false'">

					<fo:table-cell>
						<fo:block-container xsl:use-attribute-sets="subquestionfreeContainer">
							<fo:block xsl:use-attribute-sets="subquestionfreeFont">
								<xsl:value-of select="$matrix"/>
							</fo:block>
						</fo:block-container>
					</fo:table-cell>

				</xsl:when>

				<xsl:when test="$matrix != 0 and $leftalign = 'true'">
					<xsl:choose>
						<xsl:when test="count(../response/free/label)=1 and ((../response/free/format) != 'text')">
							<fo:table-cell>
								<xsl:apply-templates select="../response/free/label"/>			
							</fo:table-cell>
						</xsl:when>
						<xsl:otherwise>
							<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell> 
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>

				
				<xsl:when test="$format = 'currency'">
					<fo:table-cell>
						<fo:block-container xsl:use-attribute-sets="subquestionfreeContainer">
							<fo:block xsl:use-attribute-sets="subquestionfreeFont">$</fo:block>
						</fo:block-container>
					</fo:table-cell>
				</xsl:when>

						
				<xsl:otherwise>
					<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>				
				</xsl:otherwise>
				
			</xsl:choose>
			
			<xsl:call-template name="drawFreeResponseLoop">
				  <xsl:with-param name="repeat">
					  <xsl:value-of select="$num"/>
				  </xsl:with-param>
				  <xsl:with-param name="last">
					  <xsl:value-of select="$num"/>
				  </xsl:with-param>
				<xsl:with-param name="format" select="$format"/>
			</xsl:call-template> 

			<!-- Draw a label if it exists -->
			<!-- THIS WILL IGNORE SKIPS FOR FREE RESPONSES -->
			

			<xsl:choose>
				<xsl:when test="$matrix = -1"/>

				<xsl:when test="$matrix != 0 and $leftalign = 'false'">

					<xsl:choose>
						<xsl:when test="count(../response/free/label)=1 and ((../response/free/format) != 'text')">
							<fo:table-cell>
								<xsl:apply-templates select="../response/free/label"/>			
							</fo:table-cell>
						</xsl:when>
						<xsl:otherwise>
							<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell> 
						</xsl:otherwise>
					</xsl:choose>

				
				</xsl:when>

				<xsl:when test="$matrix != 0 and $leftalign = 'true'">

					<fo:table-cell>
						<fo:block-container xsl:use-attribute-sets="subquestionfreeContainer">
							<fo:block xsl:use-attribute-sets="subquestionfreeFont">
								<xsl:value-of select="$matrix"/>
							</fo:block>
						</fo:block-container>
					</fo:table-cell>

				</xsl:when>

				

				
				<xsl:otherwise>

					<xsl:choose>
						<xsl:when test="count(label)=1 and format !='text'">
							<fo:table-cell>
								<xsl:apply-templates select="label"/>			
							</fo:table-cell>
						</xsl:when>
						<xsl:otherwise>
							<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell> 
						</xsl:otherwise>
					</xsl:choose>
				
				
				</xsl:otherwise>
			</xsl:choose>

					
		</fo:table-row>
	</xsl:template>

	<!-- Draw a free response label -->
	<xsl:template match="/questionnaire/section/question/response/free/label">
		<fo:block-container xsl:use-attribute-sets="free_labelContainer">
			<fo:block xsl:use-attribute-sets="free_labelFont">
				<xsl:value-of select="."/>
			</fo:block>		
		</fo:block-container>
	</xsl:template>


	<!-- Creates a new column for each length of the response -->
	<xsl:template name="defineFreeResponseColumn">
		<fo:table-column xsl:use-attribute-sets="freeResponseColumn"/>
	</xsl:template>
	
	
		
<!-- handle contingents -->

    <xsl:template match="/questionnaire/section/question/response/fixed/category/contingentQuestion">
    
		<xsl:choose>
			<xsl:when test="$show_variables = 'true'">
					<fo:block>
						<xsl:value-of select="@varName"/>
					</fo:block>
			</xsl:when>
		</xsl:choose>	


		<!-- If it is a text free response AND there will be no space on the same line- draw the label beforehand -->
		<xsl:if test="((count(text)=1) and (length > ($delimiterMaxPerRow div 2))) or format = 'longtext'">
			<fo:block-container xsl:use-attribute-sets="freeLabelTextContainer">
				<fo:block xsl:use-attribute-sets="freeLabelTextFont">
					<xsl:value-of select="text"/>
				</fo:block>
			</fo:block-container>
		</xsl:if>


	
		<!-- Draw a horizontal table of delimiter boxes -->

		<fo:table inline-progression-dimension="100%" table-layout="fixed"  width="100%">
		
			<fo:table-column column-width="proportional-column-width(1)"/> <!-- for the empty space before -->
			

			<xsl:choose>
				<xsl:when test="format='longtext'">
						<fo:table-column column-width="145mm"/>
				</xsl:when>
				<xsl:otherwise>

			
					<xsl:call-template name="defineFreeResponseLoop">
						<xsl:with-param name="repeat">
		
						<!-- makes sure there is not more than the max per row -->
						<xsl:choose>
							<xsl:when test="length > $delimiterMaxPerRow">
								<xsl:value-of select="$delimiterMaxPerRow"/>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:value-of select="length"/>
							</xsl:otherwise>
						</xsl:choose>

						</xsl:with-param>
					</xsl:call-template> <!-- for the response boxes -->
				
				</xsl:otherwise>
			</xsl:choose>

			

			<fo:table-column xsl:use-attribute-sets="skipColumn"/> <!-- for the empty space after -->
			
			<fo:table-body>
	
	
	
						<xsl:choose>
							<xsl:when test="(count(text)=1) and not(length > ($delimiterMaxPerRow div 2)) and format != 'longtext'">
							<xsl:call-template name="freeResponseRowLoop">
								<xsl:with-param name="repeat">
									<xsl:value-of select="floor(length div $delimiterMaxPerRow)+1"/>
								</xsl:with-param>
								<xsl:with-param name="lastrow">
									<xsl:value-of select="length mod $delimiterMaxPerRow"/>
								</xsl:with-param>
								<xsl:with-param name="format">text</xsl:with-param>
								<xsl:with-param name="matrix">
									<xsl:value-of select="text"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>

						<xsl:when test="format='longtext'">
							<fo:table-row>
								<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:call-template name="drawbigbox">
											<xsl:with-param name="length" select="length"/>
										</xsl:call-template>						
									</fo:block>
								</fo:table-cell>
								<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
							</fo:table-row>
						</xsl:when>

						
						<xsl:otherwise>
						<xsl:call-template name="freeResponseRowLoop">
							<xsl:with-param name="repeat">
								<xsl:value-of select="floor(length div $delimiterMaxPerRow)+1"/>
							</xsl:with-param>
							<xsl:with-param name="lastrow">
								<xsl:value-of select="length mod $delimiterMaxPerRow"/>
							</xsl:with-param>
								<xsl:with-param name="format">text</xsl:with-param>

						</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					
			</fo:table-body>
		</fo:table>


    
    
    
    </xsl:template>		
		
								


	<!-- Handle free responses -->
	<xsl:template match="/questionnaire/section/question/response/free">
	
		<!-- If it is a text free response AND there will be no space on the same line- draw the label beforehand -->
		<xsl:if test="(format='text' and (count(label)=1) and (length > ($delimiterMaxPerRow div 2))) or (format='longtext' and count(label)=1)">
			<fo:block-container xsl:use-attribute-sets="freeLabelTextContainer">
				<fo:block xsl:use-attribute-sets="freeLabelTextFont">
					<xsl:value-of select="label"/>
				</fo:block>
			</fo:block-container>
		</xsl:if>
	
		<!-- Draw a horizontal table of delimiter boxes -->

		<fo:table inline-progression-dimension="100%" table-layout="fixed"  width="100%">
		
			<xsl:choose>
				<xsl:when test="$leftalign = 'false'">
					<fo:table-column column-width="proportional-column-width(1)"/> <!-- for the empty space before -->
				</xsl:when>
				<xsl:otherwise>
					<fo:table-column xsl:use-attribute-sets="skipColumn"/> <!-- for the empty space after -->
				</xsl:otherwise>
			</xsl:choose>
		
		
			<xsl:choose>
				<xsl:when test="format='longtext'">
						<fo:table-column column-width="145mm"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="defineFreeResponseLoop">
						<xsl:with-param name="repeat">
		
						<!-- makes sure there is not more than the max per row -->
						<xsl:choose>
							<xsl:when test="length > $delimiterMaxPerRow">
								<xsl:value-of select="$delimiterMaxPerRow"/>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:value-of select="length"/>
							</xsl:otherwise>
						</xsl:choose>

				</xsl:with-param>
			</xsl:call-template> <!-- for the response boxes -->
				
				
				</xsl:otherwise>
			</xsl:choose>
			

			<xsl:choose>
				<xsl:when test="$leftalign = 'false'">
					<fo:table-column xsl:use-attribute-sets="skipColumn"/>
				</xsl:when>
				<xsl:otherwise>
					<fo:table-column column-width="proportional-column-width(1)"/> 
				</xsl:otherwise>
			</xsl:choose>

			

			
			<fo:table-body>
	
	
	
						<xsl:choose>
							<xsl:when test="format='text' and (count(label)=1) and not(length > ($delimiterMaxPerRow div 2))">
							<xsl:call-template name="freeResponseRowLoop">
								<xsl:with-param name="repeat">
									<xsl:value-of select="floor(length div $delimiterMaxPerRow)+1"/>
								</xsl:with-param>
								<xsl:with-param name="lastrow">
									<xsl:value-of select="length mod $delimiterMaxPerRow"/>
								</xsl:with-param>
								<xsl:with-param name="format">
									<xsl:value-of select="format"/>
								</xsl:with-param>
								<xsl:with-param name="matrix">
									<xsl:value-of select="label"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>

						<xsl:when test="format='longtext'">
							<fo:table-row>
								<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:call-template name="drawbigbox">
											<xsl:with-param name="length" select="length"/>
										</xsl:call-template>						
									</fo:block>
								</fo:table-cell>
								<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
							</fo:table-row>
						</xsl:when>
	
						<xsl:otherwise>
						<xsl:call-template name="freeResponseRowLoop">
							<xsl:with-param name="repeat">
								<xsl:value-of select="floor(length div $delimiterMaxPerRow)+1"/>
							</xsl:with-param>
							<xsl:with-param name="lastrow">
								<xsl:value-of select="length mod $delimiterMaxPerRow"/>
							</xsl:with-param>
							<xsl:with-param name="format">
								<xsl:value-of select="format"/>
							</xsl:with-param>

						</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					
			</fo:table-body>
		</fo:table>



	</xsl:template>





	<!-- Handle free responses within a Free Matrix -->
	<xsl:template match="/questionnaire/section/question/response/free" mode="matrix">
	
		<!-- Draw a horizontal table of delimiter boxes -->

		<fo:table table-layout="fixed"  width="100%">
		
		
			<xsl:choose>
				<xsl:when test="format='longtext'">
						<fo:table-column column-width="145mm"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="defineFreeResponseLoop">
						<xsl:with-param name="repeat">

						<!-- makes sure there is not more than the max per row -->
						<xsl:choose>
							<xsl:when test="length > $delimiterMaxPerRow">
								<xsl:value-of select="$delimiterMaxPerRow"/>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:value-of select="length"/>
							</xsl:otherwise>
						</xsl:choose>

					</xsl:with-param>
					<xsl:with-param name="matrix">-1</xsl:with-param>
			</xsl:call-template> <!-- for the response boxes -->
				
				
				</xsl:otherwise>
			</xsl:choose>
			

			
			<fo:table-body>
	
						<xsl:call-template name="freeResponseRowLoop">
							<xsl:with-param name="repeat">
								<xsl:value-of select="floor(length div $delimiterMaxPerRow)+1"/>
							</xsl:with-param>
							<xsl:with-param name="lastrow">
								<xsl:value-of select="length mod $delimiterMaxPerRow"/>
							</xsl:with-param>
							<xsl:with-param name="format">
								<xsl:value-of select="format"/>
							</xsl:with-param>
							<xsl:with-param name="matrix">-1</xsl:with-param>

						</xsl:call-template>
					
			</fo:table-body>
		</fo:table>



	</xsl:template>





	<xsl:template match="/questionnaire/section/question/response/dvas">
		<!-- Draw a Discrete Visual Analog scale -->


		<fo:table inline-progression-dimension="100%" table-layout="fixed" table-omit-header-at-break="false"  width="100%">
			<fo:table-column column-width="proportional-column-width(1)"/> <!-- the leftlabel cell -->
			<xsl:for-each select="category">
				<fo:table-column xsl:use-attribute-sets="matrixResponseColumn"/>
			</xsl:for-each>
			<fo:table-column column-width="proportional-column-width(1)"/> <!-- the rightlabel cell -->
			<fo:table-column xsl:use-attribute-sets="matrixSkipColumn"/> <!-- The empty space cell for skips -->
						

			<fo:table-header>
				<fo:table-row>
				<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
	
				<!-- draw in the category labels -->
				<xsl:for-each select="category">				

					<fo:table-cell>
						<fo:block-container xsl:use-attribute-sets="labelContainer">
								<xsl:apply-templates select="image"/>
							<fo:block xsl:use-attribute-sets="labelFont">
								<xsl:value-of select="label"/>
							</fo:block>
						</fo:block-container>
					</fo:table-cell>
					
				</xsl:for-each>

				<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
			</fo:table-row>
			</fo:table-header>

			<fo:table-body>

			<!-- Now draw the subquestions -->
			<fo:table-row xsl:use-attribute-sets="tableRow">
				<fo:table-cell>
					<fo:block-container xsl:use-attribute-sets="subquestionContainer">
						<fo:block xsl:use-attribute-sets="subquestionFont">
							<xsl:value-of select="labelleft"/>
						</fo:block>
					</fo:block-container>
				</fo:table-cell>
					<!-- When there is only one category - no lines are needed -->
				<xsl:choose>
					<xsl:when test="count(category)=1">
					
					<!-- Draw the response boxes -->
					<xsl:for-each select="category">
						<fo:table-cell>
							<fo:block xsl:use-attribute-sets="subquestionboxContainer">
								<xsl:call-template name="drawbox"/>
							</fo:block>
						</fo:table-cell>
					</xsl:for-each>
	
					<xsl:if test="position() != last()">
						<!-- here goes the blank between a double matrix question -->
					<fo:table-cell>
						<fo:block xsl:use-attribute-sets="subquestionboxContainer">
						</fo:block>
					</fo:table-cell>
					</xsl:if>
									
				
					</xsl:when>
					<xsl:otherwise>
						<!-- Draw the response boxes -->
					<xsl:for-each select="category">
						<fo:table-cell>
							<fo:block xsl:use-attribute-sets="subquestionboxContainer">
								<xsl:choose>
									<xsl:when test="position()=1">
										<xsl:call-template name="drawboxlineafter"/>
									</xsl:when>
									<xsl:when test="position()=last()">
										<xsl:call-template name="drawboxlinebefore"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="drawboxline"/>
									</xsl:otherwise>
								</xsl:choose>
							</fo:block>
						</fo:table-cell>
					</xsl:for-each>
				
					</xsl:otherwise>
				</xsl:choose>
					<fo:table-cell>
					<fo:block-container xsl:use-attribute-sets="subquestionContainer">
						<fo:block xsl:use-attribute-sets="subquestionFont" text-align="left">
							<xsl:value-of select="labelright"/>
						</fo:block>
					</fo:block-container>
				</fo:table-cell>
					<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
				
				
			</fo:table-row>

		</fo:table-body>
		</fo:table>



	</xsl:template>






	<!-- VAS questions -->

	<xsl:template match="/questionnaire/section/question/response/vas">
	
	
		<!-- Draw a horizontal table of delimiter boxes -->

		<fo:table inline-progression-dimension="100%" table-layout="fixed"  width="100%">
		
			<xsl:choose>
				<xsl:when test="$leftalign = 'false'">
					<fo:table-column column-width="proportional-column-width(1)"/> <!-- for the empty space before -->
				</xsl:when>
				<xsl:otherwise>
					<fo:table-column xsl:use-attribute-sets="skipColumn"/> <!-- for the empty space after -->
				</xsl:otherwise>
			</xsl:choose>
		
		
			<!-- define columns text line text -->
			<fo:table-column column-width="20mm"/>
			<fo:table-column column-width="85mm"/>
			<fo:table-column column-width="20mm"/>
			
			<xsl:choose>
				<xsl:when test="$leftalign = 'false'">
					<fo:table-column xsl:use-attribute-sets="skipColumn"/>
				</xsl:when>
				<xsl:otherwise>
					<fo:table-column column-width="proportional-column-width(1)"/> 
				</xsl:otherwise>
			</xsl:choose>


			
			<fo:table-body>


					<fo:table-row>
						<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
						<fo:table-cell>
							<fo:block xsl:use-attribute-sets="category_labelFont">
								<xsl:value-of select="labelleft"/>
							</fo:block>
						</fo:table-cell>

						<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>


						<fo:table-cell>
							<fo:block xsl:use-attribute-sets="category_labelFont">
								<xsl:value-of select="labelright"/>
							</fo:block>
						</fo:table-cell>

						<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
					</fo:table-row>


					<fo:table-row>
						<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
						<fo:table-cell number-columns-spanned="3" text-align="center">
							<fo:block>
								<xsl:call-template name="drawvasline"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
					</fo:table-row>
					
			</fo:table-body>
		</fo:table>



	</xsl:template>













	<!-- Handles free matrix questions -->
	<xsl:template name="matrixFree">
		<!-- on the question level -->
		<!-- Draw the matrix table -->
		
		<!-- Draw a horizontal table of delimiter boxes -->

		<xsl:for-each select="subQuestion">

		<xsl:choose>
			<xsl:when test="$show_variables = 'true'">
					<fo:block>
						<xsl:value-of select="@varName"/>
					</fo:block>
			</xsl:when>
		</xsl:choose>	
		
		<fo:table inline-progression-dimension="100%" table-layout="fixed"  width="100%">
		
			<xsl:choose>
				<xsl:when test="$leftalign = 'false'">
					<fo:table-column column-width="proportional-column-width(1)"/> <!-- for the empty space before -->
				</xsl:when>
				<xsl:otherwise>
					<fo:table-column xsl:use-attribute-sets="skipColumn"/> <!-- for the empty space after -->
				</xsl:otherwise>
			</xsl:choose>

			<xsl:for-each select="../response/free">
				<!-- column width = 6mm * number of boxes -->
				<fo:table-column column-width="6mm"/>
				<fo:table-column>
					<xsl:attribute name="column-width"><xsl:call-template name="multiply"><xsl:with-param name="x">6mm</xsl:with-param><xsl:with-param name="y"><xsl:value-of select="length"/></xsl:with-param></xsl:call-template></xsl:attribute>
				</fo:table-column>

			</xsl:for-each>

			<xsl:choose>
				<xsl:when test="$leftalign = 'false'">
					<fo:table-column xsl:use-attribute-sets="skipColumn"/> <!-- for the empty space after -->
				</xsl:when>
				<xsl:otherwise>
					<fo:table-column column-width="proportional-column-width(1)"/> <!-- for the empty space before -->

				</xsl:otherwise>
			</xsl:choose>


			<xsl:if test="position() = 1">
			<fo:table-header>
				<fo:table-row>
			
					<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>


					<xsl:for-each select="../response/free">
							<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
							<fo:table-cell>
								<fo:block-container xsl:use-attribute-sets="category_labelContainer">
							<fo:block xsl:use-attribute-sets="category_labelFont">
								<xsl:value-of select="label"/>
							</fo:block>
							</fo:block-container>
						</fo:table-cell>

						</xsl:for-each>

						<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>

				
			</fo:table-row>
			</fo:table-header>
			</xsl:if>

			
			<fo:table-body>

				<fo:table-row>

				<fo:table-cell>
						<fo:block-container xsl:use-attribute-sets="subquestionContainer">
							<fo:block xsl:use-attribute-sets="subquestionFont">
								<xsl:value-of select="text"/>
							</fo:block>
							</fo:block-container>
				</fo:table-cell>
			
				<xsl:for-each select="../response/free">
					<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
					<fo:table-cell>

					<xsl:apply-templates select="." mode="matrix"/>
					</fo:table-cell>
				
				</xsl:for-each>
			

					<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
			</fo:table-row>

			</fo:table-body>
		</fo:table>
		</xsl:for-each>
		
	</xsl:template>





	<!-- Handles matrix VAS questions -->
	<xsl:template name="matrixvas">
		<!-- on the question level -->
		<!-- Draw the matrix table -->
		
		
		<fo:table inline-progression-dimension="100%" table-layout="fixed" table-omit-header-at-break="false"  width="100%">
			<fo:table-column column-width="proportional-column-width(1)"/> <!-- the text cell -->

			<fo:table-column column-width="20mm"/>
			<fo:table-column column-width="85mm"/>
			<fo:table-column column-width="20mm"/>

			<fo:table-column xsl:use-attribute-sets="matrixSkipColumn"/> <!-- The empty space cell for skips -->
			
			

			<fo:table-header>
				<fo:table-row>
			
					<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
						<fo:table-cell>
							<fo:block xsl:use-attribute-sets="category_labelFont">
								<xsl:value-of select="response/vas/labelleft"/>
							</fo:block>
						</fo:table-cell>

						<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>


						<fo:table-cell>
							<fo:block xsl:use-attribute-sets="category_labelFont">
								<xsl:value-of select="response/vas/labelright"/>
							</fo:block>
						</fo:table-cell>

						<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
		
				
			</fo:table-row>
			</fo:table-header>

			<fo:table-body>

			<!-- Now draw the subquestions -->
			<xsl:for-each select="subQuestion">

				<fo:table-row xsl:use-attribute-sets="tableRow">
					<fo:table-cell>
						<fo:block-container xsl:use-attribute-sets="subquestionContainer">

							<fo:block xsl:use-attribute-sets="subquestionFont">
								<xsl:value-of select="text"/>
							</fo:block>
							
							<!-- When variables are to be shown -->
							<xsl:choose>
								<xsl:when test="$show_variables = 'true'">
										<fo:block>
											<xsl:value-of select="@varName"/>
										</fo:block>
								</xsl:when>
							</xsl:choose>	

						</fo:block-container>
					</fo:table-cell>


					<fo:table-cell number-columns-spanned="3" text-align="center">
						<fo:block>
							<xsl:call-template name="drawvasline"/>
						</fo:block>
					</fo:table-cell>
						

					<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
					
					
				</fo:table-row>
	
			</xsl:for-each>
			
		</fo:table-body>
		</fo:table>
		
	</xsl:template>




	<!-- Handles matrix questions -->
	<xsl:template name="matrix">
		<!-- on the question level -->
		<!-- Draw the matrix table -->
		
		

		<fo:table inline-progression-dimension="100%" table-layout="fixed" table-omit-header-at-break="false"  width="100%">
			<fo:table-column column-width="proportional-column-width(1)"/> <!-- the text cell -->
			<xsl:for-each select="response">
				<xsl:for-each select="fixed/category">
					<fo:table-column xsl:use-attribute-sets="matrixResponseColumn"/>
				</xsl:for-each>
				<xsl:if test="position() != last()"><fo:table-column xsl:use-attribute-sets="matrixResponseColumn"/></xsl:if>
			</xsl:for-each>
			<fo:table-column xsl:use-attribute-sets="matrixSkipColumn"/> <!-- The empty space cell for skips -->
			
			

			<fo:table-header>
				<fo:table-row>
				<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
	
				<!-- draw in the category labels -->
				<xsl:for-each select="response">
					<xsl:for-each select="fixed/category">				

					<fo:table-cell>
						<fo:block-container xsl:use-attribute-sets="labelContainer">
								<xsl:apply-templates select="image"/>
							<fo:block xsl:use-attribute-sets="labelFont">
								<xsl:value-of select="label"/>
							</fo:block>
						</fo:block-container>
					</fo:table-cell>
					
					</xsl:for-each>

					<xsl:if test="position() != last()">
						<!-- here goes the blank between a double matrix question -->
					<fo:table-cell>
						<fo:block-container xsl:use-attribute-sets="labelContainer">
							<fo:block xsl:use-attribute-sets="labelFont">
								<xsl:value-of select="label"/>
							</fo:block>
						</fo:block-container>
					</fo:table-cell>
					</xsl:if>				
				</xsl:for-each>
				
			</fo:table-row>
			</fo:table-header>

			<fo:table-body>

			<!-- Now draw the subquestions -->
			<xsl:for-each select="subQuestion">

				<fo:table-row xsl:use-attribute-sets="tableRow">
					<fo:table-cell>
						<fo:block-container xsl:use-attribute-sets="subquestionContainer">
							<fo:block xsl:use-attribute-sets="subquestionFont">
								<xsl:value-of select="text"/>
							</fo:block>
							
							<!-- When variables are to be shown -->
							<xsl:choose>
								<xsl:when test="$show_variables = 'true'">
										<fo:block>
											<xsl:value-of select="@varName"/>
										</fo:block>
								</xsl:when>
							</xsl:choose>	

						</fo:block-container>
					</fo:table-cell>

					<!-- When there is only one category - no lines are needed -->
					<xsl:choose>
						<xsl:when test="count(../response/fixed/category)=1">
						
						<!-- Draw the response boxes -->
						<xsl:for-each select="../response">

							<xsl:for-each select="fixed/category">
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="subquestionboxContainer">
										<xsl:call-template name="drawbox"/>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
			
							<xsl:if test="position() != last()">
								<!-- here goes the blank between a double matrix question -->
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="subquestionboxContainer">
								</fo:block>
							</fo:table-cell>
							</xsl:if>
											
						</xsl:for-each>
						
						</xsl:when>
						<xsl:otherwise>

						<!-- Draw the response boxes -->
						<xsl:for-each select="../response">

							<xsl:for-each select="fixed/category">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="subquestionboxContainer">
									<xsl:choose>
										<xsl:when test="position()=1">
											<xsl:call-template name="drawboxlineafter"/>
										</xsl:when>
										<xsl:when test="position()=last()">
											<xsl:call-template name="drawboxlinebefore"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="drawboxline"/>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</xsl:for-each>

						<xsl:if test="position() != last()">
						<!-- here goes the blank between a double matrix question -->
						<fo:table-cell>
								<fo:block xsl:use-attribute-sets="subquestionboxContainer">
								</fo:block>
							</fo:table-cell>
						</xsl:if>	

						</xsl:for-each>

						</xsl:otherwise>
					</xsl:choose>
					
					<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
					
					
				</fo:table-row>
	
			</xsl:for-each>
			
		</fo:table-body>
		</fo:table>
		
	</xsl:template>




	<!-- Handles rotated matrix questions -->
	<xsl:template name="matrixRotate">
		<!-- on the question level -->
		<!-- Draw the matrix table -->
		

		

		<fo:table inline-progression-dimension="100%" table-layout="fixed" table-omit-header-at-break="false" width="100%">
			<fo:table-column column-width="proportional-column-width(1)"/> <!-- the text cell -->
			<xsl:for-each select="subQuestion">
				<fo:table-column xsl:use-attribute-sets="matrixResponseColumn"/>
			</xsl:for-each>
			<fo:table-column xsl:use-attribute-sets="matrixSkipColumn"/> <!-- The empty space cell for skips -->
			
			

			<fo:table-header>
				<fo:table-row>
				<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
	
				<!-- draw in the subquestion texts -->
				<xsl:for-each select="subQuestion">
					<fo:table-cell>
						<fo:block-container xsl:use-attribute-sets="labelContainer">
							<fo:block xsl:use-attribute-sets="labelFont">
								<xsl:value-of select="text"/>
							</fo:block>

							<!-- When variables are to be shown -->
							<xsl:choose>
								<xsl:when test="$show_variables = 'true'">
										<fo:block>
											<xsl:value-of select="@varName"/>
										</fo:block>
								</xsl:when>
							</xsl:choose>	
						
						</fo:block-container>
					</fo:table-cell>
				</xsl:for-each>
			</fo:table-row>
			</fo:table-header>		

			<fo:table-body>

			<!-- if there is a free response, squeeze it in -->
			<xsl:for-each select="response/free">	
				<fo:table-row xsl:use-attribute-sets="tableRow">
					
					<fo:table-cell>
						<fo:block-container xsl:use-attribute-sets="subquestionContainer">
							<fo:block xsl:use-attribute-sets="subquestionFont" margin-right="0mm">
								<xsl:value-of select="label"/>
							</fo:block>
						</fo:block-container>
					</fo:table-cell>
					<xsl:for-each select="../../subQuestion">
							<fo:table-cell>
							<fo:block-container xsl:use-attribute-sets="category_boxContainer">
								<fo:block>
									<!-- draw free box -->
									<xsl:choose>
									<xsl:when test="$show_variables = 'true'">
										<fo:block>
											<xsl:value-of select="@varName"/>
										</fo:block>
									</xsl:when>	
									</xsl:choose>	
		
									<fo:table inline-progression-dimension="100%" table-layout="fixed"  width="100%">
		
									<xsl:choose>
									<xsl:when test="$leftalign = 'false'">
										<fo:table-column column-width="proportional-column-width(1)"/> <!-- for the empty space before -->
									</xsl:when>
									<xsl:otherwise>
										<fo:table-column xsl:use-attribute-sets="skipColumn"/> <!-- for the empty space after -->
									</xsl:otherwise>
									</xsl:choose>
			
									<xsl:call-template name="defineFreeResponseLoop">
									<xsl:with-param name="repeat">
				
									<!-- makes sure there is not more than the max per row -->
									<xsl:choose>
									<xsl:when test="../response/free/length > $delimiterMaxPerRow">
						<xsl:value-of select="$delimiterMaxPerRow"/>
					</xsl:when>
					<xsl:otherwise>
					  <xsl:value-of select="../response/free/length"/>
					</xsl:otherwise>
				</xsl:choose>

				</xsl:with-param>
						</xsl:call-template> <!-- for the response boxes -->
	
					<xsl:choose>
						<xsl:when test="$leftalign = 'false'">
								<fo:table-column column-width="proportional-column-width(1)"/> <!-- for the empty space after -->
						</xsl:when>
							<xsl:otherwise>
								<fo:table-column column-width="proportional-column-width(1)"/> <!-- for the empty space before -->
			
							</xsl:otherwise>
						</xsl:choose>

					
									
									<fo:table-body>
								
											<xsl:call-template name="freeResponseRowLoop">
													<xsl:with-param name="repeat">
														<xsl:value-of select="floor(../response/free/length div $delimiterMaxPerRow)+1"/>
													</xsl:with-param>
													<xsl:with-param name="lastrow">
														<xsl:value-of select="../response/free/length mod $delimiterMaxPerRow"/>
													</xsl:with-param>
												</xsl:call-template>
												
								</fo:table-body>
								</fo:table>
									
								</fo:block>
							</fo:block-container>
							</fo:table-cell>
						</xsl:for-each>
						
					<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
				
				</fo:table-row>
			</xsl:for-each>


				
			<!-- Now draw the labels -->
			<xsl:for-each select="response/fixed/category">

				<fo:table-row xsl:use-attribute-sets="tableRow">
					<fo:table-cell>
						<fo:block-container xsl:use-attribute-sets="subquestionContainer">
								<xsl:apply-templates select="image"/>
							<fo:block xsl:use-attribute-sets="subquestionFont">
								<xsl:value-of select="label"/>
							</fo:block>
						</fo:block-container>
					</fo:table-cell>

					<xsl:variable name="pos"><xsl:value-of select="position()"/></xsl:variable>
					<xsl:variable name="las"><xsl:value-of select="last()"/></xsl:variable>

					<!-- When there is only one subquestion - no lines are needed -->

						<!-- Draw the response boxes -->
						<!-- These must be rotated also -->
						<xsl:for-each select="../../../subQuestion">
							<fo:table-cell>
							<fo:block-container xsl:use-attribute-sets="category_boxContainer">
								<fo:block>
									<xsl:choose>
										<xsl:when test="$pos=1 and $pos=$las">
											<xsl:call-template name="drawbox"/>
										</xsl:when>
										<xsl:when test="$pos=1">
											<xsl:call-template name="drawboxlinebottom"/>
										</xsl:when>
										<xsl:when test="$pos=$las">
											<xsl:call-template name="drawboxlinetop"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="drawboxlinevertical"/>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:block-container>
							</fo:table-cell>
						</xsl:for-each>
						
					<fo:table-cell><fo:block>&#xA0;</fo:block></fo:table-cell>
				
				</fo:table-row>
	
			</xsl:for-each>
			
		</fo:table-body>
		</fo:table>
		
	</xsl:template>




	<!-- Handles subQuestions -->
	<xsl:template match="/questionnaire/section/question/subQuestion">
	
	
	</xsl:template>

	<!-- Draws the section information -->
	<xsl:template name="sectionInfoBefore">
		<fo:block-container xsl:use-attribute-sets="section_info_beforeContainer">
			<fo:block xsl:use-attribute-sets="section_info_beforeFont">
				<xsl:value-of select="text"/>
			</fo:block>
		</fo:block-container>
	</xsl:template>
	
	<xsl:template name="sectionInfoDuring">
		<fo:block-container xsl:use-attribute-sets="section_info_duringContainer">
			<fo:block xsl:use-attribute-sets="section_info_duringFont">
				<xsl:value-of select="text"/>
			</fo:block>
		</fo:block-container>		
	</xsl:template>

	<xsl:template name="sectionInfoAfter">
		<fo:block-container xsl:use-attribute-sets="section_info_afterContainer">
				<xsl:for-each select="text">
			<fo:block xsl:use-attribute-sets="section_info_afterFont">
				
					<xsl:value-of select="."/>
				
			</fo:block>
			</xsl:for-each>
		</fo:block-container>		
	</xsl:template>


	<xsl:template name="sectionInfoTitle">
		<xsl:choose>
			<xsl:when test="$show_section_title='true'">
				<fo:inline xsl:use-attribute-sets="section_info_titleFont">
					- <xsl:value-of select="text"/>
				</fo:inline>	
				</xsl:when>
			<xsl:otherwise>
				<fo:inline xsl:use-attribute-sets="sectionFontCenter">
					<xsl:value-of select="text"/>
				</fo:inline>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>



	<!-- Draws a box -->
	<xsl:template name="drawbox">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="fixedNoLineSVG">
				<svg:rect xsl:use-attribute-sets="boxNoLineSVG"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>
	
	<xsl:template name="drawboxcrossed">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="fixedNoLineSVG">
				<svg:rect xsl:use-attribute-sets="boxNoLineSVG"/>
				<svg:line xsl:use-attribute-sets="crossleftSVG"/>
				<svg:line xsl:use-attribute-sets="crossrightSVG"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>

	<xsl:template name="drawvasline">
		<fo:instream-foreign-object>
			<svg:svg width="105mm" height="8mm">
				<svg:line x1="2mm" y1="4mm" x2="103mm" y2="4mm" style="stroke: black; stroke-width: 1pt;"/>
				<svg:line x1="1mm" y1="2mm" x2="1mm" y2="6mm" style="stroke: black; stroke-width: 1pt;"/>
				<svg:line x1="104mm" y1="2mm" x2="104mm" y2="6mm" style="stroke: black; stroke-width: 1pt;"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>



	
	<xsl:template name="drawbigbox">
		<xsl:param name="length">1</xsl:param>
		<xsl:variable name="len" select="($length * 8)"/>
		<fo:instream-foreign-object>
			<svg:svg>
				<xsl:attribute name="width">145mm</xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="concat(string($len),'mm')"/></xsl:attribute>
					<svg:rect>
						<xsl:attribute name="width">145mm</xsl:attribute>
						<xsl:attribute name="height"><xsl:value-of select="concat(string($len),'mm')"/></xsl:attribute>
						<xsl:attribute name="style">fill:rgb(255,255,255);stroke-width:0.5pt;stroke:rgb(0,0,0);</xsl:attribute>
					</svg:rect>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>
	

	<!-- Draws a box with a line after -->
	<xsl:template name="drawboxlineafter">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="matrixSVG">
				<svg:rect xsl:use-attribute-sets="matrixboxSVG"/>
				<svg:line xsl:use-attribute-sets="lineafterSVG"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>

	<!-- Draws a box with a line before -->
	<xsl:template name="drawboxlinebefore">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="matrixSVG">
				<svg:line xsl:use-attribute-sets="linebeforeSVG"/>
				<svg:rect xsl:use-attribute-sets="matrixboxSVG"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>

    <!-- Draws a box with a line before and after-->   
	<xsl:template name="drawboxline">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="matrixSVG">
				<svg:line xsl:use-attribute-sets="linebeforeSVG"/>
				<svg:rect xsl:use-attribute-sets="matrixboxSVG"/>
				<svg:line xsl:use-attribute-sets="lineafterSVG"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>


	<!-- Draws a box with a line after -->
	<xsl:template name="drawboxlineaftershort">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="matrixSVGshort">
				<svg:rect xsl:use-attribute-sets="matrixboxSVGshort"/>
				<svg:line xsl:use-attribute-sets="lineafterSVGshort"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>

	<!-- Draws a box with a line before -->
	<xsl:template name="drawboxlinebeforeshort">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="matrixSVGshort">
				<svg:line xsl:use-attribute-sets="linebeforeSVGshort"/>
				<svg:rect xsl:use-attribute-sets="matrixboxSVGshort"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>

    <!-- Draws a box with a line before and after-->   
	<xsl:template name="drawboxlineshort">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="matrixSVGshort">
				<svg:line xsl:use-attribute-sets="linebeforeSVGshort"/>
				<svg:rect xsl:use-attribute-sets="matrixboxSVGshort"/>
				<svg:line xsl:use-attribute-sets="lineafterSVGshort"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>

	


	<!-- Draws a box with a line on the bottom -->
	<xsl:template name="drawboxlinebottom">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="fixedSVG">
				<svg:rect xsl:use-attribute-sets="boxSVG"/>
				<svg:line xsl:use-attribute-sets="linebottomSVG"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>
	
	
		<!-- Draws a box with a line on top and an arrow on the bottom -->
	<xsl:template name="drawboxlinetoparrowbottom">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="boxarrowSVG">
				<svg:rect xsl:use-attribute-sets="boxSVG"/>
				 <svg:g transform="scale(7)">
					 <svg:polygon xsl:use-attribute-sets="triangleBottomSVG"/>
				 </svg:g>
				<svg:line xsl:use-attribute-sets="linetopSVG"/>
			</svg:svg>

		</fo:instream-foreign-object>
	</xsl:template>

		<!-- Draws a box with an arrow on the bottom -->
	<xsl:template name="drawboxarrowbottom">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="boxarrowSVG">
				<svg:rect xsl:use-attribute-sets="boxSVG"/>
				 <svg:g transform="scale(7)">
					 <svg:polygon xsl:use-attribute-sets="triangleBottomSVG"/>
				 </svg:g>
			</svg:svg>

		</fo:instream-foreign-object>
	</xsl:template>


	<!-- Draws a box with a line on the top -->
	<xsl:template name="drawboxlinetop">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="fixedSVG">
				<svg:rect xsl:use-attribute-sets="boxSVG"/>
				<svg:line xsl:use-attribute-sets="linetopSVG"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>

    <!-- Draws a box with a line before and after-->   
	<xsl:template name="drawboxlinevertical">
		<fo:instream-foreign-object>
				<svg:svg xsl:use-attribute-sets="fixedSVG">
				<svg:rect xsl:use-attribute-sets="boxSVG"/>
				<svg:line xsl:use-attribute-sets="linebottomSVG"/>
					<svg:line xsl:use-attribute-sets="linetopSVG"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>


    <!-- Draws a single delimiter-->   
	<xsl:template name="drawDelimiterSingle">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="freeSVG">

				<svg:rect xsl:use-attribute-sets="delimiterBoxSVG"/>
				
				<svg:line xsl:use-attribute-sets="delimiterLineSingleNSVG"/>
				<svg:line xsl:use-attribute-sets="delimiterLineSingleSSVG"/>
				<svg:line xsl:use-attribute-sets="delimiterLineSingleESVG"/>
				<svg:line xsl:use-attribute-sets="delimiterLineSingleWSVG"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>

	


    <!-- Draws a "before" delimiter-->   
	<xsl:template name="drawDelimiterBefore">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="freeSVG">

				<svg:rect xsl:use-attribute-sets="delimiterBoxSVG"/>
				
				<svg:line xsl:use-attribute-sets="delimiterLineBeforeNSVG"/>
				<svg:line xsl:use-attribute-sets="delimiterLineBeforeSSVG"/>
				<svg:line xsl:use-attribute-sets="delimiterLineBeforeESVG"/>
				<svg:line xsl:use-attribute-sets="delimiterLineBeforeWSVG"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>

    <!-- Draws a "middle" delimiter-->   
   	<xsl:template name="drawDelimiterMiddle">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="freeSVG">
			
				<svg:rect xsl:use-attribute-sets="delimiterBoxSVG"/>
				
				<svg:line xsl:use-attribute-sets="delimiterLineMiddleNSVG"/>
				<svg:line xsl:use-attribute-sets="delimiterLineMiddleSSVG"/>
				<svg:line xsl:use-attribute-sets="delimiterLineMiddleESVG"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>
	
	<!-- Draws a "middle" delimiter-->   
   	<xsl:template name="drawDelimiterMiddleComma">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="freeSVG">
			
				<svg:rect xsl:use-attribute-sets="delimiterBoxSVG"/>
				<svg:text xsl:use-attribute-sets="delimiterComma">,</svg:text>			
				<svg:line xsl:use-attribute-sets="delimiterLineMiddleNSVG"/>
				<svg:line xsl:use-attribute-sets="delimiterLineMiddleSSVG"/>
				<svg:line xsl:use-attribute-sets="delimiterLineMiddleESVG"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>
	

    <!-- Draws an "after" delimiter-->   
   	<xsl:template name="drawDelimiterAfter">
		<fo:instream-foreign-object>
			<svg:svg xsl:use-attribute-sets="freeSVG">
				
				<svg:rect xsl:use-attribute-sets="delimiterBoxSVG"/>
				
				<svg:line xsl:use-attribute-sets="delimiterLineAfterNSVG"/>
				<svg:line xsl:use-attribute-sets="delimiterLineAfterSSVG"/>
				<svg:line xsl:use-attribute-sets="delimiterLineAfterESVG"/>
			</svg:svg>
		</fo:instream-foreign-object>
	</xsl:template>

	<!-- Given the name of a variable, find the position in the section and the question and print the label -->
	<xsl:template name="drawSkipTo">
		<xsl:param name="variableName"/>

		<xsl:for-each select="//*[@varName=$variableName]">
			<fo:table inline-progression-dimension="100%" table-layout="fixed"  width="100%">
				<fo:table-column xsl:use-attribute-sets="skipTriangleContainer"/>
				<fo:table-column column-width="proportional-column-width(1)"/>
			
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block>			
								<fo:instream-foreign-object>
									<svg:svg xsl:use-attribute-sets="skipSVG">
										 <svg:g transform="scale(7)">
											 <svg:polygon xsl:use-attribute-sets="triangleSVG"/>
										 </svg:g>
									</svg:svg>
								</fo:instream-foreign-object>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block-container xsl:use-attribute-sets="skiptoContainer">
								<fo:block xsl:use-attribute-sets="skiptoFont">			
									Skip to <xsl:if test="$show_question_letter='true'"><xsl:number count="section" level="any" format="A"/></xsl:if>
									<xsl:number count="question" level="single" format="1"/>
								</fo:block>
							</fo:block-container>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>	
			</fo:table>
			
		</xsl:for-each>
		
	</xsl:template>

	



	<!-- Test for unmatched templates -->
	<xsl:template match="*">
		<fo:block color="red">
			*** Element <xsl:value-of select="name(..)"/>/ <xsl:value-of select="name()"/> found with no template ***
		</fo:block>
	</xsl:template>
	
</xsl:stylesheet>
