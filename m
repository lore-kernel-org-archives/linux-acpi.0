From: Thomas Renninger <trenn@suse.de>
Subject: acpi.sourceforge.net DSDT collection - Get acpidumps for research
Date: Fri, 18 Apr 2008 19:41:52 +0200
Message-ID: <1208540512.31815.74.camel@linux-2bdv.site>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-qfepzOxMxelaw9KeiTVS"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:52157 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757997AbYDRRqw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Apr 2008 13:46:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: "Yu, Ling L" <ling.l.yu@intel.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, tytso@MIT.EDU


--=-qfepzOxMxelaw9KeiTVS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

attached is a hackish script that downloads a lot of the uploaded DSDTs.
It already tries to unzip, compile/disassemble, etc. to verify.

I did that to be able to grep over the DSDTs to research how vendors are
implementing details, especially how they use osi= in their code.

In the recent discussion I hoped to get some real DSDT code feedback why
osi=Windows actually makes sense, instead of some "stay Windows
compatible" theory talk.

I then realized that it's not that easy to access DSDTs for research, so
people might be interested in attached script if they want to compare
between different DSDT implementations.
The file name used is dumped from the Description Header and often
points to the laptop vendor/model.

A lot of the uploaded files are corrupt (parts of DSDTs pasted, etc.)
and the remaining are in different formats (zipped, double zipped, AML,
ALS, acpidump, ...). With attached script you should be able to nearly
extract 600 DSDTs.

Do:
wget_dsdts.sh --wget
﻿wget_dsdts.sh --parse
(have a look in /tmp/wget_dsdt while it's running, hope it still half
way works, I didn't want to waste any more time on this hack)

What is missing is the BIOS update history. Therefore you'd need
dmidecode. That could reveal really interesting info about what got
workarounded for which SP and we could be prepared (instead of waiting
for bugreports and digging in the dark).

IMO the actual purpose of the DSDT collection, be able to override your
buggy DSDT with a fixed one, is not needed anymore. ACPI in Linux is
rather stable. Everyone should be able to get a stable system through
boot params and/or the queue of critical ACPI bugs is not that long that
someone has to buy another machine...

But as said a collection of DSDTs (better acpidump) could be really
important for research, for faster driver development, fixes before bug
reports, etc.. Therefore I hope that Yu (who maintains
acpi.sourceforge.net/DSDT?) can add a little front-end to this site.
Possibly a script can be provided that tars dmidecode and acpidump
together and pushes the info up, maybe through w3m or similar?
If Yu or Intel is not willing to do that, maybe someone else has an idea
how and where such a site could be set up?

I understand that Len cannot publish the dumps sent to him.
But the current situation is far away from perfect:
  - People should sent the dumps to a list which will reject the mail
    because of size of the attachment (seems like 
    the message got changed now?).
  - When the info is sent to Len, he won't be able to publish it and
    people cannot make use of it, research or discuss ACPI problems.
    ACPI kernel decisions often rely on hundreds of
    BIOS implementations.

---------------------------

This was about a possible acpidump collection,
now some more about the current osi= implementation...:

I now found a feature implementation for osi="Windows 2006".
Both are located in brightness switching functions. It looked like:
if (OSI=Windows 2006)
   Do some things on your own
else
   Call an SMI handler

I still think that Linux should not return true for Windows.
BIOSes are developed for a specific OS. When released, they are
extensively tested and are working fine.
﻿In this case for XP and Vista functionality is added afterwards.
Every osi= workaround added later is support for another OS, mostly
Service Packs.
If for Windows osi does not return true, we have a more stable BIOS
environment. Things will not break after a BIOS upgrade (e.g. when
things are added for Vista SP2).

In above example possibly the feature for SMI free brightness support
has been added, we have the problem that we are a way behind with the
implementation and after the Vista BIOS upgrade brightness is still not
working, while the XP implementation would probably simply work.
BIOSes which do not work without osi=Windows are broken by design and
should get blacklisted (not the other way around!).

I might be wrong and there might be hundreds of BIOSes not working
correctly with osi=!Windows. I couldn't find any (at least by looking
over some DSDTs). Please provide examples where it actually makes sense
to return osi=Windows, with attached script there should be examples to
find, if it really makes sense.
To be honest, I could imagine I am wrong, but I like to see some prove
before the blacklist is done in the wrong way and the whole concept is
messed up and Linux is going down even further into an unsupportable osi
nightmare.

Thanks,

   Thomas

BTW:
For vendors who want and will provide osi Vista SPX BIOS updates and
also want to reliably support Linux, they have to compile
osi="Linux Distribution I support" to return true into their Linux
kernels.
Simply because they would break their supported Linux system with the
next Vista SPx hotfix otherwise. There is no way around currently. You
can jump and scream about that fact, but with (osi=Linux == false) and
(osi=Windows == true) you will not push the vendors to fix up their
drivers, but let them decide that Linux ACPI is unsupportable together
with Windows.

