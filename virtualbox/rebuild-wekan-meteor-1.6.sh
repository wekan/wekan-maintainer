## Most of these are uncommented, because they are already installed.
#sudo rm -rf /usr/local/lib/node_modules
#sudo rm -rf ~/.npm
#sudo apt install build-essential c++ capnproto nodejs nodejs-legacy npm git curl
#sudo npm -g install n

## Using Node.js 6.12 with Meteor 1.6
#sudo n 6.12

## Latest npm with Meteor 1.6
#sudo npm -g install npm@latest

#sudo npm -g install node-gyp
#sudo npm -g install node-pre-gyp

## Latest fibers with Meteor 1.6
# sudo npm -g install fibers

#rm -rf wekan
#git clone git@github.com:wekan/wekan.git
cd ~/repos
#curl https://install.meteor.com -o ./install_meteor.sh
#sed -i "s|RELEASE=.*|RELEASE=${METEOR_RELEASE}\"\"|g" ./install_meteor.sh
#echo "Starting meteor ${METEOR_RELEASE} installation...   \n"

# You need to install Meteor, if it's not yet installed
#chown wekan:wekan ./install_meteor.sh 
#sh ./install_meteor.sh
mkdir -p ~/repos/wekan/packages
cd ~/repos/wekan/packages
# I did use this when building for Meteor-1.6, not sure is this really needed
#rm -rf meteor-useraccounts-core
#git clone https://github.com/meteor-useraccounts/core.git meteor-useraccounts-core
sed -i 's/api\.versionsFrom/\/\/api.versionsFrom/' ~/repos/wekan/packages/meteor-useraccounts-core/package.js
cd ~/repos/wekan

rm -rf node_modules
npm install
rm -rf .build
meteor build .build --directory
cp -f fix-download-unicode/cfs_access-point.txt .build/bundle/programs/server/packages/cfs_access-point.js
sed -i "s|build\/Release\/bson|browser_build\/bson|g" ~/repos/wekan/.build/bundle/programs/server/npm/node_modules/meteor/cfs_gridfs/node_modules/mongodb/node_modules/bson/ext/index.js
cd ~/repos/wekan/.build/bundle/programs/server/npm/node_modules/meteor/npm-bcrypt
rm -rf node_modules/bcrypt
npm install bcrypt
cd ~/repos/wekan/.build/bundle/programs/server
rm -rf node_modules
npm install
npm install bcrypt
cd ~/repos
echo Done.
