From: NoZizzing OrDripping <nozizzingordripping-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: ACPI trouble (AC module, etc.) with Toshiba 1115-S103
Date: Mon, 9 Dec 2002 22:59:22 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021210065922.31967.qmail@web14512.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2109705957-1039503562=:31169"
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

--0-2109705957-1039503562=:31169
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sorry, I have to send to this list from my Yahoo
account. Mail body attached as file to prevent wrap.

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
--0-2109705957-1039503562=:31169
Content-Type: text/plain; name="report1.txt"
Content-Description: report1.txt
Content-Disposition: inline; filename="report1.txt"


Status report for Toshiba Satellite 1115-S103 laptop....

Just tried 2.4.20 + acpi-20021205-2.4.20.diff with a Toshiba Satellite
1115-s103 laptop (new model, BIOS is "first production release", dated
11/01/2002, street price is between $650 and $1000, depending on
rebates).  Built it all-modular and with debug messages.

	$ ls /lib/modules/*20/kernel/drivers/acpi
	ac.o  battery.o  button.o  fan.o  processor.o  thermal.o  toshiba_acpi.o

	$ root modprobe battery; dmesg
	ACPI: Battery Slot [BAT1] (battery present)

The module loaded and the Gnome battery monitor seems to work.  Pulled
AC power and watched battery drain down to 8%, then plugged AC back
in and watched it recharge.

	$ root modprobe ac; dmesg

	exfldio-0122 [31] Ex_setup_region       : Field [ACPW] Base+Offset+Width 38+0+4 is beyond end of region [GPIO] (length 3B)
	psparse-1103: *** Error: Method execution failed [\_SB_.PCI0.LPCB.ACAD._PSR] (Node c1671948), AE_AML_REGION_LIMIT
	acpi_ac-0083 [15] acpi_ac_get_state     : Error reading AC Adapter state

The AC module gives the above error message.  No files appear under
/proc/acpi/ac_adapter.  The Gnome battery status monitor always
indicates the laptop is on battery power.

Interestingly enough, my only previous ACPI experience was with the
stock Redhat 2.4.18 kernel recompiled with non-modular ACPI turned on.
In that case, the AC status worked, but the battery status was flaky.

	$ root modprobe processor; dmesg

	ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)

	$ root modprobe button; dmesg

	ACPI: Power Button (FF) [PWRF]
	ACPI: Lid Switch [LID]

	$ root modprobe fan; dmesg

	[ no output]

	$ root modprobe thermal; dmesg

	[ no output]

Dunno if any of the above stuff works.

	$ root modprobe toshiba_acpi

	/lib/modules/2.4.20/kernel/drivers/acpi/toshiba_acpi.o: init_module: No such device
	Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.
	      You may find more information in syslog or the output from dmesg
	/lib/modules/2.4.20/kernel/drivers/acpi/toshiba_acpi.o: insmod /lib/modules/2.4.20/kernel/drivers/acpi/toshiba_acpi.o failed
	/lib/modules/2.4.20/kernel/drivers/acpi/toshiba_acpi.o: insmod toshiba_acpi failed

Dunno if this was supposed to work or not.  The laptop has an extremely
limited BIOS, you cannot change very much at all with it.


Fooled around abit, unloaded battery.o and tried to reload it,
but system locked up.

BTW, I am willing to try additional patches, etc, to help get ACPI
solid in general and specifically on this laptop.

-Rick


-- 
Rick Richardson  rickr-EySxSuIQeMUAvxtiuMwx3w@public.gmane.org        http://home.mn.rr.com/richardsons/
Stock information at your fingertips:   http://linuxtrade.0catch.com/

"@%#$^@&" - Ozzy Osbourne

--0-2109705957-1039503562=:31169--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
