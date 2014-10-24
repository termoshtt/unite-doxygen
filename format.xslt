<?xml version="1.0" ?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" encoding="UTF-8"/>

  <xsl:template match="/add">
    <root>
      <xsl:apply-templates select="doc"/>
    </root>
  </xsl:template>

  <xsl:template match="doc">
    <xsl:value-of select="field[@name='url']"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="field[@name='type']"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="field[@name='name']"/>
    <xsl:value-of select="field[@name='args']"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="field[@name='text']"/>
    <xsl:text></xsl:text>
  </xsl:template>

</xsl:stylesheet>
