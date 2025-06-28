###############################################################################
#
# Locale specific functions for playing back time, numbers and spelling words.
# Often, the functions in this file are the only ones that have to be
# reimplemented for a new language pack.
#
###############################################################################

#
# Say the specified two digit number (00 - 99)
#
proc playTwoDigitNumber {number} {
  if {[string length $number] != 2} {
    puts "*** WARNING: Function playTwoDigitNumber received a non two digit number: $number";
    return;
  }
  
  set first [string index $number 0];
  if {$first == "0"} {
    playMsg "Default" $first;
    playMsg "Default" [string index $number 1];
  } elseif {$first == "1"} {
    playMsg "Default" $number;
  } elseif {[string index $number 1] == "0"} {
    playMsg "Default" $number;
  } else {
    playMsg "Default" "[string index $number 0]X";
    playMsg "Default" "[string index $number 1]";
  }
}


#
# Say the specified three digit number (000 - 999)
#
proc playThreeDigitNumber {number} {
  if {[string length $number] != 3} {
    puts "*** WARNING: Function playThreeDigitNumber received a non three digit number: $number";
    return;
  }
  
  set first [string index $number 0];
  if {$first == "0"} {
    spellNumber $number
  } else {
    append first "00";
    playMsg "Default" $first;
    if {[string index $number 1] != "0"} {
      playTwoDigitNumber [string range $number 1 2];
    } elseif {[string index $number 2] != "0"} {
      playMsg "Default" [string index $number 2];
    }
  }
}


#
# Say the time specified by function arguments "hour" and "minute".
#
proc playTime {hour minute} {
  set hour [string trimleft $hour " "];
  set minute [string trimleft $minute " "];
  
  if {[string length $hour] == 1} {
    set hour "0$hour";
  }
  playTwoDigitNumber $hour;

  if {$hour > 9 && $minute >= 10} {
    playMsg "Default" and
  } else {
    playSilence 100
  }

  if {[string length $minute] == 1} {
    set minute "0$minute";
  }
  playTwoDigitNumber $minute;
  
  playSilence 100;
}


#
# This file has not been truncated
#
