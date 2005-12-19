From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: ACPI C-States [Was: Re: [PATCH] i386 No Idle HZ aka dynticks
	051217]
Date: Mon, 19 Dec 2005 01:10:50 +0100
Message-ID: <20051219001050.GA10777@isilmar.linta.de>
References: <200512190219.40631.kernel@kolivas.org>
	<200512190222.40399.kernel@kolivas.org>
	<200512190934.51210.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ck-bounces@vds.kolivas.org>
Content-Disposition: inline
In-Reply-To: <200512190934.51210.kernel@kolivas.org>
List-Unsubscribe: <http://bhhdoa.org.au/mailman/listinfo/ck>,
	<mailto:ck-request@vds.kolivas.org?subject=unsubscribe>
List-Archive: <http://bhhdoa.org.au/pipermail/ck>
List-Post: <mailto:ck@vds.kolivas.org>
List-Help: <mailto:ck-request@vds.kolivas.org?subject=help>
List-Subscribe: <http://bhhdoa.org.au/mailman/listinfo/ck>,
	<mailto:ck-request@vds.kolivas.org?subject=subscribe>
Sender: ck-bounces@vds.kolivas.org
Errors-To: ck-bounces@vds.kolivas.org
To: Con Kolivas <kernel@kolivas.org>, acpi-devel@lists.sourceforge.net
Cc: vatsa@in.ibm.com, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Daniel Petrini <d.pensator@gmail.com>, linux kernel mailing list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>, Adam Belay <abelay@novell.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-acpi@vger.kernel.org

A few improvements and bugfixes to the ACPI C-States management based on
what's already in your dyn-tick patchset:
- last_sleep needs to be per-CPU
- cx->time for C1-type sleep is meaningless, remove support for it.
- Add a fast-path demotion: if dynticks are enabled, we can relax a bit
  and use a more responsive sleep type if we're going to sleep only
  for a short period of time (<1 tick), as long as we get back to deep
  sleep soon (quick_promotion).

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Index: working-tree/drivers/acpi/processor_idle.c
===================================================================
--- working-tree.orig/drivers/acpi/processor_idle.c
+++ working-tree/drivers/acpi/processor_idle.c
@@ -180,7 +180,6 @@ static void acpi_safe_halt(void)
 }
 
 static atomic_t c3_cpu_count;
-static int last_sleep = 0;
 
 static void acpi_processor_idle(void)
 {
@@ -277,28 +276,55 @@ static void acpi_processor_idle(void)
 			next_state = cx->demotion.state;
 			if (dyn_tick_enabled())
 				dyn_early_reprogram(BM_JIFFIES);
-			last_sleep = 0; /* do not promote in fast-path */
+			/* do not promote in fast-path */
+			pr->power.last_sleep = 0;
 			goto end;
 		}
 	}
 
 	/*
-	 * Fast-path promotion: if we slept for more than 2 jiffies the last
-	 * time, and we're intended to sleep for more than 2 jiffies now,
-	 * promote. Note that the processor won't enter a low-power state
-	 * during this call (to this funciton) but should upon the next.
+	 * Some special policy tweaks for dynamic ticks
 	 */
 	if (dyn_tick_enabled()) {
+		/*
+		 * Fast-path promotion: if we slept for more than 2 jiffies the
+		 * last time, and we're intended to sleep for more than 2
+		 * jiffies now, promote. Note that the processor won't enter a
+		 * low-power state during this call (to this funciton) but
+		 * should upon the next.
+		 */
 		if (cx->promotion.state && cx->promotion.count &&
-		    (last_sleep > BM_JIFFIES) &&
+		    (dyn_tick->next_tick > jiffies) &&
+		    ((pr->power.last_sleep >
+		      (BM_JIFFIES * cx->promotion.threshold.ticks)) ||
+		     (pr->power.quick_promotion == 1)) &&
 		    (dyn_tick->skip > BM_JIFFIES)) {
 			local_irq_enable();
 			next_state = cx->promotion.state;
 			goto end;
 		}
+
+
+		/*
+		 * Fast-path demotion: if we're going to sleep for only one
+		 * jiffy, and we'd enter C3-type sleep, and the wakeup latency
+		 * is high, don't use C3-type sleep but (temporarily) C2.
+		 */
+		if (cx->demotion.state && cx->demotion.threshold.bm &&
+		    (dyn_tick->next_tick < (jiffies + 1))
+		    && (cx->latency > 150)) {
+			local_irq_enable();
+			next_state = cx->demotion.state;
+
+			/* don't do a fast-path promotion next time... */
+			pr->power.last_sleep = 0;
+			/* ... but thereafter. */
+			pr->power.quick_promotion = 2;
+			goto end;
+		}
 	}
 
-	last_sleep = 0;
+	pr->power.last_sleep = 0;
 
 #ifdef CONFIG_HOTPLUG_CPU
 	/*
@@ -411,19 +437,18 @@ static void acpi_processor_idle(void)
 	if (cx->type != ACPI_STATE_C1) {
 		if (sleep_ticks > 0)
 			cx->time += sleep_ticks;
-	} else {
-		/* for C1, where we don't know the exact value, assume 0.5 of
-		 * a jiffy */
-		cx->time += (PM_TIMER_FREQUENCY / (2 * HZ));
 	}
 
-	last_sleep = sleep_ticks / (PM_TIMER_FREQUENCY / HZ);
+	pr->power.last_sleep = sleep_ticks / (PM_TIMER_FREQUENCY / HZ);
 
 	if (pr->flags.bm_check)
-		pr->power.bm_check_timestamp += last_sleep;
+		pr->power.bm_check_timestamp += pr->power.last_sleep;
 
 	next_state = pr->power.state;
 
+	if (pr->power.quick_promotion)
+		pr->power.quick_promotion--;
+
 	/*
 	 * Promotion?
 	 * ----------
Index: working-tree/include/acpi/processor.h
===================================================================
--- working-tree.orig/include/acpi/processor.h
+++ working-tree/include/acpi/processor.h
@@ -61,6 +61,8 @@ struct acpi_processor_power {
 	unsigned long bm_check_timestamp;
 	u32 default_state;
 	u32 bm_activity;
+	u16 last_sleep;
+	u16 quick_promotion;
 	int count;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
 
