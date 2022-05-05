#Nicholas Lueth
#Powershell Final Project

#Main Menu Function
function mainMenu {
    clear
    write-Host "1. System Admin Tasks."
    write-Host "2. Security Admin Tasks."
    write-Host "[E]xit"

    $u_select = read-host -prompt "Please select one of the option above"

    if ($u_select -eq 1) {
        sysAdmin

    } elseif ($u_select -eq 2) {
        secAdmin

    } elseif ($u_select -eq "E") {
        exit

    } else {
        write-Host -backgroundcolor red -foregroundcolor white "Invalid Value"
        sleep 5
        mainMenu
    }
}

#Function to prompt the user when they are done reading the information
function allDone {

    read-Host -prompt "Press [Enter] when done."
}

#Lists all running processes and the user can save the data to a file if they want to
function task1 {
    $csv = read-host -prompt "Would you like to save results to a csv?(Y/N)"
        if ($csv -eq "Y"){
            $path = read-host -prompt "Enter save path(ex. C:\Users\MyUser\Desktop\)"
            $name = read-host -prompt "Enter file name(ex. processes.csv)"
            $process = read-host -prompt "Would you like to search for a specific process? (Y/N)"
            if ($process -eq "Y"){
                $whichProcess = read-host -prompt "Which process?"
                Get-Process $whichProcess | Export-Csv -NoTypeInformation -Path $path\$name
                $there = Test-Path $path\$name
                if ($there -eq "True"){
                    Write-Host "The file has been saved to $path\$name"
                }else{
                    Write-Host "There has been an error saving the file"
                }
            }elseif ($process -eq "N"){
                Get-Process | Export-Csv -NoTypeInformation -Path $path\$name
                $there = Test-Path $path\$name
                if ($there -eq "True"){
                    Write-Host "The file has been saved to $path\$name"
                }else{
                    Write-Host "There has been an error saving the file"
                }
            }else{
                break
            }
        }elseif ($csv -eq "N"){
            $process = read-host -prompt "Would you like to search for a specific process? (Y/N)"
            if ($process -eq "Y"){
                $whichProcess = read-host -prompt "Which process?"
                Get-Process $whichProcess | out-host
            }elseif ($process -eq "N"){
                Get-Process | out-host
            }else{
                break
            }
        }else{
            break
        }

}

#Lists all running services and the user can save to a CVE if they want
function task2 {
    $csv = read-host -prompt "Would you like to save results to a csv?(Y/N)"
        if ($csv -eq "Y"){
            $path = read-host -prompt "Enter save path(ex. C:\users\User\Desktop)"
            $name = read-host -prompt "Enter file name(ex. services.csv)"
            $service = read-host -prompt "Would you like to search for a specific Service? (Y/N)"
            if ($service -eq "Y"){
                $whichService = read-host -prompt "Which Service?"
                Get-Service $whichService | where {$_.Status -eq "Running"} | Export-Csv -NoTypeInformation -Path $path\$name
                $there = Test-Path $path\$name
                if ($there -eq "True"){
                    Write-Host "The file has been saved to $path\$name"
                }else{
                    Write-Host "There has been an error saving the file"
                }
            }elseif ($service -eq "N"){
                Get-Service | where {$_.Status -eq "Running"} | Export-Csv -NoTypeInformation -Path $path\$name
                $there = Test-Path $path\$name
                if ($there -eq "True"){
                    Write-Host "The file has been saved to $path\$name"
                }else{
                    Write-Host "There has been an error saving the file"
                }
            }else{
                break
            }
        }elseif ($csv -eq "N"){
            $service = read-host -prompt "Would you like to search for a specific service? (Y/N)"
            if ($service -eq "Y"){
                $whichService = read-host -prompt "Which service?"
                Get-Service $whichService | where {$_.Status -eq "Running"} | out-host
            }elseif ($service -eq "N"){
                Get-Service | where {$_.Status -eq "Running"}
            }else{
                break
            }
        }else{
            break
        }
}

