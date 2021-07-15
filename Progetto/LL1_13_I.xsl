<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" >
    
    <xsl:output method="html" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
        
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="LL1_13_I.css" media="screen" /> 
                <script src="LL1_13_I.js"> </script>
                <title><xsl:value-of select="//tei:titleStmt/tei:title"/></title>            
            </head>
            <body>
                <div class="menuSide">
                    <a href="#info"><i class="fa fa-file-code-o"></i> Informazioni</a>
                    <a href="#manuscript"><i class="fa fa-file-text-o"></i> Manoscritto</a>
                    <a href="#about"><i class="fa fa-info-circle"></i> About</a>
                </div>
                <div>
                    <div id="info" class="content">
                        <h2>Informazioni</h2>
                        <xsl:apply-templates select="//tei:titleStmt" />
                        <xsl:apply-templates select="//tei:publicationStmt" />
                        <xsl:apply-templates select="//tei:sourceDesc" />
                    </div>
                    <div id="manuscript" class="content">
                        <h2>Descrizione Manoscritto</h2>
                        <xsl:apply-templates select="//tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support"/>
                        <div id="descManuscript">
                            <div class="imgManuscript">
                                <xsl:apply-templates select="//tei:facsimile"/>
                            </div>
                            <div class="contentManuscript">
                                <div id="fr">
                                    <xsl:apply-templates select="//tei:body/tei:div[@type='fronte-recto']" />
                                </div>
                                <div id="rv">
                                    <xsl:apply-templates select="//tei:body/tei:div[@type='retro-verso']" />
                                </div>
                            </div>
                        </div>
                        <div>
                            <h4>Note</h4>
                            <xsl:apply-templates select="//tei:div[@type='notes']"/>
                        </div>
                        <div>
                            <h4>Bibliografia</h4>
                            <xsl:apply-templates select="//tei:div[@type='bibliography']/tei:listBibl"/>
                        </div>
                        <div>
                            <h4>Dettagli bibliografici</h4>
                            <xsl:apply-templates select="//tei:div[@type='lists']/tei:listBibl" />
                        </div>
                        <div>
                            <h4>Persone</h4>
                            <xsl:apply-templates select="//tei:div[@type='lists']/tei:listPerson"/>
                        </div>
                        <div>
                            <h4>Luoghi</h4>
                            <xsl:apply-templates select="//tei:div[@type='lists']/tei:listPlace" />
                        </div>
                    </div>
                    <footer id="about">
                        <xsl:apply-templates select="//tei:editionStmt" />
                    </footer>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="//tei:titleStmt">
        <h4><xsl:value-of select="tei:title"/> [<xsl:value-of select="//tei:msDesc/tei:msIdentifier/tei:idno"/>]</h4>
        <div><xsl:apply-templates select="tei:respStmt" /></div>
    </xsl:template>

    <xsl:template match="//tei:respStmt">
        <h4><xsl:value-of select="tei:resp"/></h4>
        <ul>
            <xsl:for-each select="tei:name">
                <li><xsl:value-of select="."/></li>     
            </xsl:for-each>
        </ul>
    </xsl:template>

    <xsl:template match="//tei:editionStmt">
        <h2><xsl:value-of select="tei:edition"/></h2>
        <div>
            <xsl:for-each select="tei:respStmt">
                <xsl:element name="p">
                    <xsl:value-of select="tei:resp"/><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text><xsl:value-of select="tei:name"/>
                </xsl:element>
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template match="//tei:publicationStmt">
        <h4><xsl:value-of select="tei:publisher"/></h4>
        <p>Licenza: 
            <xsl:element name="a">
                <xsl:attribute name="href">
                    <xsl:value-of select="tei:availability/tei:licence/@target"/>
                </xsl:attribute>
                <xsl:value-of select="tei:availability/tei:licence"/>
            </xsl:element>
        </p>
    </xsl:template>

    <xsl:template match="//tei:sourceDesc">
        <div>
            <h4>Collocazione <xsl:value-of select="//tei:msDesc/tei:msIdentifier/tei:idno"/></h4>
            <p>
               <xsl:value-of select="//tei:msDesc/tei:msIdentifier/tei:country"/>, <xsl:value-of select="//tei:msDesc/tei:msIdentifier/tei:settlement"/>; <xsl:value-of select="//tei:msDesc/tei:msIdentifier/tei:altIdentifier/tei:idno"/>.
            </p>
            <h4>Note</h4>
            <ul>
               <xsl:for-each select="//tei:adminInfo/tei:note">
                    <li style="width:50%"><xsl:value-of select="."/></li>
                </xsl:for-each> 
                <xsl:for-each select="//tei:notesStmt">
                    <li><xsl:apply-templates/></li>
                </xsl:for-each>
            </ul>    
        </div>
    </xsl:template>

    <xsl:template match="//tei:support">
        <ul>
            <xsl:element name="li">
                <xsl:value-of select="concat('Materiale: ',tei:material)"/>
            </xsl:element>
            <!--filigrana-->
            <xsl:element name="li">
                <xsl:text disable-output-escaping="yes">Filigrana:<![CDATA[&nbsp;]]></xsl:text>
                <xsl:element name="span">
                    <xsl:attribute name="id">
                        <xsl:value-of select="concat('desc_',//tei:watermark/tei:hi/@facs)"/>
                    </xsl:attribute>
                    <xsl:element name="span">
                        <xsl:attribute name="id">
                            <xsl:value-of select="concat('desc_',//tei:watermark/tei:hi[2]/@facs)"/>
                        </xsl:attribute>
                        <xsl:value-of select="tei:watermark"/>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
            <!--condizioni-->
            <xsl:element name="li">
                <xsl:value-of select="concat('Condizioni: ',tei:p[1])"/>
            </xsl:element>
            <!--segni-->
            <xsl:element name="li">
                <xsl:text disable-output-escaping="yes">Segni particolari:<![CDATA[&nbsp;]]></xsl:text>
                <!--macchie-->
                <xsl:element name="dd">
                    <xsl:element name="span">
                        <xsl:attribute name="id">
                            <xsl:value-of select="concat('desc_',//tei:support/tei:p[2]/tei:hi[1]/@facs)"/>
                        </xsl:attribute>
                        <xsl:element name="span">
                            <xsl:attribute name="id">
                                <xsl:value-of select="concat('desc_',//tei:support/tei:p[2]/tei:hi[2]/@facs)"/>
                            </xsl:attribute>
                            <xsl:value-of select="tei:p[2]"/>
                        </xsl:element>
                        
                    </xsl:element>
                </xsl:element>
                <!--scarabocchio-->
                <xsl:element name="dd">
                    <xsl:element name="span">
                        <xsl:attribute name="id">
                            <xsl:value-of select="concat('desc_',//tei:support/tei:p[3]/tei:hi/@facs)"/>
                        </xsl:attribute>
                        <xsl:value-of select="tei:p[3]"/>
                    </xsl:element>
                </xsl:element>
                <!--foro-->
                <xsl:element name="dd">
                    <xsl:element name="span">
                        <xsl:attribute name="id">
                            <xsl:value-of select="concat('desc_',//tei:support/tei:p[4]/tei:hi[1]/@facs)"/>
                        </xsl:attribute>
                        <xsl:element name="span">
                            <xsl:attribute name="id">
                                <xsl:value-of select="concat('desc_',//tei:support/tei:p[4]/tei:hi[2]/@facs)"/>
                            </xsl:attribute>
                            <xsl:value-of select="tei:p[4]"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
            <!--dimension/foliation-->
            <li>Dimensioni: 
                <xsl:value-of select="//tei:extent/tei:dimensions/tei:height"/><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]>x<![CDATA[&nbsp;]]></xsl:text>
                <xsl:value-of select="//tei:extent/tei:dimensions/tei:width"/> 
                <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
                <xsl:value-of select="//tei:extent/tei:dimensions/@unit"/> 
            </li>
            <li><xsl:value-of select="concat('Disposizione: ',//tei:foliation)"/> </li>
            <!--annotazione-->
            <xsl:element name="li">
                <xsl:value-of select="concat('Annotazioni: ',//tei:handNote)"/>
                <xsl:element name="dd">
                    <xsl:element name="span">
                        <xsl:attribute name="id">
                            <xsl:value-of select="concat('desc_',//tei:handNote[3]/@facs)"/>
                        </xsl:attribute>
                        <xsl:value-of select="//tei:handNote[3]/tei:p"/>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="dd">
                    <xsl:call-template name="splitString">
                        <xsl:with-param name="stringtosplit" select ="//tei:handNote[2]/@facs" />
                    </xsl:call-template>
                </xsl:element>
            </xsl:element>
        </ul>
    </xsl:template>

    <xsl:template name="splitString">
        <xsl:param name="stringtosplit" />
        <xsl:variable name="first" select="substring-before($stringtosplit, ' ')" />
        <xsl:variable name="second" select="substring-after($stringtosplit, ' ')" />
        <xsl:element name="span">
            <xsl:attribute name="id">
                <xsl:value-of select="concat('desc_',$first)"/>
            </xsl:attribute>
            <xsl:element name="span">
                <xsl:attribute name="id">
                    <xsl:value-of select="concat('desc_',$second)"/>
                </xsl:attribute>
                <xsl:value-of select="//tei:handNote[2]/tei:p"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//tei:facsimile">
        <xsl:for-each select="tei:surface/tei:graphic"> 
            <xsl:variable name="position" select="position()"/>
            <xsl:element name="div">
                <xsl:attribute name="class">
                    <xsl:value-of select="concat('imgMapContainer','')"/>
                </xsl:attribute>
                <xsl:element name="img">
                    <xsl:attribute name="usemap">
                        <xsl:value-of select="concat('#map',$position)"/>
                    </xsl:attribute>
                    <xsl:attribute name="id">
                        <xsl:value-of select="concat('map',$position)"/>
                    </xsl:attribute> 
                    <xsl:attribute name="src">
                        <xsl:value-of select="@url"/>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="div">
                    <xsl:attribute name="id">
                        <xsl:value-of select="concat('mapSelector',$position)"/>
                    </xsl:attribute>
                    <xsl:attribute name="class">
                        <xsl:value-of select="concat('mapSelector','')"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:element>
            
            <xsl:element name="map">
                <xsl:attribute name="name">
                    <xsl:value-of select="concat('map',$position)"/>
                </xsl:attribute>
                <xsl:attribute name="id">
                    <xsl:value-of select="concat('mapImg',$position)"/>
                </xsl:attribute>
                <xsl:for-each select="parent::tei:surface/tei:zone">
                    <xsl:element name="area">   
                        <xsl:attribute name="id">
                            <xsl:value-of select="@xml:id"/>       
                        </xsl:attribute>
                        <xsl:attribute name="shape">
                            <xsl:value-of select="concat('rect','')"/>
                        </xsl:attribute>
                        <xsl:attribute name="coords">
                            <xsl:value-of select="@ulx"/>,<xsl:value-of select="@uly"/>,<xsl:value-of select="@lrx"/>,<xsl:value-of select="@lry"/>
                        </xsl:attribute>
                        <xsl:attribute name="class">
                            <xsl:value-of select="concat(parent::tei:surface/@xml:id, '')"/>       
                        </xsl:attribute>
                        <xsl:if test="@rendition='HotSpot'">
                            <xsl:attribute name="onmouseover">
                                <xsl:value-of select="concat('hover(this,',$position,')')"/>
                            </xsl:attribute>
                            <xsl:attribute name="onmouseout">
                                <xsl:value-of select="concat('nohover(',$position,', this.id)','')"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:if test="@rendition='Line'">
                            <xsl:attribute name="onmouseover">
                                <xsl:value-of select="concat('hoverLine(this,',$position,')')"/>
                            </xsl:attribute>
                            <xsl:attribute name="onmouseout">
                                <xsl:value-of select="concat('nohoverLine(',$position,', this.id)','')"/>
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="choice_orig-reg_template" match="//tei:distinct">
        <xsl:element name="abbr">
            <xsl:attribute name="title">
                <xsl:value-of select="tei:choice/tei:reg"/>
            </xsl:attribute>
            <xsl:value-of select="tei:choice/tei:orig"/>
        </xsl:element>
        <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
    </xsl:template>

    <xsl:template name="choice_abbr-expan_template" match="//tei:choice">
        <xsl:element name="abbr">
            <xsl:attribute name="title">
                <xsl:value-of select="tei:expan"/>
            </xsl:attribute>            
            <xsl:apply-templates />
        </xsl:element>
        <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
    </xsl:template>

    <xsl:template match="//tei:expan"></xsl:template>

    <xsl:template match="//tei:hi">
        <xsl:if test="@rend='supralinear'">
            <sup><xsl:apply-templates/></sup>
        </xsl:if>
        <xsl:if test="@rend='align(right)'">
            <span style="text-align:right;"><p><xsl:apply-templates/></p></span>
        </xsl:if>
        <xsl:if test="@rend='align(center) case(mixed)'">
            <span style="text-align:center;"><p><xsl:apply-templates /></p></span>
        </xsl:if>
    </xsl:template>

    <xsl:template match="//tei:body">
        <xsl:element name="div">
            <xsl:attribute name="id">
                <xsl:value-of select="/tei:div/tei:pb/@xml:id"/>
            </xsl:attribute>
        </xsl:element>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:lb">
        <xsl:if test="@n!=1"><br/></xsl:if>
        
        <xsl:for-each select=".">
            <xsl:element name="span">
                <xsl:attribute name="id">
                    <xsl:value-of select="concat('line_',@facs)"/>
                </xsl:attribute>
                
            </xsl:element>
        </xsl:for-each>
        
    </xsl:template>
    
    <xsl:template match="//tei:damage/tei:hi">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//tei:subst">
        <span style="display:inline-block;">
            <xsl:element name="ins" >
                <xsl:value-of select="tei:add"/>
            </xsl:element>
            <xsl:element name="del">
                <xsl:value-of select="tei:del"/>
            </xsl:element>
        </span>
    </xsl:template>

    <xsl:template match="//tei:div[@type='notes']">
        <xsl:element name="ol">
            <xsl:for-each select="tei:note">
                <xsl:element name="li">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    <xsl:value-of select="tei:p" />
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//tei:ptr">
        <xsl:apply-templates/>
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
            </xsl:attribute>
            <xsl:call-template name="num_note">
                <xsl:with-param name="notetosplit" select ="//tei:ptr/@target" />
            </xsl:call-template>
        </xsl:element>
    </xsl:template>

    <xsl:template name="num_note">
        <xsl:param name="notetosplit" />
        <xsl:variable name="first" select="substring-before($notetosplit, '-')" />
        <xsl:variable name="second" select="substring-after($notetosplit, '-')" />
        <sup>[<xsl:value-of select="$second"/>]</sup>
    </xsl:template>
    
    <xsl:template match="//tei:div[@type='bibliography']/tei:listBibl">
        <xsl:element name="ul">
            <xsl:for-each select="tei:bibl">
                <xsl:element name="li">
                    <xsl:value-of select="tei:ref/tei:bibl/tei:author" /><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]>(</xsl:text><xsl:value-of select="tei:ref/tei:bibl/tei:date" /><xsl:text disable-output-escaping="yes">)<![CDATA[&nbsp;]]>-<![CDATA[&nbsp;]]>Pag.</xsl:text><xsl:value-of select="tei:ref/tei:bibl/tei:citedRange" />
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//tei:div[@type='lists']/tei:listBibl">
        <xsl:element name="ul">
            <xsl:for-each select="tei:bibl">
                <xsl:element name="li">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    <xsl:for-each select="*">
                        <xsl:value-of select="."/>
                        <xsl:text disable-output-escaping="yes">.<![CDATA[&nbsp;]]></xsl:text>             
                    </xsl:for-each>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//tei:div[@type='lists']/tei:listPerson">
        <xsl:element name="ul">
            <xsl:for-each select="tei:person/tei:persName">
                <xsl:element name="li">
                    <xsl:attribute name="id">
                        <xsl:value-of select="../@xml:id"/>
                    </xsl:attribute>
                    <xsl:for-each select="tei:forename">
                        <xsl:value-of select="."/>
                        <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>             
                    </xsl:for-each>
                    <xsl:text disable-output-escaping="yes">-<![CDATA[&nbsp;]]></xsl:text>
                    <xsl:value-of select="tei:addName"/><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]>-<![CDATA[&nbsp;]]></xsl:text><xsl:value-of select="tei:roleName"/>
                    <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]>-</xsl:text>
                    <xsl:for-each select="../tei:birth">
                        <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text><xsl:value-of select="tei:date"/>
                        <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]>(</xsl:text><xsl:value-of select="tei:placeName/tei:settlement"/><xsl:text disable-output-escaping="yes">)<![CDATA[&nbsp;]]>/</xsl:text>
                    </xsl:for-each>
                    <xsl:for-each select="../tei:death">
                        <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text><xsl:value-of select="tei:date"/>
                        <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]>(</xsl:text><xsl:value-of select="tei:placeName/tei:settlement"/><xsl:text disable-output-escaping="yes">)<![CDATA[&nbsp;]]></xsl:text>
                    </xsl:for-each>
                    <xsl:call-template name="link_template">
                        <xsl:with-param name="linktosplit" select ="//tei:person/tei:persName/tei:ref/@target" />
                    </xsl:call-template>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//tei:div[@type='lists']/tei:listPlace">
        <xsl:element name="ul">
            <xsl:for-each select="tei:place">
                <xsl:element name="li">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@xml:id" />
                    </xsl:attribute>
                        <xsl:value-of select="tei:placeName"/><xsl:text disable-output-escaping="yes">,<![CDATA[&nbsp;]]></xsl:text><xsl:value-of select="tei:country"/><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
                    <xsl:call-template name="link_template">
                        <xsl:with-param name="linktosplit" select ="tei:placeName/@ref" />
                    </xsl:call-template>
                    <xsl:choose>
                        <xsl:when test="tei:note">
                            <xsl:element name="dd">
                                <xsl:element name="a">
                                    <xsl:attribute name="id">
                                        <xsl:value-of select="tei:note/@source"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="onmouseover">
                                        <xsl:value-of select="concat('linkTo(this.id)','')"/>  
                                    </xsl:attribute>
                                    <xsl:attribute name="onmouseout">
                                        <xsl:value-of select="concat('linkToDown(this.id)','')"/>  
                                    </xsl:attribute>
                                    <sup><mark><xsl:text disable-output-escaping="yes">(nota<![CDATA[&nbsp;]]>pag.</xsl:text><xsl:value-of select="tei:note/tei:bibl"/><xsl:text disable-output-escaping="yes">)<![CDATA[&nbsp;]]></xsl:text></mark></sup>
                                </xsl:element>
                                <xsl:value-of select="tei:note/tei:p"/>
                            </xsl:element>
                        </xsl:when>
                    </xsl:choose>   
                </xsl:element>             
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <xsl:template name="link_template">
        <xsl:param name="linktosplit" />
        <xsl:variable name="link1" select="substring-before($linktosplit, ' ')" />
        <xsl:variable name="link2" select="substring-after($linktosplit, ' ')" />
        <xsl:text disable-output-escaping="yes">-<![CDATA[&nbsp;]]>[</xsl:text>
            <xsl:element name="a">
                <xsl:attribute name="href">
                    <xsl:value-of select="$link1"/>
                </xsl:attribute>
                <i class="fa fa-link"></i> Fonte1
            </xsl:element>- 
            <xsl:element name="a">
                <xsl:attribute name="href">
                    <xsl:value-of select="$link2"/>
                </xsl:attribute>
                <i class="fa fa-link"></i> Fonte2
            </xsl:element>
            <xsl:text disable-output-escaping="yes">]</xsl:text>
    </xsl:template>

</xsl:stylesheet>