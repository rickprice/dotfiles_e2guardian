.Include</etc/e2guardian/common.story>
.Include</etc/e2guardian/site.story>

# Add any altered functions for this filtergroup here
# They will overwrite library or site level definitions

# To allow unfiltered access to this group 
# uncomment next 4 lines
#function(checkrequest)
#if(true) return setexception
#function(thttps-checkrequest)
#if(true) return setexception

# To block all access to this group 
# uncomment next 4 lines
#function(checkrequest)
#if(true,,105) return setblock
#function(sslexceptioncheck)
#function(localsslcheckrequest)

# Note: Blanket blocks are checked after exceptions
# and can be used to make a 'walled garden' filtergroup

# To create blanket block for http 
# uncomment next line and one condition line.
#function(checkblanketblock)
#if(true,,502) return setblock  # = ** total blanket
#if(siteisip,,505) return setblock  # = *ip ip blanket

# To create blanket block for SSL 
# uncomment next line and one condition line.
#function(sslcheckblanketblock)
#if(true,,506) return setblock  # = **s total blanket
#if(siteisip,,507) return setblock  # = **ips ip blanket

# To limit MITM to sslgreylist
# replaces onlymitmsslgrey e2guardianf1.conf option
# uncomment the next 2 lines
#function(sslcheckmitm)
#if(true) return sslcheckmitmgreyonly


# SNI checking - overrides default action when no SNI or TSL is present on a 
#    THTTPS connection
# To allow (tunnell) non-tls and/or non-sni connections uncomment the next 3 lines
#function(checksni)
#ifnot(tls,,511) return setexception  # change to setblock to block only non-tls
#ifnot(hassniset,,512) return setexception
