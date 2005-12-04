From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: C-State policy and dynticks [Was: [PATCH] i386 no idle HZ aka Dynticks 051203]
Date: Sun, 4 Dec 2005 14:01:28 +0100
Message-ID: <20051204130128.GA9514@dominikbrodowski.de>
References: <200512041737.07996.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200512041737.07996.kernel-S9WDWIYMKk5AfugRpC6u6w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Con Kolivas <kernel-S9WDWIYMKk5AfugRpC6u6w@public.gmane.org>
Cc: linux kernel mailing list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ck list <ck-1Vlr8iRN5lTguvvKUr3tXg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, Daniel Petrini <d.pensator-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, vatsa-xthvdsQ13ZrQT0dZR+AlfA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Make the ACPI C-States policy smarter when dynticks are enabled:

- reprogram the timer if bus mastering activity is present, so that we don't
  sleep too long in C2, but hopefully can switch to C3 then.
- promote to a higher C-State more easily: if we slept for more than 2
  jiffies the last time, and we're intended to sleep for more than 2
  jiffies now, promote. This is justified as the current policy looks at
  whether we slept longer than a certain threshold for the last 4 or 10
  times; but we usually sleep much longer when dynticks are enabled.

Signed-off-by: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>

Index: working-tree/drivers/acpi/processor_idle.c
===================================================================
--- working-tree.orig/drivers/acpi/processor_idle.c
+++ working-tree/drivers/acpi/processor_idle.c
@@ -38,6 +38,7 @@
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>	/* need_resched() */
+#include <linux/dyn-tick.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -60,6 +61,8 @@ module_param(max_cstate, uint, 0644);
 static unsigned int nocst = 0;
 module_param(nocst, uint, 0000);
 
+#define BM_JIFFIES	(HZ >= 800 ? 4 : 2)
+
 /*
  * bm_history -- bit-mask with a bit per jiffy of bus-master activity
  * 1000 HZ: 0xFFFFFFFF: 32 jiffies = 32ms
@@ -177,6 +180,7 @@ static void acpi_safe_halt(void)
 }
 
 static atomic_t c3_cpu_count;
+static int last_sleep = 0;
 
 static void acpi_processor_idle(void)
 {
@@ -259,7 +263,7 @@ static void acpi_processor_idle(void)
 		 * If bus mastering is active, automatically demote
 		 * to avoid a faulty transition.  Note that the processor
 		 * won't enter a low-power state during this call (to this
-		 * funciton) but should upon the next.
+		 * function) but should upon the next.
 		 *
 		 * TBD: A better policy might be to fallback to the demotion
 		 *      state (use it for this quantum only) istead of
@@ -270,10 +274,31 @@ static void acpi_processor_idle(void)
 		if (bm_status && cx->demotion.threshold.bm) {
 			local_irq_enable();
 			next_state = cx->demotion.state;
+			if (dyn_tick_enabled())
+				dyn_early_reprogram(BM_JIFFIES);
+			last_sleep = 0; /* do not promote in fast-path */
+			goto end;
+		}
+	}
+
+	/*
+	 * Fast-path promotion: if we slept for more than 2 jiffies the last
+	 * time, and we're intended to sleep for more than 2 jiffies now,
+	 * promote. Note that the processor won't enter a low-power state
+	 * during this call (to this funciton) but should upon the next.
+	 */
+	if (dyn_tick_enabled()) {
+		if (cx->promotion.state && cx->promotion.count &&
+		    (last_sleep > BM_JIFFIES) &&
+		    (dyn_tick->skip > BM_JIFFIES)) {
+			local_irq_enable();
+			next_state = cx->promotion.state;
 			goto end;
 		}
 	}
 
+	last_sleep = 0;
+
 #ifdef CONFIG_HOTPLUG_CPU
 	/*
 	 * Check for P_LVL2_UP flag before entering C2 and above on
@@ -391,9 +416,10 @@ static void acpi_processor_idle(void)
 		cx->time += (PM_TIMER_FREQUENCY / (2 * HZ));
 	}
 
+	last_sleep = sleep_ticks / (PM_TIMER_FREQUENCY / HZ);
+
 	if (pr->flags.bm_check)
-		pr->power.bm_check_timestamp += sleep_ticks /
-			(PM_TIMER_FREQUENCY / HZ);
+		pr->power.bm_check_timestamp += last_sleep;
 
 	next_state = pr->power.state;
 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
