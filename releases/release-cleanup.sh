# Usage: ./release.sh 1.36

# Delete old stuff
cd ~/repos/wekan
sudo rm -rf parts prime stage .meteor-spk

# Set permissions
cd ~/repos
sudo chown user:user wekan -R
cd ~/
sudo chown user:user .meteor -R

# Back
cd ~/repos
