#!/bin/bash

echo "Supported: Debian 9."
echo
echo "Note: If you use other locale than en_US.UTF-8 , you need to additionally install en_US.UTF-8"
echo "      with 'sudo dpkg-reconfigure locales' , so that MongoDB works correctly."
echo "      You can still use any other locale as your main locale."
echo
PS3='Please enter your choice: '
options=("Install Wekan dependencies" "Build Wekan" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Install Wekan dependencies")
            echo "Installing Wekan dependencies."
            sudo apt install -y build-essential git curl
            # Node.js and NPM for Debian
            curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
            sudo apt install -y nodejs
            sudo npm -g install n
            ## Using Node.js 6.12 with Meteor 1.6
            sudo n 8.9.3
            ## Latest npm with Meteor 1.6
            sudo npm -g install npm@5.5.1
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
        "Build Wekan")
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
            #Removed binary version of bcrypt because of security vulnerability that is not fixed yet.
            #https://github.com/wekan/wekan/commit/4b2010213907c61b0e0482ab55abb06f6a668eac
            #https://github.com/wekan/wekan/commit/7eeabf14be3c63fae2226e561ef8a0c1390c8d3c
            #cd ~/repos/wekan/.build/bundle/programs/server/npm/node_modules/meteor/npm-bcrypt
            #rm -rf node_modules/bcrypt
            #meteor npm install bcrypt
            cd ~/repos/wekan/.build/bundle/programs/server
            rm -rf node_modules
            meteor npm install
            #meteor npm install bcrypt
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
