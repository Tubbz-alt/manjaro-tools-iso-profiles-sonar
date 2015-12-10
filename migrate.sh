#!/bin/bash

name=sonar
mkdir $name
for p in cli mate gnome;do
	mv $p $name/
	git rm -r $p
	for f in $name/$p/*;do
		if [[ -L $f ]];then
			target=$(readlink $f)
			ln -sf ../$target $f
		fi
		if [[ ${f##*/} == profile.conf ]];then
			sed -e "/^\# edition type/,/^edition_type/d" -i $f
		fi
	done
done
git add -A
git commit -m "transition to new structure for manjaro-tools-0.9.15"
