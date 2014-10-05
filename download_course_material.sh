#!/bin/sh
# Ce script permet de garder une copie locale des supports de cours
# Par défault il utilise la structure de répertoires ci-dessous :
#
# $home
#	/istic
#		/vv
#		/idm
#			/JMJ
#			/MA
#		/m2infopro
#
# Vous pouvez l'adapter à vos besoins et l'exécuter à chaque fois 
# que vous auriez besoin de mettre à jour vos fichiers locaux, 
# uniquement les nouvelles versions seront téléchargées.

# Indiquer votre numéro d'étudiant
NO_ETUDIANT="XXXXXXXX"
# Redéfinir $HOME si nécessaire
#HOME="/home/user"
# Nom du répertoire de destination
ISTIC_DIR=${HOME}"/""istic"

# Sous-répertoires pour chaque matière
# V&V
DEST_VV=${ISTIC_DIR}"/vv"
# IDM cours de J.M. Jézéquel
DEST_IDM_1=${ISTIC_DIR}"/idm/JMJ"
# IDM cours de M. Archer
DEST_IDM_2=${ISTIC_DIR}"/idm/MA"
# Share ISTIC
DEST_SHARE=${ISTIC_DIR}

# URLs des sites des enseignants
URL_VV="http://people.rennes.inria.fr/Benoit.Baudry/m2-gl-vv/"
URL_IDM_1_BASE="http://people.irisa.fr/Jean-Marc.Jezequel/enseignement/"
URL_IDM_1_PAGE=${URL_IDM_1_BASE}"IngenierieModeles.htm"
URL_IDM_2="http://mathieuacher.com/teaching/MDE/"
URL_SHARE="cassius.istic.univ-rennes1.fr:/share/m2infopro"

# Exclure les répertoires des mises à niveau
EXCLUDES="xml mnco man-XML2* MNJ*"

# Télécharger cours de V&V
wget -q -O- h $URL_VV | grep -o 'http://[^;]*.pdf' | xargs -I% wget -N % -P $DEST_VV

# Télécharger cours d'IDM
# Cours de J.M. Jézéquel
wget -q -O- $URL_IDM_1_PAGE | grep -o '"[^;]*.pdf"' | sed 's/\s+/%20/g' | xargs -I% wget -N ${URL_IDM_1_BASE}% -P $DEST_IDM_1

# Cours de M. Acher
wget -r -A.pdf -N -np -nH --cut-dirs=2 $URL_IDM_2 -P $DEST_IDM_2

# Copier share en respectant la liste d'exclusions
EXCLUDE_LIST=""
for i in ${EXCLUDES}; do
    EXCLUDE_LIST=${EXCLUDE_LIST}"--exclude ${i} "
done
rsync -azvP ${NO_ETUDIANT}@${URL_SHARE} $DEST_SHARE $EXCLUDE_LIST
