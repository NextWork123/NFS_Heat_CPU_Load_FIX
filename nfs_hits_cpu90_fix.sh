#!/bin/bash
# Fix 90% load for NEED FOR SPEED HEAT (Linux bash version)
# Original by Octanium

CPU_Cores=$(nproc --all) 
CPU_Threads=$CPU_Cores     
UserCFGFileCDDir="$(dirname "$(realpath "$0")")/"
UserCFGFileName="user.cfg"
UserCFGFile="${UserCFGFileCDDir}${UserCFGFileName}"

echo
echo "   Fix 90% CPU load!"
echo "   For game NEED FOR SPEED HEAT"
echo "   by Octanium"
echo
echo "  ==== Your CPU ===="
echo "   CPU cores  : $(lscpu | awk '/^Core\(s\) per socket:/ {print $4}')"
echo "   CPU threads: $CPU_Threads"
echo "  =================="

if [[ -f "$UserCFGFile" ]]; then
    if [[ -f "${UserCFGFileCDDir}${UserCFGFileName}.bak" ]]; then
        rm -f "$UserCFGFile"
    else
        mv "$UserCFGFile" "${UserCFGFileCDDir}${UserCFGFileName}.bak"
    fi
fi

echo "Thread.ProcessorCount $CPU_Cores" > "$UserCFGFile"

echo
echo "Done! Created $UserCFGFile"
