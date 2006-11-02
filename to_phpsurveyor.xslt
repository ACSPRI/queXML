<?xml version="1.0" encoding="UTF-8"?>

<!-- to_phpsurveyor

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
	

	
	Convert queXML to an intermediate XML description to be converted to SQL commands

	This stylesheet is to be used with the phpSurveyor package (see http://www.phpsurveyor.org)
	The SQL commands produced by this stylesheet in combination with to_phpsurveyor2 are compatible
	with phpsurveyor version 1.0.
	
	
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8"/>


<!-- escape-apos template by Jeni Tennison
	see: http://www.dpawson.co.uk/xsl/sect2/N7150.html
	
	makes sure apostrophes in text are escaped to be safely used in SQL	
-->


<xsl:template name="escape-apos">
 <xsl:param name="string"/>
<xsl:variable name="apos" select='"&apos;"' />
<xsl:choose>
 <xsl:when test='contains($string, $apos)'>
  <xsl:value-of select="substring-before($string,$apos)" />
	<xsl:text>\'</xsl:text>
	<xsl:call-template name="escape-apos">
	 <xsl:with-param name="string"
          select="substring-after($string, $apos)" />
	</xsl:call-template>
 </xsl:when>
 <xsl:otherwise>
  <xsl:value-of select="$string" />
 </xsl:otherwise>
</xsl:choose>
</xsl:template>


	<xsl:template match="questionnaire">
		<!-- Start with insertion into "survey" table -->
		<xsl:element name="phpSurveyor">
		
					
		<xsl:element name="insert">INSERT INTO surveys 
																(`sid`, `short_title`, `description`, `admin`, `active`, `welcome`,
																 `expires`, `adminemail`, `private`, `faxto`, `format`, `template`,
																 `url`, `urldescrip`, `language`, `datestamp`, `usecookie`,
																 `notification`, `allowregister`, `attribute1`, `attribute2`,
																 `email_invite_subj`, `email_invite`, `email_remind_subj`, 
																 `email_remind`, `email_register_subj`, `email_register`,
																 `email_confirm_subj`, `email_confirm`, `allowsave`, 
																 `autonumber_start`, `autoredirect`, `allowprev`, `ipaddr`, `useexpiry`)
																 
																   VALUES ('<xsl:element name="surveyid"/>',
																    '<xsl:value-of select="title"/>',
																    '<xsl:value-of select="title"/>', '<xsl:value-of select="dataCollector/name"/>','N','<xsl:apply-templates select="questionnaireInfo[position='before']"/>',
																    '0000-00-00','<xsl:value-of select="dataCollector/emailAddress"/>','Y','','G','DCARF','','',
																    'english','Y','N','1','N','','','Invitation to Participate','Dear {FIRSTNAME},\n\nYou have been invited to participate in a survey.\n\nThe survey is titled:\n\\\"{SURVEYNAME}\\\"\n\n\\\"{SURVEYDESCRIPTION}\\\"\n\nTo participate, please click on the link below.\n\nSincerely,\n\n{ADMINNAME} ({ADMINEMAIL})\n\n----------------------------------------------\nClick here to do the survey:\n{SURVEYURL}', 'REMINDER TO PARTICIPATE', 'Dear {FIRSTNAME},\n\nRecently we invited you to participate in a survey.\n\nWe note that you have not yet completed the survey, and wish to remind you that the survey is still available should you wish to take part.\n\nThe survey is titled:\n\\\"{SURVEYNAME}\\\"\n\n\\\"{SURVEYDESCRIPTION}\\\"\n\nTo participate, please click on the link below.\n\nSincerely,\n\n{ADMINNAME} ({ADMINEMAIL})\n\n----------------------------------------------\nClick here to do the survey:\n{SURVEYURL}', 'SURVEY REGISTRATION CONFIRMATION', 'Dear {FIRSTNAME},\n\nYou, or someone using your email address, have registered to participate in an online survey titled {SURVEYNAME}.\n\nTo complete this survey, click on the following URL:\n\n{SURVEYURL}\n\nIf you have any questions about this survey, or if you did not register to participate and believe this email is in error, please contact {ADMINNAME} at {ADMINEMAIL}.', 'CONFIRMATION OF COMPLETION', 'Dear {FIRSTNAME},\n\nThis email is to confirm that you have completed the survey titled {SURVEYNAME} and your response has been saved. Thank you for participating.\n\nIf you have any further questions about this email, please contact {ADMINNAME} on {ADMINEMAIL}.\n\nSincerely,\n\n{ADMINNAME}',
																    
																    'N','0','N','N','Y','N');</xsl:element>
		
		<!-- then move on to sections -->
		<xsl:apply-templates select="section"/>

		</xsl:element>
	</xsl:template>
	

	<xsl:template match="questionnaireInfo">
		<xsl:if test="administration='self'">
			<xsl:for-each select="text">
				<xsl:call-template name="escape-apos" ><xsl:with-param name="string" select="."/></xsl:call-template><br/><br/>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>


	<xsl:template match="section">
		<!-- insert all the questions in this section -->
		
		<xsl:element name="group">
		
			<xsl:element name="comment">This is a new section</xsl:element>
				<xsl:element name="insert">INSERT INTO groups (`gid`, `sid`, `group_name`, `description`) VALUES ('<xsl:element name="groupid"/>', '<xsl:element name="surveyid"/>', '<xsl:number count="/questionnaire/section" format="0001"/>', '<xsl:value-of select="sectionInfo[position = 'title' and administration='self']/text"/>\n');</xsl:element>	

		
		<!-- put in section text -->
		<xsl:apply-templates select="sectionInfo"/>
		
				
		<xsl:apply-templates select="question"/>
		
		
		</xsl:element>
		

	</xsl:template>
	


	<!-- Section info template -->
	<xsl:template match="sectionInfo">
		<xsl:if test="position='before' and administration='self'">
		<xsl:element name="comment">This is a section text</xsl:element>
		
		<xsl:element name="insert">INSERT INTO questions (`qid`, `sid`, `gid`, `type`, `title`, `question`, `preg`, `help`, `other`, `mandatory`, `lid`) VALUES ('<xsl:element name="qid"/>', '1', '<xsl:element name="groupidchoice"/>', 'X', '<xsl:element name="position"/>SECTIONTEXT', '<xsl:call-template name="escape-apos" ><xsl:with-param name="string" select="text"/></xsl:call-template>', '', '', 'N', 'N', '');</xsl:element>		
		
		</xsl:if>
	</xsl:template>	
	

	<!-- for each question in the queXML questionnaire 
	-->
	
	<xsl:template match="question">
	
		
		<!-- also qualifiers and specifiers -->
		<xsl:variable name="qtext">
			<xsl:call-template name="escape-apos" >
				<xsl:with-param name="string">
			<xsl:choose>
				<xsl:when test="(count(qualifier) + count(specifier)) = 2">
					<xsl:for-each select="text">
						<xsl:if test="not(position() = 1)">.</xsl:if>
						<xsl:value-of select="." />
					 </xsl:for-each><xsl:element name="text"> : </xsl:element><xsl:value-of select="qualifier"/><xsl:element name="text"> : </xsl:element><xsl:value-of select="specifier"/>
				</xsl:when>
				<xsl:when test="count(qualifier) = 1">
					<xsl:for-each select="text">
						<xsl:if test="not(position() = 1)">.</xsl:if>
						<xsl:value-of select="." />
					 </xsl:for-each><xsl:element name="text"> : </xsl:element><xsl:value-of select="qualifier"/>
				</xsl:when>
				<xsl:when test="count(specifier) = 1">
					<xsl:for-each select="text">
						<xsl:if test="not(position() = 1)">.</xsl:if>
						<xsl:value-of select="." />
					 </xsl:for-each><xsl:element name="text"> : </xsl:element><xsl:value-of select="specifier"/>				
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="text">
						<xsl:if test="not(position() = 1)">.</xsl:if>
						<xsl:value-of select="." />
					 </xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
	
		<!-- now consider matrix questions -->
		<xsl:choose>
			<!-- when there is a matrix question of free responses
					can assume only one response field applies
					and is copied from each -->			
			<xsl:when test="count(subQuestion) > 0 and count(response/free) = 1">
				<!-- in this case we are basically looping over free responses with subquestion text appended -->
	
				<!-- Make the original text a section text -->
				<xsl:element name="comment">This is a matrix of free response question</xsl:element>
				
				
				<!-- Multiple Short Text (Type Q) users answers table -->
				<xsl:element name="insert">
	INSERT INTO questions (`qid`, `sid`, `gid`, `type`, `title`, `question`, `preg`, `help`, `other`, `mandatory`, `lid`) VALUES ('<xsl:element name="qid"/>', '<xsl:element name="surveyid"/>', '<xsl:element name="groupidchoice"/>', 'Q', '<xsl:element name="position"/>', '<xsl:call-template name="escape-apos" ><xsl:with-param name="string" select="text"/></xsl:call-template>', '', '<xsl:apply-templates select="directive"/>', 'N', 'N', '');</xsl:element>
	

				<!-- NOTE: This should update the answers table -->
				<xsl:for-each select="subQuestion">
					<xsl:apply-templates select="../response">
						<xsl:with-param name="qtext"><xsl:call-template name="escape-apos" ><xsl:with-param name="string" select="text"/></xsl:call-template></xsl:with-param>
						<xsl:with-param name="varName" select="@varName"/>
					</xsl:apply-templates>				
				</xsl:for-each>

			</xsl:when>


			<!-- when there is a matrix question
					can assume only one response field applies
					and is copied from each -->			
			<xsl:when test="count(subQuestion) > 0">

				<xsl:variable name="varName"><xsl:value-of select="response/@varName"/></xsl:variable>
				<!-- width in this case is the number of responses -->
				<xsl:variable name="width"><xsl:value-of select="count(response/fixed/category)"/></xsl:variable>
			
				<xsl:element name="question">
					<xsl:element name="comment">Inserting a matrix question</xsl:element>

					<!-- type F for normal matrix question, type H for rotated -->
					<xsl:element name="insert">
					INSERT INTO questions (`qid`, `sid`, `gid`, `type`, `title`, `question`, `preg`, `help`, `other`, `mandatory`, `lid`) VALUES ('<xsl:element name="qid"/>', '<xsl:element name="surveyid"/>', '<xsl:element name="groupidchoice"/>', '<xsl:choose><xsl:when test="response/fixed/@rotate='true'">H</xsl:when><xsl:otherwise>F</xsl:otherwise></xsl:choose>', '<xsl:element name="position"/>', '<xsl:value-of select="$qtext"/>','', '<xsl:apply-templates select="directive"/>','N', 'N', '<xsl:element name="lid"/>');
					</xsl:element>

				<!-- add a question attribute that makes it the right width 
						By default, phpSurveyor gives the question text 20% - we want more!-->
						
					<xsl:element name="insert">INSERT INTO question_attributes (`qaid`,`qid`,`attribute`,`value`) VALUES (NULL,'<xsl:element name="qidchoice"/>','answer_width','60');</xsl:element>

				<!-- for the "answers" component -->
				<xsl:apply-templates select="subQuestion"/>


					<!-- insert the category labels -->

					<!-- first create a labelset -->
					<xsl:apply-templates select="response/fixed"/>
					<!-- now insert labels -->
					<xsl:apply-templates select="response/fixed/category" mode="subQuestion"/>
				</xsl:element>

			</xsl:when>
			
			<!-- Where there are multiple responses with fixed categories with single category responses, assume a multi question layout -->
			<xsl:when test="(count(response) > 1) and (count(response/fixed) > 0)">
		
				<xsl:variable name="varName"><xsl:value-of select="response/@varName"/></xsl:variable>
				<xsl:variable name="width">1</xsl:variable>
				
				
				
			
					<xsl:element name="question">
					<xsl:element name="comment">Inserting a question multi question question (checkbox)</xsl:element>


				<xsl:element name="insert">
INSERT INTO questions (`qid`, `sid`, `gid`, `type`, `title`, `question`, `preg`, `help`, `other`, `mandatory`, `lid`) VALUES ('<xsl:element name="qid"/>', '<xsl:element name="surveyid"/>', '<xsl:element name="groupidchoice"/>', 'M', '<xsl:element name="position"/><xsl:value-of select="$varName"/>', '<xsl:value-of select="$qtext"/>', '', '<xsl:apply-templates select="directive"/>', 'N', 'N', '');</xsl:element>
					
					
					<xsl:for-each select="response">
						<xsl:apply-templates select="fixed/category" mode="multi"/>
					</xsl:for-each>
					</xsl:element>

			</xsl:when>

			<!-- when there is a simple response question -->
			<xsl:otherwise>
				<xsl:apply-templates select="response" mode="all">
					<xsl:with-param name="qtext" select="$qtext"/>
					<xsl:with-param name="label"><xsl:apply-templates select="directive"/></xsl:with-param>
				</xsl:apply-templates>				
			</xsl:otherwise>
		</xsl:choose>
	
	
	</xsl:template>
	
	
		<xsl:template match="directive">
			<xsl:if test="administration='self'">
			<xsl:call-template name="escape-apos" ><xsl:with-param name="string" select="text"/></xsl:call-template>
			</xsl:if>
		</xsl:template>
	

	<!-- subQuestion template deals with each subQuestion in turn, insert into answers table -->
	<xsl:template match="subQuestion">
	
		<xsl:element name="insert">INSERT INTO answers (`qid`, `code`, `answer`, `default_value`, `sortorder`) VALUES ('<xsl:element name="qidchoice"/>', '<xsl:value-of select="@varName"/>', '<xsl:call-template name="escape-apos" ><xsl:with-param name="string" select="text"/></xsl:call-template>', 'N', '<xsl:number format="0001" level="any"/>');</xsl:element>	
		
	</xsl:template>



	<!-- applies to all responses the varName variable -->
	<xsl:template match="response" mode="all">
		<xsl:param name="qtext"/>
		<xsl:param name="label"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="qtext" select="$qtext"/>
			<xsl:with-param name="varName" select="@varName"/>
			<xsl:with-param name="label" select="$label"/>
		</xsl:apply-templates>
	</xsl:template>

	<!-- match a checkbox style response -->



	<!-- match a response -->
	<xsl:template match="response">
		<xsl:param name="varName"/>
		<xsl:param name="qtext"/>
		<xsl:param name="label"/>

		<xsl:choose>
			<xsl:when test="count(free)>0">
				
				<xsl:choose>
					
					<xsl:when test="(free/format = 'integer') or (free/format = 'currency')">

						<xsl:call-template name="variable">
							<xsl:with-param name="varName" select="$varName"/>
							<xsl:with-param name="qtext" select="$qtext"/>
							<xsl:with-param name="width" select="free/length"/>
							
							<xsl:with-param name="qtype">N</xsl:with-param>
							
							<xsl:with-param name="label" select="concat($label, free/label)"/>
						</xsl:call-template>



					</xsl:when>

					<xsl:when test="(free/format = 'longtext')">

						<xsl:call-template name="variable">
							<xsl:with-param name="varName" select="$varName"/>
							<xsl:with-param name="qtext" select="$qtext"/>
							<xsl:with-param name="width" select="free/length"/>
							
							<xsl:with-param name="qtype">T</xsl:with-param>
							<xsl:with-param name="type">character</xsl:with-param>
							<xsl:with-param name="label" select="concat($label, free/label)"/>
						</xsl:call-template>



					</xsl:when>


					<xsl:otherwise>

						<xsl:call-template name="variable">
							<xsl:with-param name="varName" select="$varName"/>
							<xsl:with-param name="qtext" select="$qtext"/>
							<xsl:with-param name="width" select="free/length"/>

							
					<xsl:with-param name="qtype">S</xsl:with-param>		
								<xsl:with-param name="type">character</xsl:with-param>					
						
							<xsl:with-param name="label" select="concat($label, free/label)"/>
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


			<xsl:choose>
				<xsl:when test="fixed/@rotate='true'">
				
				<xsl:call-template name="variable">
					<xsl:with-param name="varName" select="$varName"/>
					<xsl:with-param name="qtext" select="$qtext"/>
					<xsl:with-param name="width" select="$the_max"/>
					<!-- default is numeric
										<xsl:with-param name="type">character</xsl:with-param>					-->
					<xsl:with-param name="qtype">W</xsl:with-param>
					<xsl:with-param name="label" select="$label"/>
				</xsl:call-template>
				
				
				</xsl:when>
				<xsl:otherwise>

				<xsl:call-template name="variable">
					<xsl:with-param name="varName" select="$varName"/>
					<xsl:with-param name="qtext" select="$qtext"/>
					<xsl:with-param name="width" select="$the_max"/>
					<!-- default is numeric
										<xsl:with-param name="type">character</xsl:with-param>					-->
					<xsl:with-param name="qtype">Z</xsl:with-param>					
					<xsl:with-param name="label" select="$label"/>					
				</xsl:call-template>


				
				</xsl:otherwise>
			</xsl:choose>

							
			</xsl:otherwise>
		</xsl:choose>
				
	
	</xsl:template>




	<!-- template for a variable -->
	<xsl:template name="variable">
		<xsl:param name="varName"/>
		<xsl:param name="qtext"/>
		<xsl:param name="width"/>
		<xsl:param name="qtype"/>
		<xsl:param name="label"></xsl:param>
		<xsl:param name="type">numeric</xsl:param>
		<xsl:param name="ivuInstr"/>

		<!-- qtype variable for phpSurveyor -->

<!-- List question (Type W for dropdown list or Z for radio labels) uses labelsets-->
<!-- Date question  (Type D) -->
<!-- Array (Type F for normal, Type H for rotated) Uses answers (subQuestions) and labelsets (response categories) -->
	<!-- Multiple Short Text (Type Q) users answers table -->
		<!-- Long Text Input (Type T) -->
<!-- Short Text Input (Type S) -->
				<!-- Numerical Input (Type N )-->
		<!-- Multiple Options (Type M)  uses answers table--> 

	
		<xsl:element name="question">
		<xsl:element name="comment">Inserting question</xsl:element>

<xsl:element name="insert">INSERT INTO questions (`qid`, `sid`, `gid`, `type`, `title`, `question`, `preg`, `help`, `other`, `mandatory`, `lid`) VALUES ('<xsl:element name="qid"/>', '<xsl:element name="surveyid"/>', '<xsl:element name="groupidchoice"/>', '<xsl:value-of select="$qtype"/>', '<xsl:element name="position"/><xsl:value-of select="$varName"/>', '<xsl:value-of select="$qtext"/>', '', '<xsl:value-of select="$label"/>', 'N', 'N', '<xsl:element name="lid"/>');</xsl:element>

	
					
					<!-- if this is a fixed response - insert the category labels -->
				<xsl:apply-templates select="fixed"/>
					<xsl:apply-templates select="fixed/category"/>
		
		</xsl:element>

		<!-- handle contingent questions of this fixed group -->
		<xsl:for-each select="fixed/category/contingentQuestion">
		</xsl:for-each>


		
	</xsl:template>


	<xsl:template match="contingentQuestion">

		<xsl:element name="cquestion">
		<xsl:element name="comment">Inserting CONTINGENT question</xsl:element>

<xsl:element name="insert">INSERT INTO questions (`qid`, `sid`, `gid`, `type`, `title`, `question`, `preg`, `help`, `other`, `mandatory`, `lid`) VALUES ('<xsl:element name="qid"/>', '<xsl:element name="surveyid"/>', '<xsl:element name="groupidchoice"/>', 'S', '<xsl:element name="position"/><xsl:value-of select="@varName"/>', '<xsl:call-template name="escape-apos" ><xsl:with-param name="string" select="text"/></xsl:call-template>', '', '', 'N', 'N', '');</xsl:element>

<xsl:element name="insert">INSERT INTO conditions (`cid`, `qid`, `cqid`, `cfieldname`, `method`, `value`) VALUES ('<xsl:element name="cid"/>', '<xsl:element name="tqid"/>', '<xsl:element name="cqid"/>', '<xsl:element name="surveyid"/>X<xsl:element name="groupidchoice"/>X<xsl:element name="cqid"/>', '', '<xsl:value-of select="../value"/>');</xsl:element>

		</xsl:element>
	
	
	</xsl:template>


	<!-- fixed response requries a labelset -->
	<xsl:template match="fixed">
	<xsl:element name="insert">INSERT INTO labelsets (`lid`, `label_name`) VALUES ('<xsl:element name="lidchoice"/>', '<xsl:value-of select="@varName"/>');</xsl:element>		
	</xsl:template>


	<!-- insert lid elements into labels tables-->
	<xsl:template match="category">
		
				<xsl:element name="insert">INSERT INTO labels (`lid`, `code`, `title`, `sortorder`) VALUES ('<xsl:element name="lidchoice"/>', '<xsl:value-of select="value"/>', '<xsl:call-template name="escape-apos" ><xsl:with-param name="string" select="label"/></xsl:call-template>', '<xsl:number value="value" format="0001"/>');</xsl:element>	


		<!-- check for contingents -->
		<xsl:apply-templates select="contingentQuestion"/>
		
	</xsl:template>

	<!-- insert lid elements into answers table for multi questions-->
	<xsl:template match="category" mode="multi">
		
		<xsl:element name="insert">INSERT INTO answers (`qid`, `code`, `answer`, `default_value`, `sortorder`) VALUES ('<xsl:element name="qidchoice"/>', '<xsl:value-of select="value"/>', '<xsl:call-template name="escape-apos" ><xsl:with-param name="string" select="label"/></xsl:call-template>', 'N', '<xsl:number value="value" format="0001"/>');</xsl:element>	


		
	</xsl:template>



	<xsl:template match="category" mode="subQuestion">

				<xsl:element name="insert">INSERT INTO labels (`lid`, `code`, `title`, `sortorder`) VALUES ('<xsl:element name="lidchoice"/>', '<xsl:value-of select="value"/>', '<xsl:call-template name="escape-apos" ><xsl:with-param name="string" select="label"/></xsl:call-template>', '<xsl:number value="value" format="0001"/>');</xsl:element>	


		<!-- check for contingents -->
		<xsl:choose>
			<xsl:when test="count(contingentQuestion) = 1">
				
			</xsl:when>
			<xsl:otherwise>	
				
			</xsl:otherwise>
		</xsl:choose>


	</xsl:template>


	
</xsl:stylesheet>
