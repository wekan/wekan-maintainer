#!/bin/bash

PS3='Please enter your choice: '
options=("First build of Wekan" "Pull latest changes and rebuild" "Rebuild Wekan only" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "First build of Wekan")
            echo "Installing Wekan dependencies."
            sudo apt -y install build-essential npm git curl
            sudo npm -g install n
            ## Using Node.js 6.12 with Meteor 1.6
            sudo n 8.9.3
            ## Latest npm with Meteor 1.6
            sudo npm -g install npm@5.1.1
            sudo npm -g install node-gyp
            # Latest fibers with Meteor 1.6
            sudo npm -g install fibers@2.0.0
            # You need to install Meteor, if it's not yet installed
            curl https://install.meteor.com | bash
            mkdir ~/repos
            cd ~/repos
            git clone https://github.com/wekan/wekan.git
            cd wekan
            git checkout devel
            break
            ;;
        "Pull latest changes and rebuild")
            echo "Pulling latest changes."
            cd ~/repos/wekan
            git pull
            cd ~/repos
            break
            ;;
        "Rebuild Wekan only")
            echo "Building Wekan."
            cd ~/repos/wekan
            mkdir -p ~/repos/wekan/packages
            cd ~/repos/wekan/packages
            git clone https://github.com/wekan/flow-router.git kadira-flow-router
            git clone https://github.com/meteor-useraccounts/core.git meteor-useraccounts-core
            sed -i 's/api\.versionsFrom/\/\/api.versionsFrom/' ~/repos/wekan/packages/meteor-useraccounts-core/package.js
            cd ~/repos/wekan
            rm -rf node_modules
            meteor npm install
            rm -rf .build
            meteor build .build --directory
            cp -f fix-download-unicode/cfs_access-point.txt .build/bundle/programs/server/packages/cfs_access-point.js
            cd ~/repos/wekan/.build/bundle/programs/server/npm/node_modules/meteor/npm-bcrypt
            rm -rf node_modules/bcrypt
            meteor npm install bcrypt
            cd ~/repos/wekan/.build/bundle/programs/server
            rm -rf node_modules
            meteor npm install
            meteor npm install bcrypt
            cd ~/repos
            echo Done.
            break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
