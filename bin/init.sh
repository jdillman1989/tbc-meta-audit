# requires config file:
# STAGING='test';
# WEBROOT=/var/www/$STAGING;
# PUBLIC=$WEBROOT/public_html;
# USER='user';
# SERVER=$USER'@jdillman.com';

source "config.sh";
echo 'echo start;' > installStaging.sh;
cat config.sh >> installStaging.sh;
cat stagingScript.sh >> installStaging.sh;
SCRIPT=`cat installStaging.sh`;
ssh -t $SERVER "sh $SCRIPT";
git remote add staging $SERVER:$WEBROOT/$STAGING.git;
rm installStaging.sh;