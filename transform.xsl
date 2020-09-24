<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="html" />
	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:text>PubMed2bitTex Transformation</xsl:text>
				</title>
			</head>
			<body bgcolor="#ffffff">
				<div >
					<xsl:apply-templates
						select="ArticleSet/Article" />						
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="ArticleSet/Article">
		<div>
			<xsl:text>@{</xsl:text>
			<xsl:apply-templates select="AuthorList"
				mode="outline" />
			<xsl:value-of select="./Journal/PubDate/Year" />
			<xsl:variable name="title" select="./ArticleTitle" />
			<xsl:value-of select="substring-before($title, ' ')" />
		</div>
		<div type="outline_item">
			<div>
				<xsl:apply-templates select="ArticleTitle" />
				<xsl:text>,&#10;</xsl:text>
			</div>
			<div>
				<xsl:text>page&#x9;={</xsl:text>
				<xsl:value-of select="FirstPage" />-<xsl:value-of select="LastPage" />
				<xsl:text>},&#10;</xsl:text>
			</div>
			<xsl:apply-templates select="AuthorList"
				mode="inside" />
			<xsl:apply-templates select="Journal"
				mode="jname" />	
			<xsl:apply-templates select="Journal"
				mode="jvolume" />	
			<xsl:apply-templates select="Journal"
				mode="jissue" />
			<xsl:apply-templates select="Journal"
				mode="jpublisher" />
			<xsl:apply-templates select="ArticleIdList" />
			<xsl:apply-templates select="Abstract" />			
		</div>
		<div>
			<xsl:text>}</xsl:text>
		</div><br/>
	</xsl:template>

	<xsl:template match="AuthorList" mode="inside">
		<xsl:text>author&#x9;={</xsl:text>
		<xsl:for-each select="Author">
			<xsl:apply-templates select="./FirstName" />
			<xsl:apply-templates select="./MiddleName" />
			<xsl:apply-templates select="./LastName" />
			<xsl:apply-templates select="./CollectiveName" />
			<xsl:if test="not(position() = last())">
				<xsl:text> and </xsl:text>
			</xsl:if>
		</xsl:for-each>
		<xsl:text>},</xsl:text>
	</xsl:template>

	<xsl:template match="Journal" mode="jname">
		<div>
		<xsl:text>journal&#x9;={</xsl:text>
		<xsl:value-of select="JournalTitle" />
		<xsl:text>},</xsl:text>
		</div>
	</xsl:template>

	<xsl:template match="Journal" mode="jvolume">
		<div>
		<xsl:text>volume&#x9;={</xsl:text>
		<xsl:value-of select="Volume" />
		<xsl:text>},</xsl:text>
		</div>
	</xsl:template>
	
	<xsl:template match="Journal" mode="jissue">
		<div>
		<xsl:text>volume&#x9;={</xsl:text>
		<xsl:value-of select="Issue" />
		<xsl:text>},</xsl:text>
		</div>
	</xsl:template>
	
	<xsl:template match="Journal" mode="jpublisher">
		<div>
		<xsl:text>publisher&#x9;={</xsl:text>
		<xsl:value-of select="PublisherName" />
		<xsl:text>},</xsl:text>
		</div>
	</xsl:template>
	
	<xsl:template match="ArticleIdList">
		<div>
		<xsl:text>DOI&#x9;={</xsl:text>
		<xsl:value-of select="ArticleId[@IdType='doi']" />
		<xsl:text>},</xsl:text>
		</div>
	</xsl:template>
	
		<xsl:template match="Abstract">
		<div>
		<xsl:text>abstractr&#x9;={</xsl:text>
		<xsl:value-of select="." />
		<xsl:text>}</xsl:text>
		</div>
	</xsl:template>
<!-- 	<xsl:template match="Journal" mode="jname">
	
	</xsl:template>
	
	<xsl:template match="Journal" mode="jname">
	
	</xsl:template> -->

	<xsl:template match="ArticleTitle">
		<xsl:text>title&#x9;={</xsl:text>
		<xsl:value-of select="." />
		<xsl:text>}</xsl:text>
	</xsl:template>

	<xsl:template match="CollectiveName">
		<xsl:value-of select="." />
	</xsl:template>

	<xsl:template match="FirstName">
		<xsl:value-of select="." />
		<xsl:text> </xsl:text>
	</xsl:template>

	<xsl:template match="MiddleName">
		<xsl:value-of select="." />
		<xsl:text> </xsl:text>
	</xsl:template>

	<xsl:template match="LastName">
		<xsl:value-of select="." />
	</xsl:template>

	<xsl:template match="AuthorList" mode="outline">
		<xsl:if test="./Author[1]/LastName">
			<xsl:value-of select="./Author[1]/LastName" />
		</xsl:if>
		<xsl:if test="./Author[1]/CollectiveName">
			<xsl:variable name="cname"
				select="../AuthorList/Author[1]/CollectiveName" />
			<xsl:value-of select="substring-before($cname, ' ')" />
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>