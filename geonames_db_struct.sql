-- Create syntax for TABLE geonames.admin1_codes_ascii
CREATE TABLE geonames.admin1_codes_ascii (
  code char(15) DEFAULT NULL,
  name TEXT,
  name_ascii TEXT,
  geoname_id INTEGER DEFAULT NULL
);

CREATE INDEX IXFK_admin1_codes_ascii_code ON geonames.admin1_codes_ascii (ascii_code ASC);
CREATE INDEX IXFK_admin1_codes_ascii_name ON geonames.admin1_codes_ascii (name ASC);
CREATE INDEX IXFK_admin1_codes_ascii_name_ascii ON geonames.admin1_codes_ascii (name_ascii ASC);
CREATE INDEX IXFK_admin1_codes_ascii_geoname_id ON geonames.admin1_codes_ascii (geoname_id ASC);

-- Create syntax for TABLE geonames.admin2_codes
CREATE TABLE geonames.admin2_codes (
  code char(15) DEFAULT NULL,
  name TEXT,
  name_ascii TEXT,
  geoname_id INTEGER DEFAULT NULL
);

CREATE INDEX IXFK_admin2_codes_code ON geonames.admin2_codes (ascii_code ASC);
CREATE INDEX IXFK_admin2_codes_name ON geonames.admin2_codes (name ASC);
CREATE INDEX IXFK_admin2_codes_name_ascii ON geonames.admin2_codes (name_ascii ASC);
CREATE INDEX IXFK_admin2_codes_geoname_id ON geonames.admin2_codes (geoname_id ASC);

-- Create syntax for TABLE geonames.alternate_name
CREATE TABLE geonames.alternate_name (
  alternatename_Id INTEGER NOT NULL,
  geoname_id INTEGER DEFAULT NULL,
  iso_language varchar(7) DEFAULT NULL,
  alternate_name varchar(200) DEFAULT NULL,
  is_preferredn_name SMALLINT DEFAULT NULL,
  is_short_name SMALLINT DEFAULT NULL,
  is_colloquial SMALLINT DEFAULT NULL,
  is_historic SMALLINT DEFAULT NULL
);

ALTER TABLE geonames.alternate_name ADD CONSTRAINT PK_alternate_name PRIMARY KEY (alternatename_id);
CREATE INDEX IXFK_alternate_name_geoname_id ON geonames.alternate_name (geoname_id ASC);
CREATE INDEX IXFK_alternate_name_iso_language ON geonames.alternate_name (iso_language ASC);
CREATE INDEX IXFK_alternate_name_alternate_name ON geonames.alternate_name (alternate_name ASC);

-- Create syntax for TABLE geonames.continent_codes
CREATE TABLE geonames.continent_codes (
  code char(2) DEFAULT NULL,
  name varchar(20) DEFAULT NULL,
  geoname_id INTEGER DEFAULT NULL
);

CREATE INDEX IXFK_continent_codes_code ON geonames.continent_codes (code ASC);
CREATE INDEX IXFK_continent_codes_name ON geonames.continent_codes (name ASC);
CREATE INDEX IXFK_continent_codes_geoname_id ON geonames.continent_codes (geoname_id ASC);

-- Create syntax for TABLE geonames.country_info
CREATE TABLE geonames.country_info (
  iso_alpha2 char(2) DEFAULT NULL,
  iso_alpha3 char(3) DEFAULT NULL,
  iso_numeric INTEGER DEFAULT NULL,
  fips_code varchar(3) DEFAULT NULL,
  name varchar(200) DEFAULT NULL,
  capital varchar(200) DEFAULT NULL,
  area_in_sqkm double DEFAULT NULL,
  population INTEGER DEFAULT NULL,
  continent char(2) DEFAULT NULL,
  tld char(3) DEFAULT NULL,
  currency char(3) DEFAULT NULL,
  currency_name char(20) DEFAULT NULL,
  Phone char(10) DEFAULT NULL,
  postal_code_format varchar(100) DEFAULT NULL,
  postal_code_regex varchar(255) DEFAULT NULL,
  geoname_Id INTEGER DEFAULT NULL,
  languages varchar(200) DEFAULT NULL,
  neighbours char(100) DEFAULT NULL,
  equivalent_fips_code char(10) DEFAULT NULL
);

CREATE INDEX IXFK_country_info_iso_alpha2 ON geonames.country_info (iso_alpha2 ASC);
CREATE INDEX IXFK_country_info_iso_alpha3 ON geonames.country_info (iso_alpha3 ASC);
CREATE INDEX IXFK_country_info_iso_numeric ON geonames.country_info (iso_numeric ASC);
CREATE INDEX IXFK_country_info_fips_code ON geonames.country_info (fips_code ASC);
CREATE INDEX IXFK_country_info_name ON geonames.country_info (name ASC);

-- Create syntax for TABLE geonames.feature_codes
CREATE TABLE geonames.feature_codes (
  code char(7) DEFAULT NULL,
  name varchar(200) DEFAULT NULL,
  description TEXT
);

CREATE INDEX IXFK_feature_codes_code ON geonames.feature_codes (code ASC);
CREATE INDEX IXFK_feature_codes_name ON geonames.feature_codes (name ASC);

