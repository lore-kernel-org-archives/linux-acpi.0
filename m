From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI trouble (AC module, etc.) with Toshiba 1115-S103
Date: Tue, 10 Dec 2002 10:23:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021210092357.GA29390@poup.poupinou.org>
References: <20021210065922.31967.qmail@web14512.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021210065922.31967.qmail-4GJ6zp1JX++A/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: NoZizzing OrDripping <nozizzingordripping-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 09, 2002 at 10:59:22PM -0800, NoZizzing OrDripping wrote:
> 
> Status report for Toshiba Satellite 1115-S103 laptop....
> 
> Just tried 2.4.20 + acpi-20021205-2.4.20.diff with a Toshiba Satellite
> 1115-s103 laptop (new model, BIOS is "first production release", dated
> 11/01/2002, street price is between $650 and $1000, depending on
> rebates).  Built it all-modular and with debug messages.
> 
> 	$ ls /lib/modules/*20/kernel/drivers/acpi
> 	ac.o  battery.o  button.o  fan.o  processor.o  thermal.o  toshiba_acpi.o
> 
> 	$ root modprobe battery; dmesg
> 	ACPI: Battery Slot [BAT1] (battery present)
> 
> The module loaded and the Gnome battery monitor seems to work.  Pulled
> AC power and watched battery drain down to 8%, then plugged AC back
> in and watched it recharge.
> 
> 	$ root modprobe ac; dmesg
> 
> 	exfldio-0122 [31] Ex_setup_region       : Field [ACPW] Base+Offset+Width 38+0+4 is beyond end of region [GPIO] (length 3B)
> 	psparse-1103: *** Error: Method execution failed [\_SB_.PCI0.LPCB.ACAD._PSR] (Node c1671948), AE_AML_REGION_LIMIT
> 	acpi_ac-0083 [15] acpi_ac_get_state     : Error reading AC Adapter state
> 

Known issue with most of the Toshiba Satellite series with a Phoenix
BIOS.  I guess that Toshiba (or in fact Compal) still don't
know how to debug correctly their ASLs.

You need a patched DSDT for this model.  Please send me your DSDT.
BTW, I think that my tosh3k kernel module at
ftp://ftp.poupinou.org/tosh_3000/
will work for you.  I am in process of rewrite it a little, then I think
that I can probably add your model if you agree.


[...]

> 	$ root modprobe toshiba_acpi
> 
> 	/lib/modules/2.4.20/kernel/drivers/acpi/toshiba_acpi.o: init_module: No such device
> 	Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.
> 	      You may find more information in syslog or the output from dmesg
> 	/lib/modules/2.4.20/kernel/drivers/acpi/toshiba_acpi.o: insmod /lib/modules/2.4.20/kernel/drivers/acpi/toshiba_acpi.o failed
> 	/lib/modules/2.4.20/kernel/drivers/acpi/toshiba_acpi.o: insmod toshiba_acpi failed

The toshiba acpi support would probably not work for you, because your BIOS is
a Phoenix one, not a Toshiba one.

> 
> Dunno if this was supposed to work or not.  The laptop has an extremely
> limited BIOS, you cannot change very much at all with it.

This is a 'legacy-free' bios...

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
