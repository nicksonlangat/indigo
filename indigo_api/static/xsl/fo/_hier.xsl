<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
                xmlns:akn="http://docs.oasis-open.org/legaldocml/ns/akn/3.0"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- containers
   - heading centered
   - content
   -->
  <xsl:template match="akn:article|akn:book|akn:clause|akn:chapter|akn:division|akn:part|akn:subchapter|akn:subclause|akn:subdivision|akn:subpart|akn:subtitle|akn:title|akn:tome">
    <fo:block-container>
      <fo:block margin-top="{$para-spacing}*2" font-size="{$fontsize-h2}" text-align="center" widows="2" orphans="2" keep-with-next="always" id="{@eId}" start-indent="0" font-weight="bold">
        <!-- keyword before certain containers -->
        <xsl:if test="self::akn:article">
          <xsl:text>Article </xsl:text>
        </xsl:if>
        <xsl:if test="self::akn:book">
          <xsl:text>Book </xsl:text>
        </xsl:if>
        <xsl:if test="self::akn:clause">
          <xsl:text>Clause </xsl:text>
        </xsl:if>
        <xsl:if test="self::akn:chapter">
          <xsl:text>Chapter </xsl:text>
        </xsl:if>
        <xsl:if test="self::akn:part">
          <xsl:text>Part </xsl:text>
        </xsl:if>
        <xsl:if test="self::akn:title">
          <xsl:text>Title </xsl:text>
        </xsl:if>
        <xsl:if test="self::akn:tome">
          <xsl:text>Tome </xsl:text>
        </xsl:if>
        <!-- num is always rendered (if there is one) -->
        <xsl:apply-templates select="akn:num"/>
        <xsl:if test="akn:heading">
          <!-- final character of num (if there is one) -->
          <xsl:variable name="terminus">
            <xsl:value-of select="substring(akn:num, string-length(akn:num))"/>
          </xsl:variable>
          <xsl:choose>
            <!-- certain containers get their heading on the next line -->
            <xsl:when test="self::akn:book or self::akn:chapter or self::akn:title or self::akn:tome">
              <fo:block keep-with-previous="always">
                <xsl:apply-templates select="akn:heading"/>
              </fo:block>
            </xsl:when>
            <!-- certain containers get a dash before the heading, unless there is a num and it ends in a stop or colon -->
            <xsl:when test="self::akn:article or self::akn:clause or self::akn:part">
              <xsl:if test="not($terminus='.' or $terminus=':')">
                <xsl:text> –</xsl:text>
              </xsl:if>
              <xsl:text> </xsl:text>
              <xsl:apply-templates select="akn:heading"/>
            </xsl:when>
            <!-- all other containers get a dash before the heading, only if there is a num and it doesn't end in a stop or colon -->
            <xsl:otherwise>
              <xsl:if test="akn:num and not($terminus='.' or $terminus=':')">
                <xsl:text> –</xsl:text>
              </xsl:if>
              <xsl:text> </xsl:text>
              <xsl:apply-templates select="akn:heading"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </fo:block>
      <fo:block margin-top="{$para-spacing}">
        <xsl:apply-templates select="./*[not(self::akn:num|self::akn:heading)]"/>
      </fo:block>
    </fo:block-container>
  </xsl:template>

  <!-- schedules
   - heading centered
   - subheading centered
   - content
   -->
  <xsl:template match="akn:attachment">
    <fo:block margin-top="{$para-spacing}*2" font-size="{$fontsize-h2}" text-align="center" widows="2" orphans="2" keep-with-next="always" id="{@eId}">
      <fo:inline font-weight="bold">
        <xsl:apply-templates select="akn:heading"/>
      </fo:inline>
    </fo:block>
    <fo:block margin-top="{$para-spacing}" font-size="{$fontsize-h2}" text-align="center" widows="2" orphans="2" keep-with-next="always">
      <fo:inline font-weight="bold">
        <xsl:apply-templates select="akn:subheading"/>
      </fo:inline>
    </fo:block>
    <xsl:apply-templates select="./*[not(self::akn:heading|self::akn:subheading)]"/>
  </xsl:template>

  <!-- TODO / WIP: make all basic units into list-items -->
  <xsl:template match="akn:rule|akn:section">
    <!-- use a block container to retain relative indentation (nesting depth) -->
    <fo:block-container>
      <fo:list-block start-indent="0" margin-top="{$para-spacing}*2">
        <fo:list-item id="{@eId}">
          <fo:list-item-label>
            <fo:block font-weight="bold" font-size="{$fontsize-h3}">
              <!-- optionally include startQuote character with num -->
              <xsl:choose>
                <xsl:when test="parent::akn:embeddedStructure and not(preceding-sibling::*)">
                  <xsl:call-template name="start-quote">
                    <xsl:with-param name="quote-char" select="parent::akn:embeddedStructure/@startQuote"/>
                    <xsl:with-param name="num" select="akn:num"/>
                  </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="akn:num"/>
                </xsl:otherwise>
              </xsl:choose>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="{$indent}">
            <!-- basic units always get a heading; use a non-breaking space if it's missing for alignment -->
            <fo:block font-weight="bold" font-size="{$fontsize-h3}" keep-with-next="always">
              <xsl:apply-templates select="akn:heading"/>
              <xsl:if test="not(akn:heading)">
                <xsl:text>&#160;</xsl:text>
              </xsl:if>
            </fo:block>
            <!-- basic unit content always goes below the num -->
            <xsl:apply-templates select="./*[not(self::akn:num|self::akn:heading)]"/>
          </fo:list-item-body>
        </fo:list-item>
      </fo:list-block>
    </fo:block-container>
  </xsl:template>

  <!-- basic unit
   - number to the side, bold (if present)
   - heading in bold (if present)
   - content in next block regardless of whether there's a heading
   -->
  <xsl:template match="akn:section|akn:rule">
    <fo:block-container>
      <fo:block start-indent="{$indent}" margin-top="{$para-spacing}*2" font-size="{$fontsize-h3}" widows="2" orphans="2" id="{@eId}">
        <!-- 'float' number to the side, in bold; deal with opening quote character if relevant -->
        <xsl:if test="akn:num">
          <fo:inline-container width="0" height="0" margin-left="-{$indent}">
            <fo:block>
              <!-- include the opening quote here if the quote didn't start with a p (and this is the first element) -->
              <!-- TODO: test and adjust once quotes are supported -->
              <xsl:if test="parent::akn:embeddedStructure and not(preceding-sibling::*)">
                <xsl:call-template name="start-quote">
                  <xsl:with-param name="quote-char" select="parent::akn:embeddedStructure/@startQuote"/>
                </xsl:call-template>
              </xsl:if>
              <fo:inline font-weight="bold">
                <xsl:apply-templates select="akn:num"/>
              </fo:inline>
            </fo:block>
          </fo:inline-container>
        </xsl:if>
        <!-- heading in bold -->
        <xsl:if test="akn:heading">
          <fo:inline font-weight="bold">
            <xsl:apply-templates select="akn:heading"/>
          </fo:inline>
        </xsl:if>
        <!-- regardless of whether a basic unit has a heading, the content comes in its own block after the num -->
        <fo:block margin-top="{$para-spacing}" font-size="{$fontsize}" keep-with-previous="always">
          <xsl:apply-templates select="./*[not(self::akn:num|self::akn:heading)]"/>
        </fo:block>
      </fo:block>
    </fo:block-container>
  </xsl:template>

  <!-- TODO / WIP: make all generic hierarchical elements into list-items -->
  <xsl:template match="akn:alinea|akn:indent|akn:blockList/akn:item|akn:level|akn:list|akn:paragraph|akn:point|
                       akn:proviso|akn:sublist|akn:subparagraph|akn:subrule|akn:subsection|akn:transitional|
                       akn:li[not(parent::akn:ul[@class='notice-list'])]">
    <!-- use a block container to retain relative indentation (nesting depth) -->
    <fo:block-container>
      <fo:list-block start-indent="0">
        <fo:list-item id="{@eId}">
          <fo:list-item-label>
            <fo:block margin-top="{$para-spacing}">
              <xsl:value-of select="akn:num"/>
              <!-- bullets for li -->
              <xsl:if test="self::akn:li">
                <xsl:text>&#x2022;</xsl:text>
              </xsl:if>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="{$indent}">
            <fo:block>
              <!-- optional heading in its own block -->
              <xsl:if test="akn:heading">
                <fo:block margin-top="{$para-spacing}" font-weight="bold">
                  <xsl:apply-templates select="akn:heading"/>
                </fo:block>
              </xsl:if>
              <xsl:apply-templates select="./*[not(self::akn:num|self::akn:heading)]"/>
            </fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </fo:list-block>
    </fo:block-container>
  </xsl:template>

  <!-- all other hierarchical and numbered elements
   - number to the side (if present)
   - heading in bold (if present)
   - content
   -->
  <xsl:template match="akn:alinea|akn:indent|akn:blockList/akn:item|akn:level|akn:list|akn:paragraph|akn:point|akn:proviso|akn:sublist|akn:subparagraph|akn:subrule|akn:subsection|akn:transitional|akn:ul[not(@class='notice-list')]/akn:li">
    <fo:block-container>
      <fo:block start-indent="{$indent}" margin-top="{$para-spacing}" widows="2" orphans="2" id="{@eId}">
        <!-- 'float' number to the side -->
        <xsl:if test="akn:num">
          <fo:inline-container width="0" height="0" margin-left="-{$indent}">
            <fo:block>
              <!-- include the opening quote here if the quote didn't start with a p (and this is the first element) -->
              <!-- TODO: test and adjust once quotes are supported -->
              <xsl:if test="parent::akn:embeddedStructure and not(preceding-sibling::*)">
                <xsl:call-template name="start-quote">
                  <xsl:with-param name="quote-char" select="parent::akn:embeddedStructure/@startQuote"/>
                </xsl:call-template>
              </xsl:if>
              <xsl:apply-templates select="akn:num"/>
            </fo:block>
          </fo:inline-container>
        </xsl:if>
        <xsl:if test="self::akn:li">
          <fo:inline-container width="0" height="0" margin-left="-{$indent-bullets}">
            <fo:block>
              <!-- include the opening quote here if the quote didn't start with a p (and this is the first element) -->
              <xsl:if test="parent::akn:ul/parent::akn:embeddedStructure and not(preceding-sibling::*) and not(parent::akn:ul/preceding-sibling::*)">
                <xsl:call-template name="start-quote">
                  <xsl:with-param name="quote-char" select="parent::akn:ul/parent::akn:embeddedStructure/@startQuote"/>
                </xsl:call-template>
              </xsl:if>
              <xsl:text>&#x2022;</xsl:text>
            </fo:block>
          </fo:inline-container>
        </xsl:if>
        <!-- heading in bold -->
        <xsl:if test="akn:heading">
          <fo:inline font-weight="bold">
            <xsl:apply-templates select="akn:heading"/>
          </fo:inline>
        </xsl:if>
        <xsl:choose>
          <!-- if the element had a heading, the content comes in its own block -->
          <xsl:when test="akn:heading">
            <fo:block margin-top="{$para-spacing}" keep-with-previous="always">
              <xsl:apply-templates select="./*[not(self::akn:num|self::akn:heading)]"/>
            </fo:block>
          </xsl:when>
          <!-- when there's no heading, the num and the content fall into the same block -->
          <xsl:otherwise>
            <xsl:apply-templates select="./*[not(self::akn:num)]"/>
          </xsl:otherwise>
        </xsl:choose>
      </fo:block>
    </fo:block-container>
  </xsl:template>

</xsl:stylesheet>
