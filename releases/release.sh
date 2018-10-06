# Usage: ./release.sh 1.36

# Delete old stuff
cd ~/repos/wekan
sudo rm -rf parts prime stage .meteor-spk

# Set permissions
cd ~/repos
sudo chown user:user wekan -R
cd ~/
sudo chown user:user .meteor -R
sudo chown user:user .cache/snapcraft

# Build Source
cd ~/repos
./rebuild-release.sh

# Build Sandstorm
cd wekan
meteor-spk pack wekan-$1.spk
spk publish wekan-$1.spk
scp wekan-$1.spk x2:/var/snap/wekan/common/releases.wekan.team/
mv wekan-$1.spk ../..
rm -rf .meteor-spk

# Build Snap
cd ~/repos
./release-cleanup.sh
./release-snap.sh $1
#sudo snapcraft
#scp wekan_$1_amd64.snap x2:/var/snap/wekan/common/releases.wekan.team/
#snapcraft push wekan_$1_amd64.snap
#mv wekan_$1_amd64.snap ..
