#!/bin/bash

num=$1
type=$2
case ${type} in
	t1)
		for (( i=1; i<=$num ;i++ ));
		do
			for (( j=$num ;j>i ; j--));
			do
				echo -n " "
			done
			for (( j=1;j<=i ; j++));do
				echo  -n "*"
			done
			echo " "
		done
		;;

	t2)
		for (( i=1; i<=$num ;i++ ));
		do
			for (( j=1;j<=i ; j++));
			do
				echo -n "*"
			done
			echo " "
		done
		;;
        t3)
                for (( i=1; i<=$num ;i++ ));
		do
                        for (( j=$num+1 ;j>i ; j--));
			do
				echo -n " "
			done
			for (( j=1;j<=i ; j++));
			do
				echo  -n "*"
			done
			for (( j=2 ;j<=i ; j++));
			do
				echo  -n "*"
			done
			echo " "
		done
		;;
         t4)
                for (( i=1; i<=$num ;i++ ));
		do
			for (( j=$num+1 ;j>i ; j--));
			do
				echo -n "*"
                        done
                        for (( j=1;j<=i ; j++));
			do
                                echo  -n " "
                        done
                        echo " "
                done
                ;;
	t5)
		for (( i=1; i<=$num ;i++ ));
		do
			for (( j=1;j<=i ; j++));
			do
                                echo -n " "
                        done
                        for ((j=$num+1 ; j>i ;j--));
			do
                                echo -n "*"
                        done
                        echo " "
		done
                ;;
	t6)
		for (( i=1; i<=$num ;i++ ));
		do
			for (( j=1;j<=i ; j++));
			do
				echo -n " "
                        done
                        for (( j=$num+1 ;j>i ; j--));
			do
                                echo -n "*"
                        done
                        for (( j=$num  ;j>i ; j--));
			do
				echo  -n "*"
                        done
                        echo " "
		done
                ;;
	t7)
		for ((i=1; i<=$num; i++));
		do
			for ((j=$num; j>i; j--));
                        do
				echo -n " "
                        done
                        for ((k=1; k<=(2*i-1); k++));
                        do
                                echo -n "*"
                        done
                        echo ""
		done
                for ((i=$num-1; i>=1; i--));
                do
                        for ((j=1; j<=$num-i; j++));
                        do
                                echo -n " "
                        done
                        for ((k=1; k<=(2*i-1); k++));
                        do
                                echo -n "*"
                        done
                        echo ""
		done
		;;
	*)
		echo "command not found"
                ;;
esac