#Lists installed packages and the user can save to a CVE file if they want to
function task3 {
    $csv = read-host -prompt "Would you like to save results to a csv?(Y/N)"
        if ($csv -eq "Y"){
            $path = read-host -prompt "Enter save path(ex. C:\users\User\Desktop)"
            $name = read-host -prompt "Enter file name(ex. services.csv)"
            $package = read-host -prompt "Would you like to search for a specific Package? (Y/N)"
            if ($package -eq "Y"){
                $whichPackage = read-host -prompt "Which Package?"
                Get-Package | where {$_.Name -ilike "*$whichPackage*"} | Select Name, Version, InstallDate | Export-Csv -NoTypeInformation -Path $path\$name
                $there = Test-Path $path\$name
                if ($there -eq "True"){
                    Write-Host "The file has been saved to $path\$name"
                }else{
                    Write-Host "There has been an error saving the file"
                }
            }elseif ($package -eq "N"){
                Get-Package | Select Name, Version, InstallDate | Export-Csv -NoTypeInformation -Path $path\$name
                $there = Test-Path $path\$name
                if ($there -eq "True"){
                    Write-Host "The file has been saved to $path\$name"
                }else{
                    Write-Host "There has been an error saving the file"
                }
            }else{
                break
            }
        }elseif ($csv -eq "N"){
            $package = read-host -prompt "Would you like to search for a specific package? (Y/N)"
            if ($package -eq "Y"){
                $whichPackage = read-host -prompt "Which service?"
                Get-Package | where {$_.Name -ilike "*$whichPackage*"} | Select Name, Version, InstallDate | out-host
            }elseif ($package -eq "N"){
                Get-Package | Select Name, Version, InstallDate
            }else{
                break
            }
        }else{
            break
        }

}

