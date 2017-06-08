function Test-SiteFunctioning {
    $url="http://www.tervis.com"
    $wc = new-object net.webclient
    $html = $wc.DownloadString($url) 
    return $html.contains("Join the conversation!")
}

function Invoke-SiteAlarmCode {
    $ErrCount = 0
    
    While ($True -eq $True) {
        Try {
            $isSiteFunctioning = Test-SiteFunctioning
            
            Write-host "The site is functioning $isSiteFunctioning"
            
            if ( $isSiteFunctioning -eq $False) {
                write-host "Problem with website $ErrCount"
                $ErrCount++
                
                if ($ErrCount -gt 2) {
                    write-host "Site has experienced $ErrCount consecutive errors"
                    (new-object Media.SoundPlayer "C:\tornado.wav").play();
                    start-sleep -s 15
                    $ErrCount = 0                    
                }
                
                start-sleep -s 5                
            }
            else {
                start-sleep -s 5
            }
        }
        catch {
            write-host "exception found"
            $_
            write-host "Problem with website $ErrCount"
            $ErrCount++
            
            if ($ErrCount -gt 2) {
               write-host "Site has experienced $ErrCount consecutive errors"
               (new-object Media.SoundPlayer "C:\tornado.wav").play();
               start-sleep -s 15
               $ErrCount = 0                      
            }
            
            start-sleep -s 5
        }
    }
}