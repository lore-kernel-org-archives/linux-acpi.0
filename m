From: "Tomasz Torcz, BG" <zdzichu-YxaM2a6SwlU@public.gmane.org>
Subject: [acpid] corrected acpi_handler.sh
Date: Sat, 29 Mar 2003 12:59:10 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030329115910.GA10257@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,

I've corrected acpi_handler.sh to work with 2.4.x and 2.5.x kernels.
Name of powerbutton event has changed. My motherboard is Matsonic 7132A,
on VIA Apollo Pro+ 133 chipset.

This is my acpi_handler.sh (note, that I've changed powerbutton event
in 2.5.x part to suit my needs):

#v+

#!/bin/sh
# Default acpi script that takes an entry for all actions

set $*

case "$1" in
	# ACPI in 2.4.x
	button)
		case "$2" in
			power)	 /sbin/init 0
				;;
			*)	logger "ACPI action $2 is not defined"
				;;
		esac
		;;
	# ACPI in 2.5.x
	button/power)
		case "$2" in
			PWRF)	hdparm -W0 /dev/hdd;
				ifconfig eth0 down;
				echo 4 > /proc/acpi/sleep;
				ifconfig eth0 up;
				;;
			*)      logger "ACPI action $2 is not defined"
				;;
		esac
		;;
	*)
		logger "ACPI group $1 / action $2 is not defined"
		;;
esac
#v-

-- 
Tomasz Torcz               RIP is irrevelant. Spoofing is futile.
zdzichu-X3HQ1c18OqI0iLA60pu2Z2ZHpeb/A1Y/@public.gmane.org     Your routes will be aggreggated.


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
