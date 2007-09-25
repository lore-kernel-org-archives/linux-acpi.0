From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Retain old acpi policy for !CONFIG_CPU_IDLE
Date: Tue, 25 Sep 2007 18:13:16 -0400
Message-ID: <200709251813.16935.lenb@kernel.org>
References: <20070913204005.GB1183@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44879 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273AbXIYWNd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Sep 2007 18:13:33 -0400
In-Reply-To: <20070913204005.GB1183@linux-os.sc.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-acpi@vger.kernel.org, abelay@novell.com

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Retain the old policy in processor_idle, so that when CPU_IDLE is not
configured, old C-state policy will still be used. This provides a
clean gradual migration path from old acpi policy to new cpuidle
based policy.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
Okay, here's a refreshed version that applies cleanly on top of the
existing 2.6.22 cpuidle series.

 processor_idle.c |  618 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 616 insertions(+), 2 deletions(-)

Index: acpi/drivers/acpi/processor_idle.c
===================================================================
--- acpi.orig/drivers/acpi/processor_idle.c
+++ acpi/drivers/acpi/processor_idle.c
@@ -64,14 +64,20 @@
 ACPI_MODULE_NAME("processor_idle");
 #define ACPI_PROCESSOR_FILE_POWER	"power"
 #define PM_TIMER_TICKS_TO_US(p)		(((p) * 1000)/(PM_TIMER_FREQUENCY/1000))
-#define C2_OVERHEAD			1	/* 1us */
-#define C3_OVERHEAD			1	/* 1us */
 
 static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
 module_param(max_cstate, uint, 0000);
 static unsigned int nocst __read_mostly;
 module_param(nocst, uint, 0000);
 
+#ifndef CONFIG_CPU_IDLE
+
+#define US_TO_PM_TIMER_TICKS(t)		((t * (PM_TIMER_FREQUENCY/1000)) / 1000)
+
+static int acpi_processor_set_power_policy(struct acpi_processor *pr);
+
+#endif
+
 /*
  * IBM ThinkPad R40e crashes mysteriously when going into C2 or C3.
  * For now disable this. Probably a bug somewhere else.
@@ -446,7 +452,12 @@ static void acpi_processor_power_verify_
 	 * Normalize the C2 latency to expidite policy
 	 */
 	cx->valid = 1;
+
+#ifdef CONFIG_CPU_IDLE
 	cx->latency_ticks = cx->latency;
+#else
+	cx->latency_ticks = US_TO_PM_TIMER_TICKS(cx->latency);
+#endif
 
 	return;
 }
@@ -520,7 +531,12 @@ static void acpi_processor_power_verify_
 	 * use this in our C3 policy
 	 */
 	cx->valid = 1;
+
+#ifdef CONFIG_CPU_IDLE
 	cx->latency_ticks = cx->latency;
+#else
+	cx->latency_ticks = US_TO_PM_TIMER_TICKS(cx->latency);
+#endif
 
 	return;
 }
@@ -585,6 +601,20 @@ static int acpi_processor_get_power_info
 
 	pr->power.count = acpi_processor_power_verify(pr);
 
+#ifndef CONFIG_CPU_IDLE
+	/*
+	 * Set Default Policy
+	 * ------------------
+	 * Now that we know which states are supported, set the default
+	 * policy.  Note that this policy can be changed dynamically
+	 * (e.g. encourage deeper sleeps to conserve battery life when
+	 * not on AC).
+	 */
+	result = acpi_processor_set_power_policy(pr);
+	if (result)
+		return result;
+#endif
+
 	/*
 	 * if one state of type C2 or C3 is available, mark this
 	 * CPU as being "idle manageable"
@@ -701,6 +731,11 @@ static inline u32 ticks_elapsed(u32 t1, 
 		return ((0xFFFFFFFF - t1) + t2);
 }
 
+#ifdef CONFIG_CPU_IDLE
+
+#define C2_OVERHEAD			1	/* 1us */
+#define C3_OVERHEAD			1	/* 1us */
+
 /**
  * acpi_idle_bm_check - checks if bus master activity was detected
  */
