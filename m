From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Wrong button event reported when waking up from S1
Date: Wed, 16 Apr 2003 14:42:17 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8427228F@pdsmsx403.ccr.corp.intel.com>
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
To: stef <stef-listes-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Give me=20
1)	boot log
2)	/proc/acpi/dsdt
3)	lspci -v
4)	/proc/interrupts
5)	the machine name, motherboard name ..,

Thanks,
Luming

-----Original Message-----
From: stef [mailto:stef-listes-39ZsbGIQGT5GWvitb5QawA@public.gmane.org]
Sent: 2003?4?5? 23:40
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] Wrong button event reported when waking up from S1


        Hello,

        I have a problem with 2.4.21pre6+acpi 20030328, when I do
'echo -n 1 >/proc/acpi/sleep' and wake my laptop with the sleep
button, acpi gives a power button (PWRF) event instead of a sleep
button event (SBTN).

cat /proc/acpi/event
button/power PWRF 00000080 00000007
button/power PWRF 00000080 00000008
button/power PWRF 00000080 00000009
button/power PWRF 00000080 0000000a
button/power PWRF 00000080 0000000b
button/power PWRF 00000080 0000000c
button/power PWRF 00000080 0000000d
button/power PWRF 00000080 0000000e
button/power PWRF 00000080 0000000f
button/power PWRF 00000080 00000010
button/power PWRF 00000080 00000011
button/power PWRF 00000080 00000012
button/sleep SBTN 00000080 0000001a <- last button pressed before=20
entering S1
button/power PWRF 00000080 00000013 <- event reported

from dmesg:

[ACPI Debug] String: __________________________________
[ACPI Debug] String:
[ACPI Debug] String: Sleep button be pressed: -----
[ACPI Debug] String: __________________________________
 hwsleep-0257 [75] acpi_enter_sleep_state: Entering sleep state [S1]
[ACPI Debug] String: Wake up
   evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for =

GPE[D1], disabling event
   evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for =

GPE[12], disabling event
   evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for =

GPE[13], disabling event
   evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for =

GPE[30], disabling event
   evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for =

GPE[11], disabling event

Regards,
    Stef



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb:=20
Dedicated Hosting for just $79/mo with 500 GB of bandwidth!=20
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
