From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi on toshiba satellite 1625CDT
Date: Wed, 16 Apr 2003 16:29:16 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F84272293@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mark Stocker <pezed-K4nppHclNNFeoWH0uzbU5w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Your dmesg output doesn't provide any clue to root cause of your issue.
Can you turn on debug option of ACPI, and collect debug message of
1). boot time=20
2)  run time when you echo -n 3 > /proc/acpi/fan/PFAN/state

/proc/acpi/dsdt is also needed.

Thanks,
Luming

-----Original Message-----
From: Mark Stocker [mailto:pezed-K4nppHclNNFeoWH0uzbU5w@public.gmane.org]
Sent: 2003?3?10? 17:04
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] acpi on toshiba satellite 1625CDT


I've been trying for about a week now to get acpi working properly on =
this=20
machine (using 2.4.21-pre5 and the latest acpi patch) but im just not =
having=20
much luck.  The annoying problem is the fan.  The fan comes on as it =
should,=20
but then it will never go off again. The fan is "detected" and shows up =
under=20
/proc/acpi/fan/FAN/ and under /proc/acpi/power_resource/PFAN/.  Both of =
these=20
directories have a "state" file which show:

mark@lappy /proc/acpi/fan/FAN]$ cat state
status:                  off

[mark@lappy /proc/acpi/power_resource/PFAN]$ cat state
state:                   off
system level:            S0
order:                   0
reference count:         0

"echo 0 > /proc/acpi/fan/FAN/state" shows the following:
acpi_power-0363 [50] acpi_power_transition : Error transitioning device =
[FAN]=20
to D0
acpi_bus-0496 [49] acpi_bus_set_power    : Error transitioning device =
[FAN] to=20
D0

"echo 1 > /proc/acpi/fan/FAN/state" shows:

acpi_bus-0447 [49] acpi_bus_set_power    : Device does not support D1

/proc/acpi/power_resouce/PFAN isnt writable.

cat /proc/acpi/event will properly show when the lid switch or power =
button is=20
pressed.
battery info doesnt appear to be read correctly as it shows a battery =
even=20
when i remove the battery. (doesnt bother me)

thermal info appears to be read correctly (temp goes up and down with =
system=20
load).

the fan problem is the only thing that is really bothering me (the fan =
is=20
loud!!).  i've tried to create my own dsdt file with no luck.  in the =
stock=20
dsdt file Device(FAN) appears to be an alias to PowerResource PFAN.
i've searched the net over and cant seem to find any info on this laptop =
and=20
acpi.  :(
any help or tips would be greatly appreciated!
thanks!


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
