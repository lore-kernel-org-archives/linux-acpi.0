From: Eric Valette <eric.valette-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH] fix IRQ / GPEs restore on wake
Date: Fri, 30 Apr 2004 21:50:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4092ADEF.2000505@free.fr>
References: <37F890616C995246BE76B3E6B2DBE05571657B@orsmsx403.amr.corp.intel.com>
Reply-To: eric.valette-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080202060402010207060602"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <37F890616C995246BE76B3E6B2DBE05571657B-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, a.malysh-1WJ9BOJEYl0b1SvskN2V4Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080202060402010207060602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Moore, Robert wrote:
> The next version of ACPI CA will better manage wake vs. run vs. wake/run
> GPEs and may handle this correctly without the change below.
> 
> Bob

OK. This was fair enough but as I have tried 2.6.6-rc3-mm1 that contains:

ACPI: Subsystem revision 20040326

I still says that the attached patch is indeed badly needed to fix bug 
described in <http://bugme.osdl.org/show_bug.cgi?id=2321>.

Now, as :

	1) this bug is open with several proposed patches for several kernel 
versions for more than a month and a half,
	2) that I never heard anything serious by ACPI developpers about 
possible issue of irq incorrectly restored because (at least on my ASUS 
L3800C) after executing of _WAK irq's are enabled, so stored gpe bits 
(before suspend) will be overwriten and not restored correctly while 
resume (bug analysis by Alexander Malysh),

I would _really_ like to have someone _really_ analyse what happens (I 
can put any trace in my kernel if you ask for it) and propose a better 
fix if this one is not the best way to fix it.

I suspect the problem exist on other systems but as only _few_ do 
correctly wakeup from S3, and even _less_ using dedicated ACPI buttons, 
they are just too many other bugs masking the importance of this one...

But not correctly restoring interrupt status is generally a good way to 
crash a system...

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette-GANU6spQydw@public.gmane.org




--------------080202060402010207060602
Content-Type: text/plain;
 name="acpi-irq-gpe-restore-on-wake.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-irq-gpe-restore-on-wake.txt"

--- a/drivers/acpi/hardware/hwsleep.c	2004-04-17 22:57:11.000000000 +0200
+++ b/drivers/acpi/hardware/hwsleep.c	2004-04-17 23:12:08.000000000 +0200
@@ -512,6 +512,16 @@ acpi_leave_sleep_state (

 	acpi_gbl_sleep_type_a = ACPI_SLEEP_TYPE_INVALID;

+	/*
+	 * Restore the GPEs:
+	 * 1) Disable all wakeup GPEs
+	 * 2) Enable all runtime GPEs
+	 */
+	status = acpi_hw_restore_gpes_on_wake ();
+	if (ACPI_FAILURE (status)) {
+		ACPI_REPORT_ERROR(("Could not enable non wakeup GPEs, %s\n",acpi_format_exception (status)));
+	}
+
 	/* Setup parameter object */

 	arg_list.count = 1;
@@ -538,16 +548,6 @@ acpi_leave_sleep_state (
 	}
 	/* TBD: _WAK "sometimes" returns stuff - do we want to look at it? */

-	/*
-	 * Restore the GPEs:
-	 * 1) Disable all wakeup GPEs
-	 * 2) Enable all runtime GPEs
-	 */
-	status = acpi_hw_restore_gpes_on_wake ();
-	if (ACPI_FAILURE (status)) {
-		return_ACPI_STATUS (status);
-	}
-
 	/* Enable power button */


acpi_set_register(acpi_gbl_fixed_event_info[ACPI_EVENT_POWER_BUTTON].enable_register_id,
--- a/drivers/acpi/sleep/main.c	2004-04-17 22:55:12.000000000 +0200
+++ b/drivers/acpi/sleep/main.c	2004-04-17 23:09:45.000000000 +0200
@@ -107,7 +107,6 @@ static int acpi_pm_enter(u32 state)
 	default:
 		return -EINVAL;
 	}
-	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");

 	/* restore processor state
@@ -118,6 +117,8 @@ static int acpi_pm_enter(u32 state)
 	if (state > PM_SUSPEND_STANDBY)
 		acpi_restore_state_mem();

+	acpi_leave_sleep_state(state);
+	local_irq_restore(flags);

 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
@@ -133,8 +134,6 @@ static int acpi_pm_enter(u32 state)

 static int acpi_pm_finish(u32 state)
 {
-	acpi_leave_sleep_state(state);
-
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);



--------------080202060402010207060602--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