#Lists the processor, RAM, and disk information and the user can save to a CSV file
function task4 {
    $processor = Get-WmiObject Win32_Processor
        $ram = [math]::Round((Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory/1GB)
        $disks = Get-PhysicalDisk
        $diskSpaceAvailable = [math]::Round((get-wmiobject -class win32_logicaldisk -Filter "DeviceID = 'C:'").FreeSpace/1GB)

        $csv = read-host -prompt "Would you like to save results to a csv?(Y/N)"
        if ($csv -eq "Y"){
            $path = read-host -prompt "Enter save path(ex. C:\users\User\Desktop)"
            $name = read-host -prompt "Enter file name(ex. services.csv)"
            
            $processor, $ram, $disks, $diskSpaceAvailable | Export-Csv -NoTypeInformation -Path $path\$name
            $there = Test-Path $path\$name
            if ($there -eq "True"){
                Write-Host "The file has been saved to $path\$name"
            }else{
                Write-Host "There has been an error saving the file"
            }
        }elseif ($csv -eq "N"){
            Get-WmiObject Win32_Processor
            Write-Host "Ram:"
            [math]::Round((Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory/1GB)
            Get-PhysicalDisk
            Write-Host "Free Disk Space:"
            [math]::Round((get-wmiobject -class win32_logicaldisk -Filter "DeviceID = 'C:'").FreeSpace/1GB)

        }else{
            break
        }
}

#Lists Windows Event Logs and the user can save to a CVE if they want
function task5 {
    Get-EventLog -list
        $logSearch = read-host -prompt "What event log would you like to search?"
        $amount = read-host -prompt "How many events would you like to display?"
        $keyWord = read-host -Prompt "Enter a keyword/timeframe"
        Get-EventLog $logSearch -Newest $amount | where {$_.Message -ilike "*$keyword*"}

        $csv = read-host -prompt "Would you like to save results to a csv?(Y/N)"
        if ($csv -eq "Y"){
            $path = read-host -prompt "Enter save path(ex. C:\users\User\Desktop)"
            $name = read-host -prompt "Enter file name(ex. services.csv)"

            Get-EventLog -list
            $logSearch = read-host -prompt "What event log would you like to search?"
            $amount = read-host -prompt "How many events would you like to display?"
            $keyWord = read-host -Prompt "Enter a keyword/timeframe"
            
            Get-EventLog $logSearch -Newest $amount | where {$_.Message -ilike "*$keyword*"} | Export-Csv -NoTypeInformation -Path $path\$name
            $there = Test-Path $path\$name
            if ($there -eq "True"){
                Write-Host "The file has been saved to $path\$name"
            }else{
                Write-Host "There has been an error saving the file"
            }
        }elseif ($csv -eq "N"){

            Get-EventLog -list
            $logSearch = read-host -prompt "What event log would you like to search?"
            $amount = read-host -prompt "How many events would you like to display?"
            $keyWord = read-host -Prompt "Enter a keyword/timeframe"
            Get-EventLog $logSearch -Newest $amount | where {$_.Message -ilike "*$keyword*"}

        }else{
            break
        }


}

#Function to email information
function email{
    $subject = Read-Host -Prompt "Enter a subject:"
    $message = Read-Host -Prompt "Enter a message:"
    $who = Read-Host -prompt "Enter your e-mail:"
    $toWho = Read-Host -Prompt "Enter the e-mail of the person you want to send this to:"
    $msg = "CVE NAME: $entryName", "CVE DESC: $entryDesc", "CVE STAT: $entryStatus"

    Send-MailMessage -from $who -to $toWho -Subject $subject -body $message, " ", $msg
        
}

#Asks to download or load file for use. Searches CVE file for name of file or description keyword
function task6 {
    $download = read-host -prompt "Would you like to download the allitems.csv file?(Y/N)"
        if ($download -eq "Y"){
            Invoke-WebRequest -URI https://cve.mitre.org/data/downloads/allitems.csv -OutFile C:\Users\MyUser\Desktop\allitems.csv
            Write-Host "The csv file has been downloaded to C:\Users\MyUser\Desktop\allitems.csv"

        }elseif ($download -eq "N"){
            $cveFile = import-csv ex. C:\users\User\Desktop\allitems.csv
            $nameDesc = Read-Host -Prompt "Would you like to search by CVE name or description?(N/D)"
            if ($nameDesc = "N"){
                $name = Read-Host -Prompt "Enter the name of the file. (Ex. CVE-1999-0001)"
           
                #Searches through the CVE file    
                foreach ($cveEntry in $cveFile) {
            
                    #If the entry is found "found" will get printed and the data will be printed    
                    if ($cveEntry.Name -eq "$name") {
                        Write-Host "Found!"
                        $entryName = $cveEntry.Name
                        $entryDesc = $cveEntry.Description
                        $entryStatus = $cveEntry.Status

                        write-host "CVE NAME: $entryName"
                        Write-Host "CVE DESC: $entryDesc"
                        Write-Host "CVE STAT: $entryStatus"     
                        $notFound = "false"
                        email
                        break
                    }else{
                    
                        #If not found the script will continue
                        if ($notFound -eq "false") {

                            continue

                        } else {

                            # Set value to "true" if no entry is found.
                            $notFound = "true"
                        }

                    }
                }
            }elseif ($nameDesc = "D"){
                $keyword = Read-Host -Prompt "Enter a keyword"
                foreach ($cveEntry in $cveFile) {
                    if ($cveEntry.Description -ilike "*$keyword*") {
    
                        # Print that the CVE was found.
                        write-host "Found."
                        # Print the results for the CVE.
                        $entryName = $cveEntry.Name
                        $entryDesc = $cveEntry.Description
                        $entryStatus = $cveEntry.Status

                        write-host "CVE NAME: $entryName"
                        Write-Host "CVE DESC: $entryDesc"
                        Write-Host "CVE STAT: $entryStatus"

                        # Set value to false to denote the entry was found.
                        $notFound = "false"
                        email
                    } else {
                        if ($notFound -eq "false") {

                            continue

                        } else {

                            # Set value to "true" if no entry is found.
                            $notFound = "true"
                        }
                    }
                }
            }else{
                Write-Host "Please enter a valid option"
                task6
            }
        }else{
            
            task6
        }
}

#Sysadmin menu
function sysAdmin {
    clear

    write-host "1. List All Running Processes."
    write-host "2. List All Running Services"
    write-host "3. Installed Packages."
    Write-Host "4. Processor, Ram, and Disks"
    Write-Host "5. Windows Event Logs"
    write-host "[R]eturn to Main Menu."
    write-host "[E]xit"

    $sysAdminTask = Read-Host -Prompt "Please select one of the options above"

    if ($sysAdminTask -eq "R") {
        mainMenu

    } elseif ($sysAdminTask -eq 1) {
        task1

    } elseif ($sysAdminTask -eq 2) {
        task2

    } elseif ($sysAdminTask -eq 3) {
        task3

    } elseif ($sysAdminTask -eq 4) {
        task4

    } elseif ($sysAdminTask -eq 5) {
        task5

    } elseif ($sysAdminTask -eq "E") {
        break

    } else {

        write-host -BackgroundColor Red -ForegroundColor White "Invalid Option"
        sleep 4
        sysAdmin

    }
    allDone

    sysAdmin
}

#Secadmin Menu
function secAdmin {
    clear

    write-host "1. List All Running Processes."
    write-host "2. List All Running Services"
    write-host "3. Installed Packages."
    Write-Host "4. Processor, Ram, and Disks"
    Write-Host "5. Windows Event Logs"
    Write-Host "6. Recent Security Vulnerabilities"
    write-host "[R]eturn to Main Menu."
    write-host "[E]xit"

    $secAdminTask = Read-Host -Prompt "Please select one of the options above"

    if ($secAdminTask -eq "R") {
        mainMenu

    } elseif ($secAdminTask -eq 1) {
        task1

    } elseif ($secAdminTask -eq 2) {
        task2

    } elseif ($secAdminTask -eq 3) {
        task3

    } elseif ($secAdminTask -eq 4) {
        task4

    } elseif ($secAdminTask -eq 5) {
        task5

    } elseif ($secAdminTask -eq 6) {
        task6

    } elseif ($secAdminTask -eq "E") {
        break

    } else {

        write-host -BackgroundColor Red -ForegroundColor White "Invalid Option"
        sleep 4
        secAdmin

    }
    allDone

    secAdmin
}

mainMenu
