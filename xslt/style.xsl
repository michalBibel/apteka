
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:sv="http://www.nfz.gov.pl/xml/ow-ow/View/Sign/Short_v1_0" xmlns:u="http://www.nfz.gov.pl/xml/swd-platnik/e-dok-rozlicz/lekzr/v1.1" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.0">
		
		
	<xsl:output doctype-public="-//W3C//DTD HTML 4.01//EN" doctype-system="http://www.w3.org/TR/html4/strict.dtd" encoding="UTF-8" indent="yes" method="html" version="4.01"/>
	<xsl:template name="TytulDokumentu">e-LEKZR</xsl:template>
	<xsl:variable name="vFormatKwota">
		<xsl:text>### ##0,00</xsl:text>
	</xsl:variable>
	<xsl:decimal-format decimal-separator="," grouping-separator=" " name="FormatDziesietny"/>
	
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="*[local-name()='komunikat']">
		<xsl:call-template name="StyleWspolne"/>
		<body>
			<div id="Dokument">
				<div id="Komunikat">
							<xsl:apply-templates/>
							<div class="row row50">
							<div class="box_r "> 
								<xsl:if test="../*[local-name()='Signature']"> 
									<div class="stempel "> Dokument podpisany elektronicznie</div> 
									<div class="stempel "> <xsl:text>Ilość podpisów: </xsl:text> <xsl:value-of select="count(../*[local-name()='Signature'])"/></div> 
								</xsl:if> 
							</div> 
							</div>
				</div>
			</div>
		</body>
	</xsl:template>
	
	<xsl:template match="*[local-name()='naglowek-dok']">
	
		<div class="rowt row25">
				<div class="box_l" id="Tyt">ZESTAWIENIE ZBIORCZE RECEPT NA LEKI,<br/>ŚRODKI SPOŻYWCZE SPECJALNEGO PRZEZNACZENIA ŻYWIENIOWEGO,<br/>WYROBY MEDYCZNE</div>
		</div>
		
		<xsl:apply-templates/>
		
		<div class="rowt row50">
				<div class="box_l" id="Tyt2">I.  ZESTAWIENIE ZBIORCZE RECEPT NA LEKI, ŚRODKI SPOŻYWCZE
					<br/>SPECJALNEGO PRZEZNACZENIA ŻYWIENIOWEGO, WYROBY MEDYCZNE <br/>OBJĘTE REFUNDACJĄ</div>
		</div>
		
		<div class="rowt row25">
				<div class="box_l" id="Tyt"> <xsl:if test="@typ-dok = 'K'"> <xsl:text>Korekta </xsl:text> </xsl:if> Nr <xsl:value-of select="@numer-dok"/></div>
		</div>
		
	</xsl:template>
	
	<xsl:template match="*[local-name()='podmiot']">
		<div class="row row50">
			<div class="nagl">Podmiot prowadzący aptekę:</div>
		</div>
		<div class="row">
			<xsl:value-of select="@nazwa"/><xsl:text>, </xsl:text> 
			<xsl:value-of select="*[local-name()='adres']/@adres"/><xsl:text>, </xsl:text> 
			<xsl:value-of select="*[local-name()='adres']/@kod-pocztowy"/><xsl:text> </xsl:text> 
			<xsl:value-of select="*[local-name()='adres']/@miejscowosc"/>
			
		</div>
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="*[local-name()='apteka']">
		<div class="row row15">
				<div class="nagl">Nazwa i adres apteki:</div>
		</div>
		<div class="row">
			<xsl:value-of select="@nazwa"/>
			<xsl:for-each select="*[local-name()='adres']">
					<xsl:call-template name="adres"/>
			</xsl:for-each>
		</div>
		<div class="row">
			<div class="box_l nagl">Numer REGON: </div>
			<div class="box_l " style="padding-left: 5px;"><xsl:value-of select="@regon"/></div> 
			<div class="box_l nagl" style="padding-left: 10px;">NIP:</div>
			<div class="box_l " style="padding-left: 5px;"><xsl:value-of select="@nip"/></div>
		</div>
		<div class="row">
			<div class="box_l nagl">Identyfikator apteki: </div>
			<div class="box_l " style="padding-left: 5px;"><xsl:value-of select="../../../@id-apteki"/></div> 
		</div>
	</xsl:template>
	
	<xsl:template match="*[local-name()='nabywca']">

		<div class="row row15">
			<div class="nagl tyt">Podmiot zobowiązany do finansowania świadczeń ze środków publicznych:</div>
		</div>
		<div class="row">
			<div class="nagl tyt">Nabywca:</div>
		</div>
		<div class="row">
			<xsl:value-of select="@nazwa"/>
			<xsl:for-each select="*[local-name()='adres']">
				<xsl:call-template name="adres"/>
			</xsl:for-each>
			<xsl:text>, NIP:</xsl:text>
			<xsl:value-of select="@nip"/>
		</div>
	</xsl:template>
	
	<xsl:template match="*[local-name()='odbiorca']">
		<div class="row row15">
			<div class="nagl tyt">Odbiorca - płatnik:</div>
		</div>
		<div class="row">
			<xsl:value-of select="@nazwa"/>
			<xsl:for-each select="*[local-name()='adres']">
				<xsl:call-template name="adres"/>
			</xsl:for-each>
		</div>
	</xsl:template>	
	
	<!--<xsl:template match="*[local-name()='adres']" >-->
	<xsl:template name="adres">
		<xsl:text>, </xsl:text><xsl:value-of select="@adres"/> 
		<xsl:text>, </xsl:text> <xsl:value-of select="@kod-pocztowy"/> 
		<xsl:text>  </xsl:text> <xsl:value-of select="@miejscowosc"/>  
	</xsl:template>
	
	<xsl:template match="*[local-name()='pozycje']">
		<xsl:apply-templates/>
		<xsl:call-template name="Osw"/>
	</xsl:template>
	
	<xsl:template match="*[local-name()='czesc-a-zest']">
		<div class="row row15">
			<div class="nagl tyt">CZĘŚĆ A</div>
		</div>
		<div class="row row15">
			<div>Zrealizowanych w okresie Nr <xsl:value-of select="../../*[local-name()='naglowek-dok']/@okres-nr"/>  od <xsl:value-of select="../../*[local-name()='naglowek-dok']/@okres-od"/> do 
				<xsl:value-of select="../../*[local-name()='naglowek-dok']/@okres-do"/> w oddziale wojewódzkim Narodowego Funduszu Zdrowia - 
				<xsl:call-template name="OwNfz"><xsl:with-param name="pOw" select="../../*[local-name()='naglowek-dok']/@umowa-oddzial"/></xsl:call-template> 
				- dla osób uprawnionych zgodnie z przepisami ustawy z dnia 27 sierpnia 2004 r. o świadczeniach opieki zdrowotnej finansowanych ze środków publicznych (Dz. U. z 2017 r. poz. 1938, z późn. zm.)
			</div>
		</div>
		<div class="row  row15">
			<table>
				<tbody>
					<tr>
						<th>Lp.</th>
						<th>Rodzaj</th>
						<th>Liczba pozycji leków, <br/>środków spożywczych <br/>specjalnego<br/>przeznaczenia<br/>żywieniowego, wyrobów<br/>medycznych<br/>zrealizowanych na<br/>podstawie recept</th>
						<th>Wartość leków, środków <br/>spożywczych specjalnego<br/>przeznaczenia<br/>żywieniowego, wyrobów<br/>medycznych<br/>zrealizowanych na<br/>podstawie recept</th>
						<th>Dopłata<br/>wniesiona przez<br/>świadczeniobiorcę</th>
						<th>Kwota<br/>podlegająca<br/>refundacji</th>
					</tr>
					<tr>
						<th>1</th>
						<th>2</th>
						<th>3</th>
						<th>4</th>
						<th>5</th>
						<th>6</th>
					</tr>
					<xsl:apply-templates>
						<xsl:with-param name="p_part" select="'A'"/>
					</xsl:apply-templates>
					<tr>
						<td style="text-align:left">Razem:</td>
						<td><xsl:value-of select="@liczba-recept"/></td>
						<td><xsl:value-of select="@liczba-pozycji"/></td>
						<td><xsl:value-of select="format-number(@wartosc, $vFormatKwota, 'FormatDziesietny')"/><xsl:text> zł</xsl:text></td>
						<td><xsl:value-of select="format-number(@doplata, $vFormatKwota, 'FormatDziesietny')"/><xsl:text> zł</xsl:text></td>
						<td><xsl:value-of select="format-number(@refundacja, $vFormatKwota, 'FormatDziesietny')"/><xsl:text> zł</xsl:text></td>
					</tr>
				</tbody>
			</table>
		</div>
		<xsl:call-template name="Slownie"/>
	</xsl:template>
	
	<xsl:template match="*[local-name()='czesc-b-zest']">
		<div class="row row15">
			<div class="nagl tyt">CZĘŚĆ B</div>
		</div>
		<div class="row row15">
			<div>Zrealizowanych w okresie Nr <xsl:value-of select="../../*[local-name()='naglowek-dok']/@okres-nr"/> od 
			<xsl:value-of select="../../*[local-name()='naglowek-dok']/@okres-od"/> do <xsl:value-of select="../../*[local-name()='naglowek-dok']/@okres-do"/> 
			w oddziale wojewódzkim Narodowego Funduszu Zdrowia - <xsl:call-template name="OwNfz"><xsl:with-param name="pOw" select="../../*[local-name()='naglowek-dok']/@umowa-oddzial"/></xsl:call-template> 
			- dla osób uprawnionych do świadczeń opieki zdrowotnej na podstawie przepisów o koordynacji</div>
		</div>
		<div class="row  row15">
			<table>
				<tbody>
					<tr>
						<th style="">Lp.</th>
						<th>Symbol kraju<br/>instytucji<br/>właściwej</th>
						<th>Numer poświadczenia<br/>lub numer dokumentu<br/>osoby uprawnionej do<br/>świadczeń opieki<br/>zdrowotnej na<br/>podstawie przepisów o<br/>koordynacji</th>
						<th>Liczba recept</th>
						<th>Liczba pozycji</th>
						<th>Wartość leków,<br/>środków spożywczych<br/>specjalnego<br/>przeznaczenia<br/>żywieniowego,<br/>wyrobów medycznych<br/>zrealizowanych na<br/>podstawie recept</th>
						<th>Dopłata wniesiona<br/>przez osobe<br/>uprawnioną do<br/>świadczeń opieki<br/>zdrowotnej na<br/>podstawie przepisów o<br/>koordynacji</th>
						<th>Kwota<br/>podlegająca<br/>refundacji</th>
					</tr>
					<tr>
						<th>1</th>
						<th>2</th>
						<th>3</th>
						<th>4</th>
						<th>5</th>
						<th>6</th>
						<th>7</th>
						<th>8</th>
					</tr>
					<xsl:apply-templates>
						<xsl:with-param name="p_part" select="'B'"/>
					</xsl:apply-templates>
					<tr>
						<td colspan="2" style="text-align:left">Razem:</td>
						<td/>
						<td><xsl:value-of select="@liczba-recept"/></td>
						<td><xsl:value-of select="@liczba-pozycji"/></td>
						<td><xsl:value-of select="format-number(@wartosc, $vFormatKwota, 'FormatDziesietny')"/><xsl:text> zł</xsl:text></td>
						<td><xsl:value-of select="format-number(@doplata, $vFormatKwota, 'FormatDziesietny')"/><xsl:text> zł</xsl:text></td>
						<td><xsl:value-of select="format-number(@refundacja, $vFormatKwota, 'FormatDziesietny')"/><xsl:text> zł</xsl:text></td>
					</tr>
				</tbody>
			</table>
		</div>
		<xsl:call-template name="Slownie"/>
	</xsl:template>
	
	<xsl:template match="*[local-name()='pozycja-zb']">
		<xsl:param name="p_part"/>	
		<xsl:choose>
					<xsl:when test="$p_part='A'">
						<xsl:call-template name="RowA"/>
					</xsl:when>
					<xsl:when test="$p_part='B'">
						<xsl:call-template name="RowB"/>
					</xsl:when>
					<xsl:otherwise/>
		</xsl:choose>
		
		
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template name="RowA">
	<tr>
			<td style="text-align:center;">
				<xsl:value-of select="@lp"/>
			</td>
			<td style="text-align:left;">
				<xsl:value-of select="@rodzaj"/>
			</td>
			<td>
				<xsl:value-of select="@liczba-pozycji"/>
			</td>
			<td>
				<xsl:value-of select="format-number(@wartosc, $vFormatKwota, 'FormatDziesietny')"/><xsl:text> zł</xsl:text>
			</td>
			<td>
				<xsl:value-of select="format-number(@doplata, $vFormatKwota, 'FormatDziesietny')"/><xsl:text> zł</xsl:text>
			</td>
			<td>
				<xsl:value-of select="format-number(@refundacja, $vFormatKwota, 'FormatDziesietny')"/><xsl:text> zł</xsl:text>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template name="RowB">
	<tr>
			<td style="text-align:center;">
				<xsl:value-of select="@lp"/>
			</td>
			<td style="text-align:left;">
				<xsl:value-of select="@platnik"/>
			</td>
			<td style="text-align:left;">
				<xsl:value-of select="@nr"/>
			</td>
			<td>
				<xsl:value-of select="@liczba-recept"/>
			</td>
			<td>
				<xsl:value-of select="@liczba-pozycji"/>
			</td>
			<td>
				<xsl:value-of select="format-number(@wartosc, $vFormatKwota, 'FormatDziesietny')"/><xsl:text> zł</xsl:text>
			</td>
			<td>
				<xsl:value-of select="format-number(@doplata, $vFormatKwota, 'FormatDziesietny')"/><xsl:text> zł</xsl:text>
			</td>
			<td>
				<xsl:value-of select="format-number(@refundacja, $vFormatKwota, 'FormatDziesietny')"/><xsl:text> zł</xsl:text>
			</td>
	</tr>
	</xsl:template>
	
	<xsl:template name="Slownie">
		<div class="row row15">
			<div class="nagl tyt box_l"><xsl:text>Do zapłaty (słownie):   </xsl:text></div><div><xsl:value-of select="@do-zaplaty-slownie"/></div>
		</div>
		<div class="row">
			<div class="nagl tyt box_l"><xsl:text>Data sporządzenia zestawienia:  </xsl:text></div><div><xsl:value-of select="../../*[local-name()='naglowek-dok']/@data-wystawienia"/></div>
		</div>
	</xsl:template>
	
	<xsl:template name="Osw">
		<div class="row row15">
			<div><xsl:text>Oświadczam, że wyżej wymieniona kwota wynika z treści recept podlegających refundacji wystawionych i zrealizowanych
