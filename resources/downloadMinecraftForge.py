#!/usr/bin/python2.7

import json
import argparse
import urllib
import sys
import os

# parse command line arguments
parser=argparse.ArgumentParser()
parser.add_argument("-v", "--version", type=str, default="latest", help="the version number of the minecraft server or latest")
parser.add_argument("-t", "--target", type=str, default="recommended", choices=['recommended', 'latest'], help="precice which version of forge to get")
parser.add_argument("-m", "--manifest", type=str, default="./forge_manifest.json", help="the path to manifest of forge.")
args=parser.parse_args()

# read json file previously downloaded from http://files.minecraftforge.net/maven/net/minecraftforge/forge/json
if not os.path.isfile(args.manifest) : 
  print "Start downloading vesion manifest for minecraftforge"
  try:
    jarfile=urllib.URLopener()
    jarfile.retrieve("http://files.minecraftforge.net/maven/net/minecraftforge/forge/json", args.manifest)
  except IOError as e:
    print "I/O Error. Download aborted "+str(e)
    sys.exit(2)

with open(args.manifest) as json_data:
  manifest=json.load(json_data)

  promos=manifest["promos"]
  if args.version == "latest" and args.target == "recommended" :
    number=promos["recommended"]
  elif args.version  == "latest" :
    number=promos["latest"]
  else :
    number=promos[args.version+"-"+args.target]

  numbers=manifest["number"]
  numberDetails=numbers[str(number)]
  mcversion=numberDetails["mcversion"]
  forgeVersion=numberDetails["version"]
  fullVersion=mcversion+"-"+forgeVersion
  webpath=manifest["webpath"]
  filename="forge-"+fullVersion+"-installer.jar"
  installerUrl=webpath+fullVersion+"/"+filename

  print "Start downloading installer: "+filename
  try:
    jarfile=urllib.URLopener()
    jarfile.retrieve(installerUrl, "./"+filename)
  except IOError as e:
    print "I/O Error. Download aborted "+str(e)
    sys.exit(2)

