From: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
Subject: Re: Re: fix ACPI poweroff in 2.4.25-rc2
Date: Sat, 6 Mar 2004 12:01:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040306110105.GA7214@alpha.home.local>
References: <200403031117.25937.bjorn.helgaas@hp.com> <20040303194656.GV25779@parcelfarce.linux.theplanet.co.uk> <20040303202027.GA30084@alpha.home.local> <1078554086.12991.3191.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1078554086.12991.3191.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Mar 06, 2004 at 01:21:26AM -0500, Len Brown wrote:
> Willy,
> Zwane was right, set_cpus_allowed() fixes the SMP poweroff problem.  The
> patch is here:

Len, my last mail was totally stupid : my dual athlon uses APM to power off,
so the code was not even compiled ! And guess what ? it does not compile :-(
So please use this one instead, which compiles in 2.4 :

--- linux-2.4.25-wt3/drivers/acpi/system.c.old	Sat Mar  6 10:22:25 2004
+++ linux-2.4.25-wt3/drivers/acpi/system.c	Sat Mar  6 11:56:28 2004
@@ -40,6 +40,7 @@
 #include <asm/acpi.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <linux/sched.h>
 
 #ifdef CONFIG_X86
 #ifdef CONFIG_ACPI_SLEEP
@@ -95,6 +96,10 @@
 {
 	if (unlikely(in_interrupt())) 
 		BUG();
+#ifdef CONFIG_SMP
+	/* Some SMP machines only can poweroff in boot CPU */
+	set_cpus_allowed(current, 1 << cpu_logical_map(0));
+#endif
 	acpi_system_save_state(ACPI_STATE_S5);
 	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
 	ACPI_DISABLE_IRQS();

Now the SMP athlon *really* powers off with this code since APM is disabled.

Sorry for the confusion,
Willy



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