zgodnie z odrębnymi przepisami oraz z treści innych dokumentów fiskalno-księgowych, w szczególności paragonów fiskalnych.</xsl:text></div>
		</div>
	</xsl:template>
	
	<xsl:template name="OwNfz">
		<xsl:param name="pOw"/>
		<xsl:choose>
					<xsl:when test="$pOw='01'">
						<xsl:text>Dolnośląski Oddział Narodowego Funduszu Zdrowia we Wrocławiu</xsl:text>
					</xsl:when>
					<xsl:when test="$pOw='02'">
						<xsl:text>Kujawsko-Pomorski Oddział Narodowego Funduszu Zdrowia w Bydgoszczy</xsl:text>
					</xsl:when>
					<xsl:when test="$pOw='03'">
						<xsl:text>Lubelski Oddział Narodowego Funduszu Zdrowia w Lublinie</xsl:text>
					</xsl:when>
					<xsl:when test="$pOw='04'">
						<xsl:text>Lubuski Oddział Narodowego Funduszu Zdrowia w Zielonej Górze</xsl:text>
					</xsl:when>
					<xsl:when test="$pOw='05'">
						<xsl:text>Łódzki Oddział Narodowego Funduszu Zdrowia w Łodzi</xsl:text>
					</xsl:when>
					<xsl:when test="$pOw='06'">
						<xsl:text>Małopolski Oddział Narodowego Funduszu Zdrowia w Krakowie</xsl:text>
					</xsl:when>
					<xsl:when test="$pOw='07'">
						<xsl:text>Mazowiecki Oddział Narodowego Funduszu Zdrowia w Warszawie</xsl:text>
					</xsl:when>
					<xsl:when test="$pOw='08'">
						<xsl:text>Opolski Oddział Narodowego Funduszu Zdrowia w Opolu</xsl:text>
					</xsl:when>
					<xsl:when test="$pOw='09'">
						<xsl:text>Podkarpacki Oddział Narodowego Funduszu Zdrowia w Rzeszowie</xsl:text>
					</xsl:when>
					<xsl:when test="$pOw='10'">
						<xsl:text>Podlaski Oddział Narodowego Funduszu Zdrowia w Białymstoku</xsl:text>
					</xsl:when>
					<xsl:when test="$pOw='11'">
						<xsl:text>Pomorski Oddział Narodowego Funduszu Zdrowia w Gdańsku</xsl:text>
					</xsl:when>
					<xsl:when test="$pOw='12'">
						<xsl:text>Śląski Oddział Narodowego Funduszu Zdrowia w Katowicach</xsl:text>
					</xsl:when>
					<xsl:when test="$pOw='13'">
						<xsl:text>Świętokrzyski Oddział Narodowego Funduszu Zdrowia w Kielcach</xsl:text>
					</xsl:when>
					<xsl:when test="$pOw='14'">
						<xsl:text>Warmińsko-Mazurski Oddział Narodowego Funduszu Zdrowia w Olsztynie</xsl:text>
					</xsl:when>
					<xsl:when test="$pOw='15'">
						<xsl:text>Wielkopolski Oddział Narodowego Funduszu Zdrowia w Poznaniu</xsl:text>
					</xsl:when>
					<xsl:when test="$pOw='16'">
						<xsl:text>Zachodniopomorski Oddział Narodowego Funduszu Zdrowia w Szczecinie</xsl:text>
					</xsl:when>
					
					<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="StyleWspolne">
	
		<head>
			<meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
			<style type="text/css">
					body { font-family:Arial; }
					#Dokument{ align:center; }
					#Komunikat { clear: both; font-size:22px;  width: 950px; float:center; margin: 0px auto;  padding: 80px;} 
					#Dnia {text-align: left;   width: 33%; }
					#Tyt {text-align: Center;   width: 100%; font-weight: bold; padding-top: 25px;}
					#Tyt2 {text-align: Center;   width: 100%; padding-top: 25px;}
					.box_r {  float: right;  }
					.box_l {  float: left;  }
					.row{  clear: both; position: relative; width: 950px;   float: none; font-size:15px;  }
					.rowt{  clear: both; position: relative; width: 950px;   float: none;}
					.row15{ padding-top: 15px;}
					.row25{ padding-top: 25px;}
					.row50{ padding-top: 50px;}
					.nagl {text-align: left;  font-weight: bold; }
					.nagl.tyt { font-size:16px; }
					.stempel {text-align: center;  font-weight: bold;   width: 100%; }
					
					
					table {font-size:15px; width: 950px; border:solid 2px #000;}
					table th{background-color: #cccccc;}
					table, td {  border: 1px solid black;  text-align:right; padding:2px; border-collapse: collapse; }
					table, th {  border: 1px solid black;  text-align:center; padding:2px; border-collapse: collapse; }


					
					
					
					#Art {text-align: justify;   width: 100%; padding-top: 25px; }
					
						
					

		</style>
		</head>
	</xsl:template>
	
	<xsl:template match="ds:Signature">
	<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="ds:X509Certificate">
		<xsl:if test="text()|@*">
    </xsl:if>
	</xsl:template>
	
	<xsl:template match="text()|@*"> 
	</xsl:template>
	
	<xsl:template match="sv:DynamGenPodpisyInfo">
		<div class="row">
			<div class="box_r row50">
				<xsl:apply-templates/>		
			</div>
		</div>	
	</xsl:template>

	<xsl:template match="sv:Podpis">
				<div class="stempel "> <xsl:value-of select="@osoba-podpisujaca"/> </div>
	</xsl:template>
	</xsl:stylesheet>