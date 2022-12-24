name=bevy-nix-test
echo "#!/usr/bin/env bash" > $out/bin/$name.sh
echo export LD_LIBRARY_PATH=$LD_LIBRARY_PATH >> $out/bin/$name.sh
echo "echo $LD_LIBRARY_PATH" >> $out/bin/$name.sh
echo "$out/share/$name/$name" >> $out/bin/$name.sh

mkdir -p $out/share/$name
mv $out/bin/$name $out/share/$name
cp -r assets $out/share/$name

chmod a+x $out/bin/$name.sh
env >> $out/environment
