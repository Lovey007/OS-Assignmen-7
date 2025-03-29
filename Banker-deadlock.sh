#!/bin/bash

# Function to check if the system is in a safe state using Banker's Algorithm
is_safe() {
    local work=(${available[@]})
    local finish=()
    for ((i = 0; i < P; i++)); do
        finish[i]=0
    done

    local count=0
    while [ $count -lt $P ]; do
        local found=false
        for ((i = 0; i < P; i++)); do
            if [ ${finish[i]} -eq 0 ]; then
                local j
                for ((j = 0; j < R; j++)); do
                    if [ ${need[i * R + j]} -gt ${work[j]} ]; then
                        break
                    fi
                done
                if [ $j -eq $R ]; then
                    for ((k = 0; k < R; k++)); do
                        work[k]=$((work[k] + allocation[i * R + k]))
                    done
                    finish[i]=1
                    ((count++))
                    found=true
                fi
            fi
        done
        if [ "$found" = false ]; then
            echo "System is in an unsafe state! Deadlock may occur."
            return 1
        fi
    done
    echo "System is in a safe state!"
    return 0
}

# Function to detect deadlock using resource allocation graph
detect_deadlock() {
    local work=(${available[@]})
    local finish=()
    for ((i = 0; i < P; i++)); do
        finish[i]=0
    done

    for ((i = 0; i < P; i++)); do
        local allocated=false
        for ((j = 0; j < R; j++)); do
            if [ ${allocation[i * R + j]} -ne 0 ]; then
                allocated=true
                break
            fi
        done
        if [ "$allocated" = false ]; then
            finish[i]=1
        fi
    done

    local changed=true
    while [ "$changed" = true ]; do
        changed=false
        for ((i = 0; i < P; i++)); do
            if [ ${finish[i]} -eq 0 ]; then
                local canFinish=true
                for ((j = 0; j < R; j++)); do
                    if [ ${request[i * R + j]} -gt ${work[j]} ]; then
                        canFinish=false
                        break
                    fi
                done
                if [ "$canFinish" = true ]; then
                    for ((j = 0; j < R; j++)); do
                        work[j]=$((work[j] + allocation[i * R + j]))
                    done
                    finish[i]=1
                    changed=true
                fi
            fi
        done
    done

    for ((i = 0; i < P; i++)); do
        if [ ${finish[i]} -eq 0 ]; then
            echo "Deadlock detected involving process P$i"
            return 1
        fi
    done
    echo "No deadlock detected."
    return 0
}

# Read input
while true; do
    read -p "Enter number of processes: " P
    if [[ $P =~ ^[0-9]+$ && $P -gt 0 ]]; then
        break
    else
        echo "Invalid input. Please enter a positive integer."
    fi
done

while true; do
    read -p "Enter number of resources: " R
    if [[ $R =~ ^[0-9]+$ && $R -gt 0 ]]; then
        break
    else
        echo "Invalid input. Please enter a positive integer."
    fi
done

allocation=()
max=()
available=()
need=()
request=()

echo "Enter allocation matrix:"
for ((i = 0; i < P; i++)); do
    for ((j = 0; j < R; j++)); do
        read -p "Allocation for P$i Resource $j: " allocation[i * R + j]
    done
done

echo "Enter max matrix:"
for ((i = 0; i < P; i++)); do
    for ((j = 0; j < R; j++)); do
        read -p "Max for P$i Resource $j: " max[i * R + j]
    done
    for ((j = 0; j < R; j++)); do
        need[i * R + j]=$((max[i * R + j] - allocation[i * R + j]))
    done
done

echo "Enter available resources:"
for ((j = 0; j < R; j++)); do
    read -p "Available for Resource $j: " available[j]
done

is_safe

echo "Checking for deadlock..."
detect_deadlock
