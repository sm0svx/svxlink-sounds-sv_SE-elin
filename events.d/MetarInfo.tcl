###############################################################################
#
# MetarInfo module event handlers
#
###############################################################################

#
# This is the namespace in which all functions and variables below will exist.
# The name must match the configuration variable "NAME" in the
# [ModuleMetarInfo] section in the configuration file. The name may be changed
# but it must be changed in both places.
#
# This version is trimmed by both SM5GXQ and SA7CND for a Swedish report lang.
#
namespace eval MetarInfo {

#
# Check if this module is loaded in the current logic core
#
if {![info exists CFG_ID]} {
  return;
}


# METAR as raw txt to make them available in a file
proc metar {input} {
  set fp [open "/tmp/metar" w];
  ::puts $fp $input;
  close $fp
}


# no airport defined
proc no_airport_defined {} {
   playMsg "no";
   playMsg "airport";
   playMsg "defined";
   playSilence 300;
}


# no airport defined
proc no_such_airport {} {
   playMsg "no";
   playMsg "such";
   playMsg "airport";
   playSilence 300;
}


# METAR not valid
proc metar_not_valid {} {
  playMsg "metar_not_valid";
  playSilence 300;
}


# MET-report TIME
proc metreport_time {item} {
   playMsg "metreport_time";
#   playMsg "at"
   playSilence 100;
   sayTime $item
   playSilence 100;
   playMsg "utc";
   playSilence 200;

}

# visibility
proc visibility args {
  playMsg "visibility";
  foreach item $args {
    if [regexp {(\d+)} $item] {
         sayNumber $item;
    } else {
      playMsg $item;
    }
    playSilence 100;
  }
  playSilence 300;
}


# temperature
proc temperature {temp} {
  playMsg "temperature";
  playSilence 100;
  if {$temp == "not"} {
    playMsg "not";
    playMsg "reported";
  } else {
    if { int($temp) < 0} {
       playMsg "minus";
       set temp [string trimleft $temp "-"];
    }
#     sayNumber $temp;
    if {int($temp) == 1} {
      playMsg "en";
      playMsg "unit_degree";
    } else {
      sayNumber $temp;
      playMsg "unit_degrees";
    }
    playSilence 100;
  }
  playSilence 300;
}


# dewpoint
proc dewpoint {dewpt} {
  playMsg "dewpoint";
  playSilence 100;
  if {$dewpt == "not"} {
    playMsg "not";
    playMsg "reported";
  } else {
    if { int($dewpt) < 0} {
       playMsg "minus";
       set dewpt [string trimleft $dewpt "-"];
    }
    if {int($dewpt) == 1} {
      playMsg "en";
      playMsg "unit_degree";
    } else {
      sayNumber $dewpt;
      playMsg "unit_degrees";
    }
    playSilence 100;
  }
  playSilence 300;
}


# sea level pressure
proc slp {slp} {
  playMsg "slp";
  sayNumber $slp;
  playMsg "unit_hPa";
  playSilence 300;
}


# flightlevel
proc flightlevel {level} {
  playMsg "flightlevel";
  sayNumber $level;
  playSilence 300;
}


# No specific reports taken
proc nospeci {} {
  playMsg "no";
  playMsg "specific_reports_taken";
  playSilence 100;
}


# peakwind
proc peakwind {val} {
  playMsg "pk_wnd";
  playSilence 100;
# SA7CND m/s
  sayNumber [expr int($val * 0.514)];
### Could put detection of 1 m/s here to say "en"
  playSilence 300;
}


# wind
# SA7CND say windspeed in m/s
proc wind {deg {vel 0 } {unit 0} {gvel 0} {gunit 0}} {
  playSilence 200;
  playMsg "wind";
  playSilence 200;

  if {[string range $vel 0 0] == "0" } {
    set vel [string range $vel 1 end];
  }
  if {$deg == "calm"} {
    playMsg "calm";
  } elseif {$deg == "variable"} {
    playMsg "variable";
    playSilence 200;
#   sayNumber $vel;
#   playMsg $unit;
#    sayNumber [expr int($vel * 0.514)];
    set vind [expr int($vel * 0.514)];
    if { $vind == 1 } {
       playMsg "en";
    } else {
       sayNumber $vind;
    } 
      playMsg "unit_mps";
  } else {
    sayNumber $deg;
    playMsg "unit_degrees";
    playSilence 100;
#   playMsg "at";
#   playSilence 100;
#   sayNumber $vel;
#   playMsg $unit;
#   sayNumber [expr int($vel * 0.514)];
    set vind [expr int($vel * 0.514)];
    if { $vind == 1 } {
       playMsg "en";
    } else {
       sayNumber $vind;
    } 
    playMsg "unit_mps";
    playSilence 100;

    if {$gvel > 0} {
      playMsg "gusts_up";
#     sayNumber $gusts;
#     playMsg $gvel;
      if {[string range $gvel 0 0] == "0" } {
        set gvel [string range $gvel 1 end];
      }
#      sayNumber [expr int($gvel * 0.514)];
      set gvind [expr int($gvel * 0.514)];
      if { $gvind == 1 } {
          playMsg "en";
      } else {
         sayNumber $gvind;
      } 
      playMsg "unit_mps";;
    }
  }
  playSilence 200;
}


# weather actually
proc actualWX args {
  foreach item $args {
    if [regexp {(\d+)} $item] {
      sayNumber $item;
    } else {
      playMsg $item;
    }
  }
  playSilence 300;
}


# wind varies $from $to
proc windvaries {from to} {
   playMsg "wind";
   playSilence 50;
   playMsg "varies_from";
   playSilence 100;

   sayNumber $from;
   playSilence 100;

   playMsg "to";
   playSilence 100;
   sayNumber $to;

   playMsg "unit_degrees";
   playSilence 300;
}


# Peak WIND
proc peakwind {deg kts hh mm} {
   playMsg "pk_wnd";
   playMsg "from";
   playSilence 100;
   sayNumber $deg;
   playMsg "unit_degrees";

   playSilence 100;
   if {[string range $kts 0 0] == "0" } {
     set kts [string range $kts 1 end];
   }
### Could put detect if 1 m/s here to say "en"
   sayNumber [expr int($kts *0.514)];
   playMsg "unit_mps";
   playSilence 100;
   playMsg "at";
   if {$hh != "XX"} {
      sayNumber $hh;
   }
   sayNumber $mm;
   playMsg "utc";
   playSilence 300;
}


# ceiling varies $from $to
proc ceilingvaries {from to} {
   playMsg "ca";
   playSilence 50;
   playMsg "varies_from";
   playSilence 100;
   set from [expr {int($from) * 100}];
   sayNumber [expr int( int($from *0.3048) /100 +1) *100];
#  sayNumber $from;
   playSilence 100;

   playMsg "to";
   playSilence 100;
   set to [expr {int($to)*100}];
   sayNumber [expr int( int($to *0.3048) /100 +1) *100];
   playMsg "unit_meters";
#  sayNumber $to;
#  playMsg "unit_feet";
   playSilence 300;
}

# runway visual range
proc rvr args {
   playMsg "rwy";
   foreach item $args {
     if [regexp {(\d+)} $item] {
       sayNumber $item;
     } else {
       playMsg $item;
     }
     playSilence 100;
   }
   playSilence 300;
}


# airport is closed due to snow
proc snowclosed {} {
   playMag "aiport";
   playMag "closed";
   playMsg "due_to"
   playMsg "sn";
   playSilence 300;
}


# RWY is clear
proc all_rwy_clear {} {
  playMsg "all";
  playMsg "runways";
  playMsg "clr";
  playSilence 300;
}


# Runway designator
proc runway args {
  foreach item $args {
    if [regexp {(\d+)} $item] {
      spellNumber $item;
    } else {
      playMsg $item;
    }
    playSilence 100;
  }
  playSilence 300;
}


# time
proc utime {utime} {
   sayTime $utime;
   playSilence 100;
   playMsg "utc";
   playSilence 300;
}


# vv010 -> "vertical view (ceiling) 1000 feet"
# SA7CND to meters
proc ceiling {param} {
   playMsg "ca";
   playSilence 100;
#   sayNumber $param;
   sayNumber [expr int( $param * 0.3048)];
###   sayNumber [expr int( int($param /10) *30.48)];
   playSilence 100;
   playMsg "unit_meters";
#   playMsg "unit_feet";
   playSilence 300;
}


# QNH
proc qnh {value} {
  playMsg "qnh";
  playSilence 200;
  if {$value == 1000} {
     playNumber 1;
     playMsg "thousand";
  } else {
     sayNumber $value;
  }
  playMsg "unit_hPa";
  playSilence 300;
}


# altimeter
proc altimeter {value} {
  playMsg "altimeter";
  playSilence 100;
  sayNumber $value;
  playMsg "unit_inches";
  playSilence 300;
}


# trend
proc trend args {
  playMsg "trend";
  foreach item $args {
    playMsg $item;
    playSilence 100;
  }
  playSilence 300;
}


# clouds with arguments
proc clouds {obs height {cbs ""}} {

  playMsg $obs;
  playSilence 100;

  if {[string length $cbs] > 0} {
    playMsg $cbs;
    playSilence 50;
  }

# sayNumber $height
# playMsg "unit_feet";
  sayNumber [expr int( round($height *0.3048) /10 ) *10];
  playMsg "unit_meters";

  playSilence 250;
}


# temporary weather obscuration
proc tempo_obscuration {from until} {
  playMsg "tempo";
  playSilence 100;
  playMsg "obsc";
  playSilence 200;
  playMsg "from";
  sayTime $from;
  playSilence 200;
  playMsg "to";
  playSilence 100;
  sayTime $until;
  playSilence 300;
}


# max day temperature
proc max_daytemp {deg time} {
  playMsg "predicted";
  playSilence 50;
  playMsg "maximal";
  playSilence 50;
  playMsg "daytime_temperature";
  playSilence 150;
### Could detect if 1 m/s here to say en
  sayNumber $deg;
  playMsg "unit_degrees";
  playSilence 150;
  playMsg "at";
  playSilence 50;
  sayTime $time;
  playSilence 300;
}


# min day temperature
proc min_daytemp {deg time} {
  playMsg "predicted";
  playSilence 50;
  playMsg "minimal";
  playSilence 50;
  playMsg "daytime_temperature";
  playSilence 150;
### Could detect if 1 m/s here to say en
  sayNumber $deg;
  playMsg "unit_degrees";
  playSilence 150;
  playMsg "at";
  playSilence 50;
  sayTime $time;
  playSilence 300;
}


# Maximum temperature in RMK section
proc rmk_maxtemp {val} {
  playMsg "maximal";
  playMsg "temperature";
  playMsg "last";
  sayNumber 6;
  playMsg "hours";
  if {$val < 0} {
    playMsg "minus";
  }
  sayNumber $val;
  playMsg "unit_degrees";
  playSilence 300;
}


# Minimum temperature in RMK section
proc rmk_mintemp {val} {
  playMsg "minimal";
  playMsg "temperature";
  playMsg "last";
  sayNumber 6;
  playMsg "hours";
  if {$val < 0} {
    playMsg "minus";
  }
  sayNumber $val;
  playMsg "unit_degrees";
  playSilence 300;
}


# the begin of RMK section
proc remarks {} {
  playSilence 200;
  playMsg "remarks";
  playSilence 200;
}


# RMK section pressure trend next 3 h
proc rmk_pressure {val args} {
  playMsg "pressure";
  playMsg "tendency";
  playMsg "next";
  sayNumber 3;
  playMsg "hours";
  playSilence 150;
  sayNumber $val;
  playSilence 150;
  playMsg "unit_mbs";
  playSilence 250;

  foreach item $args {
     if [regexp {(\d+)} $item] {
       sayNumber $item;
     } else {
       playMsg $item;
     }
     playSilence 100;
  }
  playSilence 300;
}


# precipitation last hours in RMK section
proc rmk_precipitation {hour val} {
  playMsg "precipitation";
  playMsg "last";

  if {$hour == "1"} {
     playMsg "hour";
  } else {
     sayNumber $hour;
     playMsg "hours";
  }

  playSilence 150;
  sayNumber $val;
  playMsg "unit_inches";
  playSilence 300;
}

# precipitations in RMK section
proc rmk_precip {args} {
  foreach item $args {
     if [regexp {(\d+)} $item] {
       sayNumber $item;
     } else {
       playMsg $item;
     }
     playSilence 100;
  }
  playSilence 300;
}


# daytime minimal/maximal temperature
proc rmk_minmaxtemp {max min} {
  playMsg "daytime";
  playMsg "temperature";
  playMsg "maximum";
  if { $max < 0} {
     playMsg "minus";
     set max [string trimleft $max "-"];
  }
  sayNumber $min;
  playMsg "unit_degrees";

  playMsg "minimum";
  if { $min < 0} {
     playMsg "minus";
     set min [string trimleft $min "-"];
  }
  sayNumber $max;
  playMsg "unit_degrees";
  playSilence 300;
}


# recent temperature and dewpoint in RMK section
proc rmk_tempdew {temp dewpt} {
  playMsg "re";
  playMsg "temperature";
  if { $temp < 0} {
     playMsg "minus";
     set temp [string trimleft $temp "-"];
  }

  sayNumber $temp;
  playMsg "unit_degrees";
  playSilence 300;
  playMsg "dewpoint";
  if { $dewpt < 0} {
     playMsg "minus";
     set dewpt [string trimleft $dewpt "-"];
  }
  sayNumber $dewpt;
  playMsg "unit_degrees";
  playSilence 300;
}


# wind shift
proc windshift {val} {
  playMsg "wshft";
  playSilence 100;
  playMsg "at";
  playSilence 100;
  sayNumber $val;
  playSilence 300;
}

# QFE value
proc qfe {val} {
  playMsg "qfe";
  sayNumber $val;
  playMsg "unit_hPa";
  playSilence 300;
}

# runwaystate
proc runwaystate args {
  playSilence 250;
  set last_item "";
  foreach item $args {
    if [regexp {(\d+)} $item] {
      sayNumber $item;
      #playSilence 50;  #TESTING
      if {$last_item == "runway"} {
        playSilence 200;
      }
    } else {
      playMsg $item;
      if {($item != "runway") && ($item != "to")} {
        playSilence 200; #TESTING
      }
    }
    set last_item $item
    #playSilence 200;
  }
  playSilence 300;
}


# output numbers  -  SM5GXQ mods

proc sayNumber { number } {
  variable ts;
  variable hd;
  variable te;

  if {[string range $number 0 1] == "0."} {
    set number [string range $number 2 end]   
  } 

  while {[string range $number 0 0] == "0"} {
    set number [string range $number 1 end];
  } 

  if {$number == "" || $number == "0"} {
    playMsg "0";
    return;
  }

  if {[string length $number] == 1} {
    playMsg $number;
  } elseif {[string length $number] == 2} { 
    playNumber $number;
  } elseif {[string length $number] > 2} {
    set ts [expr {int($number / 1000)}];   # 1...9 thousand
    set hd [expr {int(($number - $ts * 1000)/100) * 100}];  # 100-900
    set te [expr {($number - ($ts * 1000) - ($hd))}];  # 0...99

    # say 1...9 thousand
    if { $ts > 0 } {
      playNumber $ts;
      playMsg "thousand";
    }
    if { $hd > 0 } {
      playMsg $hd;
    }
    if { $te > 0 } {
      sayNumber $te;
    }
  }
}



# output
proc say args {
  variable tsay;

  playSilence 100;
  foreach item $args {
    if [regexp {^(\d+)} $item] {
      sayNumber $item;
    } else {
      if {$item == "."} {
        playMsg "decimal";
      } else {
        playMsg $item;
      }
    }
    playSilence 100;
  }
  playSilence 300;
}


# part 1 of help #01
proc icao_available {} {
   playMsg "icao_available";
   playSilence 300;
}


# announce airport at the beginning of the MEATAR
proc announce_airport {icao} {
  global langdir;
  if [file exists "$langdir/MetarInfo/$icao.wav"] {
    playMsg $icao;
  } else {
    spellWord $icao;
  }
#  playSilence 50;
  playMsg "airport";
}


# say preconfigured airports
proc airports args {
  global langdir;
#  global lang;
  variable tval;

  foreach item $args {

     # is a number??

     if {[regexp {(\d+)} $item tval]} {
       sayNumber $tval;
     } else {
       if [file exists "$langdir/MetarInfo/$item.wav"] {
         playFile "$langdir/MetarInfo/$item.wav";
       } else {
         spellWord $item;
       }
     }
     playSilence 50;
  }
  playSilence 300;
}


# say clouds with covering
proc cloudtypes {} {
variable a 0;
  variable l [llength $args];

  while {$a < $l} {
    set msg [lindex $args $a];
    playMsg "cld_$msg";
    playMsg "covering";
    incr a;
    playNumber [lindex $args $a];
    playMsg "eighth";
    incr a;
    playSilence 100;
  }
}

proc sayTime {time} {
   set hr [string range $time 0 1]
   set mn [string range $time 2 3]
   playTime $hr $mn;
}


#
# Spell the specified number
#
proc playNr {number} {
  for {set i 0} {$i < [string length $number]} {set i [expr $i + 1]} {
    set ch [string index $number $i];
    if {$ch == "."} {
      playMsg "decimal";
    } else {
      playMsg "$ch";
    }
  }
}


# end of namespace
}

#
# This file has not been truncated
#
