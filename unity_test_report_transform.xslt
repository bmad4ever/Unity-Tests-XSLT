<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" version="4.0"
encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
	  <xsl:text  disable-output-escaping="yes">
        &lt;meta name="viewport" content="width=device-width, initial-scale=1"/&gt;
        &lt;link rel="stylesheet" href="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css"/&gt;
        
        &lt;script src="https://code.jquery.com/jquery-1.11.3.min.js"&gt;&lt;/script&gt;
        &lt;script src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"&gt;&lt;/script&gt;
        </xsl:text>
      </head>
      <body>

        <xsl:apply-templates select="test-run"/>
        
        <div data-role="collapsible">
          <h2>Test Details</h2>
            <xsl:apply-templates select="test-run/node()"/>
        </div>
      </body>
    </html>

  </xsl:template>


  <xsl:template match="test-suite[test-suite]" >
    <xsl:apply-templates select="test-suite"/>
  </xsl:template>


  <!-- <items> without <item> children is not handled -->
  <xsl:template match="test-suite[not(test-suite)]" >
    <div data-role="collapsible">
      <h3>
        <xsl:value-of select="@fullname"/>

        <table data-role="table" data-mode="" class="ui-responsive table-stroke">
          <tr>
            <th>Duration</th>
            <th>Total</th>
            <th>Passed</th>
            <th>Failed</th>
            <th>Inconclusive</th>
            <th>Skipped</th>
          </tr>
          <tr>
            <td>
              <xsl:value-of select="@duration"/>
            </td>
            <td>
              <xsl:value-of select="@total"/>
            </td>
            <td>
              <xsl:value-of select="@passed"/>
            </td>
            <td>
              <xsl:value-of select="@failed"/>
            </td>
            <td>
              <xsl:value-of select="@inconclusive"/>
            </td>
            <td>
              <xsl:value-of select="@skipped"/>
            </td>
          </tr>
        </table>
      </h3>

      <table data-role="table" data-mode="" class="ui-responsive table-stroke">
        <tr>
          <th>Name</th>
          <th>Result</th>
          <th>Duration</th>
          <th>Category</th>
        </tr>
        <xsl:apply-templates select="test-case"/>
      </table>
    </div>
  </xsl:template>


  <!-- test-case template -->
  <xsl:template match="test-case">
    <tr>
      <td>
        <xsl:value-of select="@name"/>
        <xsl:if test="output">
          <div data-role="collapsible">
            <h4>Output</h4>
            <p style="white-space: pre-line">
              <xsl:value-of select="output"/>
            </p>
          </div>
        </xsl:if>
        <xsl:if test="failure">
          <div data-role="collapsible">
            <h4>Stack-trace</h4>
            <p style="white-space: pre-line">
              <xsl:value-of select="failure/stack-trace"/>
            </p>
          </div>
        </xsl:if>
      </td>
      <td>
        <xsl:value-of select="@result"/>
      </td>
      <td>
        <xsl:value-of select="@duration"/>
      </td>
      <td>
        <!-- print test category if it has any -->
        <xsl:for-each select="properties/property">
          <xsl:if test="@name='Category'">
            <xsl:value-of select="@value"/>
          </xsl:if>
        </xsl:for-each>
      </td>
    </tr>
  </xsl:template>












  <xsl:template match="test-run">
    <h1>Test Summary</h1>
    <table data-role="table" data-mode="" class="ui-responsive table-stroke">
      <tr>
        <th>Duration</th>
        <th>Total</th>
        <th>Passed</th>
        <th>Failed</th>
        <th>Inconclusive</th>
        <th>Skipped</th>
      </tr>
      <tr>
        <td>
          <xsl:value-of select="@duration"/>
        </td>
        <td>
          <xsl:value-of select="@total"/>
        </td>
        <td>
          <xsl:value-of select="@passed"/>
        </td>
        <td>
          <xsl:value-of select="@failed"/>
        </td>
        <td>
          <xsl:value-of select="@inconclusive"/>
        </td>
        <td>
          <xsl:value-of select="@skipped"/>
        </td>
      </tr>
    </table>
    
    
    
  </xsl:template>



</xsl:stylesheet>
