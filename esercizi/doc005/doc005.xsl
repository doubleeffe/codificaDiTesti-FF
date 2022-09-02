<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html>
		<head>
		<title><xsl:value-of select="//tei:titleStmt//tei:title" /></title>
		</head>
		<body>
		<h2><xsl:value-of select="//tei:titleStmt//tei:title" /></h2>
		<h2><xsl:value-of select="//tei:titleStmt//tei:author"></xsl:value-of></h2>
		<div class="source">
			<div>
				<xsl:apply-templates select="//tei:sourceDesc" />
			</div>
		</div>

		<div id="body_doc">
			<xsl:apply-templates select="//tei:div[@id='body_doc']" />
		</div>

		</body>
		</html>
	</xsl:template>
</xsl:stylesheet>