@@ -1049,6 +1084,552 @@ int acpi_processor_cst_has_changed(struc
 	return ret;
 }
 
+#else
+
+/*
+ * This code provides the older acpi behaviour when cpuidle is not configured.
+ * This will go away once CPU_IDLE has been fully integrated into the mainline
+ * kernel. -- Venki --
+ */
+#define C2_OVERHEAD			4	/* 1us (3.579 ticks per us) */
+#define C3_OVERHEAD			4	/* 1us (3.579 ticks per us) */
+static void (*pm_idle_save) (void) __read_mostly;
+
+/*
+ * bm_history -- bit-mask with a bit per jiffy of bus-master activity
+ * 1000 HZ: 0xFFFFFFFF: 32 jiffies = 32ms
+ * 800 HZ: 0xFFFFFFFF: 32 jiffies = 40ms
+ * 100 HZ: 0x0000000F: 4 jiffies = 40ms
+ * reduce history for more aggressive entry into C3
+ */
+static unsigned int bm_history __read_mostly =
+    (HZ >= 800 ? 0xFFFFFFFF : ((1U << (HZ / 25)) - 1));
+module_param(bm_history, uint, 0644);
+
+static void
+acpi_processor_power_activate(struct acpi_processor *pr,
+			      struct acpi_processor_cx *new)
+{
+	struct acpi_processor_cx *old;
+
+	if (!pr || !new)
+		return;
+
+	old = pr->power.state;
+
+	if (old)
+		old->promotion.count = 0;
+	new->demotion.count = 0;
+
+	/* Cleanup from old state. */
+	if (old) {
+		switch (old->type) {
+		case ACPI_STATE_C3:
+			/* Disable bus master reload */
+			if (new->type != ACPI_STATE_C3 && pr->flags.bm_check)
+				acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
+			break;
+		}
+	}
+
+	/* Prepare to use new state. */
+	switch (new->type) {
+	case ACPI_STATE_C3:
+		/* Enable bus master reload */
+		if (old->type != ACPI_STATE_C3 && pr->flags.bm_check)
+			acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
+		break;
+	}
+
+	pr->power.state = new;
+
+	return;
+}
+
+static void acpi_safe_halt(void)
+{
+	current_thread_info()->status &= ~TS_POLLING;
+	/*
+	 * TS_POLLING-cleared state must be visible before we
+	 * test NEED_RESCHED:
+	 */
+	smp_mb();
+	if (!need_resched())
+		safe_halt();
+	current_thread_info()->status |= TS_POLLING;
+}
+
+static atomic_t c3_cpu_count;
+
+/* Common C-state entry for C2, C3, .. */
+static void acpi_cstate_enter(struct acpi_processor_cx *cstate)
+{
+	if (cstate->space_id == ACPI_CSTATE_FFH) {
+		/* Call into architectural FFH based C-state */
+		acpi_processor_ffh_cstate_enter(cstate);
+	} else {
+		int unused;
+		/* IO port based C-state */
+		inb(cstate->address);
+		/* Dummy wait op - must do something useless after P_LVL2 read
+		   because chipsets cannot guarantee that STPCLK# signal
+		   gets asserted in time to freeze execution properly. */
+		unused = inl(acpi_gbl_FADT.xpm_timer_block.address);
+	}
+}
+
+static void acpi_processor_idle(void)
+{
+	struct acpi_processor *pr = NULL;
+	struct acpi_processor_cx *cx = NULL;
+	struct acpi_processor_cx *next_state = NULL;
+	int sleep_ticks = 0;
+	u32 t1, t2 = 0;
+
+	/*
+	 * Interrupts must be disabled during bus mastering calculations and
+	 * for C2/C3 transitions.
+	 */
+	local_irq_disable();
+
+	pr = processors[smp_processor_id()];
+	if (!pr) {
+		local_irq_enable();
+		return;
+	}
+
+	/*
+	 * Check whether we truly need to go idle, or should
+	 * reschedule:
+	 */
+	if (unlikely(need_resched())) {
+		local_irq_enable();
+		return;
+	}
+
+	cx = pr->power.state;
+	if (!cx) {
+		if (pm_idle_save)
+			pm_idle_save();
+		else
+			acpi_safe_halt();
+		return;
+	}
+
+	/*
+	 * Check BM Activity
+	 * -----------------
+	 * Check for bus mastering activity (if required), record, and check
+	 * for demotion.
+	 */
+	if (pr->flags.bm_check) {
+		u32 bm_status = 0;
+		unsigned long diff = jiffies - pr->power.bm_check_timestamp;
+
+		if (diff > 31)
+			diff = 31;
+
+		pr->power.bm_activity <<= diff;
+
+		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
+		if (bm_status) {
+			pr->power.bm_activity |= 0x1;
+			acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS, 1);
+		}
+		/*
+		 * PIIX4 Erratum #18: Note that BM_STS doesn't always reflect
+		 * the true state of bus mastering activity; forcing us to
+		 * manually check the BMIDEA bit of each IDE channel.
+		 */
+		else if (errata.piix4.bmisx) {
+			if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
+			    || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
+				pr->power.bm_activity |= 0x1;
+		}
+
+		pr->power.bm_check_timestamp = jiffies;
+
+		/*
+		 * If bus mastering is or was active this jiffy, demote
+		 * to avoid a faulty transition.  Note that the processor
+		 * won't enter a low-power state during this call (to this
+		 * function) but should upon the next.
+		 *
+		 * TBD: A better policy might be to fallback to the demotion
+		 *      state (use it for this quantum only) istead of
+		 *      demoting -- and rely on duration as our sole demotion
+		 *      qualification.  This may, however, introduce DMA
+		 *      issues (e.g. floppy DMA transfer overrun/underrun).
+		 */
+		if ((pr->power.bm_activity & 0x1) &&
+		    cx->demotion.threshold.bm) {
+			local_irq_enable();
+			next_state = cx->demotion.state;
+			goto end;
+		}
+	}
+
+#ifdef CONFIG_HOTPLUG_CPU
+	/*
+	 * Check for P_LVL2_UP flag before entering C2 and above on
+	 * an SMP system. We do it here instead of doing it at _CST/P_LVL
+	 * detection phase, to work cleanly with logical CPU hotplug.
+	 */
+	if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
+	    !pr->flags.has_cst && !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
+		cx = &pr->power.states[ACPI_STATE_C1];
+#endif
+
+	/*
+	 * Sleep:
+	 * ------
+	 * Invoke the current Cx state to put the processor to sleep.
+	 */
+	if (cx->type == ACPI_STATE_C2 || cx->type == ACPI_STATE_C3) {
+		current_thread_info()->status &= ~TS_POLLING;
+		/*
+		 * TS_POLLING-cleared state must be visible before we
+		 * test NEED_RESCHED:
+		 */
+		smp_mb();
+		if (need_resched()) {
+			current_thread_info()->status |= TS_POLLING;
+			local_irq_enable();
+			return;
+		}
+	}
+
+	switch (cx->type) {
+
+	case ACPI_STATE_C1:
+		/*
+		 * Invoke C1.
+		 * Use the appropriate idle routine, the one that would
+		 * be used without acpi C-states.
+		 */
+		if (pm_idle_save)
+			pm_idle_save();
+		else
+			acpi_safe_halt();
+
+		/*
+		 * TBD: Can't get time duration while in C1, as resumes
+		 *      go to an ISR rather than here.  Need to instrument
+		 *      base interrupt handler.
+		 *
+		 * Note: the TSC better not stop in C1, sched_clock() will
+		 *       skew otherwise.
+		 */
+		sleep_ticks = 0xFFFFFFFF;
+		break;
+
+	case ACPI_STATE_C2:
+		/* Get start time (ticks) */
+		t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
+		/* Tell the scheduler that we are going deep-idle: */
+		sched_clock_idle_sleep_event();
+		/* Invoke C2 */
+		acpi_state_timer_broadcast(pr, cx, 1);
+		acpi_cstate_enter(cx);
+		/* Get end time (ticks) */
+		t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
+
+#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86_TSC)
+		/* TSC halts in C2, so notify users */
+		mark_tsc_unstable("possible TSC halt in C2");
+#endif
+		/* Compute time (ticks) that we were actually asleep */
+		sleep_ticks = ticks_elapsed(t1, t2);
+
+		/* Tell the scheduler how much we idled: */
+		sched_clock_idle_wakeup_event(sleep_ticks*PM_TIMER_TICK_NS);
+
+		/* Re-enable interrupts */
+		local_irq_enable();
+		/* Do not account our idle-switching overhead: */
+		sleep_ticks -= cx->latency_ticks + C2_OVERHEAD;
+
+		current_thread_info()->status |= TS_POLLING;
+		acpi_state_timer_broadcast(pr, cx, 0);
+		break;
+
+	case ACPI_STATE_C3:
+		/*
+		 * disable bus master
+		 * bm_check implies we need ARB_DIS
+		 * !bm_check implies we need cache flush
+		 * bm_control implies whether we can do ARB_DIS
+		 *
+		 * That leaves a case where bm_check is set and bm_control is
+		 * not set. In that case we cannot do much, we enter C3
+		 * without doing anything.
+		 */
+		if (pr->flags.bm_check && pr->flags.bm_control) {
+			if (atomic_inc_return(&c3_cpu_count) ==
+			    num_online_cpus()) {
+				/*
+				 * All CPUs are trying to go to C3
+				 * Disable bus master arbitration
+				 */
+				acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1);
+			}
+		} else if (!pr->flags.bm_check) {
+			/* SMP with no shared cache... Invalidate cache  */
+			ACPI_FLUSH_CPU_CACHE();
+		}
+
+		/* Get start time (ticks) */
+		t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
+		/* Invoke C3 */
+		acpi_state_timer_broadcast(pr, cx, 1);
+		/* Tell the scheduler that we are going deep-idle: */
+		sched_clock_idle_sleep_event();
+		acpi_cstate_enter(cx);
+		/* Get end time (ticks) */
+		t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
+		if (pr->flags.bm_check && pr->flags.bm_control) {
+			/* Enable bus master arbitration */
+			atomic_dec(&c3_cpu_count);
+			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
+		}
+
+#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86_TSC)
+		/* TSC halts in C3, so notify users */
+		mark_tsc_unstable("TSC halts in C3");
+#endif
+		/* Compute time (ticks) that we were actually asleep */
+		sleep_ticks = ticks_elapsed(t1, t2);
+		/* Tell the scheduler how much we idled: */
+		sched_clock_idle_wakeup_event(sleep_ticks*PM_TIMER_TICK_NS);
+
+		/* Re-enable interrupts */
+		local_irq_enable();
+		/* Do not account our idle-switching overhead: */
+		sleep_ticks -= cx->latency_ticks + C3_OVERHEAD;
+
+		current_thread_info()->status |= TS_POLLING;
+		acpi_state_timer_broadcast(pr, cx, 0);
+		break;
+
+	default:
+		local_irq_enable();
+		return;
+	}
+	cx->usage++;
+	if ((cx->type != ACPI_STATE_C1) && (sleep_ticks > 0))
+		cx->time += sleep_ticks;
+
+	next_state = pr->power.state;
+
+#ifdef CONFIG_HOTPLUG_CPU
+	/* Don't do promotion/demotion */
+	if ((cx->type == ACPI_STATE_C1) && (num_online_cpus() > 1) &&
+	    !pr->flags.has_cst && !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED)) {
+		next_state = cx;
+		goto end;
+	}
+#endif
+
+	/*
+	 * Promotion?
+	 * ----------
+	 * Track the number of longs (time asleep is greater than threshold)
+	 * and promote when the count threshold is reached.  Note that bus
+	 * mastering activity may prevent promotions.
+	 * Do not promote above max_cstate.
+	 */
+	if (cx->promotion.state &&
+	    ((cx->promotion.state - pr->power.states) <= max_cstate)) {
+		if (sleep_ticks > cx->promotion.threshold.ticks &&
+		  cx->promotion.state->latency <= system_latency_constraint()) {
+			cx->promotion.count++;
+			cx->demotion.count = 0;
+			if (cx->promotion.count >=
+			    cx->promotion.threshold.count) {
+				if (pr->flags.bm_check) {
+					if (!
+					    (pr->power.bm_activity & cx->
+					     promotion.threshold.bm)) {
+						next_state =
+						    cx->promotion.state;
+						goto end;
+					}
+				} else {
+					next_state = cx->promotion.state;
+					goto end;
+				}
+			}
+		}
+	}
+
+	/*
+	 * Demotion?
+	 * ---------
+	 * Track the number of shorts (time asleep is less than time threshold)
+	 * and demote when the usage threshold is reached.
+	 */
+	if (cx->demotion.state) {
+		if (sleep_ticks < cx->demotion.threshold.ticks) {
+			cx->demotion.count++;
+			cx->promotion.count = 0;
+			if (cx->demotion.count >= cx->demotion.threshold.count) {
+				next_state = cx->demotion.state;
+				goto end;
+			}
+		}
+	}
+
+      end:
+	/*
+	 * Demote if current state exceeds max_cstate
+	 * or if the latency of the current state is unacceptable
+	 */
+	if ((pr->power.state - pr->power.states) > max_cstate ||
+		pr->power.state->latency > system_latency_constraint()) {
+		if (cx->demotion.state)
+			next_state = cx->demotion.state;
+	}
+
+	/*
+	 * New Cx State?
+	 * -------------
+	 * If we're going to start using a new Cx state we must clean up
+	 * from the previous and prepare to use the new.
+	 */
+	if (next_state != pr->power.state)
+		acpi_processor_power_activate(pr, next_state);
+}
+
+static int acpi_processor_set_power_policy(struct acpi_processor *pr)
+{
+	unsigned int i;
+	unsigned int state_is_set = 0;
+	struct acpi_processor_cx *lower = NULL;
+	struct acpi_processor_cx *higher = NULL;
+	struct acpi_processor_cx *cx;
+
+
+	if (!pr)
+		return -EINVAL;
+
+	/*
+	 * This function sets the default Cx state policy (OS idle handler).
+	 * Our scheme is to promote quickly to C2 but more conservatively
+	 * to C3.  We're favoring C2  for its characteristics of low latency
+	 * (quick response), good power savings, and ability to allow bus
+	 * mastering activity.  Note that the Cx state policy is completely
+	 * customizable and can be altered dynamically.
+	 */
+
+	/* startup state */
+	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
+		cx = &pr->power.states[i];
+		if (!cx->valid)
+			continue;
+
+		if (!state_is_set)
+			pr->power.state = cx;
+		state_is_set++;
+		break;
+	}
+
+	if (!state_is_set)
+		return -ENODEV;
+
+	/* demotion */
+	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
+		cx = &pr->power.states[i];
+		if (!cx->valid)
+			continue;
+
+		if (lower) {
+			cx->demotion.state = lower;
+			cx->demotion.threshold.ticks = cx->latency_ticks;
+			cx->demotion.threshold.count = 1;
+			if (cx->type == ACPI_STATE_C3)
+				cx->demotion.threshold.bm = bm_history;
+		}
+
+		lower = cx;
+	}
+
+	/* promotion */
+	for (i = (ACPI_PROCESSOR_MAX_POWER - 1); i > 0; i--) {
+		cx = &pr->power.states[i];
+		if (!cx->valid)
+			continue;
+
+		if (higher) {
+			cx->promotion.state = higher;
+			cx->promotion.threshold.ticks = cx->latency_ticks;
+			if (cx->type >= ACPI_STATE_C2)
+				cx->promotion.threshold.count = 4;
+			else
+				cx->promotion.threshold.count = 10;
+			if (higher->type == ACPI_STATE_C3)
+				cx->promotion.threshold.bm = bm_history;
+		}
+
+		higher = cx;
+	}
+
+	return 0;
+}
+
+int acpi_processor_cst_has_changed(struct acpi_processor *pr)
+{
+	int result = 0;
+
+
+	if (!pr)
+		return -EINVAL;
+
+	if (nocst) {
+		return -ENODEV;
+	}
+
+	if (!pr->flags.power_setup_done)
+		return -ENODEV;
+
+	/* Fall back to the default idle loop */
+	pm_idle = pm_idle_save;
+	synchronize_sched();	/* Relies on interrupts forcing exit from idle. */
+
+	pr->flags.power = 0;
+	result = acpi_processor_get_power_info(pr);
+	if ((pr->flags.power == 1) && (pr->flags.power_setup_done))
+		pm_idle = acpi_processor_idle;
+
+	return result;
+}
+
+#ifdef CONFIG_SMP
+static void smp_callback(void *v)
+{
+	/* we already woke the CPU up, nothing more to do */
+}
+
+/*
+ * This function gets called when a part of the kernel has a new latency
+ * requirement.  This means we need to get all processors out of their C-state,
+ * and then recalculate a new suitable C-state. Just do a cross-cpu IPI; that
+ * wakes them all right up.
+ */
+static int acpi_processor_latency_notify(struct notifier_block *b,
+		unsigned long l, void *v)
+{
+	smp_call_function(smp_callback, NULL, 0, 1);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block acpi_processor_latency_notifier = {
+	.notifier_call = acpi_processor_latency_notify,
+};
+
+#endif
+
+#endif
+
 int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
 			      struct acpi_device *device)
 {
@@ -1065,6 +1646,9 @@ int __cpuinit acpi_processor_power_init(
 			       "ACPI: processor limited to max C-state %d\n",
 			       max_cstate);
 		first_run++;
+#if !defined (CONFIG_CPU_IDLE) && defined (CONFIG_SMP)
+		register_latency_notifier(&acpi_processor_latency_notifier);
+#endif
 	}
 
 	if (!pr)
