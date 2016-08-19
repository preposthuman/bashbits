#!/bin/bash
# Installs the various dot.* files and dirs into ~/

cd $( dirname "$0" )
for ZZZ in $( find . -maxdepth 1 -type d -name "dot.*" )
do
    rsync -v --progress -clpr --inplace ${ZZZ#./}/ ~/${ZZZ#./dot}
done
for ZZZ in $( find . -maxdepth 1 -type f -name "dot.*" )
do
    rsync -v --progress -clp --inplace ${ZZZ#./} ~/${ZZZ#./dot}
done
for ZZZ in $( find . -maxdepth 1 -type l -name "dot.*" )
do
    YYY=$( readlink "$ZZZ" )
    ln -s ~/${YYY#*dot} ~/${ZZZ#*dot}
done
