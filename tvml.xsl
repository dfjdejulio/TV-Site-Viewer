<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- Every TVML document is wrapped in a "document" element. -->
<xsl:template match="/document">
<!-- Fetch the first title element -->
<xsl:variable name="title" select="//title"/>
<!-- Fetch the first description element. -->
<xsl:variable name="description" select="//description"/>
<html>
<head>
<title><xsl:value-of select="$title"/></title>
</head>
<body>
<h1><xsl:value-of select="$title"/></h1>
<hr/>
<p><xsl:value-of select="$description"/></p>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
