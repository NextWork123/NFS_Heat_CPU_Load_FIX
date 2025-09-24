#!/bin/bash
# Fix 90% load for NEED FOR SPEED HEAT (Linux bash version)
# Original idea by Octanium

CPU_Cores=$(lscpu | awk '/^Core\(s\) per socket:/ {print $4}')
Sockets=$(lscpu | awk '/^Socket\(s\):/ {print $2}')
CPU_Cores=$((CPU_Cores * Sockets))  
CPU_Threads=$(nproc --all)        

UserCFGFileCDDir="$(dirname "$(realpath "$0")")/"
UserCFGFileName="user.cfg"
UserCFGFile="${UserCFGFileCDDir}${UserCFGFileName}"

echo
echo "   Fix 90% CPU load!"
echo "   For game NEED FOR SPEED HEAT"
echo "   by Octanium"
echo
echo "  ==== Your CPU ===="
echo "   CPU cores  : $CPU_Cores"
echo "   CPU threads: $CPU_Threads"
echo "  =================="

if [[ -f "$UserCFGFile" ]]; then
    if [[ -f "${UserCFGFileCDDir}${UserCFGFileName}.bak" ]]; then
        rm -f "$UserCFGFile"
    else
        mv "$UserCFGFile" "${UserCFGFileCDDir}${UserCFGFileName}.bak"
    fi
fi

{
    echo "Thread.ProcessorCount $CPU_Cores"
    echo "Thread.MaxProcessorCount $CPU_Cores"
    echo "Thread.MinFreeProcessorCount 0"
    echo "Thread.JobThreadPriority 0"
    echo "GstRender.Thread.MaxProcessorCount $CPU_Threads"
} > "$UserCFGFile"

if [[ -f "$UserCFGFile" ]]; then
    echo
    echo "  ============================="
    echo "   File user.cfg created!"
    echo "  ============================="
    echo
else
    echo
    echo "  ============================="
    echo "   File user.cfg NOT created!"
    echo "  ============================="
    echo
fi
