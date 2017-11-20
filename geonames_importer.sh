#! /bin/bash


working_dir=$( cd "$( dirname "$0" )" && pwd )
data_dir="$working_dir/data"
zip_codes_dir="$working_dir/data/zip_codes"

# [BEGIN] CONFIGURATION FOR THE SCRIPT
# -------------------------------------

# Geonames URLs
geonames_general_data_repo="http://download.geonames.org/export/dump/"
geonames_postal_code_repo="http://download.geonames.org/export/zip/"

# Default values for database variables.
dbhost="localhost"
dbport=5432
dbname="geonames"
dbusername="postgres"
#Encode special characters with percent encoding e.g. @ = %40
dbpassword="password"

tmp_connection_uri="postgres://$dbusername:$dbpassword@$dbhost:$dbport/postgres"
connection_uri="postgres://$dbusername:$dbpassword@$dbhost:$dbport/$dbname"


# Default value for download folder
download_folder="$working_dir/download"

# Default general dumps to download
dumps="allCountries.zip alternateNames.zip hierarchy.zip admin1CodesASCII.txt admin2Codes.txt featureCodes_en.txt timeZones.txt countryInfo.txt"
# By default all postal codes ... You can specify a set of the files located at http://download.geonames.org/export/zip/
#postal_codes="allCountries.zip"
postal_codes="PL.zip DE.zip"

#
# The folders configuration used by this application is as follows:
#
# current_dir
#    ├── data                 => Decompressed data used in the import process
#    └── download             => Default folder where downloaded files will be stored temporaly
#
#
#
# [END] CONFIGURATION FOR THE SCRIPT
# -------------------------------------

logo() {
    echo "================================================================================================"
    echo "                                                                                                "
    echo "                           G E O N A M E S    D A T A    I M P O R T E R                        "
    echo "                                                                                                "
    echo "=========================================== v 2.0 =============================================="
}

usage() {
	logo
	echo "Usage: " $0 "-a <action> "
    echo " Where <action> can be one of this: "
	echo "    download-data: Downloads the last packages of data available in GeoNames. An additional parameter with a download directory should be used."
    echo "    create-db: Creates the mysql database structure with no data."
    echo "    create-tables: Creates the tables in the current database. Useful if we want to import them in an exsiting db."
    echo "    import-dumps: Imports geonames data into db. A database is previously needed for this to work."
	echo "    drop-db: Removes the db completely."
    echo "    truncate-db: Removes geonames data from db."
    echo
    exit -1
}

dump_db_params() {
    echo "Database parameters being used..."
    echo "Orden: " $action
    echo "UserName: " $dbusername
    echo "Password: " $dbpassword
    echo "DB Host: " $dbhost
    echo "DB Port: " $dbport
    echo "DB Name: " $dbname
    echo "Default connection URI: " $connection_uri
}

if [ $# -lt 1 ]; then
	usage
	exit 1
fi

logo
echo "Current working folder: $working_dir"
echo "Current data folder: $data_dir"
echo "Default download folder: $download_folder"
# echo "PostgreSQL connection URI: $connection_uri"
# echo "PostgreSQL connection URI for database creation: $tmp_connection_uri"


# Deals with operation mode 2 (Database issues...)
# Parses command line parameters.
while getopts "a:u:p:h:r:n:" opt; 
do
    case $opt in
        a) action=$OPTARG ;;
        u) dbusername=$OPTARG ;;
        p) dbpassword=$OPTARG ;;
        h) dbhost=$OPTARG ;;
        r) dbport=$OPTARG ;;
        n) dbname=$OPTARG ;;
    esac
done


