<?xml version="1.0" encoding="UTF-8"?>

<!--
    Studente: Eugenio Gugliotta
    Matricola: 535855
    Corso: Codifica di Testi 19-20

    Descrizione esercizio:
        costruire un foglio di stile XSLT con alcune regole
        di trasformazione e lanciare il comando xsltproc da terminale    
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head></head>
            <body>
                <xsl:apply-templates /> <!--  -->
            </body>
        </html>
    </xsl:template>

    <xsl:template match="fileDesc">
        <h1>Titolo</h1>
        <h2>
            <xsl:value-of select="titleStmt/title" />
        </h2>
    </xsl:template>
</xsl:stylesheet>