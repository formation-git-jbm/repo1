#!/bin/sh -l

# Construct the exclude commands
for excludedPath in $EXCLUDE
do
  EXCLUDE="$EXCLUDE --exclude $excludedPath"
done

lftp $FTP_HOST -u $FTP_USERNAME,$FTP_PASSWORD -e "$([ "$DISABLE_SSL_CERTIFICATE_VERIFICATION" == true ] && echo "set ssl:verify-certificate false;") mirror --verbose --reverse $([ "$DELETE" == true ] && echo "--delete") $([ "$ONLY_NEWER" == true ] && echo "--only-newer") $([ "$IGNORE_TIME" == true ] && echo "--ignore-time") $OTHER_FLAGS $EXCLUDE $LOCAL_SOURCE_DIR $DIST_TARGET_DIR; exit"