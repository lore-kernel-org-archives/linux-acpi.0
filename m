From: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] processor: jiffies-based bm_check, bugfixes
Date: Thu, 23 Dec 2004 13:41:18 -0800
Message-ID: <20041223134118.A24497@unix-os.sc.intel.com>
References: <20041223201334.GA19292@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041223201334.GA19292-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>; from linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org on Thu, Dec 23, 2004 at 12:13:34PM -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



The patch below helps us maintain a proper bm_activity history. We monitor
the bm_activity every 10mS. Using the current 32 bit bm_activity we can store
the history of upto 320mS.

As Dominik pointed out, it has a disadvantage of adding some overhead, even
when CPU is not idle. But, the advantage is that it has a good bm_activity 
history for 320 mS, which can be useful in future, to have more fancier C-state
policies.

Thanks,
Venki

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

--- linux-2.6.10-rc3-cst/drivers/acpi/processor_idle.c.org	2004-12-23 12:48:01.000000000 -0800
+++ linux-2.6.10-rc3-cst/drivers/acpi/processor_idle.c	2004-12-23 15:59:35.000000000 -0800
@@ -36,6 +36,9 @@
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
 
+#include <linux/workqueue.h>
+#include <linux/compiler.h>
+
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
@@ -108,6 +111,121 @@ ticks_elapsed (
 }
 
 
