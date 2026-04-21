# https://www.syxsense.com/syxsense-securityarticles/cis_benchmarks_(windows_11)/bl/syx-1039-15210.html?agt=index
# https://www.syxsense.com/syxsense-securityarticles/cis_benchmarks_(windows_11)/bl/syx-1039-15210.html?agt=index
# https://superuser.com/questions/772157/group-policy-error-when-adding-bitlocker-password-using-manage-bde
# maybe: https://www.techhelpfornonprofits.org/2024/12/07/enable-bitlocker-automatically-using-group-policy-object/

# this script works with no variables, for restricted environments...

Get-BitLockerVolume C: | Select-Object -Property * | Select-Object -ExpandProperty KeyProtector | Select-Object -Property *
# so, "Get-BitlockerVolume" just outputs a "KeyProtector" property with a list of "{Tpm, RecoveryPassword}"
# which needs expanded, and then the ID of the TPM needs to be specified, for removal.
# this will just list the ID: $(Get-BitLockerVolume C: | Select-Object -ExpandProperty KeyProtector | Where-Object -property KeyProtectorType -eq "Tpm"  | Select-Object -Property *).KeyProtectorId
# it's way below though...

#Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\FVE" -Name "UsePassphrase"
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\FVE" -Force
# these from copilot/Bing search:
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\FVE" -Name "UsePassphrase" -Value 1 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\FVE" -Name "UsePassphraseForOS" -Value 1 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\FVE" -Name "FDVPassphrase" -Value 1 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\FVE" -Name "RDVPassphrase" -Value 1 -Type DWord
# these from watching after GPO change:
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\FVE" -Name "EnableBDEWithNoTPM" -Value 1 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\FVE" -Name "UseAdvancedStartup" -Value 1 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\FVE" -Name "UseTPM" -Value 2 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\FVE" -Name "UseTPMKey" -Value 2 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\FVE" -Name "UseTPMKeyPIN" -Value 2 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\FVE" -Name "UseTPMPIN" -Value 2 -Type DWord

#Add-BitLockerKeyProtector -MountPoint "C:" -Password $SomeSecureString -PasswordProtector
#$SomeSecureString = ConvertTo-SecureString -String "HereBeDragons" -AsPlainText -Force
Remove-BitlockerKeyProtector -MountPoint "C:" -KeyProtectorId $(Get-BitLockerVolume C: | Select-Object -ExpandProperty KeyProtector | Where-Object -property KeyProtectorType -eq 'Tpm'  | Select-Object -Property *).KeyProtectorId
Add-BitLockerKeyProtector -MountPoint "C:" -Password $(ConvertTo-SecureString -String "HereBeDragons" -AsPlainText -Force) -PasswordProtector
















