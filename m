From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M6800N: battery0 not present
Date: Thu, 04 Mar 2004 15:12:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4047395D.6000500@pca.it>
References: <40324F44.60006@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40324F44.60006-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Yannick Chabanois <ycarus-nMPBK4rpgxgiq3RsQ1AnAw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I found on Jan Philipp Giel report
	http://fsai.fh-trier.de/~gielj/M6800N/
a new DSDT which solve the battery problem with the new BIOS 0205A. This new
DSDT was hacked by Ycarus, here the first lines from the .dsl version:
=====
/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20030918
 *
 * Disassembly of dsdt.dat, Tue Mar  2 23:05:23 2004
 *
 * Modified version of DSDT from Asus M6800N bios version 0205A
 * This version now report battery state under Linux.
 * Bug : Ac_adapter state is always off-line
 * Modified version by Ycarus (Yannick Chabanois)
 * chabanois(at)ifrance.com
 *
 */
=====

I just tried it on 2.6.3 + ACPI 20040220 + ACPI DSDT in initrd 2.6.1 and now the
battery0 is read correctly:
=====
luca-HSB4nKSusd8@public.gmane.org:~$ dmesg | grep battery
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
luca-HSB4nKSusd8@public.gmane.org:~$ cat /proc/acpi/battery/BAT0/alarm
alarm:                   unsupported
luca-HSB4nKSusd8@public.gmane.org:~$ cat /proc/acpi/battery/BAT0/info
present:                 yes
design capacity:         4300 mAh
last full capacity:      4300 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 130 mAh
design capacity low:     21 mAh
capacity granularity 1:  52 mAh
capacity granularity 2:  2418 mAh
model number:            M6N
serial number:           00001
battery type:            LIon
OEM info:                ASUSTek
luca-HSB4nKSusd8@public.gmane.org:~$ cat /proc/acpi/battery/BAT0/state [if on AC mode]
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            unknown
remaining capacity:      4456 mAh
present voltage:         16649 mV
luca-HSB4nKSusd8@public.gmane.org:~$ cat /proc/acpi/battery/BAT0/state [if on battery mode]
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            1320 mA
remaining capacity:      4455 mAh
present voltage:         16406 mV
luca-HSB4nKSusd8@public.gmane.org:~$
=====

IMHO someone should send this hacked DSDT to ASUS in order to have a new BIOS
version which doesn't need an hacked DSDT, am I right? Could this be useful?

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFARzlZVAp7Xm10JmkRAqyEAJ9G4G3Yv83nHaGoqmTSa9RQW0t+uACgjexW
oIriGQXghKzcdpHEAfDgxGk=
=0n5Z
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
