From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.21-rc5-git 0/3] x86_pc and ACPI support /sys/devices/.../wakeup
Date: Thu, 5 Apr 2007 12:48:40 -0700
Message-ID: <200704051248.40745.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:41620 "HELO
	smtp102.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753314AbXDEUHW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Apr 2007 16:07:22 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

Following are three patches for basic driver model wakeup flag support on
PCs.  I think the first two are nearly mergable.  The third previously broke
powerpc, so it's likely not yet mergeable ... the issue was arch-specific
differences in PCI initialization, someone else will need to solve them.

The patches are:

 - Define a platform_enable_wakeup() PM hook and use it with PCI.  (This
   might help OLPC with its non-RTC events...)

 - Make ACPI init and use driver model wakeup flags for the (motherboard)
   devices in its table ... and implement that new platform hook.  Now
   /proc/acpi/wakeup is almost purely informative.

 - Update PCI to set those flags on devices that can issue PME#/WAKE#;
   this gets overridden by ACPI, except for add-on cards.

Now, I've not yet made time to test whether the results _work_ but they
do look like they do the right thing.  (So far I've had lousy luck seeing
ACPI recover from wake events...)  The script I append (which I've posted
before) gave the following on one system:

	input      on  acpi_system:00/device:00/PNP0C0E:00
	           on  pci0000:00/0000:00:09.0
	lan        on  pci0000:00/0000:00:04.0
	hub        on  pci0000:00/0000:00:03.3/usb1
	usb_host   on  pci0000:00/0000:00:03.3
	hub        on  pci0000:00/0000:00:03.1/usb3
	usb_host   on  pci0000:00/0000:00:03.1
	input      on  pci0000:00/0000:00:03.0/usb2/2-1/2-1.1
	hub        on  pci0000:00/0000:00:03.0/usb2/2-1
	hub        on  pci0000:00/0000:00:03.0/usb2
	usb_host   on  pci0000:00/0000:00:03.0
	modem      on  pci0000:00/0000:00:02.7
	           on  pci0000:00
	tty        on  pnp0/00:08
	           on  pnp0/00:06
	           on  pnp0/00:05
	rtc        on  pnp0/00:02

Notice the external USB hub and keyboard.  The i8042 drivers don't
seem to list themselvs as input drivers in the usual way, or those
PS2 kbd/aux nodes would also say "input".  PCI 00:09.0 is an add-in
card, invisible without the third patch; it'd be a USB host if it
had a Linux driver.

- Dave

#!/bin/bash
# pm-wake

# classfilename *:* ==> $type
class_label ()
{
	case $1 in
	# recognize common types of wakeup-capable devices
	i2c-dev:*)	type="smbus     "; return 0;;
	input:*)	type="input     "; return 0;;
	mmc_host:*)	type="mmc_host  "; return 0;;
	net:eth*)	type="lan       "; return 0;;
	net:*)		type="net       "; return 0;;
	pcmcia_socket:*)type="pcmcia    "; return 0;;
	rtc:*)		type="rtc       "; return 0;;
	sound:*)	type="modem     "; return 0;;
	tty:*)		type="tty       "; return 0;;
	usb_host:*)	type="usb_host  "; return 0;;
	esac
	return 1
}

# interface_label $PATH ==> $type
interface_label ()
{
	for F in $(cd $1 >/dev/null 2>&1 ; echo *:*)
	do
		class_label $F && return
	done
}

# devtype $PATH ==> $type
devtype ()
{
	local F T

	# fixed length, currently ten spaces
	type=""

	for F in $(cd $1 >/dev/null 2>&1 ; echo *:*)
	do
		if [ ! -d "$1/$F" ]
		then
			break;
		fi

		# is this a usb interface?
		if [ -f $1/$F/bInterfaceClass ]
		then
			interface_label $1/$F && return
		fi

		case $F in
		# use interface's label if possible, else generic
		usb_device:*)
			read T < $1/maxchild
			if [ 0 -lt $T ]
			then
				type="hub       "
				return
			fi
			type="(usb)     "
			continue;;
		*:*)	class_label $F && return ;;
		esac

	done

	if [ "$type" = "" ]
	then
		for T in $(cd $1 >/dev/null 2>&1 ; echo fw-host*/ieee1394_host:*)
		do
			if [ ! -L "$1/$T" ]
			then
				break;
			fi
			type="firewire  "
			return
		done
	fi

	if [ "$type" = "" ]
		then
		type="          "
	fi
}

cd /sys/devices
for F in $(find * -name 'wakeup')
do
	# F=.../power/wakeup
	read value < $F
	if [ "$value" = "" ]
	then
		continue
	fi

	# F=...
	F=$(dirname $(dirname $F))
	devtype $F

	# for each entry that actually supports wakeup, one line with:
	#  - device type (if recognized)
	#  - wake on/OFF
	#  - /sys/devices/... path
	case "$value" in
	"disabled")	echo "$type OFF $F" ;;
	"enabled")	echo "$type on  $F" ;;
	esac
done
