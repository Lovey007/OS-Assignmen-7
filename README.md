# OS-Assignmen-7: Banker's Algorithm and Deadlock Detection

## Overview
This script implements the **Banker's Algorithm** for deadlock avoidance and a **Deadlock Detection Algorithm** to check for deadlocks in a system. It simulates resource allocation for multiple processes and ensures safe execution.

## Features
- Checks if the system is in a **safe state** using Banker's Algorithm.
- Detects **deadlocks** based on allocated and requested resources.
- Takes user input for **processes, resources, allocation, maximum claims, and availability**.
- Provides clear output indicating whether the system is in a safe state or if a deadlock has occurred.

## Requirements
- A Unix-based system with a shell (Bash).
- Execute permissions for the script.

## Usage
1. **Make the script executable:**
   ```sh
   chmod +x banker-deadlock.sh
   ```
2. **Run the script:**
   ```sh
   ./banker-deadlock.sh
   ```
3. **Provide the following inputs:**
   - Number of processes (P)
   - Number of resources (R)
   - Allocation matrix (Current resource allocation for each process)
   - Maximum resource claim matrix
   - Available resources

4. **Script Output:**
   - If the system is in a safe state, it prints **"System is in a safe state!"**.
   - If a deadlock is possible, it prints **"System is in an unsafe state! Deadlock may occur."**
   - If a deadlock is detected, it identifies the involved processes.

## Example Input & Output
```
Enter number of processes: 3
Enter number of resources: 2
Enter allocation matrix:
Allocation for P0 Resource 0: 1
Allocation for P0 Resource 1: 2
...
Enter max matrix:
Max for P0 Resource 0: 3
Max for P0 Resource 1: 3
...
Enter available resources:
Available for Resource 0: 2
Available for Resource 1: 1

System is in a safe state!
Checking for deadlock...
No deadlock detected.
```

## Notes
- Ensure inputs are valid to prevent incorrect calculations.
- The script assumes integer inputs and does not handle negative or non-numeric values.
  
## Author
- Name: Pranzal Sharma
- SID: 21105048
- Branch: ECE

