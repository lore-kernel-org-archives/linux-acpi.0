From: Eric Valette <eric.valette-GANU6spQydw=@public.gmane.org>
Subject: Re: [PATCH] fix IRQ / GPEs restore on wake
Date: Sun, 18 Apr 2004 14:29:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <408274B5.9080806@free.fr>
References: <20040417215139.GA17862@hell.org.pl>
Reply-To: eric.valette-GANU6spQydw=@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040417215139.GA17862-DETuoxkZsSqrDJvtcaxF/A==@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA==@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg==@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Robert.Moore-ral2JQCrhuEAvxtiuMwx3w==@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


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
+		ACPI_REPORT_ERROR(("Could not enable non wakeup GPEs, %s\n", 
acpi_format_exception (status)));
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




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
