for d in $(dirname "$(readlink -f "$0")")/* ; do
	if [ -d $d ] ; then
		if [ -e $d/profile ] ; then
			source $d/profile
		fi
	fi
done
