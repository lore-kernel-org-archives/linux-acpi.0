From: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] ACPI poweroff fixes for 2.4.26-pre2
Date: Fri, 26 Mar 2004 06:55:47 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040326055547.GA26599@alpha.home.local>
References: <20040309233325.GA22953@alpha.home.local> <1079279490.10225.10.camel@darkstar> <20040315210729.GA19306@alpha.home.local> <1079389434.3695.2.camel@darkstar> <20040315231927.GA19829@alpha.home.local> <20040322105946.GC1505@openzaurus.ucw.cz> <1080253327.3755.20.camel@darkstar> <20040325222934.GF2179@elf.ucw.cz> <1080255058.4187.1.camel@darkstar> <20040325230037.GK2179@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040325230037.GK2179-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Pavel,

On Fri, Mar 26, 2004 at 12:00:37AM +0100, Pavel Machek wrote:
> Hi!
> 
> > so acpi_system_save_state(state) does do nothing at all ?
> > or does return nothing at all ?
> 
> IIRC there was patch that made acpi_system_save_state() do nothing at
> all if !CONFIG_ACPI_SLEEP. I'm arguing thats very wrong.

I 100% agree that it's dirty to call a fake function instead of not
calling it at all. Indeed, one of my proposed patches removed the
dependency on CONFIG_ACPI_SLEEP through a simple replacement of
acpi_system_save_state() with two calls to pm_send_all() which does
not depend on CONFIG_ACPI_SLEEP. I believe it was cleaner, but it's
not what is included in BK right now... Here it is for reference.

Regards,
Willy

--- linux-2.4.26-pre3-acpi/drivers/acpi/system.c	Mon Mar 15 21:54:55 2004
+++ linux-2.4.26-pre3-acpi-pwoff/drivers/acpi/system.c	Mon Mar 15 21:57:32 2004
@@ -46,13 +46,6 @@
 #include <linux/mc146818rtc.h>
 #include <linux/irq.h>
 #include <asm/hw_irq.h>
-
-acpi_status acpi_system_save_state(u32);
-#else
-static inline acpi_status acpi_system_save_state(u32 state)
-{
-	return AE_OK;
-}
 #endif /* !CONFIG_ACPI_SLEEP */
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
@@ -102,7 +95,8 @@
 		BUG();
 	/* Some SMP machines only can poweroff in boot CPU */
 	set_cpus_allowed(current, 1UL << cpu_logical_map(0));
-	acpi_system_save_state(ACPI_STATE_S5);
+	pm_send_all(PM_SAVE_STATE, (void *)3);
+	pm_send_all(PM_SUSPEND, (void *)3);
 	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
 	ACPI_DISABLE_IRQS();
 	acpi_enter_sleep_state(ACPI_STATE_S5);




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
