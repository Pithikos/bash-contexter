_upfind_dir(){
	_dir=`pwd`
	while [[ $_dir != / ]] ; do
		guess_path="$_dir"/"$1"
		if [[ -d "$guess_path" ]]; then
			echo "$guess_path"
			return 0
		fi
		_dir=`dirname "$_dir"`
	done
	return 1
}


_upfind_file(){
	_dir=`pwd`
	while [[ "$_dir" != "/" ]] ; do
		guess_path="$_dir"/"$1"
		if [[ -f "$guess_path" ]]; then
			echo "$guess_path"
			return 0
		fi
		_dir=`dirname "$_dir"`
	done
	return 1
}
