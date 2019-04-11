currentfol=$(pwd);

for d in */; do
    echo "$d"
    cd "$currentfol/$d" && . $renumfol
done

cd $batchfolder