case $action in
    download-data)
        echo "STARTING DATA DOWNLOAD !!"
        # Checks if a download folder has been specified otherwise checks if the default download folder
        # exists and if it doesn't then creates it.
        if { [ "$3" != "" ]; } then
            if [ ! -d "$3" ]; then
                echo "Temporary download data folder $3 doesn't exists. Creating it."
                mkdir -p "$working_dir/$3"
            fi
            # Changes the default download folder to the one specified by the user.
            download_folder="$working_dir/$3"
            echo "Changed defuault download folder to $download_folder"
        else
            # Creates default download folder
            if [ ! -d "$download_folder" ]; then
                echo "Temporary download data folder '$download_folder' doesn't exists. Creating it."
                mkdir -p "$download_folder"
            fi
        fi

        # Dumps General data.
        echo "Downloading general files"
        if [ ! -d $data_dir ]; then
            echo "Data folder does not exist. Creating it ..."
            mkdir -p $data_dir
        fi
        for dump in $dumps; do
            echo "Downloading $dump into $download_folder"
            wget -c -P "$download_folder" "$geonames_general_data_repo/$dump"
            if [ ${dump: -4} == ".zip" ]; then
                echo "Unzipping $dump into $data_dir"
                unzip -o "$download_folder/$dump" -d $data_dir
            else
                if [ ${dump: -4} == ".txt" ]; then
                    mv "$download_folder/$dump" $data_dir
                fi
            fi
        done

        # Dumps Postal Code data.
        echo "Downloading postal code information"
        if [ ! -d $zip_codes_dir ]; then
            echo "Zip Codes data folder does not exist. Creating it ..."
            mkdir -p $zip_codes_dir
        fi
        if [ ! -d "$download_folder/zip_codes" ]; then
                echo "Temporary download data folder '$download_folder/zip_codes' doesn't exists. Creating it."
                mkdir -p "$download_folder/zip_codes"
        fi
        for postal_code_file in $postal_codes; do
            echo "Downloading $postal_code_file into $download_folder/zip_codes"
            wget -c -P "$download_folder/zip_codes" "$geonames_postal_code_repo/$postal_code_file"
            if [ ${postal_codes: -4} == ".zip" ]; then
                echo "Unzipping Postal Code file $postal_code_file into $download_folder/zip_codes"
                unzip -o "$download_folder/zip_codes/$postal_code_file" -d $zip_codes_dir
            fi 
        done
        echo "DATA DOWNLOAD FINISHED !!"
        
        # File post-processing        
        echo "Starting file post-processing..."
        if [ -f $data_dir/countryInfo.txt ]; then
			
			sed -i[backup] '1,51d' "$data_dir/countryInfo.txt"			
		fi
		if [ -f $data_dir/timeZones.txt ]; then
			
			sed -i[backup] '1d' "$data_dir/countryInfo.txt"
		fi
		echo "File post-processing done."
        
        
        exit 0
    ;;
esac

case "$action" in
    create-db)
        echo "Creating database $dbname..."
        psql $tmp_connection_uri -c "DROP DATABASE IF EXISTS $dbname;"
        psql $tmp_connection_uri -c "CREATE DATABASE $dbname ENCODING 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';" 
        psql $connection_uri -c "CREATE SCHEMA IF NOT EXISTS geonames;"
        psql $connection_uri -f "$working_dir/geonames_db_struct.sql"
    ;;
        
    create-tables)
        echo "Creating tables for database $dbname..."
        psql $connection_uri -c "CREATE SCHEMA IF NOT EXISTS geonames;"
        psql $connection_uri -f "$working_dir/geonames_db_struct.sql"
    ;;
    
    import-dumps)
        echo "Importing geonames dumps into database $dbname"
        psql $connection_uri -f "$working_dir/geonames_import_data.sql"
    ;;    
    
    drop-db)
        echo "Dropping $dbname database"
        psql $tmp_connection_uri -c "DROP DATABASE IF EXISTS $dbname;"
    ;;
        
    truncate-db)
        echo "Truncating \"geonames\" database"
        psql $connection_uri -f "$working_dir/geonames_truncate_db.sql"
    ;;
esac

if [ $? -eq 0 ]; then 
	echo "[OK]"
else
	echo "[FAILED]"
fi

exit 0
