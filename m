From: John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Subject: Re: display interface?
Date: Thu, 05 Sep 2002 23:31:54 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D776ADA.3060202@prairienet.org>
References: <200209050826.g858QYX07834@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030705020507010100080209"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------030705020507010100080209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

joerg.beyer-htSm2yLGOjU@public.gmane.org wrote:
> If my assumtion is correct: has anybody an example of how
> to configure acpid to do "something" when the AC adapter is plugged
> in or out?

On battery power, I slow down the cpu, set the hard disk to spin down 
quickly, and lower the LCD brightness.  Attached are the scripts involved:

     /etc/acpi/events/default
     /etc/acpi/default.sh
     /usr/local/sbin/libretto-ac_adapter

-John



-- 
http:// i      .   /

--------------030705020507010100080209
Content-Type: text/plain;
 name="default"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="default"

# This is the ACPID default configuration, it takes all
# events and passes them to /etc/acpi/default.sh for further
# processing.

# event keeps a regular expression matching the event. To get
# power events only, just use something like "event=button power.*"
# to catch it.
# action keeps the command to be executed after an event occurs
# In case of the power event above, your entry may look this way:
#event=button power.*
#action=/sbin/init 0

# Optionally you can specify the placeholder %e. It will pass
# through the whole kernel event message to the program you've
# specified.

event=.*
action=/etc/acpi/default.sh %e

--------------030705020507010100080209
Content-Type: application/x-sh;
 name="default.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="default.sh"

#!/bin/sh
# Default acpi script that takes an entry for all actions

set $*

case "$1" in
	button)
		case "$2" in
			power)	/sbin/init 0
				;;
			*)	logger "ACPI action $2 is not defined"
				;;
		esac
		;;

	ac_adapter)
		/usr/local/sbin/libretto-ac_adapter $2 $3 $4
		;;

	*)
		#logger "ACPI group $1 / action $2 is not defined"
		;;
esac

--------------030705020507010100080209
Content-Type: text/plain;
 name="libretto-ac_adapter"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libretto-ac_adapter"

#!/usr/bin/python

# call longrun and hdparm based on acpi ac adapter status
# John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>

import sys
import re
import commands

device_num = sys.argv[1]
status_name = "/proc/acpi/ac_adapter/%s/status" % device_num

status_file = open(status_name)
status = status_file.read()
status_file.close()

def command(s):
    commands.getstatusoutput(s)

is_off_line = re.search("off-line", status)
# NOTE: hdparm sleep settings seem to trump noflushd
# ISSUE: longrun doesn't like -f and -s at the same time
if is_off_line:
    command("longrun -s 0 30")
    command("longrun -f economy")
    command("hdparm -S 4 /dev/hda") # 20 second sleep timeout
    command("echo 'brightness:1' > /proc/acpi/toshiba/lcd")
else:
    command("longrun -s 0 100")
    command("longrun -f performance")
    command("hdparm -S 48 /dev/hda") # 4 minute sleep timeout
    command("echo 'brightness:6' > /proc/acpi/toshiba/lcd")


--------------030705020507010100080209--



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