-- Create syntax for TABLE geonames.geoname
CREATE TABLE geonames.geoname (
  geoname_id INTEGER NOT NULL,
  name varchar(200) DEFAULT NULL,
  asciiname varchar(200) DEFAULT NULL,
  alternatenames varchar(4000) DEFAULT NULL,
  latitude decimal(10,7) DEFAULT NULL,
  longitude decimal(10,7) DEFAULT NULL,
  fclass char(1) DEFAULT NULL,
  fcode varchar(10) DEFAULT NULL,
  country varchar(2) DEFAULT NULL,
  cc2 varchar(200) DEFAULT NULL,
  admin1 varchar(20) DEFAULT NULL,
  admin2 varchar(80) DEFAULT NULL,
  admin3 varchar(20) DEFAULT NULL,
  admin4 varchar(20) DEFAULT NULL,
  population INTEGER DEFAULT NULL,
  elevation INTEGER DEFAULT NULL,
  gtopo30 INTEGER DEFAULT NULL,
  timezone varchar(40) DEFAULT NULL,
  moddate date DEFAULT NULL
);

ALTER TABLE geonames.geoname ADD CONSTRAINT PK_geoname PRIMARY KEY (geoname_id);
CREATE INDEX IXFK_geoname_name ON geonames.geoname (name ASC);
CREATE INDEX IXFK_geoname_latitude ON geonames.geoname (latitude ASC);
CREATE INDEX IXFK_geoname_longitude ON geonames.geoname (longitude ASC);
CREATE INDEX IXFK_geoname_fclass ON geonames.geoname (fclass ASC);
CREATE INDEX IXFK_geoname_fcode ON geonames.geoname (fcode ASC);
CREATE INDEX IXFK_geoname_country ON geonames.geoname (country ASC);
CREATE INDEX IXFK_geoname_cc2 ON geonames.geoname (cc2 ASC);
CREATE INDEX IXFK_geoname_admin1 ON geonames.geoname (admin1 ASC);
CREATE INDEX IXFK_geoname_population ON geonames.geoname (population ASC);
CREATE INDEX IXFK_geoname_population ON geonames.geoname (population ASC);
CREATE INDEX IXFK_geoname_elevation ON geonames.geoname (elevation ASC);
CREATE INDEX IXFK_geoname_timezone ON geonames.geoname (timezone ASC);

-- Create syntax for TABLE geonames.hierarchy
CREATE TABLE geonames.hierarchy (
  parent_id INTEGER DEFAULT NULL,
  child_id INTEGER DEFAULT NULL,
  type varchar(50) DEFAULT NULL
);

CREATE INDEX IXFK_hierarchy_parent_id ON geonames.hierarchy (parent_id ASC);
CREATE INDEX IXFK_hierarchy_child_id ON geonames.hierarchy (child_id ASC);

-- Create syntax for TABLE geonames.iso_language_codes
CREATE TABLE geonames.iso_language_codes (
  iso_639_3 char(4) DEFAULT NULL,
  iso_639_2 varchar(50) DEFAULT NULL,
  iso_639_1 varchar(50) DEFAULT NULL,
  language_name varchar(200) DEFAULT NULL
);

-- Create syntax for TABLE geonames.time_zones
CREATE TABLE geonames.time_zones (
  time_zone_id varchar(200) DEFAULT NULL,
  GMT_offset decimal(3,1) DEFAULT NULL,
  DST_offset decimal(3,1) DEFAULT NULL
);

-- Create syntax for TABLE geonames.postal_codes
CREATE TABLE geonames.postal_codes (
  country char(2) DEFAULT NULL,
  postal_code varchar(20) DEFAULT NULL,
  name varchar(180) DEFAULT NULL,
  admin1_name varchar(100) DEFAULT NULL,
  admin1_code varchar(20) DEFAULT NULL,
  admin2_name varchar(100) DEFAULT NULL,
  admin2_code varchar(20) DEFAULT NULL,
  admin3_name varchar(100) DEFAULT NULL,
  admin3_code varchar(20) DEFAULT NULL,
  latitude decimal(10,7) DEFAULT NULL,
  longitude decimal(10,7) DEFAULT NULL,
  accuracy SMALLINT DEFAULT NULL
);

CREATE INDEX IXFK_postal_codes_admin1_code ON geonames.postal_codes (admin1_code ASC);
CREATE INDEX IXFK_postal_codes_country ON geonames.postal_codes (country ASC);
CREATE INDEX IXFK_postal_codes_name ON geonames.postal_codes (name ASC);
CREATE INDEX IXFK_postal_codes_postal_code ON geonames.postal_codes (postal_code ASC);
CREATE INDEX IXFK_postal_codes_latitude ON geonames.postal_codes (latitude ASC);
CREATE INDEX IXFK_postal_codes_longitude ON geonames.postal_codes (longitude ASC);
CREATE INDEX IXFK_postal_codes_admin1_name ON geonames.postal_codes (admin1_name ASC);
CREATE INDEX IXFK_postal_codes_admin1_code ON geonames.postal_codes (admin1_code ASC);
