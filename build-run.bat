@echo off
python pdxinfobuilder.py
%USERPROFILE%"\Documents\PlaydateSDK\bin\pdc.exe" src name
%USERPROFILE%"\Documents\PlaydateSDK\bin\PlaydateSimulator.exe" "name.pdx"