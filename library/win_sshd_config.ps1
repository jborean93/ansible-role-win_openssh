#!powershell

# Copyright: (c) 2019, Jordan Borean (@jborean93) <jborean93@gmail.com>
# MIT License (see LICENSE or https://opensource.org/licenses/MIT)

#Requires -Module Ansible.ModuleUtils.Legacy

$params = Parse-Args $args -supports_check_mode $true
$check_mode = Get-AnsibleParam -obj $params -name '_ansible_check_mode' -type 'bool' -default $false

$path = Get-AnsibleParam -obj $params -name "path" -type "str" -failifempty $true
$match_name = Get-AnsibleParam -obj $params -name "match_Name" -type "str" -failifempty $true
$name = Get-AnsibleParam -obj $params -name "name" -type "str" -failifempty $true
$value = Get-AnsibleParam -obj $params -name "value" -type "str"

$result = @{
    changed = $false
}

$found = $false
$in_match = $false
$new_lines = Get-Content -LiteralPath $path | ForEach-Object -Process {
    if ($_ -match "^\s*Match\s+(([\w]+)\s+([\w]+))") {
        if ($Matches[1] -eq $match_name) {
            $in_match = $true
        } elseif ($in_match) {
            # We are exiting the chosen match group, make sure the the name is set if a value is specified.
            if (-not $found -and $value) {
                "        $name $value"
                ""  # Empty line to give some space between the next match.
                $result.changed = $true
                $found = $true
            }
            $in_match = $false
        }
    } elseif ($in_match -and $_ -match "^\s*([\w]+)\s+(.+)") {
        if ($Matches[1] -eq $Name) {
            $found = $true
            if (-not $value) {
                # We want to remove the key
                $result.changed = $true
                return
            } elseif ($Matches[2] -ne $value) {
                # The value is changed
                "        $($Matches[1]) $value"
                $found = $true
                $result.changed = $true
                return
            }
        }
    }

    $_
}

# Finally if the match was the last group we need to match sure the entry was found.
if ($in_match) {
    if (-not $found -and $value) {
        $new_lines += "        $name $value"
        $result.changed = $true
    }
} elseif (-not $found -and $value) {
    # The match group wasn't even present so add that
    $new_lines += @("", "Match $match_name", "        $name $value")
    $result.changed = $true
}

if ($result.changed) {
    Set-Content -LiteralPath $path -Value $new_lines -WhatIf:$check_mode
}

Exit-Json -obj $result
