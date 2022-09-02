<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html>
			<head>
				<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous" />
				<link rel="stylesheet" href="style.css" />
				<script src="script.js" />
				<title><xsl:value-of select="//tei:fileDesc/tei:titleStmt/tei:title" /></title>
			</head>
			<body>
				<div class="container">
					<div class="row">
						<div class="col-sm-12 border border-secondary">
						<!-- titolo -->
							<h1 id="desc">Documento: <xsl:value-of select="//tei:fileDesc/tei:titleStmt/tei:title"/></h1>
						</div>
						<div class="col-sm-6 border border-secondary">
							<h2>Autrice codifica: <xsl:value-of select="//tei:fileDesc/tei:titleStmt/tei:author" /></h2>
						</div>
						<div class="col-sm-6 border border-secondary">
							<h2>Descrizione: <xsl:value-of select="//tei:bibl/title" /> documento del <xsl:apply-templates select="//tei:bibl/tei:date" /></h2>
						</div>
						<div class="col-sm-12 border border-secondary">
							<h3>Gentilmente concesso da <xsl:value-of select="//tei:bibl/tei:publisher" /> - <xsl:apply-templates select="//tei:placeName/tei:settlement" /></h3>
						</div>
					</div>
					
					<div class="row source">
						<div class="col-sm-6 border border-secondary">
							<div class="source-line"><xsl:value-of select="//tei:physDesc/tei:objectDesc/tei:supportDesc" /></div>
							<div class="source-line"><xsl:value-of select="//tei:physDesc/tei:objectDesc/tei:layoutDesc" /></div>
						</div>
						<div class="col-sm-6 border border-secondary">
							<div class="source-line"><xsl:value-of select="//tei:handDesc" /></div>
							<div class="source-line"><xsl:value-of select="//tei:typeDesc" /></div>
							<div class="source-line"><xsl:value-of select="//tei:summary" /></div>
							<div class="source-line"><xsl:value-of select="//tei:acquisition" /></div>
						</div>
					</div>

					<div class="raw source-line istruzioni">
						<div class="col-sm-12">Per comprendere il testo del documento è possibile cliccare su di esso: il testo corrispondente sarà evidenziato da un pallino rosso sul lato sinistro.</div>
					</div>

					<div id="document_body" class="row">
						<div class="col-sm-12 border border-secondary">
							<h2>Corpo del documento</h2>
							<div id="body_lettera">
								<xsl:apply-templates select="//tei:div[@xml:id='doc012_document']"/>
							</div>
						</div>
					</div>
					
				</div>
				
				<div id="doc_image">
					<xsl:apply-templates select="//tei:facsimile" />
				</div>
				
				<div class="container footer">
					<div class="row">
						<div class="col-sm-4">Progetto di Codifica di Testi</div>
						<div class="col-sm-4">Francesca Ferraioli, mat. 586328</div>
						<div class="col-sm-4">Anno Accademico 2021/2022</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>

    <xsl:template match="//tei:facsimile">
        <xsl:for-each select="tei:surface/tei:graphic"> 
            <xsl:variable name="position" select="position()"/>

            <xsl:element name="img">    
			<!-- otteniamo <img usemap="#map1" id="imglettera1" src="doc012.jpg" class="immagini_lettera"> -->
                <xsl:attribute name="usemap">
                    <xsl:value-of select="concat('#map',$position)"/>   <!-- usemap="#map1" -->
                </xsl:attribute>
                <xsl:attribute name="id">
                    <xsl:value-of select="concat('imglettera' , $position)"/>  <!-- id="imglettera1" -->
                </xsl:attribute> 
                <xsl:attribute name="src">
                    <xsl:value-of select="current()/@url"/>     <!-- src="doc012.jpg" -->
                </xsl:attribute>
                <xsl:attribute name="class">
                    <xsl:text>immagini_lettera</xsl:text>
                </xsl:attribute>
    
                <xsl:element name="map">
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat('map',$position)"/>
                    </xsl:attribute>

                    <xsl:for-each select="parent::tei:surface/tei:zone">
                        <xsl:element name="area">   
                            <xsl:attribute name="class">
                                <xsl:value-of select="concat(parent::tei:surface/@xml:id, '_class')"/>  
								<!-- recupero ID del surface padre di zone -->     
                            </xsl:attribute>   
                            <xsl:attribute name="id">
                                <xsl:value-of select="@xml:id"/>       
                            </xsl:attribute>
                            <xsl:attribute name="shape">
                                <xsl:text>rect</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="coords">
                                <xsl:value-of select="@ulx"/>,<xsl:value-of select="@uly"/>,<xsl:value-of select="@lrx"/>,<xsl:value-of select="@lry"/>
                            </xsl:attribute>
                            <xsl:attribute name="href"> 
                                <xsl:value-of select="concat('#ID#', @xml:id)"/>
                            </xsl:attribute>
                            <xsl:attribute name="onclick">
                                <xsl:value-of select="concat('gestoreEvidenzia( &quot;ID#', @xml:id, '&quot;)' )"/>     
								<!-- chiama funzioen gestoreEvidenzia() --> 
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

	<!-- Gestione dell'immagine -->
    <xsl:template name="facs_template_body" match="*[@facs]">
        <xsl:apply-templates/><br /><xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:value-of select="concat('ID',@facs)"/>
            </xsl:attribute>
            <xsl:text disable-output-escaping="yes"><![CDATA[&#8226;&nbsp]]></xsl:text> 
        </xsl:element>
    </xsl:template>
	
	<xsl:template name="barrato" match="//tei:del[@rend='overstrike']">
		<span class="supralinear"><xsl:value-of select="."/></span>
	</xsl:template>
	
	<!-- Gestione delle "choice" di tipo errore -->
	<xsl:template name="select-err" match="//tei:choice[@n='2']">
        <select class="choice_class">
            <xsl:element name="option">
                <xsl:attribute name="value">
                    <xsl:value-of select="concat(tei:sic, '')"/>
                </xsl:attribute>
                <xsl:value-of select="concat(tei:sic, '')"/>
            </xsl:element>
            <xsl:element name="option">
                <xsl:attribute name="value">
                    <xsl:value-of select="concat(tei:corr, '')"/>
                </xsl:attribute>
                <xsl:value-of select="concat(tei:corr, '')"/>
            </xsl:element>
        </select>
    </xsl:template>        
	
	<!-- Gestione delle "choice" di tipo abbreviazione -->
	<xsl:template name="select-abbr" match="//tei:choice[@n='1']">
        <select class="choice_class">
            <xsl:element name="option">
                <xsl:attribute name="value">
                    <xsl:value-of select="concat(tei:abbr, '')"/>
                </xsl:attribute>
                <xsl:value-of select="concat(tei:abbr, '')"/>
            </xsl:element>
            <xsl:element name="option">
                <xsl:attribute name="value">
                    <xsl:value-of select="concat(tei:expan, '')"/>
                </xsl:attribute>
                <xsl:value-of select="concat(tei:expan, '')"/>
            </xsl:element>
        </select>
    </xsl:template>        
	
</xsl:stylesheet>