+static void do_bm_check_timer(void *data);
+static DECLARE_MUTEX	(bm_check_sem);
+static DECLARE_WORK	(bm_check_work, do_bm_check_timer, NULL);
+
+#define BM_CHECK_START 	1
+#define BM_CHECK_STOP 	2
+
+#define BM_CHECK_RATE 	((HZ < 100) ? (1) : (HZ/100))
+
+u32
+acpi_get_bm_status (u32 clear_status)
+{
+	u32		bm_status = 0;
+
+	down(&bm_check_sem);
+	/*
+	 * Check for bus mastering activity
+	 */
+	acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, 
+		&bm_status, ACPI_MTX_DO_NOT_LOCK);
+	if (bm_status && clear_status) {
+		/* Clear BM status bit */
+		acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
+			1, ACPI_MTX_DO_NOT_LOCK);
+	}
+	
+	/*
+	 * PIIX4 Erratum #18: Note that BM_STS doesn't always reflect
+	 * the true state of bus mastering activity; forcing us to 
+	 * manually check the BMIDEA bit of each IDE channel.
+	 */
+	else if (errata.piix4.bmisx) {
+		if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01) 
+			|| (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
+			bm_status++;
+	}
+
+	up(&bm_check_sem);
+	return (bm_status);
+}
+
+void
+acpi_bm_activity_update (unsigned long cpu, unsigned long num_bits)
+{
+	struct acpi_processor	*pr = NULL;
+
+	pr = processors[cpu];
+	if (!pr)
+		return;
+
+	if (unlikely(num_bits > 32))
+		num_bits = 32;
+
+	/*
+	 * Check BM Activity
+	 * -----------------
+	 * Check for bus mastering activity (if required), record, and check
+	 * for demotion.
+	 */
+	if (pr->flags.bm_check) {
+		u32 status;
+		int i;
+		status = acpi_get_bm_status(1);
+		for (i = 0; i < num_bits; i++) {
+			pr->power.bm_activity <<= 1;
+			pr->power.bm_activity |= (status & 0x1);
+		}
+	}
+}		
+
+static void 
+do_bm_check_timer(void *data)
+{
+	static unsigned long last_jiffies;
+	unsigned long this_jiffies;
+	unsigned long i, num_bits;
+
+	/*
+	 * Number of bits in the history that we are going to update.
+	 * We want one bit per 10mS. So, if we are not called late, 
+	 * update that many bits in history.
+	 */
+	this_jiffies = jiffies;
+	num_bits = (this_jiffies/BM_CHECK_RATE) - (last_jiffies/BM_CHECK_RATE);
+
+	/*
+	 * It should be enough if we do this check on one CPU.
+	 * Do it only on current CPU for now.
+	 */
+	acpi_bm_activity_update(smp_processor_id(), num_bits);
+
+	last_jiffies = this_jiffies;
+	schedule_delayed_work(&bm_check_work, BM_CHECK_RATE);
+}
+
+static void
+setup_periodic_bm_status_check(int opt)
+{
+	static int bm_status_check_count;
+
+	if (opt == BM_CHECK_START)
+		bm_status_check_count++;
+	else if (opt == BM_CHECK_STOP)
+		bm_status_check_count--;
+
+	if (bm_status_check_count == 1) {
+		INIT_WORK(&bm_check_work, do_bm_check_timer, NULL);
+		schedule_work(&bm_check_work);
+	} else if (bm_status_check_count == 0) {
+		cancel_delayed_work(&bm_check_work);
+	}
+	return;
+}
+ 
+
 static void
 acpi_processor_power_activate (
 	struct acpi_processor	*pr,
@@ -188,27 +306,9 @@ static void acpi_processor_idle (void)
 	 * for demotion.
 	 */
 	if (pr->flags.bm_check) {
-		u32		bm_status = 0;
+		unsigned long bm_activity;
 
-		pr->power.bm_activity <<= 1;
-
-		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
-			&bm_status, ACPI_MTX_DO_NOT_LOCK);
-		if (bm_status) {
-			pr->power.bm_activity++;
-			acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
-				1, ACPI_MTX_DO_NOT_LOCK);
-		}
-		/*
-		 * PIIX4 Erratum #18: Note that BM_STS doesn't always reflect
-		 * the true state of bus mastering activity; forcing us to
-		 * manually check the BMIDEA bit of each IDE channel.
-		 */
-		else if (errata.piix4.bmisx) {
-			if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
-				|| (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
-				pr->power.bm_activity++;
-		}
+		bm_activity = pr->power.bm_activity | acpi_get_bm_status(0);
 		/*
 		 * Apply bus mastering demotion policy.  Automatically demote
 		 * to avoid a faulty transition.  Note that the processor
@@ -216,12 +316,12 @@ static void acpi_processor_idle (void)
 		 * funciton) but should upon the next.
 		 *
 		 * TBD: A better policy might be to fallback to the demotion
-		 *      state (use it for this quantum only) istead of
+		 *      state (use it for this quantum only) instead of
 		 *      demoting -- and rely on duration as our sole demotion
 		 *      qualification.  This may, however, introduce DMA
 		 *      issues (e.g. floppy DMA transfer overrun/underrun).
 		 */
-		if (pr->power.bm_activity & cx->demotion.threshold.bm) {
+		if (bm_activity & cx->demotion.threshold.bm) {
 			local_irq_enable();
 			next_state = cx->demotion.state;
 			goto end;
@@ -420,7 +520,7 @@ acpi_processor_set_power_policy (
 			cx->demotion.threshold.ticks = cx->latency_ticks;
 			cx->demotion.threshold.count = 1;
 			if (cx->type == ACPI_STATE_C3)
-				cx->demotion.threshold.bm = 0x0F;
+				cx->demotion.threshold.bm = 0x07;
 		}
 
 		/* from C3 we always demote to C2, even if there are multiple
@@ -443,7 +543,7 @@ acpi_processor_set_power_policy (
 			else
 				cx->promotion.threshold.count = 10;
 			if (higher->type == ACPI_STATE_C3)
-				cx->demotion.threshold.bm = 0x0F;
+				cx->demotion.threshold.bm = 0x07;
 		}
 
 		higher = cx;
@@ -710,6 +810,7 @@ static void acpi_processor_power_verify_
 	cx->valid = 1;
 	cx->latency_ticks = US_TO_PM_TIMER_TICKS(cx->latency);
 	pr->flags.bm_check = 1;
+	setup_periodic_bm_status_check(BM_CHECK_START);
 
 	return_VOID;
 }
@@ -985,5 +1086,8 @@ int acpi_processor_power_exit(struct acp
 		synchronize_kernel();
 	}
 
+	if (pr->flags.bm_check == 1)
+		setup_periodic_bm_status_check(BM_CHECK_STOP);
+
 	return_VALUE(0);
 }


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
