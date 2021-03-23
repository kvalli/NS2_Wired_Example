#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Open the NS trace file
set tracefile [open out.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile

#===================================
#        Nodes Definition        
#===================================
#Create 61 nodes

set totalnodes 61
set localcc 12
set roomnodes 4

#Create 12 Local coordinators for 12 houses
for {set j 0} {$j <= $localcc} {incr j} {
set n($j) [$ns node]
if { $j == 0 } {
$n($j) color magenta 
$n($j) label "CC"
} else {
$n($j) color blue 
$n($j) label "LC"
}
} 


#===================================
#        Links Definition        
#===================================

#Createlinks between link nodes and central coordinator

for {set j 1} {$j <= $localcc} {incr j} {
$ns duplex-link $n($j) $n(0) 10.0Mb 10ms SFQ PINK
$ns queue-limit $n($j) $n(0) 50
set null($j) [new Agent/Null]
$ns attach-agent $n($j) $null($j)
} 
#$ns duplex-link-op $n(0) $cc orient 24deg
$ns duplex-link-op $n(1) $n(0) orient 30deg
$ns duplex-link-op $n(2) $n(0) orient 60deg
$ns duplex-link-op $n(3) $n(0) orient 90deg
$ns duplex-link-op $n(4) $n(0) orient 120deg
$ns duplex-link-op $n(5) $n(0) orient 150deg
$ns duplex-link-op $n(6) $n(0) orient 180deg
$ns duplex-link-op $n(7) $n(0) orient 210deg
$ns duplex-link-op $n(8) $n(0) orient 240deg
$ns duplex-link-op $n(9) $n(0) orient 270deg
$ns duplex-link-op $n(10) $n(0) orient 300deg
$ns duplex-link-op $n(11) $n(0) orient 330deg
$ns duplex-link-op $n(12) $n(0) orient 360deg

#Attach null agent to central coordinator
set null0 [new Agent/Null]
$ns attach-agent $n(0) $null0

#===================================
#        Applications Definition        
#===================================

#Create from nodel duplex links to 4 other nodes
set k 1
for {set j 1} {$j <= 4} {incr j} {
set sn($k$j) [$ns node]
$sn($k$j) color gold 
$ns duplex-link $sn($k$j) $n($k)  1.0Mb 10ms SFQ 
$ns queue-limit $sn($k$j) $n($k)  50
if { $j == 1 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 0deg  
$ns duplex-link-op $sn($k$j) $n($k)  color red
} elseif { $j == 2 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 20deg
$ns duplex-link-op $sn($k$j) $n($k)  color red
} elseif { $j == 3 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient  40deg
$ns duplex-link-op $sn($k$j) $n($k)  color red
} else { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 60deg
$ns duplex-link-op $sn($k$j) $n($k)  color red
}

set udp($k$j) [new Agent/UDP]
$udp($k$j) set class_ kj # fid in trace file
$ns attach-agent $sn($k$j) $udp($k$j)

# Create a CBR traffic source and attach it to udp1
set cbr($k$j) [new Application/Traffic/CBR]
$cbr($k$j) set packetSize_ 500
$cbr($k$j) set interval_ 0.005
$cbr($k$j) attach-agent $udp($k$j)

$ns connect $udp($k$j) $null($j)
$ns at 0.5 "$cbr($k$j) start"
$ns at 1.5 "$cbr($k$j) stop"

}

set k 2
for {set j 1} {$j <= 4} {incr j} {
set sn($k$j) [$ns node]
$sn($k$j) color blue 
$ns duplex-link $sn($k$j) $n($k)  1.0Mb 10ms SFQ 
$ns queue-limit $sn($k$j) $n($k)  50
if { $j == 1 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 50deg  
$ns duplex-link-op $sn($k$j) $n($k)  color pink
} elseif { $j == 2 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 70deg
$ns duplex-link-op $sn($k$j) $n($k)  color pink
} elseif { $j == 3 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient  90deg
$ns duplex-link-op $sn($k$j) $n($k)  color pink
} else { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 110deg
$ns duplex-link-op $sn($k$j) $n($k)  color pink
}


set udp($k$j) [new Agent/UDP]
$udp($k$j) set class_ kj # fid in trace file
$ns attach-agent $sn($k$j) $udp($k$j)


# Create a CBR traffic source and attach it to udp1
set cbr($k$j) [new Application/Traffic/CBR]
$cbr($k$j) set packetSize_ 500
$cbr($k$j) set interval_ 0.005
$cbr($k$j) attach-agent $udp($k$j)

$ns connect $udp($k$j) $null($j)
$ns at 0.5 "$cbr($k$j) start"
$ns at 1.5 "$cbr($k$j) stop"

}

set k 3
for {set j 1} {$j <= 4} {incr j} {
set sn($k$j) [$ns node]
$sn($k$j) color red 
$ns duplex-link $sn($k$j) $n($k)  1.0Mb 10ms SFQ 
$ns queue-limit $sn($k$j) $n($k)  50
if { $j == 1 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 90deg  
$ns duplex-link-op $sn($k$j) $n($k)  color blue
} elseif { $j == 2 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 110deg
$ns duplex-link-op $sn($k$j) $n($k)  color blue
} elseif { $j == 3 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient  130deg
$ns duplex-link-op $sn($k$j) $n($k)  color blue
} else { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 150deg
$ns duplex-link-op $sn($k$j) $n($k)  color blue
}

set udp($k$j) [new Agent/UDP]
$udp($k$j) set class_ kj # fid in trace file
$ns attach-agent $sn($k$j) $udp($k$j)

# Create a CBR traffic source and attach it to udp1
set cbr($k$j) [new Application/Traffic/CBR]
$cbr($k$j) set packetSize_ 500
$cbr($k$j) set interval_ 0.005
$cbr($k$j) attach-agent $udp($k$j)

$ns connect $udp($k$j) $null($j)
$ns at 0.5 "$cbr($k$j) start"
$ns at 1.5 "$cbr($k$j) stop"

}

set k 4
for {set j 1} {$j <= 4} {incr j} {
set sn($k$j) [$ns node]
$sn($k$j) color magenta 
$ns duplex-link $sn($k$j) $n($k)  1.0Mb 10ms SFQ 
$ns queue-limit $sn($k$j) $n($k)  50
if { $j == 1 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 140deg  
$ns duplex-link-op $sn($k$j) $n($k)  color green
} elseif { $j == 2 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 160deg
$ns duplex-link-op $sn($k$j) $n($k)  color green
} elseif { $j == 3 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient  180deg
$ns duplex-link-op $sn($k$j) $n($k)  color green
} else { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 200deg
$ns duplex-link-op $sn($k$j) $n($k)  color green
}

set udp($k$j) [new Agent/UDP]
$udp($k$j) set class_ kj # fid in trace file
$ns attach-agent $sn($k$j) $udp($k$j)

# Create a CBR traffic source and attach it to udp1
set cbr($k$j) [new Application/Traffic/CBR]
$cbr($k$j) set packetSize_ 500
$cbr($k$j) set interval_ 0.005
$cbr($k$j) attach-agent $udp($k$j)

$ns connect $udp($k$j) $null($j)
$ns at 0.5 "$cbr($k$j) start"
$ns at 1.5 "$cbr($k$j) stop"

}

set k 5
for {set j 1} {$j <= 4} {incr j} {
set sn($k$j) [$ns node]
$sn($k$j) color tan 
$ns duplex-link $sn($k$j) $n($k)  1.0Mb 10ms SFQ 
$ns queue-limit $sn($k$j) $n($k)  50
if { $j == 1 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 170deg  
$ns duplex-link-op $sn($k$j) $n($k)  color brown
} elseif { $j == 2 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 190deg
$ns duplex-link-op $sn($k$j) $n($k)  color brown
} elseif { $j == 3 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient  210deg
$ns duplex-link-op $sn($k$j) $n($k)  color brown
} else { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 230deg
$ns duplex-link-op $sn($k$j) $n($k)  color brown
}

set udp($k$j) [new Agent/UDP]
$udp($k$j) set class_ kj # fid in trace file
$ns attach-agent $sn($k$j) $udp($k$j)

# Create a CBR traffic source and attach it to udp1
set cbr($k$j) [new Application/Traffic/CBR]
$cbr($k$j) set packetSize_ 500
$cbr($k$j) set interval_ 0.005
$cbr($k$j) attach-agent $udp($k$j)

$ns connect $udp($k$j) $null($j)
$ns at 0.5 "$cbr($k$j) start"
$ns at 1.5 "$cbr($k$j) stop"

}

set k 6
for {set j 1} {$j <= 4} {incr j} {
set sn($k$j) [$ns node]
$sn($k$j) color blue 
$ns duplex-link $sn($k$j) $n($k)  1.0Mb 10ms SFQ 
$ns queue-limit $sn($k$j) $n($k)  50
if { $j == 1 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 190deg  
$ns duplex-link-op $sn($k$j) $n($k)  color chocolate
} elseif { $j == 2 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 210deg
$ns duplex-link-op $sn($k$j) $n($k)  color chocolate
} elseif { $j == 3 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient  230deg
$ns duplex-link-op $sn($k$j) $n($k)  color chocolate
} else { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 250deg
$ns duplex-link-op $sn($k$j) $n($k)  color chocolate
}

set udp($k$j) [new Agent/UDP]
$udp($k$j) set class_ kj # fid in trace file
$ns attach-agent $sn($k$j) $udp($k$j)

# Create a CBR traffic source and attach it to udp1
set cbr($k$j) [new Application/Traffic/CBR]
$cbr($k$j) set packetSize_ 500
$cbr($k$j) set interval_ 0.005
$cbr($k$j) attach-agent $udp($k$j)

$ns connect $udp($k$j) $null($j)
$ns at 0.5 "$cbr($k$j) start"
$ns at 1.5 "$cbr($k$j) stop"

}

set k 7
for {set j 1} {$j <= 4} {incr j} {
set sn($k$j) [$ns node]
$sn($k$j) color red 
$ns duplex-link $sn($k$j) $n($k)  1.0Mb 10ms SFQ 
$ns queue-limit $sn($k$j) $n($k)  50
if { $j == 1 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 220deg  
$ns duplex-link-op $sn($k$j) $n($k)  color cyan
} elseif { $j == 2 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 240deg
$ns duplex-link-op $sn($k$j) $n($k)  color cyan
} elseif { $j == 3 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient  260deg
$ns duplex-link-op $sn($k$j) $n($k)  color cyan
} else { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 280deg
$ns duplex-link-op $sn($k$j) $n($k)  color cyan
}

set udp($k$j) [new Agent/UDP]
$udp($k$j) set class_ kj # fid in trace file
$ns attach-agent $sn($k$j) $udp($k$j)

# Create a CBR traffic source and attach it to udp1
set cbr($k$j) [new Application/Traffic/CBR]
$cbr($k$j) set packetSize_ 500
$cbr($k$j) set interval_ 0.005
$cbr($k$j) attach-agent $udp($k$j)

$ns connect $udp($k$j) $null($j)
$ns at 0.5 "$cbr($k$j) start"
$ns at 1.5 "$cbr($k$j) stop"

}

set k 8
for {set j 1} {$j <= 4} {incr j} {
set sn($k$j) [$ns node]
$sn($k$j) color green 
$ns duplex-link $sn($k$j) $n($k)  1.0Mb 10ms SFQ 
$ns queue-limit $sn($k$j) $n($k)  50
if { $j == 1 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 220deg  
$ns duplex-link-op $sn($k$j) $n($k)  color yellow
} elseif { $j == 2 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 240deg
$ns duplex-link-op $sn($k$j) $n($k)  color yellow
} elseif { $j == 3 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient  260deg
$ns duplex-link-op $sn($k$j) $n($k)  color yellow
} else { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 280deg
$ns duplex-link-op $sn($k$j) $n($k)  color yellow
}

set udp($k$j) [new Agent/UDP]
$udp($k$j) set class_ kj # fid in trace file
$ns attach-agent $sn($k$j) $udp($k$j)

# Create a CBR traffic source and attach it to udp1
set cbr($k$j) [new Application/Traffic/CBR]
$cbr($k$j) set packetSize_ 500
$cbr($k$j) set interval_ 0.005
$cbr($k$j) attach-agent $udp($k$j)

$ns connect $udp($k$j) $null($j)
$ns at 0.5 "$cbr($k$j) start"
$ns at 1.5 "$cbr($k$j) stop"

}

set k 9
for {set j 1} {$j <= 4} {incr j} {
set sn($k$j) [$ns node]
$sn($k$j) color magenta 
$ns duplex-link $sn($k$j) $n($k)  1.0Mb 10ms SFQ 
$ns queue-limit $sn($k$j) $n($k)  50
if { $j == 1 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 270deg  
$ns duplex-link-op $sn($k$j) $n($k)  color black
} elseif { $j == 2 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 290deg
$ns duplex-link-op $sn($k$j) $n($k)  color black
} elseif { $j == 3 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient  310deg
$ns duplex-link-op $sn($k$j) $n($k)  color black
} else { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 330deg
$ns duplex-link-op $sn($k$j) $n($k)  color black
}

set udp($k$j) [new Agent/UDP]
$udp($k$j) set class_ kj # fid in trace file
$ns attach-agent $sn($k$j) $udp($k$j)

# Create a CBR traffic source and attach it to udp1
set cbr($k$j) [new Application/Traffic/CBR]
$cbr($k$j) set packetSize_ 500
$cbr($k$j) set interval_ 0.005
$cbr($k$j) attach-agent $udp($k$j)

$ns connect $udp($k$j) $null($j)
$ns at 0.5 "$cbr($k$j) start"
$ns at 1.5 "$cbr($k$j) stop"

}

set k 10
for {set j 1} {$j <= 4} {incr j} {
set sn($k$j) [$ns node]
$sn($k$j) color gold 
$ns duplex-link $sn($k$j) $n($k)  1.0Mb 10ms SFQ 
$ns queue-limit $sn($k$j) $n($k)  50
if { $j == 1 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 300deg  
$ns duplex-link-op $sn($k$j) $n($k)  color brown
} elseif { $j == 2 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 320deg
$ns duplex-link-op $sn($k$j) $n($k)  color brown
} elseif { $j == 3 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient  340deg
$ns duplex-link-op $sn($k$j) $n($k)  color brown
} else { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 360deg
$ns duplex-link-op $sn($k$j) $n($k)  color brown
}

set udp($k$j) [new Agent/UDP]
$udp($k$j) set class_ kj # fid in trace file
$ns attach-agent $sn($k$j) $udp($k$j)

# Create a CBR traffic source and attach it to udp1
set cbr($k$j) [new Application/Traffic/CBR]
$cbr($k$j) set packetSize_ 500
$cbr($k$j) set interval_ 0.005
$cbr($k$j) attach-agent $udp($k$j)

$ns connect $udp($k$j) $null($j)
$ns at 0.5 "$cbr($k$j) start"
$ns at 1.5 "$cbr($k$j) stop"

}

set k 11
for {set j 1} {$j <= 4} {incr j} {
set sn($k$j) [$ns node]
$sn($k$j) color red 
$ns duplex-link $sn($k$j) $n($k)  1.0Mb 10ms SFQ 
$ns queue-limit $sn($k$j) $n($k)  50
if { $j == 1 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 320deg  
$ns duplex-link-op $sn($k$j) $n($k)  color blue
} elseif { $j == 2 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 340deg
$ns duplex-link-op $sn($k$j) $n($k)  color blue
} elseif { $j == 3 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient  360deg
$ns duplex-link-op $sn($k$j) $n($k)  color blue
} else { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 20deg
$ns duplex-link-op $sn($k$j) $n($k)  color blue
}

set udp($k$j) [new Agent/UDP]
$udp($k$j) set class_ kj # fid in trace file
$ns attach-agent $sn($k$j) $udp($k$j)

# Create a CBR traffic source and attach it to udp1
set cbr($k$j) [new Application/Traffic/CBR]
$cbr($k$j) set packetSize_ 500
$cbr($k$j) set interval_ 0.005
$cbr($k$j) attach-agent $udp($k$j)

$ns connect $udp($k$j) $null($j)
$ns at 0.5 "$cbr($k$j) start"
$ns at 1.5 "$cbr($k$j) stop"

}

set k 12
for {set j 1} {$j <= 4} {incr j} {
set sn($k$j) [$ns node]
$sn($k$j) color green 
$ns duplex-link $sn($k$j) $n($k)  1.0Mb 10ms SFQ 
$ns queue-limit $sn($k$j) $n($k)  50
if { $j == 1 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 320deg  
$ns duplex-link-op $sn($k$j) $n($k)  color magenta
} elseif { $j == 2 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 340deg
$ns duplex-link-op $sn($k$j) $n($k)  color magenta
} elseif { $j == 3 } { 
$ns duplex-link-op $sn($k$j) $n($k)  orient  360deg
$ns duplex-link-op $sn($k$j) $n($k)  color magenta
} else { 
$ns duplex-link-op $sn($k$j) $n($k)  orient 20deg
$ns duplex-link-op $sn($k$j) $n($k)  color magenta
}

set udp($k$j) [new Agent/UDP]
$udp($k$j) set class_ kj # fid in trace file
$ns attach-agent $sn($k$j) $udp($k$j)

# Create a CBR traffic source and attach it to udp1
set cbr($k$j) [new Application/Traffic/CBR]
$cbr($k$j) set packetSize_ 500
$cbr($k$j) set interval_ 0.005
$cbr($k$j) attach-agent $udp($k$j)

$ns connect $udp($k$j) $null($j)
$ns at 0.5 "$cbr($k$j) start"
$ns at 1.5 "$cbr($k$j) stop"

}

#Create traffic simulation from lc to cc

for {set j 1} {$j <= $localcc} {incr j} {
set udp($j) [new Agent/UDP]
$udp($j) set class_ j # fid in trace file
$ns attach-agent $n($j) $udp($j)

# Create a CBR traffic source and attach it to udp1
set cbr($j) [new Application/Traffic/CBR]
$cbr($j) set packetSize_ 500
$cbr($j) set interval_ 0.005
$cbr($j) attach-agent $udp($j)

$ns connect $udp($j) $null0
$ns at 1.8 "$cbr($j) start"
$ns at 3.0 "$cbr($j) stop"

}

#Create traffic source from  cc to lc

for {set j 1} {$j <= $localcc} {incr j} {
set udp($j$j) [new Agent/UDP]
$udp($j$j) set class_ jj # fid in trace file
$ns attach-agent $n(0) $udp($j$j)

# Create a CBR traffic source and attach it to udp1
set cbr($j$j) [new Application/Traffic/CBR]
$cbr($j$j) set packetSize_ 500
$cbr($j$j) set interval_ 0.005
$cbr($j$j) attach-agent $udp($j$j)

set null($j$j) [new Agent/Null]
$ns attach-agent $n($j) $null($j$j)
$ns connect $udp($j$j) $null($j$j)
$ns at 3.2 "$cbr($j$j) start"
$ns at 4.0 "$cbr($j$j) stop"

}

#Traffic simulation from LC to End devices 

for {set j 1} {$j <= $localcc} {incr j} {
for {set i 1} {$i <= 4} {incr i} {
set udp($i$j) [new Agent/UDP]
$udp($i$j) set class_ ij # fid in trace file
$ns attach-agent $n($j) $udp($i$j)

# Create a CBR traffic source and attach it to udp1
set cbr($i$j) [new Application/Traffic/CBR]
$cbr($i$j) set packetSize_ 500
$cbr($i$j) set interval_ 0.005
$cbr($i$j) attach-agent $udp($i$j)

set null($i$j) [new Agent/Null]
$ns attach-agent $sn($j$i) $null($i$j)
$ns connect $udp($i$j) $null($i$j)
$ns at 4.2 "$cbr($i$j) start"
$ns at 5.0 "$cbr($i$j) stop"

}
}
#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}

#Call the finish procedure after 5 seconds of simulation time
$ns at 5.2 "finish"

#Run the simulation
$ns run
