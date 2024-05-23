parameter1=$1
parameter2=$2
add(){	
	result=$(echo "scale=2;${parameter1}+${parameter2}"|bc)
    	echo "$1+$2=$result"
}
reduce(){
	result=$(echo "scale=2;${parameter1}-${parameter2}"|bc)
    	echo "$1-$2=$result"
}
cheng(){
	result=$(echo "scale=2;${parameter1}*${parameter2}"|bc)
    	echo "$1*$2=$result"
}

read -p "Please enter your choice:" choice
case ${choice} in
	1 )
        echo "choice 1:"
        add $1 $2
		;;
	2 )
        echo "choice 2"
	reduce $1 $2
		;;
        3 )
        echo "choice 3"
	cheng $1 $2
		;;
esac
