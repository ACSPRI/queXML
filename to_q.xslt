<?xml version="1.0" encoding="UTF-8"?>
<!-- to_q

	Copyright Deakin University 2005,2006
	Written by Adam Zammit - adam.zammit@deakin.edu.au
	For the Deakin Computer Assisted Research Facility: http://www.deakin.edu.au/dcarf/
	Text wrapping template based upon examples from:  Sal Mangano, "XSLT Cookbook", December 2002, O'Reilly & Associates ISBN: 0-596-00372-2

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


	
	Convert queXML to the text based Q language used in CASES

	This stylesheet is to be used with the CASES package (see http://cases.berkeley.edu)

	This stylesheet will produce the questionnaire portion of the instrument, but not the "Backend" Q language required for a complete CASES instrument
	Therefore, this stylesheet will not produce a complete CASES instrument that can be compiled by CASES.

	DCARF uses a set of "template" backend Q language files in combination with the result of this stylesheet to produce a complete CASES instrument.
	
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dcarf="http://www.deakin.edu.au/dcarf" xmlns:redirect="http://xml.apache.org/xalan/redirect" extension-element-prefixes="redirect">

	<!-- 	Note that due to Q language being plain text and requiring some formatting within the Q file that effects the display of the instrument, the spacing of text within this stylesheet may effect the final Q document -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>

	<!-- **Parameters** -->

	<!-- Parameter determining to redirect to a file or not -->
	<xsl:param name="to_file">false</xsl:param>
		
	<!-- the length of a line in the output -->
	<xsl:param name="line_length">80</xsl:param>
	

	<!-- **Global Variables** -->
	<xsl:variable name="numberFormat">001</xsl:variable>

	<!-- **Templates** -->
	
	<!-- remove extra spaces -->
	<xsl:strip-space elements="*"/>
	
	<!-- Section info template -->
	<xsl:template match="sectionInfo">
		<xsl:if test="position='before' and administration='interviewer'">
			<xsl:text></xsl:text><xsl:call-template name="textwrap"><xsl:with-param name="text" select="text"/></xsl:call-template><xsl:text/>
		</xsl:if>
	</xsl:template>


	<!-- Directive template -->
	<xsl:template name="beforeDirective">
		<xsl:for-each select="directive">
			<xsl:if test="position='before' and administration='interviewer'">
				<xsl:text></xsl:text><xsl:call-template name="textwrap"><xsl:with-param name="text" select="text"/></xsl:call-template><xsl:text/><xsl:text>&#xa;</xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="afterDirective">
		<xsl:for-each select="directive">
			<xsl:if test="position='after' and administration='interviewer'">
				<xsl:text>[magenta]</xsl:text><xsl:call-template name="textwrap"><xsl:with-param name="text" select="text"/></xsl:call-template>[normal]<xsl:text/><xsl:text>&#xa;</xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="duringDirective">
		<xsl:for-each select="directive">
			<xsl:if test="position='during' and administration='interviewer'">
				<xsl:text>[red]</xsl:text><xsl:call-template name="textwrap"><xsl:with-param name="text" select="text"/></xsl:call-template>[normal]<xsl:text/><xsl:text>&#xa;</xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!-- Question Template -->

	<xsl:template name="question">
		<!-- The section number - auto generated -->
		<xsl:param name="sectionNumber"/>

		<!-- Store the current question number (for skips and form marking) -->
		<xsl:variable name="questionNumber">
			<xsl:number count="question" level="any" format="001"/>
		</xsl:variable>

		<xsl:variable name="randomQuestion">
			<xsl:number count="question"  level="any" format="001"/>
		</xsl:variable>

		<xsl:variable name="numberOfSubQuestions">
			<xsl:value-of select="count(subQuestion)"/>				
		</xsl:variable>


		<!-- If there are subquestions - this is a matrix question that needs to be flattened for CATI -->
		<xsl:if test="$numberOfSubQuestions>=1">

			
			<!-- If there is randomisation -->
				
			<xsl:if test="@randomise='true'">
				<xsl:text>&#xa;</xsl:text><![CDATA[>]]>R<xsl:value-of select="$randomQuestion"/><![CDATA[<]]>
						[allow int <xsl:value-of select="string-length($numberOfSubQuestions)"/> for <xsl:value-of select="$numberOfSubQuestions"/>]<xsl:text>&#xa;</xsl:text>
				[randomize <![CDATA[<]]>1<![CDATA[>]]> to <![CDATA[<]]><xsl:value-of select="$numberOfSubQuestions"/><![CDATA[>]]> into R<xsl:value-of select="$randomQuestion"/>]<xsl:text>&#xa;</xsl:text>
				<![CDATA[>]]>L<xsl:value-of select="$randomQuestion"/><![CDATA[<]]>
				[allow int <xsl:value-of select="string-length($numberOfSubQuestions)"/>]<xsl:text>&#xa;</xsl:text>
				[loop for L<xsl:value-of select="$randomQuestion"/> from <![CDATA[<]]>1<![CDATA[>]]> to <![CDATA[<]]><xsl:value-of select="$numberOfSubQuestions"/><![CDATA[>]]>]<xsl:text>&#xa;</xsl:text>
			
				<!-- make the if statements -->
				<xsl:for-each select="subQuestion">
					[IF R<xsl:value-of select="$randomQuestion"/>(L<xsl:value-of select="$randomQuestion"/>) eq <![CDATA[<]]><xsl:value-of select="position()"/><![CDATA[>]]> GOTO <xsl:value-of select="@varName"/>]<xsl:text>&#xa;</xsl:text>
				
				</xsl:for-each>
			
				
			</xsl:if>
				
			<!-- Create a new form for each subQuestion in the matrix -->	
			<xsl:for-each select="subQuestion"><xsl:text>&#xa;</xsl:text><![CDATA[>]]><xsl:value-of select="@varName"/><![CDATA[<]]><xsl:text>&#xa;</xsl:text>

				<!-- If there is a before question directive -->
				<xsl:for-each select="../directive">
					<xsl:if test="position='before' and administration='interviewer'">
					
						<xsl:text></xsl:text><xsl:call-template name="textwrap"><xsl:with-param name="text" select="text"/></xsl:call-template><xsl:text/><xsl:text>&#xa;</xsl:text>
					</xsl:if>
				</xsl:for-each>
					
				<!-- Print the question text then the subQuestion text -->
				<xsl:for-each select="../text"><xsl:call-template name="textwrap"><xsl:with-param name="text" select="."/></xsl:call-template></xsl:for-each> [bold]<xsl:value-of select="../qualifier"/>[normal]<xsl:text>&#xa;</xsl:text>
				<xsl:value-of select="../specifier"/><xsl:text>&#xa;</xsl:text>
			
				<xsl:value-of select="text"/><xsl:text>&#xa;</xsl:text><xsl:text>&#xa;</xsl:text>
				

				<!-- store the skip if it does exist - Note: only one will store -->
				<xsl:variable name="skipif">
					<xsl:value-of select="skip/ifValue"/>
				</xsl:variable>

				<xsl:variable name="skipto">
					<xsl:value-of select="skip/to"/>
				</xsl:variable>

				<!-- If there is a during question directive -->
				<xsl:for-each select="../directive">
					<xsl:if test="position='during' and administration='interviewer'">
						<xsl:text>[red]</xsl:text><xsl:call-template name="textwrap"><xsl:with-param name="text" select="text"/></xsl:call-template>[normal]<xsl:text/><xsl:text>&#xa;</xsl:text><xsl:text>&#xa;</xsl:text>
					</xsl:if>
				</xsl:for-each>


				<!-- If there is an after question directive -->
				<xsl:for-each select="../directive">
					<xsl:if test="position='after' and administration='interviewer'">
						<xsl:text>[magenta]</xsl:text><xsl:call-template name="textwrap"><xsl:with-param name="text" select="text"/></xsl:call-template>[normal]<xsl:text/><xsl:text>&#xa;</xsl:text><xsl:text>&#xa;</xsl:text>
					</xsl:if>
				</xsl:for-each>
				
				<!-- display the responses -->
			<xsl:choose>
					<xsl:when test="count(../response/fixed/category) &lt; 21">
				
				<xsl:for-each select="../response/fixed/category">	<![CDATA[	<]]><xsl:value-of select="value"/><![CDATA[>]]> <xsl:value-of select="label"/><xsl:text>&#xa;</xsl:text>
					<!-- Check for skips -->
					<xsl:if test="count(child::skipTo)=1">   [goto <xsl:value-of select="skipTo"/>]<xsl:text>&#xa;</xsl:text></xsl:if>

					<!-- Check for subQuestion specific skips -->
					<xsl:if test="$skipif = value">   [goto <xsl:value-of select="$skipto"/>]<xsl:text>&#xa;</xsl:text></xsl:if>

					<xsl:variable name="value">
						<xsl:value-of select="value"/>
					</xsl:variable>

		
					<!-- Check for contingent questions -->
					<xsl:if test="count(child::contingentQuestion)=1">
						[# Contingent questions within subquestion groups are not currently supported]
						
					</xsl:if>

				</xsl:for-each>

					</xsl:when>
					
					
					<xsl:otherwise>

<!-- more than 20 repsonses - go in columns of 3 -->
				<xsl:for-each select="../response/fixed/category">	<![CDATA[	<]]><xsl:value-of select="value"/><![CDATA[>]]> <xsl:value-of select="label"/>					<!-- Check for skips --> <xsl:if test="count(child::skipTo)=1">   [goto <xsl:value-of select="skipTo"/>]</xsl:if>		<!-- Check for subQuestion specific skips -->	<xsl:if test="$skipif = value">   [goto <xsl:value-of select="$skipto"/>]</xsl:if> <xsl:if test="position() mod 4 = 0">	<xsl:text>&#xa;</xsl:text></xsl:if>	</xsl:for-each>

								
					
					</xsl:otherwise>
						</xsl:choose>
				
				<!-- Display the form entry field-->
				<xsl:text>&#xa;</xsl:text><xsl:text/>	<![CDATA[@]]>
														
						
				<!-- If the questions are randomised add the goto statement -->
				<xsl:if test="../@randomise='true'">
					<xsl:text>&#xa;</xsl:text>
	<![CDATA[[@]]]>[goto E<xsl:value-of select="$randomQuestion"/>]<xsl:text>&#xa;</xsl:text>
				</xsl:if>

									
			</xsl:for-each>
			
			<xsl:if test="@randomise='true'">
				<!-- make the loop end statement -->
				<xsl:text>&#xa;</xsl:text>
				<![CDATA[>]]>E<xsl:value-of select="$randomQuestion"/><![CDATA[<]]>
				[loop end L<xsl:value-of select="$randomQuestion"/>]<xsl:text/>
			</xsl:if>

		</xsl:if>

		<!-- If there are no subQuestions, treat this as a normal question -->
		<xsl:if test="count(child::subQuestion)=0 and count(response)=1">
		<!-- Check if it is an open response or a category response -->

			
			<!-- If there is only one response - this is a simple form with one question -->
			<xsl:if test="count(response/free)=1">
<![CDATA[>]]><xsl:value-of select="response/@varName"/><![CDATA[<]]><xsl:if test="response/free/format='text'">	[allow <xsl:value-of select="response/free/length"/>]<xsl:text>&#xa;</xsl:text>
				</xsl:if>
				<xsl:if test="response/free/format='integer'">[allow int <xsl:value-of select="response/free/length"/>]<xsl:text>&#xa;</xsl:text>
				</xsl:if>
    			<xsl:if test="response/free/format='currency'">[allow int <xsl:value-of select="response/free/length"/>]<xsl:text>&#xa;</xsl:text>
				</xsl:if>				
				<!-- ignore the length for the date variable -force it to be 8 -->
				<xsl:if test="response/free/format='date'">[allow date 8]<xsl:text>&#xa;</xsl:text>
				</xsl:if>
				<xsl:if test="response/free/format='longtext'">[allow 1]<xsl:text>&#xa;</xsl:text>
				</xsl:if>
					
				<xsl:call-template name="beforeDirective"/>
				
				<xsl:for-each select="text"><xsl:text>&#xa;</xsl:text>
		<xsl:call-template name="textwrap"><xsl:with-param name="text" select="."/></xsl:call-template> [bold]<xsl:value-of select="../qualifier"/>[normal]<xsl:text>&#xa;</xsl:text>
		<xsl:value-of select="../specifier"/><xsl:text>&#xa;</xsl:text>
				
				</xsl:for-each>

				<xsl:call-template name="duringDirective"/>
				
				<xsl:call-template name="afterDirective"/>	
				
				<xsl:text>&#xa;</xsl:text>				
				<xsl:text>&#xa;</xsl:text>

<!-- a longtext style free response is stored as a note in CASES -->
<xsl:if test="response/free/format='longtext'">
	<![CDATA[<1>]]> Write note[specify]<xsl:text>&#xa;</xsl:text>
	<![CDATA[<2>]]> Done - no note<xsl:text>&#xa;</xsl:text><xsl:text>&#xa;</xsl:text>
</xsl:if>				
				<!-- check for labels-->
				<xsl:if test="count(response/free/label)=1"><xsl:value-of select="response/free/label"/>:<xsl:text/></xsl:if>
<![CDATA[@]]>


				<!-- Check for skips -->
				<xsl:if test="count(response/free/skipTo)=1">
					<xsl:text>&#xa;</xsl:text>
<![CDATA[[@]]]>[goto <xsl:value-of select="response/free/skipTo"/>]<xsl:text>&#xa;</xsl:text>
				</xsl:if>

			</xsl:if>
			
			<xsl:if test="count(response/fixed)=1">
<![CDATA[>]]><xsl:value-of select="response/@varName"/><![CDATA[<]]><xsl:text/>
				<!-- If this is in the respondent selection phase, need to reset the info in this form -->
				<xsl:if test="../@respondentselection='true'">[reset <xsl:value-of select="response/@varName"/>]<xsl:text/></xsl:if>
				

				<!-- If there is a before question directive -->
				<xsl:for-each select="directive">
					<xsl:if test="position='before' and administration='interviewer'">
						<xsl:text>&#xa;</xsl:text>
						<xsl:text></xsl:text><xsl:call-template name="textwrap"><xsl:with-param name="text" select="text"/></xsl:call-template><xsl:text/>
					</xsl:if>
				</xsl:for-each>


				<xsl:text>&#xa;</xsl:text><xsl:text>&#xa;</xsl:text>

		<!--Question text -->
				<xsl:for-each select="text"><xsl:text>&#xa;</xsl:text>
		<xsl:call-template name="textwrap"><xsl:with-param name="text" select="."/></xsl:call-template> [bold]<xsl:value-of select="../qualifier"/>[normal]<xsl:text>&#xa;</xsl:text>
		<xsl:value-of select="../specifier"/><xsl:text>&#xa;</xsl:text></xsl:for-each>

				<!-- If there is an during question directive -->
				<xsl:for-each select="directive">
					<xsl:if test="position='during' and administration='interviewer'">
						<xsl:text>&#xa;</xsl:text>
						<xsl:text>[red]</xsl:text><xsl:call-template name="textwrap"><xsl:with-param name="text" select="text"/></xsl:call-template>[normal]<xsl:text/>
					</xsl:if>
				</xsl:for-each>		



	<!-- If there is an after question directive -->
				<xsl:for-each select="directive">
					<xsl:if test="position='after' and administration='interviewer'">
						<xsl:text>&#xa;</xsl:text>
						<xsl:text>[magenta]</xsl:text><xsl:call-template name="textwrap"><xsl:with-param name="text" select="text"/></xsl:call-template>[normal]<xsl:text/>
					</xsl:if>
				</xsl:for-each>		

				<xsl:text>&#xa;</xsl:text>			
				<xsl:text>&#xa;</xsl:text>
				
<xsl:choose>
	<xsl:when test="count(response/fixed/category) &lt; 21">
	
					
				<xsl:for-each select="response/fixed/category">
<![CDATA[	<]]><xsl:value-of select="value"/><![CDATA[>]]> <xsl:value-of select="label"/>	
					<!-- Check for skips -->
					<xsl:if test="count(skipTo)=1">[goto <xsl:value-of select="skipTo"/>]<xsl:text/></xsl:if>
		
					<!-- Check for contingent questions -->
					<xsl:if test="count(contingentQuestion)=1">[goto <xsl:value-of select="contingentQuestion/@varName"/>]<xsl:text>&#xa;</xsl:text></xsl:if>
	
				</xsl:for-each>
	
</xsl:when>

<xsl:otherwise><xsl:for-each select="response/fixed/category"><![CDATA[	<]]><xsl:value-of select="value"/><![CDATA[>]]> <xsl:value-of select="label"/>	<xsl:if test="position() mod 4 = 0"><xsl:text>&#xa;</xsl:text></xsl:if><xsl:if test="count(skipTo)=1">[goto <xsl:value-of select="skipTo"/>]<xsl:text/></xsl:if><xsl:if test="count(contingentQuestion)=1">[goto <xsl:value-of select="contingentQuestion/@varName"/>]<xsl:text>&#xa;</xsl:text></xsl:if></xsl:for-each></xsl:otherwise>

</xsl:choose>				
	
			
				<xsl:text>&#xa;</xsl:text>
				<xsl:text>&#xa;</xsl:text>
	<![CDATA[@]]>
				
				<!-- Need to add a goto to the next question to skip over the contingent question -->			
				<xsl:if test="position()!=last()">
					<xsl:text>&#xa;</xsl:text>
					<!-- When the next question is a matrix question, jump to the first subQuestion-->
					<!-- explanation of xpath syntax: -->
					<!-- following-sibiling::question would select all questions in this section
							following-sibling::question[1] selects the next question in this section
							following-sibling::question[1]/subQuestion selects the subQuestion from the next question in this section

							as we have guaranteed by the test of not being in the last position of the section, there will always be a following question-->
					<xsl:choose>
						<xsl:when test="count(following-sibling::question[1]/subQuestion)>0">
	<![CDATA[[@]]]>[goto <xsl:value-of select="following-sibling::question[1]/subQuestion/@varName"/>]<xsl:text>&#xa;</xsl:text>		
						</xsl:when>
						<xsl:otherwise>
	<![CDATA[[@]]]>[goto <xsl:value-of select="following-sibling::question[1]/response/@varName"/>]<xsl:text>&#xa;</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					

				</xsl:if>
		
				<xsl:if test="position()=last()">
					<xsl:text>&#xa;</xsl:text>
	<![CDATA[[@]]]>[goto F<xsl:number value="$sectionNumber + 1" format="001"/>]<xsl:text>&#xa;</xsl:text>
				</xsl:if>

						
			</xsl:if>
			
		</xsl:if>


		<!-- 	more than 1 response per form AND each is a fixed response with 1 possible category
			this indicates that it is a multiple-multiple choice question
		-->
		<xsl:if test="(count(response) > 1) and (count(response[1]/fixed/category) = 1)">

			<![CDATA[>]]><xsl:value-of select="response/@varName"/><![CDATA[<]]><![CDATA[[checkbox all][open ]]><xsl:value-of select="response/@varName"/><![CDATA[]]]>
					
				<xsl:call-template name="beforeDirective"/>

				
				<xsl:for-each select="text"><xsl:text>&#xa;</xsl:text>
		<xsl:call-template name="textwrap"><xsl:with-param name="text" select="."/></xsl:call-template> [bold]<xsl:value-of select="../qualifier"/>[normal]<xsl:text>&#xa;</xsl:text>
		<xsl:value-of select="../specifier"/><xsl:text>&#xa;</xsl:text></xsl:for-each>

				<xsl:call-template name="duringDirective"/>	
	
				<xsl:call-template name="afterDirective"/>	
				
				<xsl:text>&#xa;</xsl:text>				
				<xsl:text>&#xa;</xsl:text>


<xsl:for-each select="response">
	<![CDATA[@]]><xsl:number value="position()" format="01"/><xsl:text>  </xsl:text><xsl:value-of select="fixed/category/label"/><xsl:text>&#xa;</xsl:text>	
</xsl:for-each>

<![CDATA[[nodata button <NEXT>]@99]]><xsl:text>&#xa;</xsl:text>	

<!-- now do the response codes -->
<xsl:for-each select="response">
	<![CDATA[[@]]><xsl:number value="position()" format="01"/><![CDATA[] <1,0>]]><xsl:text>&#xa;</xsl:text>

	
</xsl:for-each>



		<!-- if there is a specific free skipTo, do not put another goto -->
		<xsl:if test="count(response/free/skipTo)=0">

				<!-- Need to add a goto to the next question to skip over the contingent question -->			
				<xsl:if test="position()!=last()">
					<xsl:text>&#xa;</xsl:text>
					<!-- When the next question is a matrix question, jump to the first subQuestion-->
					<!-- explanation of xpath syntax: -->
					<!-- following-sibiling::question would select all questions in this section
							following-sibling::question[1] selects the next question in this section
							following-sibling::question[1]/subQuestion selects the subQuestion from the next question in this section

							as we have guaranteed by the test of not being in the last position of the section, there will always be a following question-->
					<xsl:choose>
						<xsl:when test="count(following-sibling::question[1]/subQuestion)>0">
	[goto <xsl:value-of select="following-sibling::question[1]/subQuestion/@varName"/>]<xsl:text>&#xa;</xsl:text>		
						</xsl:when>
						<xsl:otherwise>
	[goto <xsl:value-of select="following-sibling::question[1]/response/@varName"/>]<xsl:text>&#xa;</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					

				</xsl:if>
		
				<xsl:if test="position()=last()">
					<xsl:text>&#xa;</xsl:text>
	[goto F<xsl:number value="$sectionNumber + 1" format="001"/>]<xsl:text>&#xa;</xsl:text>
				</xsl:if>

		</xsl:if>						



		</xsl:if>

		<!-- MORE THAN 1 RESPONSE PER FORM -->

		<xsl:if test="count(response) > 1 and (count(response[1]/fixed/category) != 1)">

<![CDATA[>]]><xsl:value-of select="response/@varName"/><![CDATA[<]]>
					
				<xsl:call-template name="beforeDirective"/>

				
				<xsl:for-each select="text"><xsl:text>&#xa;</xsl:text>
		<xsl:call-template name="textwrap"><xsl:with-param name="text" select="."/></xsl:call-template> [bold]<xsl:value-of select="../qualifier"/>[normal]<xsl:text>&#xa;</xsl:text>
		<xsl:value-of select="../specifier"/><xsl:text>&#xa;</xsl:text></xsl:for-each>

				<xsl:call-template name="duringDirective"/>	
	
				<xsl:call-template name="afterDirective"/>	
				
				<xsl:text>&#xa;</xsl:text>				
				<xsl:text>&#xa;</xsl:text>


<xsl:for-each select="response">
	<xsl:if test="free">
				<!-- check for labels-->
				<xsl:if test="count(free/label)=1"><xsl:value-of select="free/label"/>:<xsl:text/></xsl:if>
	<![CDATA[@]]><xsl:number value="position()" format="01"/><xsl:text>&#xa;</xsl:text><xsl:text>&#xa;</xsl:text>
			
			
</xsl:if>
			
			
<xsl:if test="fixed">
				<xsl:for-each select="fixed/category">
<![CDATA[	<]]><xsl:value-of select="value"/><![CDATA[>]]> <xsl:value-of select="label"/>	
					<!-- Check for skips -->
					<xsl:if test="count(skipTo)=1">[goto <xsl:value-of select="skipTo"/>]<xsl:text/></xsl:if>
		
					<!-- Check for contingent questions -->
					<xsl:if test="count(contingentQuestion)=1">[goto <xsl:value-of select="contingentQuestion/@varName"/>]<xsl:text>&#xa;</xsl:text></xsl:if>
	
				</xsl:for-each>
			
				<xsl:text>&#xa;</xsl:text>
				<xsl:text>&#xa;</xsl:text>

	<![CDATA[@]]><xsl:number value="position()" format="01"/><xsl:text>&#xa;</xsl:text><xsl:text>&#xa;</xsl:text>


				
</xsl:if>



</xsl:for-each>


<!-- now do the response codes -->
<xsl:for-each select="response">

<xsl:if test="free">
	<![CDATA[[@]]><xsl:number value="position()" format="01"/><![CDATA[]]]><xsl:if test="free/format='text'">	[allow <xsl:value-of select="free/length"/>]<xsl:text>&#xa;</xsl:text>
				</xsl:if>
				<xsl:if test="free/format='integer'">[allow int <xsl:value-of select="free/length"/>]<xsl:text>&#xa;</xsl:text>
				</xsl:if>
    			<xsl:if test="free/format='currency'">[allow int <xsl:value-of select="free/length"/>]<xsl:text>&#xa;</xsl:text>
				</xsl:if>				
				<!-- ignore the length for the date variable -force it to be 8 -->
				<xsl:if test="free/format='date'">[allow date 8]<xsl:text>&#xa;</xsl:text>
				</xsl:if>
				<xsl:if test="free/format='longtext'">[allow 1]<xsl:text>&#xa;</xsl:text>
				</xsl:if>
				<xsl:if test="count(free/skipTo)=1">[goto <xsl:value-of select="free/skipTo"/>]<xsl:text>&#xa;</xsl:text>
				</xsl:if>
</xsl:if>

<xsl:if test="fixed">
	<![CDATA[[@]]><xsl:number value="position()" format="01"/><![CDATA[]]]><xsl:text>&#xa;</xsl:text>

</xsl:if>
	
</xsl:for-each>

		<!-- if there is a specific free skipTo, do not put another goto -->
		<xsl:if test="count(response/free/skipTo)=0">

				<!-- Need to add a goto to the next question to skip over the contingent question -->			
				<xsl:if test="position()!=last()">
					<xsl:text>&#xa;</xsl:text>
					<!-- When the next question is a matrix question, jump to the first subQuestion-->
					<!-- explanation of xpath syntax: -->
					<!-- following-sibiling::question would select all questions in this section
							following-sibling::question[1] selects the next question in this section
							following-sibling::question[1]/subQuestion selects the subQuestion from the next question in this section

							as we have guaranteed by the test of not being in the last position of the section, there will always be a following question-->
					<xsl:choose>
						<xsl:when test="count(following-sibling::question[1]/subQuestion)>0">
	[goto <xsl:value-of select="following-sibling::question[1]/subQuestion/@varName"/>]<xsl:text>&#xa;</xsl:text>		
						</xsl:when>
						<xsl:otherwise>
	[goto <xsl:value-of select="following-sibling::question[1]/response/@varName"/>]<xsl:text>&#xa;</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					

				</xsl:if>
		
				<xsl:if test="position()=last()">
					<xsl:text>&#xa;</xsl:text>
	[goto F<xsl:number value="$sectionNumber + 1" format="001"/>]<xsl:text>&#xa;</xsl:text>
				</xsl:if>

		</xsl:if>						
</xsl:if>



		
		<!-- Contingent question form if exists -->
						
		<xsl:for-each select="response/fixed/category/contingentQuestion">
<![CDATA[>]]><xsl:value-of select="@varName"/><![CDATA[<]]>[allow <xsl:value-of select="length"/>]<xsl:text>&#xa;</xsl:text>

			<xsl:for-each select="text"><xsl:call-template name="textwrap"><xsl:with-param name="text" select="."/></xsl:call-template></xsl:for-each>

			<xsl:text>&#xa;</xsl:text>
			<xsl:text>&#xa;</xsl:text>
	<![CDATA[@]]>	<xsl:text>&#xa;</xsl:text>

	<!-- go to the next question (skip over any other contingent questions -->
	<![CDATA[[@]]]>
	
					<xsl:choose>
						<xsl:when test="count(../../../../following-sibling::question[1]/subQuestion)>0">
	[goto <xsl:value-of select="../../../../following-sibling::question[1]/subQuestion/@varName"/>]<xsl:text>&#xa;</xsl:text>		
</xsl:when>
						<xsl:when test="count(../../../../following-sibling::question[1]/response)>0">

	[goto <xsl:value-of select="../../../../following-sibling::question[1]/response/@varName"/>]<xsl:text>&#xa;</xsl:text>
</xsl:when>
<xsl:otherwise>
	<!-- Otherwise this is the end of the section -->
					<xsl:choose>
						<xsl:when test="count(../../../../../following-sibling::section[1]/question[1]/subQuestion)>0">
							[goto <xsl:value-of select="../../../../../following-sibling::section[1]/question[1]/subQuestion/@varName"/>]<xsl:text>&#xa;</xsl:text>		
</xsl:when>
<xsl:otherwise>
	[goto <xsl:value-of select="../../../../../following-sibling::section[1]/question[1]/response/@varName"/>]<xsl:text>&#xa;</xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:otherwise>
					</xsl:choose>

			
		</xsl:for-each>
				
	</xsl:template>



	<!-- Section template -->
	
	<xsl:template name="section">
		<!-- Store the current section number (for skips and form marking) -->
		<xsl:variable name="sectionNumber">
			<xsl:number count="section" level="any" format="001"/>
		</xsl:variable>
		
		<xsl:text>&#xa;</xsl:text><![CDATA[>]]>F<xsl:value-of select="$sectionNumber"/><![CDATA[<]]><xsl:text/>
		<!-- Only make this a seperate form if there is section info -->
		<xsl:if test="count(sectionInfo)>0 and sectionInfo/position='before' and sectionInfo/administration='interviewer'">[nodata]<xsl:text>&#xa;</xsl:text>
		</xsl:if>

		<!-- Display the section info if it is for before the section -->
		<xsl:for-each select="sectionInfo">
			<xsl:if test="position='before' and administration='interviewer'">
				<xsl:text></xsl:text><xsl:call-template name="textwrap"><xsl:with-param name="text" select="text"/></xsl:call-template><xsl:text>&#xa;</xsl:text>
			</xsl:if>
		</xsl:for-each>

		<!-- Only make this a seperate form if there is section info -->
		<xsl:if test="count(sectionInfo)>0 and sectionInfo/position='before' and sectionInfo/administration='interviewer'">
			@<xsl:text>&#xa;</xsl:text>
		</xsl:if>

		<!-- render each question in the section -->
		<xsl:for-each select="question">
			<xsl:call-template name="question">
			
			<xsl:with-param name="sectionNumber">
				<xsl:value-of select="$sectionNumber"/>
			</xsl:with-param>
			
			</xsl:call-template>

		</xsl:for-each>

		<!-- Display the section info if it is for after the section - not useful for CATI? -->
	
	</xsl:template>


	<!-- Main Questionnaire Template -->
	
	<!-- This template checks whether the output should be appended to a file, or displayed as standard output
			Then goes through each section, numbering them automatically and calls the section template
			Makes sure there is a [goto] statement between each section
			If it is the last section, the section has a [goto] statemen to a form in the DCARF template called "ENDQS"
	-->
	<xsl:template match="questionnaire">


		<!-- Put respondent selection into a different file... ?? -->

<xsl:choose>
	<xsl:when test="$to_file='true'">

<redirect:write file="12rs.q">
[#BEGIN 12rs.q]

		<xsl:for-each select="section[@respondentselection='true']">
			<xsl:call-template name="section"/>		
		</xsl:for-each>

[#END 12rs.q]
</redirect:write>

<redirect:write file="21ques.q">
[#BEGIN 21ques.q]

[# Questionnaire ID: <xsl:value-of select="@id"/>]<xsl:text>&#xa;</xsl:text>
[# Questionnaire title: <xsl:value-of select="title"/>]<xsl:text>&#xa;</xsl:text>
[# Questionnaire subTitle: <xsl:value-of select="subtitle"/>]<xsl:text>&#xa;</xsl:text>

<![CDATA[>START<]]>
<xsl:text>[#Beginning of questions]</xsl:text>

		<xsl:for-each select="section[@respondentselection = 'false' or not(@respondentselection)]">
			<xsl:call-template name="section"/>
			<xsl:if test="position()=last()">
				<!-- The end of the questionnaire form -->
				<xsl:variable name="snum">
					<xsl:number count="section" level="any" format="001"/>
				</xsl:variable>
				<xsl:text>&#xa;</xsl:text><![CDATA[>]]>F<xsl:number value="$snum + 1" format="001"/><![CDATA[<[goto ENDQS]]]>
				<xsl:text>&#xa;</xsl:text>
			</xsl:if>
		</xsl:for-each>

[# End of questions (Store complete)]
<![CDATA[>ENDQS<[goto APOR1001]

[#END 21ques.q]
]]>
</redirect:write>
	
	
	
	</xsl:when>

<xsl:otherwise>

[#BEGIN 12rs.q]

		<xsl:for-each select="section[@respondentselection='true']">
			<xsl:call-template name="section"/>		
		</xsl:for-each>

[#END 12rs.q]

[#BEGIN 21ques.q]

[# Questionnaire ID: <xsl:value-of select="@id"/>]<xsl:text>&#xa;</xsl:text>
[# Questionnaire title: <xsl:value-of select="title"/>]<xsl:text>&#xa;</xsl:text>
[# Questionnaire subTitle: <xsl:value-of select="subtitle"/>]<xsl:text>&#xa;</xsl:text>

<![CDATA[>START<]]>
<xsl:text>[#Beginning of questions]</xsl:text>

		<xsl:for-each select="section[@respondentselection = 'false' or not(@respondentselection)]">
			<xsl:call-template name="section"/>
			<xsl:if test="position()=last()">
				<!-- The end of the questionnaire form -->
				<xsl:variable name="snum">
					<xsl:number count="section" level="any" format="001"/>
				</xsl:variable>
				<xsl:text>&#xa;</xsl:text><![CDATA[>]]>F<xsl:number value="$snum + 1" format="001"/><![CDATA[<[goto ENDQS]]]>
				<xsl:text>&#xa;</xsl:text>
			</xsl:if>
		</xsl:for-each>

[# End of questions (Store complete)]
<![CDATA[>ENDQS<[goto APOR1001]
	
[#END 21ques.q]
]]>


</xsl:otherwise>


</xsl:choose>



	</xsl:template>



	<!-- substring-before-last template -->
	<!-- Based upon Examples from Chapter 1, Sal Mangano, "XSLT Cookbook", December 2002, O'Reilly & Associates -->
<xsl:template name="substring-before-last"> 

  <xsl:param name="input"/>
  <xsl:param name="substr"/>
  
  <xsl:variable name="mid" select="ceiling(string-length($input) div 2)"/>
  <xsl:variable name="temp1" select="substring($input,1, $mid)"/>
  <xsl:variable name="temp2" select="substring($input,$mid +1)"/>
  <xsl:choose>
    <xsl:when test="$temp2 and contains($temp2,$substr)">
      <!--search string is in second half so just append first half and recuse on second -->
      <xsl:value-of select="$temp1"/>
      <xsl:call-template name="substring-before-last">
        <xsl:with-param name="input" select="$temp2"/>
        <xsl:with-param name="substr" select="$substr"/>
      </xsl:call-template>
    </xsl:when>
    <!--search string is in boundary so a simple  substring-before will do the trick-->
    <xsl:when test="contains(substring($input,$mid - string-length($substr) +1), $substr)">
      <xsl:value-of select="substring-before($input,$substr)"/>
    </xsl:when>
    <!--search string is in first half so through away second half-->
    <xsl:when test="contains($temp1,$substr)">
      <xsl:call-template name="substring-before-last">
      <xsl:with-param name="input" select="$temp1"/>
      <xsl:with-param name="substr" select="$substr"/>
      </xsl:call-template>
    </xsl:when>
    <!-- No occurances of search string so we are done -->
    <xsl:otherwise/>
  </xsl:choose>
  
</xsl:template>
	
	<!-- Text wrapping template -->
	<!-- Based upon Example 5.6, Sal Mangano, "XSLT Cookbook", December 2002, O'Reilly & Associates -->
	<!-- if only one line long - will not put a newline character -->
	<xsl:template name="textwrap">
		<xsl:param name="text"/>
			
			<xsl:if test="$text">
				<xsl:choose>
					<xsl:when test="string-length($text) > $line_length">
						<xsl:call-template name="textwrap2">
							<xsl:with-param name="text" select="$text"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$text"/>
					</xsl:otherwise>
				</xsl:choose>
			
			</xsl:if>
		
	</xsl:template>

	<!-- Text wrapping template -->
	<xsl:template name="textwrap2">
		<xsl:param name="text"/>
		<xsl:if test="$text">

			<xsl:variable name="line">
				<xsl:choose>
					<xsl:when test="string-length($text) > $line_length">
						<xsl:call-template name="substring-before-last">
							<xsl:with-param name="input" select="substring($text,1,$line_length)"/>
							<xsl:with-param name="substr" select=" ' ' "/>
						</xsl:call-template>
					</xsl:when>			
					<xsl:otherwise>
						<xsl:value-of select="$text"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			
			<xsl:if test="$line">
				<xsl:value-of select="$line"></xsl:value-of>
				<xsl:text>&#xa;</xsl:text>
			</xsl:if>
			
			<xsl:call-template name="textwrap">
				<xsl:with-param name="text" select="substring($text,string-length($line)+2)"/>
			</xsl:call-template>
			
		</xsl:if>
	
	</xsl:template>




</xsl:stylesheet>
