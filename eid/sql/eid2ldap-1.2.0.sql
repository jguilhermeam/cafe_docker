
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Banco de Dados: 'eid2ldap'
--

-- --------------------------------------------------------

--
-- Estrutura da tabela 'TBL_EID_CONFIG'
--

CREATE TABLE TBL_EID_CONFIG (
  idConfigEid bigint(20) NOT NULL AUTO_INCREMENT,
  wsURL varchar(256) NOT NULL,
  systemVersion varchar(255) DEFAULT NULL,
  PRIMARY KEY (idConfigEid)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela 'TBL_EID_CONFIG'
--

INSERT INTO TBL_EID_CONFIG (idConfigEid, wsURL, systemVersion) VALUES
(1, 'http://localhost:8080/eid/services/EidService?wsdl ', '1.2.0');

-- --------------------------------------------------------

--
-- Estrutura da tabela 'TBL_ERROR'
--

CREATE TABLE TBL_ERROR (
  idError bigint(20) NOT NULL AUTO_INCREMENT,
  guid varchar(255) DEFAULT NULL,
  lastUpdate datetime DEFAULT NULL,
  xml text,
  idLdap bigint(20) DEFAULT NULL,
  errorMessage text DEFAULT NULL,
  PRIMARY KEY (idError),
  KEY TBL_ERROR_ibfk_1 (idLdap)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela 'TBL_ERROR'
--


-- --------------------------------------------------------

--
-- Estrutura da tabela 'TBL_LDAP_SERVER'
--

CREATE TABLE TBL_LDAP_SERVER (
  idLdap bigint(20) NOT NULL AUTO_INCREMENT,
  lastSerialNumber bigint(20) DEFAULT NULL,
  hostAddress varchar(128) NOT NULL,
  description varchar(255) DEFAULT NULL,
  port int(10) unsigned NOT NULL,
  login varchar(40) NOT NULL,
  pssword varchar(40) NOT NULL,
  protocolVersion int(10) unsigned NOT NULL,
  name varchar(80) NOT NULL,
  useSSL CHAR(1) DEFAULT 'N',
  PRIMARY KEY (idLdap)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela 'TBL_LDAP_SERVER'
--

INSERT INTO TBL_LDAP_SERVER (idLdap, lastSerialNumber, hostAddress, description, port, login, pssword, protocolVersion, `name`, useSSL) VALUES
(1, -1, 'localhost', 'Servidor LDAP local', 389, 'cn=admin,dc=INSTITUICAO,dc=br', 'SENHA_ADMIN', 3, 'LDAP local', 'N');

-- --------------------------------------------------------

--
-- Estrutura da tabela 'TBL_SCHEDULING'
--

CREATE TABLE TBL_SCHEDULING (
  idScheduling bigint(20) NOT NULL AUTO_INCREMENT,
  nextDataExecution datetime DEFAULT NULL,
  typeExecution varchar(18) DEFAULT NULL,
  description varchar(255) NOT NULL,
  numberProcessing int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  stateScheduling varchar(18) DEFAULT NULL,
  customPeriod int(11) DEFAULT NULL,
  idLdap bigint(20) DEFAULT NULL,
  maxErrors int(11) DEFAULT '0',
  PRIMARY KEY (idScheduling),
  KEY SchedulingLdapServer_FKIndex1 (idLdap)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;


--
-- Extraindo dados da tabela 'TBL_SCHEDULING'
--


-- --------------------------------------------------------

--
-- Estrutura da tabela 'TBL_SCHEDULING_RESULT'
--

CREATE TABLE TBL_SCHEDULING_RESULT (
  idResult bigint(20) NOT NULL AUTO_INCREMENT,
  idScheduling bigint(20) DEFAULT NULL,
  situationDescription varchar(18) DEFAULT NULL,
  resultDescription text,
  startDate datetime DEFAULT NULL,
  endDate datetime DEFAULT NULL,
  processingNumber int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (idResult),
  KEY SchedulingResult_FKIndex1 (idScheduling)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela 'TBL_SCHEDULING_RESULT'
--


-- --------------------------------------------------------

--
-- Estrutura da tabela 'TBL_SKIP_ATTRIBUTE'
--

CREATE TABLE TBL_SKIP_ATTRIBUTE (
  idSkipAttribute bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  insertable char(1) NOT NULL DEFAULT 'N',
  idLdap bigint(20) NOT NULL,
  PRIMARY KEY (idSkipAttribute),
  KEY SkipAttributeLdapServer_FKIndex1 (idLdap)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela 'TBL_SKIP_ATTRIBUTE'
--


-- --------------------------------------------------------

--
-- Estrutura da tabela 'TBL_XSLT'
--

CREATE TABLE TBL_XSLT (
  idXslt bigint(20) NOT NULL AUTO_INCREMENT,
  xml text,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (idXslt)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela 'TBL_XSLT'
--

INSERT INTO TBL_XSLT (idXslt, xml, `name`) VALUES
(1, '<?xml version="1.0" encoding="UTF-8"?>\r\n<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">\r\n\r\n\r\n<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>\r\n\r\n<xsl:variable name="raizLdap">\r\n        <xsl:text>${RAIZ_BASE_LDAP}</xsl:text>\r\n</xsl:variable>\r\n\r\n<xsl:variable name="peopleDn">\r\n        <xsl:text>ou=people,</xsl:text><xsl:value-of select="$raizLdap"/>\r\n</xsl:variable>\r\n\r\n<xsl:variable name="escopo">\r\n        <xsl:variable name="temp1">\r\n                <xsl:call-template name="replace-string">\r\n                        <xsl:with-param name="text" select="$raizLdap"/>\r\n                        <xsl:with-param name="replace" select="'' ''"/>\r\n                        <xsl:with-param name="with" select="''''"/>\r\n                </xsl:call-template>\r\n        </xsl:variable>\r\n        <xsl:variable name="temp2">\r\n                <xsl:call-template name="replace-string">\r\n                        <xsl:with-param name="text" select="$temp1"/>\r\n                        <xsl:with-param name="replace" select="''dc=''"/>\r\n                        <xsl:with-param name="with" select="''.''"/>\r\n                </xsl:call-template>\r\n        </xsl:variable>\r\n        <xsl:variable name="temp3">\r\n                <xsl:call-template name="replace-string">\r\n                        <xsl:with-param name="text" select="$temp2"/>\r\n                        <xsl:with-param name="replace" select="'',''"/>\r\n                        <xsl:with-param name="with" select="''''"/>\r\n                </xsl:call-template>\r\n        </xsl:variable>\r\n        <xsl:value-of select="substring-after($temp3, ''.'')"/>\r\n</xsl:variable>\r\n\r\n<xsl:template match="/">\r\n<xsl:apply-templates select="eid-object[@type=''person'' and ( not(attribute::removed) or @removed=''false'') and attributes[@class=''Conta'']]" mode="person"/>\r\n<xsl:apply-templates select="eid-object[@type=''person'' and @removed=''true'' and attributes[@class=''Conta'']]" mode="removed" />     \r\n</xsl:template>\r\n\r\n<!-- Not modify -->\r\n<xsl:template match="eid-object" mode="removed">\r\n\r\ndn: uid=<xsl:value-of select="attributes[@class = ''Conta'']/attribute[@name=''login'']" />, <xsl:value-of select="$peopleDn"/>\r\nchangetype: delete\r\n</xsl:template>\r\n\r\n<xsl:template match = "attributes" mode="Identificacao">\r\n<xsl:variable name="fullName" select="normalize-space(attribute[@name=''nomeCompleto''])"/>\r\nobjectClass: Person\r\nobjectClass: inetOrgPerson\r\nobjectClass: eduPerson\r\neduPersonPrincipalName: <xsl:value-of select="../@guid"/>@<xsl:value-of select="$escopo"/>\r\ncn: <xsl:value-of select = "$fullName" />\r\n<xsl:variable name="sobrenome" select="substring-after($fullName,'' '')" />\r\n<xsl:if test="$sobrenome">\r\nsn: <xsl:call-template name="split"><xsl:with-param name="src" select="$sobrenome"/><xsl:with-param name="delimiter" select="'' ''"/></xsl:call-template>\r\n</xsl:if>\r\n<xsl:if test="not($sobrenome)">\r\nsn: <xsl:value-of select = "$fullName" />\r\n</xsl:if>\r\ndisplayName: <xsl:value-of select="$fullName"/>\r\ngivenName: <xsl:value-of select="$fullName"/>\r\n<xsl:if test="attribute[@name=''cpf'']">\r\nobjectClass: brPerson\r\nbrCPF:<xsl:value-of select="attribute[@name=''cpf'']"/></xsl:if>\r\n<xsl:if test="attribute[@name=''sexo''] or attribute[@name=''nacionalidade''] or attribute[@name=''dataNascimento''] ">\r\nobjectClass: schacPersonalCharacteristics</xsl:if>\r\n<xsl:if test="attribute[@name=''sexo'']">\r\nschacGender: <xsl:call-template name="FormatGender"> <xsl:with-param name="gender" select="attribute[@name=''sexo'']"/></xsl:call-template></xsl:if>\r\n<xsl:if test="attribute[@name=''nacionalidade'']">\r\nschacCountryOfCitizenship: <xsl:value-of select="attribute[@name=''nacionalidade'']"/></xsl:if>\r\n<xsl:if test="attribute[@name=''dataNascimento'']">\r\nschacDateOfBirth: <xsl:call-template name="FormatDate"> <xsl:with-param name="dateTime"   select="attribute[@name=''dataNascimento'']"/></xsl:call-template></xsl:if>\r\n</xsl:template>\r\n\r\n<xsl:template name="FormatGender">\r\n    <xsl:param name="gender" />\r\n    <xsl:choose>\r\n        <xsl:when test="$gender = ''F''">2</xsl:when><xsl:otherwise>1</xsl:otherwise>\r\n     </xsl:choose>\r\n</xsl:template>\r\n \r\n<xsl:template name="FormatDate">\r\n    <xsl:param name="dateTime" />\r\n    <xsl:variable name="day">\r\n        <xsl:value-of select="substring($dateTime,9,2)" />\r\n    </xsl:variable>\r\n    <xsl:variable name="year">\r\n        <xsl:value-of select="substring($dateTime,1,4)" />\r\n    </xsl:variable>\r\n    <xsl:variable name="month">\r\n        <xsl:value-of select="substring($dateTime,6,2)" />\r\n    </xsl:variable>  <xsl:value-of select="$year"/><xsl:value-of select="$month"/><xsl:value-of select="$day"/>\r\n</xsl:template>\r\n\r\n<xsl:template match = "attributes" mode="Email">\r\n<xsl:if test="attribute[@name=''email'']" >\r\nobjectClass: inetOrgPerson\r\nmail: <xsl:value-of select="normalize-space(attribute[@name=''email''])"/></xsl:if>\r\n</xsl:template>\r\n\r\n<xsl:template match = "attributes" mode="Conta">\r\n<xsl:if test="attribute[@name=''login''] ">\r\nuid: <xsl:value-of select="attribute[@name=''login'']"/></xsl:if>\r\n<xsl:if test="attribute[@name=''senha'']">\r\nuserPassword:<xsl:choose>\r\n<xsl:when test="not(attribute[@name=''algoritmoSenha'']) or (attribute[@name=''algoritmoSenha''] = '''')"><xsl:text> </xsl:text></xsl:when>\r\n<xsl:when test="attribute[@name=''algoritmoSenha''] = ''base64''">: </xsl:when>\r\n<xsl:otherwise> {<xsl:value-of select="attribute[@name=''algoritmoSenha'']"/>}</xsl:otherwise>\r\n</xsl:choose><xsl:value-of select="attribute[@name=''senha'']"/></xsl:if>\r\n</xsl:template>\r\n\r\n<xsl:template match = "attributes" mode="Vinculo">\r\n\r\ndn: braff=<xsl:value-of select="position()" />, uid=<xsl:value-of select="/eid-object/attributes[@class = ''Conta'']/attribute[@name=''login'']" />, <xsl:value-of select="$peopleDn" />\r\nobjectClass: brEduPerson\r\nbraff: <xsl:value-of select="position()" />\r\nbraffType: <xsl:choose>\r\n<xsl:when test="@class=''Aluno''">student</xsl:when><xsl:when test="@class=''Professor''">faculty</xsl:when><xsl:when test="@class=''Tecnico''">employee</xsl:when></xsl:choose>\r\n<xsl:if test="attribute[@name=''dataVinculacao'']">\r\nbrEntranceDate: <xsl:call-template name="FormatDate"><xsl:with-param name="dateTime" select="attribute[@name=''dataVinculacao'']"/></xsl:call-template></xsl:if> \r\n<xsl:if test="attribute[@name=''dataAdmissao'']">\r\nbrEntranceDate: <xsl:call-template name="FormatDate"><xsl:with-param name="dateTime" select="attribute[@name=''dataAdmissao'']"/></xsl:call-template></xsl:if>\r\n<xsl:if test="attribute[@name=''dataAfastamento'']">\r\nbrExitDate: <xsl:call-template name="FormatDate"><xsl:with-param name="dateTime" select="attribute[@name=''dataAfastamento'']"/></xsl:call-template></xsl:if>\r\n</xsl:template>\r\n\r\n<xsl:template match="eid-object" mode="person">\r\ndn: uid=<xsl:value-of select="attributes[@class = ''Conta'']/attribute[@name=''login'']" />,  <xsl:value-of select="$peopleDn"/>\r\nchangetype: add<xsl:apply-templates select="attributes[@class = ''Identificacao'']" mode="Identificacao"/>\r\n<xsl:apply-templates select="attributes[@class = ''Email'']" mode="Email"/>\r\n<xsl:apply-templates select="attributes[@class = ''Conta'']" mode="Conta"/>\r\n<xsl:apply-templates select="attributes[@class = ''Aluno'' or @class = ''Professor'' or @class = ''Tecnico'']" mode="Vinculo"/>\r\n</xsl:template>\r\n\r\n<xsl:template name="split"><!-- this template is used to find the last name -->\r\n  <xsl:param name="src"/><!--string-->\r\n  <xsl:param name="delimiter"/><!--string-->\r\n  <xsl:if test="$src">\r\n    <xsl:variable name="s" select="substring-after($src,$delimiter)"/>\r\n    <xsl:choose>\r\n       <xsl:when test="$s">\r\n         <xsl:call-template name="split">\r\n        <xsl:with-param name="src" select="$s"/>\r\n        <xsl:with-param name="delimiter" select="$delimiter"/>\r\n        </xsl:call-template>\r\n     </xsl:when>\r\n       <xsl:otherwise>\r\n        <xsl:value-of select="$src"/>\r\n     </xsl:otherwise>\r\n    </xsl:choose>\r\n  </xsl:if>\r\n</xsl:template>\r\n\r\n<xsl:template name="replace-string">\r\n    <xsl:param name="text"/>\r\n    <xsl:param name="replace"/>\r\n    <xsl:param name="with"/>\r\n    <xsl:choose>\r\n      <xsl:when test="contains($text,$replace)">\r\n        <xsl:value-of select="substring-before($text,$replace)"/>\r\n        <xsl:value-of select="$with"/>\r\n        <xsl:call-template name="replace-string">\r\n          <xsl:with-param name="text"\r\nselect="substring-after($text,$replace)"/>\r\n          <xsl:with-param name="replace" select="$replace"/>\r\n          <xsl:with-param name="with" select="$with"/>\r\n        </xsl:call-template>\r\n      </xsl:when>\r\n      <xsl:otherwise>\r\n        <xsl:value-of select="$text"/>\r\n      </xsl:otherwise>\r\n    </xsl:choose>\r\n  </xsl:template>\r\n\r\n\r\n</xsl:stylesheet>\r\n', 'brEduPerson');

-- --------------------------------------------------------

--
-- Estrutura da tabela 'TBL_XSLT_LDAP_SERVER'
--

CREATE TABLE TBL_XSLT_LDAP_SERVER (
  idXsltLdapServer int(10) unsigned NOT NULL AUTO_INCREMENT,
  idLdap bigint(20) DEFAULT NULL,
  idXslt bigint(20) DEFAULT NULL,
  PRIMARY KEY (idXsltLdapServer),
  KEY XsltLdapServerIndexIdLdap (idLdap),
  KEY XsltLdapServer_FKIndex2 (idXslt)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela 'TBL_XSLT_LDAP_SERVER'
--

INSERT INTO TBL_XSLT_LDAP_SERVER (idXsltLdapServer, idLdap, idXslt) VALUES
(1, 1, 1);

--
-- Restrições para as tabelas dumpadas
--

--
-- Restrições para a tabela `TBL_ERROR`
--
ALTER TABLE `TBL_ERROR`
  ADD CONSTRAINT TBL_ERROR_ibfk_1 FOREIGN KEY (idLdap) REFERENCES TBL_LDAP_SERVER (idLdap) ON DELETE CASCADE;


--
-- Restrições para a tabela `TBL_SCHEDULING_RESULT`
--
ALTER TABLE `TBL_SCHEDULING_RESULT`
  ADD CONSTRAINT TBL_SCHEDULING_RESULT_ibfk_1 FOREIGN KEY (idScheduling) REFERENCES TBL_SCHEDULING (idScheduling) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para a tabela `TBL_SKIP_ATTRIBUTE`
--
ALTER TABLE `TBL_SKIP_ATTRIBUTE`
  ADD CONSTRAINT TBL_SKIP_ATTRIBUTE_LDAP_ibfk_1 FOREIGN KEY (idLdap) REFERENCES TBL_LDAP_SERVER (idLdap) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para a tabela `TBL_XSLT_LDAP_SERVER`
--
ALTER TABLE `TBL_XSLT_LDAP_SERVER`
  ADD CONSTRAINT TBL_XSLT_LDAP_SERVER_ibfk_2 FOREIGN KEY (idLdap) REFERENCES TBL_LDAP_SERVER (idLdap) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT TBL_XSLT_LDAP_SERVER_ibfk_1 FOREIGN KEY (idXslt) REFERENCES TBL_XSLT (idXslt) ON DELETE NO ACTION ON UPDATE NO ACTION;
