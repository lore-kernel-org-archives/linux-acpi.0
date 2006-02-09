From: Johannes Becker <jonnybecker@web.de>
Subject: Newbie: ACPI dsdt.dsl Compilation Error
Date: Thu, 09 Feb 2006 13:21:16 +0100
Message-ID: <43EB33BC.7010706@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060508030701080401050606"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp07.web.de ([217.72.192.225]:23738 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S1422882AbWBIMVY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2006 07:21:24 -0500
Received: from [84.153.55.138] (helo=[192.168.178.21])
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.105 #340)
	id 1F7Ana-0000Cf-00
	for linux-acpi@vger.kernel.org; Thu, 09 Feb 2006 13:21:22 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060508030701080401050606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

Hi,

OS: openSUSE 10.0

I've got a Medion MD40100 Notebook. It has a Intel Mobile Pentium 4 2,8
GHz.

I think my ACPI isn't running right. The FAN is running constantly at a
high level, can't set trip_points, etc..
Searching for the error I found this in ACPI-Watch

Code:
acpi watch 0.75
(C) 2002 Oliver Diedrich

System information

System:   (null) (null) ((null)); serial #: (null)
BIOS:   (null) (null) ((null))
Board:   (null) (null) ((null)); serial #: (null)
CPU:   (null) Mobile Intel(R) Pentium(R) 4     CPU 2.80GHz, 2793 MHz
RAM:   896 MByte
Kernel:   Linux 2.6.13-15.7-default for i686 (build #1 Tue Nov 29
14:32:29 UTC 2005)
ACPI:   release 20050408

ACPI related syslog messages:

...

/proc/acpi/fan

/proc/acpi/thermal_zone/THM0/polling_frequency
( 2/09/06  2:07:40)   polling frequency:   2 seconds

/proc/acpi/thermal_zone/THM0/cooling_mode
( 2/09/06  2:07:40)   <setting not supported>
( 2/09/06  2:07:40)   cooling mode:   critical

/proc/acpi/thermal_zone/THM0/trip_points
( 2/09/06  2:07:40)   critical (S5):   90 C

/proc/acpi/thermal_zone/THM0/temperature
( 2/09/06  2:07:40)   temperature:   44 C
...

/proc/acpi/thermal_zone/THM0/state
( 2/09/06  2:07:40)   state:   ok

...

/proc/acpi/event
( 2/09/06  2:07:40)   ### read error ###

/proc/acpi/fadt
( 2/09/06  2:07:40)   ### read error ###

/proc/acpi/dsdt
( 2/09/06  2:07:40)   ### read error ###

/proc/acpi/info
( 2/09/06  2:07:40)   version:   20050408
...

So the dsdt can't be read (because it's probably broken. Following the
instructions from a page
(http://lists.suse.com/archive/suse-laptop/2005-Jan/0273.html) I did the
following in the command line:

1) cp /proc/acpi/dsdt /tmp
2) cd /tmp
3) iasl -d dsdt
4) iasl -sa dsdt.dsl


Now I get 6 errors on point 4):

linux:/tmp # iasl -sa dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20050902 [Sep  9 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

dsdt.dsl   193:     Field (PORT, WordAcc, NoLock, Preserve)
Error    1025 -               ^ Access width is greater than region size

dsdt.dsl   195:         P80H,   8
Error    1026 -            ^ Access width of Field Unit extends beyond
region limit

dsdt.dsl  1010:                     Field (EVGR, DWordAcc, NoLock, Preserve)
Error    1025 -                               ^ Access width is greater
than region size

dsdt.dsl  1012:                         EVID,   16
Error    1026 -                            ^ Access width of Field Unit
extends beyond region limit

dsdt.dsl  3304:                             While (Local1)
Error    1048 -                                         ^ Method local
variable is not initialized (Local1)

dsdt.dsl  4952:     Method (_WAK, 1, NotSerialized)
Warning  2078 -                ^ Reserved method must return a value (_WAK)

dsdt.dsl  4977:                 Store (\TRAW (), Local0)
Error    1058 -                            ^ Called method returns no value

ASL Input:  dsdt.dsl - 4988 lines, 173086 bytes, 2311 keywords
Compilation complete. 6 Errors, 1 Warnings, 0 Remarks, 492 Optimizations

Since I'm a newbie and these errors don't tell me nothing:
Can anybody help me correct these errors?

Cheers
Jonny

--------------060508030701080401050606
Content-Type: text/x-vcard; charset=utf-8;
 name="jonnybecker.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="jonnybecker.vcf"

begin:vcard
fn:Johannes Becker
n:Becker;Johannes
adr;quoted-printable:;;Theresienstr.27;M=C3=BCnchen;Bayern;80333;Deutschland
email;internet:jonnybecker@web.de
tel;home:+498950005858
tel;cell:+491774566435
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------060508030701080401050606--
