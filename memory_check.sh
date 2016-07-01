#!/bin/bash
#Anna Mae N. Magallanes

mem_usage=$(free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
usage=$(free -m | awk 'NR==2{printf "%.0f",$3*100/$2 }');
echo $mem_usage;

ext()
        {
        echo -n "Exit Value: "
        read val;

        if [ "$val" == 0 ]; then
                if [ "$usage" -lt "${w}" ]; then
                        exit;
                else
                        echo "Incorrect Value";
                        ext;
                fi
        elif [ "$val" == 1 ]; then
                if [ "$usage" -ge "${w}" ] && [ "$usage" -lt "${c}" ]; then
                exit;
        else
                echo "Incorrect Value";
                ext;
        fi
        elif [ "$val" == 2 ]; then
        if [ "$usage" -ge "${c}" ]; then
                dt=$(date '+%Y%m%d%H:%M:%S'); process=$(ps aux --sort=-%mem | awk 'NR<=11{printf "\n%s\t%s\t%s\t%s\t%s",$1,$2,$3,$4,$11}'); echo -e "\nHi Ma'am/Sir's, \n\nKindly see top running process below for your reference. \n\n$process \n\nThanks.\n" > /tmp/mail.txt | mutt -s "$dt" -i  /tmp/mail.txt ${e} < /dev/null;
                exit;
        else
                echo "Incorrect Value";
                ext;
        fi

        else
                echo "Invalid Input"
                ext;
        fi
}



while getopts ":w:c:e:" a; do
case "${a}" in
        w)
                w=${OPTARG}
                ;;
        c)
                c=${OPTARG}
                ;;
        e)
                e=${OPTARG}
                ;;
        *)
        ;;
esac
done


        if [ $w -gt $c ] || [ $w == $c ]; then
                echo "Please Note: Input a value that must be lower than critical"
        else
                if [ "$usage" -ge "${w}" ] && [ "$usage" -lt "${c}" ]; then
                        echo "Usage is Warning";
                        echo "EmailAdrr: " ${e};
                        ext
                elif [ "$usage" -ge "${c}" ] && [ "$usage" -le 100 ]; then
                        echo "Usage is Critical";
                        echo "EmailAdrr: " ${e};
                        ext
                else
                        echo "Usage is Healthy"
			echo "EmailAdrr: " ${e};
			ext
                 fi
        fi
