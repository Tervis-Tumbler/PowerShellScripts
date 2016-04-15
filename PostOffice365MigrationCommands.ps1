Get-cloudMailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -eq "UserMailbox"} | Set-cloudMailbox -AuditOwner MailboxLogin,HardDelete -AuditDelegate HardDelete,SendAs -AuditEnabled $true
$noArchiveUser = Get-remoteMailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -eq "remoteUserMailbox"} | where {$_.archivestatus -ne "Active"}
foreach($user in $noArchiveUser){
     [string]$name = $user.name
     Enable-remoteMailbox $name -Archive
}

$mailboxes = get-remotemailbox | where {$_.RecipientTypeDetails -eq 'RemoteUserMailbox'} | select -expandproperty alias
$search = Get-cloudmailboxsearch "In-Place Hold"
$search.sourcemailboxes += $mailboxes
Set-cloudmailboxsearch "In-Place Hold" -Sourcemailboxes $search.sourcemailboxes

Get-CloudMailbox | Set-CloudClutter -Enable $false
