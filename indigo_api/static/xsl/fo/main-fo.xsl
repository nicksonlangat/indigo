<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:fox="http://xmlgraphics.apache.org/fop/extensions"
                xmlns:akn="http://docs.oasis-open.org/legaldocml/ns/akn/3.0">
  <xsl:output method="xml"/>

  <xsl:include href="_blocks.xsl"/>
  <xsl:include href="_coverpage.xsl"/>
  <xsl:include href="_front-matter.xsl"/>
  <xsl:include href="_inlines.xsl"/>
  <xsl:include href="_preface-preamble.xsl"/>
  <xsl:include href="_toc.xsl"/>
  <xsl:include href="_variables.xsl"/>

  <xsl:strip-space elements="*"/>
  <!-- TODO: what is / isn't this list? -->
  <xsl:preserve-space elements="akn:a akn:affectedDocument akn:b akn:block akn:caption akn:change akn:concept akn:courtType akn:date akn:def akn:del akn:docCommittee akn:docDate akn:docIntroducer akn:docJurisdiction akn:docNumber akn:docProponent akn:docPurpose akn:docStage akn:docStatus akn:docTitle akn:docType akn:docketNumber akn:entity akn:event akn:extractText akn:fillIn akn:from akn:heading akn:i akn:inline akn:ins akn:judge akn:lawyer akn:legislature akn:li akn:listConclusion akn:listIntroduction akn:location akn:mmod akn:mod akn:mref akn:narrative akn:neutralCitation akn:num akn:object akn:omissis akn:opinion akn:organization akn:outcome akn:p akn:party akn:person akn:placeholder akn:process akn:quantity akn:quotedText akn:recordedTime akn:ref akn:relatedDocument akn:remark akn:rmod akn:role akn:rref akn:scene akn:session akn:shortTitle akn:signature akn:span akn:sub akn:subheading akn:summary akn:sup akn:term akn:tocItem akn:u akn:vote"/>

  <!-- root template -->
  <xsl:template match="/">
    <fo:root>
      <fo:layout-master-set>
        <!-- A4 page -->
        <fo:simple-page-master master-name="A4"
                               page-width="210mm" page-height="297mm"
                               margin-top="3cm" margin-bottom="3cm"
                               margin-left="2.5cm" margin-right="2.5cm">
          <fo:region-body/>
          <fo:region-before/>
          <fo:region-after/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <!-- bookmarks / outline -->
      <fo:bookmark-tree>
        <xsl:apply-templates select="//akn:toc" mode="bookmarks"/>
      </fo:bookmark-tree>

      <!-- front matter & table of contents, Roman page numbers -->
      <!-- TODO: don't force front matter, toc to be an even number of pages -->
      <!-- TODO: skip first page number, running header -->
      <fo:page-sequence master-reference="A4" initial-page-number="1" format="i">
        <fo:static-content flow-name="xsl-region-after">
          <fo:block font-family="{$font-fam-frontmatter}" font-size="{$fontsize-frontmatter-small}" text-align="center" margin-top="1cm">
            <fo:page-number/>
          </fo:block>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body">
          <fo:block-container font-family="{$font-fam}" font-size="{$fontsize}"
                              line-height="1.3" text-align="start">
            <xsl:apply-templates select="//akn:frontMatter"/>
          </fo:block-container>
        </fo:flow>
      </fo:page-sequence>

      <!-- main body, Arabic page numbers -->
      <!-- TODO: skip first page number, running header -->
      <fo:page-sequence master-reference="A4" initial-page-number="1" format="1">
        <fo:static-content flow-name="xsl-region-before">
          <fo:block font-family="{$font-fam}"
                    font-size="{$fontsize-frontmatter-small}"
                    line-height="1.3" text-align-last="justify"
                    border-bottom-style="solid"
                    border-bottom-color="{$accent-colour}"
                    margin-top="-1.5cm">
            <fo:block start-indent="1pt" end-indent="1pt">
              <fo:inline>
                <xsl:value-of select="//akn:div[@name='short-title']"/>
                <fo:leader leader-pattern="space"/>
                <xsl:value-of select="//akn:div[@name='place']"/>
              </fo:inline>
            </fo:block>
          </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="xsl-region-after">
          <fo:block font-family="{$font-fam}"
                    font-size="{$fontsize-frontmatter-small}"
                    text-align-last="justify"
                    border-top-style="solid"
                    border-top-color="{$accent-colour}"
                    margin-top="1cm" padding-top="3pt">
            <fo:block start-indent="2pt" end-indent="2pt">
              <fo:inline>
                <xsl:text>By </xsl:text>
                <fo:basic-link external-destination="https://edit.laws.africa/widgets/pdf-attribution"
                               color="{$link-colour}" text-decoration="underline">Laws.Africa</fo:basic-link>
                <xsl:text> and contributors. Licensed under </xsl:text>
                <fo:basic-link external-destination="https://edit.laws.africa/widgets/pdf-cc-by"
                               color="{$link-colour}" text-decoration="underline">CC-BY</fo:basic-link>
                <xsl:text>. Share widely and freely.</xsl:text>
                <fo:leader leader-pattern="space"/>
                <fo:page-number/>
              </fo:inline>
            </fo:block>
          </fo:block>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body">
          <fo:block-container font-family="{$font-fam}" font-size="{$fontsize}"
                              line-height="1.3" text-align="start">
            <xsl:apply-templates/>
          </fo:block-container>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <!-- the body -->

  <!-- TODO: add more / all doctypes? -->
  <xsl:template match="akn:act|akn:debate|akn:debateReport|akn:doc|akn:judgment|akn:statement">
    <fo:block>
      <xsl:apply-templates select="./*[not(self::akn:frontMatter)]"/>
    </fo:block>
  </xsl:template>

  <!-- defined terms -->
  <xsl:template match="akn:def">
    <fo:inline font-weight="bold">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <!-- containers
   - heading centered
   - content
   -->
  <xsl:template match="akn:article|akn:chapter|akn:division|akn:part|akn:subdivision|akn:subpart">
    <fo:block-container>
      <fo:block margin-top="{$para-spacing}*2" font-size="{$fontsize-h2}" text-align="center" widows="2" orphans="2" keep-with-next="always" id="{@eId}" start-indent="0">
        <fo:inline font-weight="bold">
          <xsl:choose>
            <xsl:when test="self::akn:chapter">
              <xsl:text>Chapter </xsl:text>
            </xsl:when>
            <xsl:when test="self::akn:part">
              <xsl:text>Part </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="akn:num"/>
          <!-- only include dash / break before the heading if there is a heading -->
          <xsl:if test="akn:heading">
            <xsl:choose>
              <xsl:when test="self::akn:chapter or self::akn:article">
                <fo:block>
                  <xsl:apply-templates select="akn:heading"/>
                </fo:block>
              </xsl:when>
              <xsl:when test="self::akn:part">
                <xsl:text> – </xsl:text>
                <xsl:apply-templates select="akn:heading"/>
              </xsl:when>
              <!-- don't include dash in subpart if there is no num (because it has no prefix) -->
              <xsl:otherwise>
                <xsl:if test="akn:num">
                  <xsl:text> – </xsl:text>
                </xsl:if>
                <xsl:apply-templates select="akn:heading"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </fo:inline>
      </fo:block>
      <fo:block margin-top="{$para-spacing}">
        <xsl:apply-templates select="./*[not(self::akn:num|self::akn:heading)]"/>
      </fo:block>
    </fo:block-container>
  </xsl:template>

  <!-- crossheadings -->
  <!-- TODO: don't match on hcontainer named 'crossheading' in future -->
  <xsl:template match="akn:hcontainer[@name='crossheading']|akn:crossHeading">
    <fo:block start-indent="0" margin-top="{$para-spacing}*1.5" font-size="{$fontsize-h3}" text-align="center">
      <fo:inline font-weight="bold" font-style="italic">
        <xsl:apply-templates/>
      </fo:inline>
    </fo:block>
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

  <!-- section (basic unit)
   - number to the side, bold (if present)
   - heading in bold (if present)
   - content in next block regardless of whether there's a heading
   -->
  <xsl:template match="akn:section">
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
        <!-- regardless of whether a section has a heading, the content comes in its own block after the num -->
        <fo:block margin-top="{$para-spacing}" font-size="{$fontsize}" keep-with-previous="always">
          <xsl:apply-templates select="./*[not(self::akn:num|self::akn:heading)]"/>
        </fo:block>
      </fo:block>
    </fo:block-container>
  </xsl:template>

  <!-- all other hierarchical and numbered elements
   - number to the side (if present)
   - heading in bold (if present)
   - content
   -->
  <xsl:template match="akn:subsection|akn:paragraph|akn:subparagraph|akn:blockList/akn:item">
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

  <!-- any p tag in the body if it isn't a first child should be in its own block, e.g.
   - second or third p in a section, paragraph, or quote
   - p in a paragraph after a quote
   -->
  <!-- TODO: Update blockList below to paragraph|subparagraph after Bluebell migration -->
  <xsl:template match="akn:p[position() &gt; 1 or preceding-sibling::akn:blockList] | akn:hcontainer ">
    <fo:block margin-top="{$para-spacing}">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- blockList/listIntroduction goes in a block if it's not the first paragraph -->
  <xsl:template match="akn:listIntroduction">
    <xsl:variable name="parent-position">
      <xsl:value-of select="count(parent::akn:blockList/preceding-sibling::akn:p) + 1"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$parent-position &gt; 1">
        <fo:block margin-top="{$para-spacing}">
          <xsl:apply-templates/>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- annotations (editorial remarks) -->
  <xsl:template match="akn:remark[@status='editorial']">
    <xsl:choose>
      <xsl:when test="position()=1 and position()=last()">
        <fo:block keep-with-previous="always">
          <fo:inline font-style="italic">
            <xsl:apply-templates/>
          </fo:inline>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:inline font-style="italic">
          <xsl:apply-templates/>
        </fo:inline>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- quotes are indented from both sides relative to their parent -->
  <!-- TODO: test and adjust once quotes are supported -->
  <xsl:template match="akn:embeddedStructure">
    <fo:block-container margin-top="{$para-spacing-quote}" margin-bottom="{$para-spacing-quote}" keep-with-previous="always">
      <fo:block start-indent="{$indent-quote}" end-indent="{$indent-quote}">
        <!-- don't include opening quote here if the quote doesn't start with a p -->
        <xsl:if test="akn:p">
          <xsl:call-template name="start-quote">
            <xsl:with-param name="quote-char" select="@startQuote"/>
          </xsl:call-template>
        </xsl:if>
        <xsl:apply-templates/>
      </fo:block>
    </fo:block-container>
  </xsl:template>

  <!-- outdent the opening quote so that the blocks in the quote line up visually -->
  <xsl:template name="start-quote">
    <xsl:param name="quote-char"/>
    <fo:inline-container width="0" margin-left="-{string-length($quote-char)}*6pt">
      <fo:block>
        <xsl:apply-templates select="$quote-char"/>
      </fo:block>
    </fo:inline-container>
  </xsl:template>

  <!-- footnotes -->
  <!-- TODO: test and adjust once footnotes are supported -->
  <xsl:template match="akn:authorialNote">
    <fo:footnote>
      <fo:inline>
        <xsl:apply-templates select="@marker"/>
      </fo:inline>
      <fo:footnote-body>
        <fo:block-container margin="0">
          <fo:block margin-top="{$para-spacing}" font-size="{$fontsize-footnote}">
            <fo:inline-container width="0" margin-left="-{$indent}"
                                 baseline-shift="super" font-size="{$fontsize-small}">
              <fo:block>
                <xsl:apply-templates select="@marker"/>
              </fo:block>
            </fo:inline-container>
            <xsl:apply-templates/>
          </fo:block>
        </fo:block-container>
      </fo:footnote-body>
    </fo:footnote>
  </xsl:template>

  <!-- tables -->
  <!-- TODO: make tables totally unindented so that they're properly centered -->
  <xsl:template match="akn:table">
    <fo:table width="100%" table-layout="fixed"
              margin-top="{$para-spacing-table}" margin-bottom="{$para-spacing-table}"
              keep-together="1">
      <fo:table-body>
        <xsl:apply-templates/>
      </fo:table-body>
    </fo:table>
  </xsl:template>

  <!-- TODO: revert to single / once HTML is converted to XSLT first -->
  <xsl:template match="akn:table//akn:tr">
    <fo:table-row>
      <xsl:apply-templates/>
    </fo:table-row>
  </xsl:template>

  <!-- TODO: revert to single / once HTML is converted to XSLT first -->
  <xsl:template match="akn:table//akn:tr/akn:th | akn:table//akn:tr/akn:td">
    <fo:table-cell border-style="solid" border-color="{$table-border-colour}" padding="6pt">
      <xsl:if test="@colspan">
        <xsl:attribute name="number-columns-spanned"><xsl:value-of select="@colspan"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="@rowspan">
        <xsl:attribute name="number-rows-spanned"><xsl:value-of select="@rowspan"/></xsl:attribute>
      </xsl:if>
      <fo:block start-indent="0" text-align="start" font-weight="normal">
        <!-- headings are bold and centered -->
        <xsl:if test="self::akn:th">
          <xsl:attribute name="font-weight">bold</xsl:attribute>
          <xsl:attribute name="text-align">center</xsl:attribute>
        </xsl:if>
        <xsl:apply-templates/>
      </fo:block>
    </fo:table-cell>
  </xsl:template>

  <!-- images -->
  <!-- TODO: make images totally unindented so that they're properly centered -->
  <xsl:template match="akn:img">
    <xsl:choose>
      <xsl:when test="position()=1 and position()=last()">
        <!-- standalone images -->
        <fo:block start-indent="0" text-align="center" margin-top="{$para-spacing}">
          <fo:external-graphic src="{@src}" width="100%"
                               content-height="100%" content-width="scale-to-fit"/>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <!-- inline images -->
        <fo:external-graphic src="{@src}" width="auto"
                             content-height="100%" content-width="scale-to-fit"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- links (only if href isn't empty) -->
  <xsl:template match="akn:a[@href!='' and not(parent::akn:div[@name='update-button'])]|akn:ref[@href!='']">
    <xsl:choose>
      <xsl:when test="starts-with(@href, '#')">
        <fo:basic-link internal-destination="{substring-after(@href, '#')}" color="{$link-colour-internal}" text-decoration="underline">
          <xsl:apply-templates/>
        </fo:basic-link>
      </xsl:when>
      <xsl:otherwise>
        <fo:basic-link external-destination="{@href}" color="{$link-colour}" text-decoration="underline">
          <xsl:apply-templates/>
        </fo:basic-link>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
