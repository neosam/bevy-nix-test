mkdir -p $out/share/$appName
mv $out/bin/$appName $out/share/$appName
cp -r assets $out/share/$appName

echo "#!/usr/bin/env bash" > $out/bin/$appName
echo export LD_LIBRARY_PATH=$LD_LIBRARY_PATH >> $out/bin/$appName
echo "$out/share/$appName/$appName" >> $out/bin/$appName

chmod a+x $out/bin/$appName
