From: Alexander Malysh <a.malysh-1WJ9BOJEYl0b1SvskN2V4Q@public.gmane.org>
Subject: [PATCH] acpi_leave_sleep_state (was: [PATCH] Re: [BUG] acpi_hw_[enable|disable]_non_wakeup_gpe_block)
Date: Sun, 15 Feb 2004 23:12:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402152312.53837.a.malysh@centrium.de>
References: <200402142317.41033.a.malysh@centrium.de> <20040215200724.GN13262@poupinou.org> <200402152200.08010.a.malysh@centrium.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_l7+LAtNcIpHI3vj"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200402152200.08010.a.malysh-1WJ9BOJEYl0b1SvskN2V4Q@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_l7+LAtNcIpHI3vj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi again,

what are you think about attached patch?

Note: at least on my laptop gpes must be enabled before '_WAK' method 
execution, otherwise after '_WAK' was executed interrupts are enabled and gpe 
register were restored with wrong values...

@Karol: can you please get this patch a try?

On Sunday 15 February 2004 22:00, Alexander Malysh wrote:
> On Sunday 15 February 2004 21:07, you wrote:
> > On Sun, Feb 15, 2004 at 04:47:19PM +0100, Alexander Malysh wrote:
> > > Hi again,
> > >
> > > after some more testing, I have found a cause for this.
> > > We disable non wakeup gpes (and store those values) with interrupts
> > > disabled, but enable those with interrupts enabled which were already
> > > overwritten while handling of wakeup interrupt[1]. So we must restore
> > > non wakeup gpes as long interrupts are disabled. Attached patch should
> > > fix it.
> > >
> > >
> > > --- linux-2.6.2-linus/drivers/acpi/hardware/hwsleep.c~orig	2004-02-15
> > > 16:31:50.928455040 +0100 +++
> > > linux-2.6.2-linus/drivers/acpi/hardware/hwsleep.c	2004-02-15
> > > 16:35:30.030146520 +0100 @@ -342,6 +342,12 @@
> > >
> > >  	} while (!in_value);
> > >
> > > +	/* Enable non_wakeup_gpes as long interrupts are disabled */
> > > +	status = acpi_hw_enable_non_wakeup_gpes ();
> > > +	if (ACPI_FAILURE (status)) {
> > > +		return_ACPI_STATUS (status);
> > > +	}
> > > +
> > >  	return_ACPI_STATUS (AE_OK);
> >
> > First, this path is *never reached* for S3 and S4, so you break somehow
> > S3 and S4 in fact...
>
> hmm, where do we jump after wakeup from S3/S4 ?
>
> > Second, the path for which you remove the enable gpes is supposed to be
> > run with interrupt *dissabled*.  If that is not the case, then it is the
> > real bug in fact.
>
> as you can see from log (or in drivers/acpi/sleep/main.c)
> acpi_leave_sleep_state called with interrupts enabled.
> and you are right: acpi_leave_sleep_state _must_ be called with interrupts
> disabled, so no wonder why sleep/resume fail on many laptops :(
>
>
>
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


--Boundary-00=_l7+LAtNcIpHI3vj
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="acpi_leave_sleep_state.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acpi_leave_sleep_state.diff"

--- linux-2.6.2-linus/drivers/acpi/hardware/hwsleep.c~orig	2004-02-15 16:31:50.000000000 +0100
+++ linux-2.6.2-linus/drivers/acpi/hardware/hwsleep.c	2004-02-15 23:03:41.522301504 +0100
@@ -477,6 +477,11 @@
 
 	/* Ignore any errors from these methods */
 
+	status = acpi_hw_enable_non_wakeup_gpes ();
+	if (ACPI_FAILURE (status)) {
+		ACPI_REPORT_ERROR(("Could not enable non wakeup gpes, %s\n", acpi_format_exception (status)));
+	}
+
 	arg.integer.value = 0;
 	status = acpi_evaluate_object (NULL, "\\_SI._SST", &arg_list, NULL);
 	if (ACPI_FAILURE (status) && status != AE_NOT_FOUND) {
@@ -496,11 +501,6 @@
 
 	/* _WAK returns stuff - do we want to look at it? */
 
-	status = acpi_hw_enable_non_wakeup_gpes ();
-	if (ACPI_FAILURE (status)) {
-		return_ACPI_STATUS (status);
-	}
-
 	/* Enable BM arbitration */
 
 	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
--- linux-2.6.2-linus/drivers/acpi/sleep/main.c~orig	2004-02-15 23:03:49.543082160 +0100
+++ linux-2.6.2-linus/drivers/acpi/sleep/main.c	2004-02-15 23:04:14.258324872 +0100
@@ -107,7 +107,6 @@
 	default:
 		return -EINVAL;
 	}
-	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
 
 	/* restore processor state
@@ -118,6 +117,8 @@
 	if (state > PM_SUSPEND_STANDBY)
 		acpi_restore_state_mem();
 
+	acpi_leave_sleep_state(state);
+	local_irq_restore(flags);
 
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
@@ -133,8 +134,6 @@
 
 static int acpi_pm_finish(u32 state)
 {
-	acpi_leave_sleep_state(state);
-
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 

--Boundary-00=_l7+LAtNcIpHI3vj--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
