From: laclasse <laclasse-8pJrjL1qK2UoQmVLVEsOMtypXZDpriyu@public.gmane.org>
Subject: help on acpi irq routing
Date: Mon, 26 Jan 2004 03:51:40 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040126033708.B90099@zerv.internetcafe.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Currently running my custom 2.6.2-rc1-mm3 with the ACPI version 20040116
on a p4 HT ( SMP and SMT scheduler in mm kernel enabled ) on a Clevo
Laptop ( sager / eurocom / alienware ).

http://zerv.internetcafe.nl/~laclasse/dmesg
http://zerv.internetcafe.nl/~laclasse/interrupts
http://zerv.internetcafe.nl/~laclasse/dmidecode.txt

I boot with acpi=force and acpi_os_name="Microsoft Windows XP" as i
grepped my dissambled dsdt table and got the following statements:

 If (CondRefOf (_OS, Local0))
                    If (LEqual (SizeOf (_OS), 0x14))
                        If (LEqual (SizeOf (_OS), 0x27))
0x14 being 20, why is there a 0x27 statement ( 39 ) ?

using acpi for irq routing, i get the following when allocating the gfx
drm module:

[drm] Loading R200 Microcode
irq 17: nobody cared!
Call Trace:
 [<c010c582>] __report_bad_irq+0x2a/0x8b
 [<c010c66c>] note_interrupt+0x6f/0x9f
 [<c010c98a>] do_IRQ+0x161/0x192
 [<c02d7170>] common_interrupt+0x18/0x20
 [<c02d007b>] unix_create1+0x39/0x1a0

handlers:
[<e49447e0>] (snd_intel8x0_interrupt+0x0/0x263 [snd_intel8x0])
Disabling IRQ #17

The sound doesn't work in X ( loops and repeats ) and eventually dies.
Only work around this is using the pci=noacpi boot flag, then everything
works, and acpi reports temperature, throttling, ac only problem is a
significant increase in temperature ( 47/53 C idle vs 61/65 C ) and off
course the loud fan sound that goes with it. Any help appreciated.

Note that i have fixed my dsdt table and ready to upload it as soon as i
find out how to integrate it in the current acpi src i am running.

Thanks again.

laclasse.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
