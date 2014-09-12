sudo apt-get update
sudo apt-get install sshfs
sudo mkdir /share
sudo mkdir /mnt
# remplacez "user" par votre user linux
sudo adduser user fuse
# remplacez "XXXXXXYZ" par votre numéro d'étudiant où "YZ" sont les deux derniers chiffres
sudo sshfs XXXXXXYZ@cassius.istic.univ-rennes1.fr:/share /share -o allow_other
sudo sshfs XXXXXXYZ@cassius.istic.univ-rennes1.fr:/private/student/Z/YZ/XXXXXXYZ /mnt -o allow_other
