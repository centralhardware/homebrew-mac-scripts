function wgdown
 sudo wg-quick down wg0 2>/dev/null; sudo wg-quick up wg1 $argv; 
end
