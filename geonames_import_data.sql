\echo '########## Loading allCountries.txt... ##########';
\COPY geonames.geoname (geoname_id, name, ascii_name, alternate_names, latitude, longitude, fclass, fcode, country, cc2, admin1, admin2, admin3, admin4, population, elevation, gtopo30, time_zone, mod_date) FROM 'data/allCountries.txt' WITH (FORMAT 'csv', DELIMITER E'\t', HEADER FALSE, ENCODING 'utf-8', quote E'\b')

\echo '########## Loading alternateNames.txt... ##########';
\COPY geonames.alternate_name (alternate_name_id, geoname_id, iso_language, alternate_name, is_preferred_name, is_short_name, is_colloquial, is_historic) FROM 'data/alternateNames.txt' WITH (FORMAT 'csv', DELIMITER E'\t', HEADER FALSE, ENCODING 'utf-8', quote E'\b')

\echo '########## Loading iso-languagecodes.txt... ##########';
\COPY geonames.iso_language_codes (iso_639_3, iso_639_2, iso_639_1, language_name) FROM 'data/iso-languagecodes.txt' WITH (FORMAT 'csv', DELIMITER E'\t', HEADER TRUE, ENCODING 'utf-8', quote E'\b')

\echo '########## Loading admin1CodesASCII.txt... ##########';
\COPY geonames.admin1_codes_ascii (code, name, name_ascii, geoname_id) FROM 'data/admin1CodesASCII.txt' WITH (FORMAT 'csv', DELIMITER E'\t', HEADER FALSE, ENCODING 'utf-8', quote E'\b')

\echo '########## Loading admin2Codes.txt... ##########';
\COPY geonames.admin2_codes (code, name, name_ascii, geoname_id) FROM 'data/admin2Codes.txt' WITH (FORMAT 'csv', DELIMITER E'\t', HEADER FALSE, ENCODING 'utf-8', quote E'\b')

\echo '########## Loading hierarchy.txt... ##########';
\COPY geonames.hierarchy (parent_id, child_id, type) FROM 'data/hierarchy.txt' WITH (FORMAT 'csv', DELIMITER E'\t', HEADER FALSE, ENCODING 'utf-8', quote E'\b')

\echo '########## Loading featureCodes_en.txt... ##########';
\COPY geonames.feature_codes (code, name, description) FROM 'data/featureCodes_en.txt' WITH (FORMAT 'csv', DELIMITER E'\t', HEADER FALSE, ENCODING 'utf-8', quote E'\b')

\echo '########## Loading timeZones.txt... ##########';
\COPY geonames.time_zones (country, time_zone_id, GMT_offset, DST_offset, raw_offset) FROM 'data/timeZones.txt' WITH (FORMAT 'csv', DELIMITER E'\t', HEADER FALSE, ENCODING 'utf-8', quote E'\b')

\echo '########## Loading countryInfo.txt... ##########';
\COPY geonames.country_info (iso_alpha2, iso_alpha3, iso_numeric, fips_code, name, capital, area_in_sqkm, population, continent, tld, currency, currency_name, phone, postal_code_format, postal_code_regex, languages, geoname_id, neighbours, equivalent_fips_code) FROM 'data/countryInfo.txt' WITH (FORMAT 'csv', DELIMITER E'\t', HEADER FALSE, ENCODING 'utf-8', quote E'\b')

\echo '########## Loading continentCodes.txt... ##########';
\COPY geonames.continent_codes (code, name, geoname_id) FROM 'continentCodes.txt' WITH (FORMAT 'csv', DELIMITER ',', HEADER FALSE, ENCODING 'utf-8', quote E'\b')

\echo '########## Postal Code Data. ... ##########';
-- Postal Code Data. Ignore until we are able to download them
--\COPY geonames.postal_codes (country, postal_code, name, admin1_name, admin1_code, admin2_name, admin2_code, admin3_name, admin3_code, latitude, longitude, accuracy) FROM 'data/zip_codes/allCountries.txt' WITH (FORMAT 'csv', DELIMITER E'\t', HEADER FALSE, ENCODING 'utf-8', quote E'\b')
\COPY geonames.postal_codes (country, postal_code, name, admin1_name, admin1_code, admin2_name, admin2_code, admin3_name, admin3_code, latitude, longitude, accuracy) FROM 'data/zip_codes/PL.txt' WITH (FORMAT 'csv', DELIMITER E'\t', HEADER FALSE, ENCODING 'utf-8', quote E'\b')
\COPY geonames.postal_codes (country, postal_code, name, admin1_name, admin1_code, admin2_name, admin2_code, admin3_name, admin3_code, latitude, longitude, accuracy) FROM 'data/zip_codes/DE.txt' WITH (FORMAT 'csv', DELIMITER E'\t', HEADER FALSE, ENCODING 'utf-8', quote E'\b')

