From: David Douard <douard-nJJpUPIbDOA@public.gmane.org>
Subject: fan behaviour
Date: Fri, 13 Dec 2002 19:12:51 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212131912.53851.douard@magic.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
there have been quite a long time since I've played wit ACPI on my Compaq=
 Evo=20
N150...
Remember that I nedd a pached DSDT to get many things to work (bat, proce=
ssor=20
C states etc.).

I used to have pb with fans : they where not autmatically turned on/off=20
according to CPU temperature. Thus I made a little daemon to hold that.
But then I tried a nex ACPI version (one month or two ago), and I realize=
d=20
that fan where handled fine. But this was with the original DSDT.
I recompiled the kernel with my DSDT. And then fans where not handled.

So I compiled the lates acpi patch on a 2.4.20. And I realized that I can=
 make=20
automatic fan handling if I play with the=20
/proc/acpi/thermal_zone/THRM/cooling_mode.
The things I have to do so are quite esoteric : set passive cooling mode,=
 make=20
cpu hot (reach the trip point); then set active cooling mode. (well I gue=
ss=20
the manipulation is that, I'm not very sure).
Then, the fans are nicely handled.

This sound very strange to me, and my question is this : does anyone have=
 any=20
idea on if that may come from ACPI CA (the AML interpreter maybe), or fro=
m=20
the DSDT code which (I know) is bugged.

Note too another strange thing (I made it twice) :
I set (in single user mode) the cooling mode to passive and then lauch a=20
little cpuburner program. Throttling started to increase while temperatur=
e=20
reach the passive trip point (this is the first time I see throttling=20
working. It used to hang the machine if I try to change its value).=20
But when I killed  the cpuburner process, it hanged the machine !

Thanks for any tip !
=09David Douard



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
