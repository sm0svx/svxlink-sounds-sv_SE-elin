The Swedish sound clips for module MetarInfo were contributed by SA7CND with
help from SM5GXQ. The original release note is appended below.

-------------------------------------------------------------------------------

MetarInfo in Swedish on svxlink-systems.                2022-12-05 SA7CND

Update: 2022-12-30 Add correct Swedish pronounciation of 1 m/s or 1 degree

This is my attempt at making the svxlink repeater system deliver Metar reports in Swedish.
The aim is to have the Metar information read at a moderate pace, and using normally
used units such as meters and m/second. Reported values are rounded approximate values.
The Metar reports are clearly aimed at the "common man", not pilots.

These files can be copied onto your files in your svxlink system using the path in this archive, 
but have a backup first so you can revert if desired.

You may be cautious so that file ownership and privileges are set up in line with svxlink.
Use command chown and chmod when needed.

Note that .tcl files in a local/ directory are selected by svxlink instead of standard files, 
and will not be overwritten on updates.

You will of course have to modify config files after your needs, e.g ModuleMetarInfo.conf.
You may also have to edit or record the metarhelp.wav file in directory .../MetarInfo/,
or if you don't want to, copy help.wav there and name it metarhelp.info.
A paid service for text-to-speech is https://acapela-box.com/AcaBox/index.php, select language.

This package is free to use. 
Big thanks to SM5GXQ for a lot of help during the work.

Suggestions on improvements are most appreciated to: sa7cnd@ssa.se.

Enjoy, 73
SA7CND Poul
