#!/bin/bash
#
# init-project.sh
# Description:
# Project specific initialization.

# Load logger
. .gp/bash/workspace-init-logger.sh
# Load spinner
. .gp/bash/spinner.sh

# Install drupal
msg="Installing drupal 8.* via Composer"
log_silent "$msg" && start_spinner "$msg"
mkdir -p drupal && composer create-project drupal/recommended-project:8.* drupal
ec=$?
if [ $ec -ne 0 ]; then
  stop_spinner $ec
  log -e "ERROR: $msg"
else
  log_silent "SUCCESS: $msg"
  stop_spinner $ec
fi

# Create drupal user and database
msg="Creating mysql database: drupalsite"
log_silent "$msg" && start_spinner "$msg"
mysql -e "CREATE DATABASE drupalsite CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
ec=$?
if [ $ec -ne 0 ]; then
  stop_spinner $ec
  log -e "ERROR: $msg"
else
  log_silent "SUCCESS: $msg"
  stop_spinner $ec
fi
msg="Creating mysql drupal user @localhost: drupalusr"
log_silent "$msg" && start_spinner "$msg"
mysql -e "CREATE USER drupalusr@localhost IDENTIFIED BY 'DefaultPa33word!@#$';"
ec=$?
if [ $ec -ne 0 ]; then
  stop_spinner $ec
  log -e "ERROR: $msg"
else
  log_silent "SUCCESS: $msg"
  stop_spinner $ec
fi