@@ -1088,10 +1672,12 @@ int __cpuinit acpi_processor_power_init(
 	 * platforms that only support C1.
 	 */
 	if ((pr->flags.power) && (!boot_option_idle_override)) {
+#ifdef CONFIG_CPU_IDLE
 		acpi_processor_setup_cpuidle(pr);
 		pr->power.dev.cpu = pr->id;
 		if (cpuidle_register_device(&pr->power.dev))
 			return -EIO;
+#endif
 
 		printk(KERN_INFO PREFIX "CPU%d (power states:", pr->id);
 		for (i = 1; i <= pr->power.count; i++)
@@ -1099,6 +1685,13 @@ int __cpuinit acpi_processor_power_init(
 				printk(" C%d[C%d]", i,
 				       pr->power.states[i].type);
 		printk(")\n");
+
+#ifndef CONFIG_CPU_IDLE
+		if (pr->id == 0) {
+			pm_idle_save = pm_idle;
+			pm_idle = acpi_processor_idle;
+		}
+#endif
 	}
 
 	/* 'power' [R] */
@@ -1118,12 +1711,33 @@ int __cpuinit acpi_processor_power_init(
 int acpi_processor_power_exit(struct acpi_processor *pr,
 			      struct acpi_device *device)
 {
+#ifdef CONFIG_CPU_IDLE
 	if ((pr->flags.power) && (!boot_option_idle_override))
 		cpuidle_unregister_device(&pr->power.dev);
+#endif
 	pr->flags.power_setup_done = 0;
 
 	if (acpi_device_dir(device))
 		remove_proc_entry(ACPI_PROCESSOR_FILE_POWER,
 				  acpi_device_dir(device));
+
+#ifndef CONFIG_CPU_IDLE
+
+	/* Unregister the idle handler when processor #0 is removed. */
+	if (pr->id == 0) {
+		pm_idle = pm_idle_save;
+
+		/*
+		 * We are about to unload the current idle thread pm callback
+		 * (pm_idle), Wait for all processors to update cached/local
+		 * copies of pm_idle before proceeding.
+		 */
+		cpu_idle_wait();
+#ifdef CONFIG_SMP
+		unregister_latency_notifier(&acpi_processor_latency_notifier);
+#endif
+	}
+#endif
+
 	return 0;
 }
