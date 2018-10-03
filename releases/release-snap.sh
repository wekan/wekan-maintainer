# Usage: ./release.sh 1.36

# Delete old stuff
cd ~/repos/wekan
sudo rm -rf parts prime stage .meteor-spk

mv wekan_* ..

# Set permissions
cd ~/repos
sudo chown user:user wekan -R
cd ~/
sudo chown user:user .meteor -R
#sudo chown user:user .cache/snapcraft -R
sudo rm -rf .cache/snapcraft
sudo chown user:user .config -R

# Build Source
cd ~/repos
./rebuild-release.sh

# Build Sandstorm
cd wekan
#meteor-spk pack wekan-$1.spk
#spk publish wekan-$1.spk
#scp wekan-$1.spk x2:/var/snap/wekan/common/releases.wekan.team/
#mv wekan-$1.spk ../..
#rm -rf .meteor-spk

# Build Snap
sudo snapcraft

# Set permissions
cd ~/repos
sudo chown user:user wekan -R
cd ~/
sudo chown user:user .meteor -R
#sudo chown user:user .cache/snapcraft -R
sudo rm -rf .cache/snapcraft
sudo chown user:user .config -R

# Push snap
cd ~/repos/wekan
sudo snap install --dangerous wekan_$1_amd64.snap
#mv wekan_* ..
#cd ..
echo "Now you can test local installed snap."
#snapcraft push wekan_$1_amd64.snap
#scp wekan_$1_amd64.snap x2:/var/snap/wekan/common/releases.wekan.team/
