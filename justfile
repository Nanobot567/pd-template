# set name of playdate game here
PDX_NAME := "template"

# set playdate SDK path (don't forget the '/'!!)
SDK_PATH := "~/Documents/PlaydateSDK/"

SDK_BIN := SDK_PATH + "bin/"
SDK_PDC := SDK_BIN + "pdc"
SDK_SIM := SDK_BIN + "PlaydateSimulator"

default: build run

[private]
incrementBuildNumber:
    #! /bin/python3
    from sys import argv

    f = open("src/pdxinfo","r")
    content = f.read()
    f.close()

    contentLines = content.split("\n")

    for i, line in enumerate(contentLines):
        if line.startswith("buildNumber="):
            buildnum = int(line.split("=")[1])
            buildnum += 1
            contentLines[i] = "buildNumber=" + str(buildnum)
            break

    f = open("src/pdxinfo","w")

    f.write("\n".join(contentLines))

    print(contentLines)


build:
    @just incrementBuildNumber

    {{SDK_PDC}} -q src {{PDX_NAME}}

run:
    {{SDK_SIM}} {{PDX_NAME}}.pdx

release:
    just build
    -rm {{PDX_NAME}}.pdx.zip
    zip -rq {{PDX_NAME}}.pdx.zip {{PDX_NAME}}.pdx