--=-qfepzOxMxelaw9KeiTVS
Content-Disposition: attachment; filename=wget_dsdts.sh
Content-Type: application/x-shellscript; name=wget_dsdts.sh
Content-Transfer-Encoding: 7bit

#!/bin/bash

# Parameters:
# --wget  -> only download files
# --parse ->  only parse downloaded files
# default (no paramter): both

TEMPDIR=/tmp/wget_dsdt
TARGET=/tmp/wget_dsdt.tar.bz2
TARGET2=/tmp/wget_dsdt_parsed.tar.bz2

if [ -z "$1" ];then
    DOWNLOAD="yes"
    PARSE="yes"
else
    DOWNLOAD="no"
    PARSE="no"
fi

while [ "$1" ]; do
    param="$1"
    case "$1" in
	--wget | -w) 
	    DOWNLOAD="yes"
	    shift
	    ;;
	--parse | -p)
	    PARSE="yes"
	    shift
	    ;;
	--help | -h) 
	    echo "wget_dsdts.sh [ --wget|-w ] [ --parse|-p ]"
	    echo "    --wget  -> only download files"
	    echo "    --parse -> only parse downloaded files"
	    echo "default (no parameter) is both"
	    exit 0
	    ;;
	*)
	    echo "unknown parameter $1"
	    exit 1
	    ;;
    esac
done

function get_files() {
    if [ -e $TARGET ];then
	echo "Target file $TARGET already exists"
	exit 1
    elif [ -e $TEMPDIR ];then
	echo "Target file $TEMPDIR already exists"
	exit 1
    fi
    echo "Using temp dir $TEMPDIR"
    mkdir $TEMPDIR
    pushd $TEMPDIR >/dev/null
    echo -n "Trying to fetch DSDTs through wget.."
    for ((x=0;x<1000;x++));do
	FILE="DSDT_${x}"
	echo -n "."
	wget --quiet http://acpi.sourceforge.net/dsdt/dl.php?id=${x} -O $FILE;
    done
    tar -cvjf $TARGET -C /dev/shm wget_dsdt
    echo "Raw downloaded DSDT files in stored in $TARGET"
    popd
    rm -rf $TEMPDIR
}

function parse_files() {
    if [ ! -e $TARGET ];then
	echo "Could not find downloaded and packed DSDTs here: $TARGET"
	exit 1
    elif [ -e $TEMPDIR ];then
	echo "Target file $TEMPDIR already exists, remove it first"
	exit 1
    fi

    good=0

    mkdir $TEMPDIR
    pushd $TEMPDIR
    tar -xvjf $TARGET
    cd wget_dsdt
    set -x
    for ((x=0;x<1000;x++));do
	FILE="DSDT_${x}"
	[ ! -e $FILE ] && continue
	echo -n "."
	SIZE=`ls -l $FILE| awk '{print$5}'`
	if [ $SIZE -lt 100 ];then
	    rm $FILE;
	    continue
	elif ( file -z $FILE | grep -q "gzip compressed data" );then
	    zcat $FILE > ${FILE}.uncompressed
	    rm $FILE
	else
	mv $FILE ${FILE}.uncompressed
	fi
	
	acpixtract $FILE >/dev/null 2>&1
	if [ $? = 0 ];then
	    mv DSDT.dat $FILE.uncompressed
	fi
	
	iasl -d $FILE.uncompressed >/dev/null 2>&1
	
FILE_NAME=DSDT_`grep DefinitionBlock $FILE.uncompressed |sed -n -e 's/DefinitionBlock ("\(\S*\)\s*", "\(\S*\)\s*", [0-9], "\(\S*\)\s*", "\(\S*\)\s*",.*/\3_\4/p'`.dsl
	if [ $FILE_NAME = "DSDT_.dsl" ];then
	    continue
	fi
	    
	touch $FILE_NAME >/dev/null 2>&1
	[ $? != 0 ] && continue
	
	iasl -sa -f $FILE.uncompressed 2>&1
	
	AML_NAME=`grep DefinitionBlock $FILE.uncompressed |sed -n -e 's/DefinitionBlock ("\(\S*\)\s*", "\(\S*\)\s*", [0-9], "\(\S*\)\s*", "\(\S*\)\s*",.*/\1/p'`
	
	if [ -e $AML_NAME ];then
	    rm -f DSDT_${x}.asm >/dev/null 2>&1
	    rm -f DSDT_${x}.dsl.asm >/dev/null 2>&1
	    rm $AML_NAME
	    mv $FILE.uncompressed $TEMPDIR/$FILE_NAME
	    good=$(($good+1))
	else
	    rm -f DSDT_${x}.asm
	    rm -f DSDT.aml
	    mv $FILE.uncompressed $FILE.dsl.error
	fi
    done
    tar -cvjf $TARGET2 -C /dev/shm wget_dsdt
    rm -rf $TEMPDIR
    echo "$good DSDT files in ACPI Source Language found and copied to $TARGET2"
}

[ $DOWNLOAD = "yes" ] && get_files
[ $PARSE = "yes" ] && parse_files

--=-qfepzOxMxelaw9KeiTVS--

