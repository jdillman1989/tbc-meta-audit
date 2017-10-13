echo "Installing WordPress";
cd $PUBLIC;
wget http://wordpress.org/latest.tar.gz;
tar xfz latest.tar.gz;
mv wordpress/* ./;
rmdir ./wordpress/;
rm -f latest.tar.gz;
echo "Setting WordPress permissions";
touch .htaccess;
sudo chmod 660 .htaccess;
mkdir wp-content/upgrade;
sudo chown -R $USER:www-data $PUBLIC;
sudo find $PUBLIC -type d -exec chmod g+s {} \;
sudo chmod g+w $PUBLIC/wp-content;
sudo chmod -R g+w $PUBLIC/wp-content/themes;
sudo chmod -R g+w $PUBLIC/wp-content/plugins;

echo "Installing Git deployment";
cd $WEBROOT;
mkdir $STAGING.git;
cd $STAGING.git;
git init --bare;
cd hooks;
touch post-receive;
echo "#!/bin/sh
unset GIT_DIR;
export GIT_WORK_TREE=$WEBROOT/build;
export GIT_DIR=$WEBROOT/$STAGING.git;
git checkout -f master;
rsync -r $WEBROOT/build/wp-content/* $PUBLIC/wp-content/" >> post-receive;

cd $WEBROOT;
mkdir build;

echo "Setting up deployments";
cd $WEBROOT/$STAGING.git/hooks;
chmod 775 post-receive;
echo "Complete";