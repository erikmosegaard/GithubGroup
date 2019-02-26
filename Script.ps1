


#vmLS3
#Ins Root hoch.
cd /root

cd home/vmadmin

#cd home/vmadmin/Backup-Restore/Marti_AG




#vmLS3
mkdir  Backup-Restore

ls
#Ausgabe
#Backup-Restore

cd Backup-Restore
#Dir change

mkdir Marti_AG

ls
#Ausgabe
#Marti_AG


cd Marti_AG
#Dir change

mkdir Chef
mkdir user1
mkdir user2
mkdir user3
mkdir user4
mkdir user5
mkdir user6
mkdir user7
mkdir user8
mkdir user9

ls
#Ausgabe
<#
Chef
user1
user2
user3
user4
user5
user6
user7
user8
user9
#>






#######################                  IDEA 1                   ###################################

#!/bin/bash
####################################
#
# Backup to NFS mount script.
#
####################################

# What to backup. 
backup_files="/home /var/spool/mail /etc /root /boot /opt"

# Where to backup to.
dest="/mnt/backup"

# Create archive filename.
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file"
date
echo

# Backup the files using tar.
tar czf $dest/$archive_file $backup_files

# Print end status message.
echo
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest


##########How to
<#
$backup_files: a variable listing which directories you would like to backup. The list should be customized to fit your needs.

$day: a variable holding the day of the week (Monday, Tuesday, Wednesday, etc). This is used to create an archive file for each day of the week, giving a backup history of seven days. There are other ways to accomplish this including using the date utility.

$hostname: variable containing the short hostname of the system. Using the hostname in the archive filename gives you the option of placing daily archive files from multiple systems in the same directory.

$archive_file: the full archive filename.

$dest: destination of the archive file. The directory needs to be created and in this case mounted before executing the backup script. See Network File System (NFS) for details of using NFS.

status messages: optional messages printed to the console using the echo utility.

tar czf $dest/$archive_file $backup_files: the tar command used to create the archive file.

c: creates an archive.

z: filter the archive through the gzip utility compressing the archive.

f: output to an archive file. Otherwise the tar output will be sent to STDOUT.

ls -lh $dest: optional statement prints a -l long listing in -h human readable format of the destination directory. This is useful for a quick file size check of the archive file. This check should not replace testing the archive file.
#>

<#
To automate the the task you can add a new entry in root's crontab by the command sudo crontab -e. For example to execute the script every night at 1:15 the Cron job definition should be:

15 1 * * * /usr/local/bin/mybackup > /var/log/mybackup-cron.log 2>&1
#>

############################################    Restore IDEA 1         ###########################################

<#
Restoring from the Archive
Once an archive has been created it is important to test the archive. The archive can be tested by listing the files it contains, but the best test is to restore a file from the archive.

To see a listing of the archive contents. From a terminal prompt type:

tar -tzvf /mnt/backup/host-Monday.tgz
To restore a file from the archive to a different directory enter:

tar -xzvf /mnt/backup/host-Monday.tgz -C /tmp etc/hosts
The -C option to tar redirects the extracted files to the specified directory. The above example will extract the /etc/hosts file to /tmp/etc/hosts. tar recreates the directory structure that it contains.

Also, notice the leading "/" is left off the path of the file to restore.

To restore all files in the archive enter the following:

cd /
sudo tar -xzvf /mnt/backup/host-Monday.tgz
This will overwrite the files currently on the file system.
#>




#Ubuntu Original



#!/bin/bash
DATE=$(date +%Y-%m-%d-%H%M%S)

# pfad sollte nicht mit "/" enden!
# Dies ist nur ein Beispiel - bitte an eigene Bedürfnisse anpassen.
# Man muß schreibberechtigt im entsprechenden Verzeichnis sein.
BACKUP_DIR="/mnt/backup"

# Hier Verzeichnisse auflisten, die gesichert werden sollen.
# Dies ist nur ein Beispiel - bitte an eigene Bedürfnisse anpassen.
# Bei Verzeichnissen, für die der User keine durchgehenden Leserechte hat (z.B. /etc) sind Fehler vorprogrammiert.
# Pfade sollte nicht mit "/" enden!
SOURCE="$HOME/bin $HOME/.gaim "

tar -cjpf $BACKUP_DIR/backup-$DATE.tar.bz2 $SOURCE