function wgup
 sudo wg-quick down wg1 2>/dev/null; sudo wg-quick up wg0 $argv; 
end
