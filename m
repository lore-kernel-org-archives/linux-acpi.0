From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC 1/2] Modular acpi_idle policy
Date: Tue, 10 Jan 2006 12:12:53 +0800
Message-ID: <1136866373.5750.28.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ACPI-ML <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pallipadi Venkatesh <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Modular C-state policy. And convert current algorithm to the framework.
This is the updated patch I sent out to the list several months ago.
Next patch will use the framework.

Thanks,
Shaohua
---

 linux-2.6.15-rc7-root/drivers/acpi/processor_idle.c          |  654 +++++++----
 linux-2.6.15-rc7-root/include/acpi/processor.h               |   19 
 linux-2.6.15-rc7-root/include/acpi/processor_cstate_policy.h |   37 
 3 files changed, 472 insertions(+), 238 deletions(-)

diff -puN drivers/acpi/processor_idle.c~cstate-policy drivers/acpi/processor_idle.c
--- linux-2.6.15-rc7/drivers/acpi/processor_idle.c~cstate-policy	2006-01-09 11:03:23.000000000 +0800
+++ linux-2.6.15-rc7-root/drivers/acpi/processor_idle.c	2006-01-09 12:21:05.000000000 +0800
@@ -38,12 +38,14 @@
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>	/* need_resched() */
+#include <linux/cpu.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_bus.h>
 #include <acpi/processor.h>
+#include <acpi/processor_cstate_policy.h>
 
 #define ACPI_PROCESSOR_COMPONENT        0x01000000
 #define ACPI_PROCESSOR_CLASS            "processor"
@@ -51,9 +53,7 @@
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("acpi_processor")
 #define ACPI_PROCESSOR_FILE_POWER	"power"
-#define US_TO_PM_TIMER_TICKS(t)		((t * (PM_TIMER_FREQUENCY/1000)) / 1000)
-#define C2_OVERHEAD			4	/* 1us (3.579 ticks per us) */
-#define C3_OVERHEAD			4	/* 1us (3.579 ticks per us) */
+
 static void (*pm_idle_save) (void);
 module_param(max_cstate, uint, 0644);
 
@@ -70,6 +70,11 @@ module_param(nocst, uint, 0000);
 static unsigned int bm_history =
     (HZ >= 800 ? 0xFFFFFFFF : ((1U << (HZ / 25)) - 1));
 module_param(bm_history, uint, 0644);
+
+DECLARE_MUTEX(cstate_policy_lock);
+static struct acpi_processor_cstate_policy cstate_dfl_policy;
+static struct acpi_processor_cstate_policy *current_policy = &cstate_dfl_policy;
+
 /* --------------------------------------------------------------------------
                                 Power Management
    -------------------------------------------------------------------------- */
@@ -115,16 +120,6 @@ static struct dmi_system_id __initdata p
 	{},
 };
 
-static inline u32 ticks_elapsed(u32 t1, u32 t2)
-{
-	if (t2 >= t1)
-		return (t2 - t1);
-	else if (!acpi_fadt.tmr_val_ext)
-		return (((0x00FFFFFF - t1) + t2) & 0x00FFFFFF);
-	else
-		return ((0xFFFFFFFF - t1) + t2);
-}
-
 static void
 acpi_processor_power_activate(struct acpi_processor *pr,
 			      struct acpi_processor_cx *new)
@@ -136,10 +131,6 @@ acpi_processor_power_activate(struct acp
 
 	old = pr->power.state;
 
-	if (old)
-		old->promotion.count = 0;
-	new->demotion.count = 0;
-
 	/* Cleanup from old state. */
 	if (old) {
 		switch (old->type) {
@@ -214,65 +205,9 @@ static void acpi_processor_idle(void)
 		return;
 	}
 
-	/*
-	 * Check BM Activity
-	 * -----------------
-	 * Check for bus mastering activity (if required), record, and check
-	 * for demotion.
-	 */
-	if (pr->flags.bm_check) {
-		u32 bm_status = 0;
-		unsigned long diff = jiffies - pr->power.bm_check_timestamp;
-
-		if (diff > 32)
-			diff = 32;
-
-		while (diff) {
-			/* if we didn't get called, assume there was busmaster activity */
-			diff--;
-			if (diff)
-				pr->power.bm_activity |= 0x1;
-			pr->power.bm_activity <<= 1;
-		}
-
-		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
-				  &bm_status, ACPI_MTX_DO_NOT_LOCK);
-		if (bm_status) {
-			pr->power.bm_activity++;
-			acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
-					  1, ACPI_MTX_DO_NOT_LOCK);
-		}
-		/*
-		 * PIIX4 Erratum #18: Note that BM_STS doesn't always reflect
-		 * the true state of bus mastering activity; forcing us to
-		 * manually check the BMIDEA bit of each IDE channel.
-		 */
-		else if (errata.piix4.bmisx) {
-			if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
-			    || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
-				pr->power.bm_activity++;
-		}
-
-		pr->power.bm_check_timestamp = jiffies;
-
-		/*
-		 * Apply bus mastering demotion policy.  Automatically demote
-		 * to avoid a faulty transition.  Note that the processor
-		 * won't enter a low-power state during this call (to this
-		 * funciton) but should upon the next.
-		 *
-		 * TBD: A better policy might be to fallback to the demotion
-		 *      state (use it for this quantum only) istead of
-		 *      demoting -- and rely on duration as our sole demotion
-		 *      qualification.  This may, however, introduce DMA
-		 *      issues (e.g. floppy DMA transfer overrun/underrun).
-		 */
-		if (pr->power.bm_activity & cx->demotion.threshold.bm) {
-			local_irq_enable();
-			next_state = cx->demotion.state;
-			goto end;
-		}
-	}
+	cx = current_policy->pre_cx(pr);
+	if (cx != pr->power.state)
+		acpi_processor_power_activate(pr, cx);
 
 #ifdef CONFIG_HOTPLUG_CPU
 	/*
@@ -310,6 +245,7 @@ static void acpi_processor_idle(void)
 		 * Use the appropriate idle routine, the one that would
 		 * be used without acpi C-states.
 		 */
+		t1 = read_acpi_pmtimer();
 		if (pm_idle_save)
 			pm_idle_save();
 		else
@@ -320,18 +256,19 @@ static void acpi_processor_idle(void)
 		 *      go to an ISR rather than here.  Need to instrument
 		 *      base interrupt handler.
 		 */
-		sleep_ticks = 0xFFFFFFFF;
+		t2 = read_acpi_pmtimer();
+		sleep_ticks = ticks_elapsed(t1, t2);
 		break;
 
 	case ACPI_STATE_C2:
 		/* Get start time (ticks) */
-		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
+		t1 = read_acpi_pmtimer();
 		/* Invoke C2 */
 		inb(cx->address);
 		/* Dummy op - must do something useless after P_LVL2 read */
-		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
+		t2 = read_acpi_pmtimer();
 		/* Get end time (ticks) */
-		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
+		t2 = read_acpi_pmtimer();
 		/* Re-enable interrupts */
 		local_irq_enable();
 		set_thread_flag(TIF_POLLING_NRFLAG);
@@ -358,13 +295,13 @@ static void acpi_processor_idle(void)
 		}
 
 		/* Get start time (ticks) */
-		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
+		t1 = read_acpi_pmtimer();
 		/* Invoke C3 */
 		inb(cx->address);
 		/* Dummy op - must do something useless after P_LVL3 read */
-		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
+		t2 = read_acpi_pmtimer();
 		/* Get end time (ticks) */
-		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
+		t2 = read_acpi_pmtimer();
 		if (pr->flags.bm_check) {
 			/* Enable bus master arbitration */
 			atomic_dec(&c3_cpu_count);
@@ -385,8 +322,6 @@ static void acpi_processor_idle(void)
 		return;
 	}
 
-	next_state = pr->power.state;
-
 #ifdef CONFIG_HOTPLUG_CPU
 	/* Don't do promotion/demotion */
 	if ((cx->type == ACPI_STATE_C1) && (num_online_cpus() > 1) &&
@@ -396,62 +331,8 @@ static void acpi_processor_idle(void)
 	}
 #endif
 
-	/*
-	 * Promotion?
-	 * ----------
-	 * Track the number of longs (time asleep is greater than threshold)
-	 * and promote when the count threshold is reached.  Note that bus
-	 * mastering activity may prevent promotions.
-	 * Do not promote above max_cstate.
-	 */
-	if (cx->promotion.state &&
-	    ((cx->promotion.state - pr->power.states) <= max_cstate)) {
-		if (sleep_ticks > cx->promotion.threshold.ticks) {
-			cx->promotion.count++;
-			cx->demotion.count = 0;
-			if (cx->promotion.count >=
-			    cx->promotion.threshold.count) {
-				if (pr->flags.bm_check) {
-					if (!
-					    (pr->power.bm_activity & cx->
-					     promotion.threshold.bm)) {
-						next_state =
-						    cx->promotion.state;
-						goto end;
-					}
-				} else {
-					next_state = cx->promotion.state;
-					goto end;
-				}
-			}
-		}
-	}
-
-	/*
-	 * Demotion?
-	 * ---------
-	 * Track the number of shorts (time asleep is less than time threshold)
-	 * and demote when the usage threshold is reached.
-	 */
-	if (cx->demotion.state) {
-		if (sleep_ticks < cx->demotion.threshold.ticks) {
-			cx->demotion.count++;
-			cx->promotion.count = 0;
-			if (cx->demotion.count >= cx->demotion.threshold.count) {
-				next_state = cx->demotion.state;
-				goto end;
-			}
-		}
-	}
-
-      end:
-	/*
-	 * Demote if current state exceeds max_cstate
-	 */
-	if ((pr->power.state - pr->power.states) > max_cstate) {
-		if (cx->demotion.state)
-			next_state = cx->demotion.state;
-	}
+	next_state = current_policy->post_cx(pr, sleep_ticks);
+end:
 
 	/*
 	 * New Cx State?
@@ -463,81 +344,49 @@ static void acpi_processor_idle(void)
 		acpi_processor_power_activate(pr, next_state);
 }
 
+/*
+ * Set Default Policy
+ * ------------------
+ * Now that we know which states are supported, set the default
+ * policy.  Note that this policy can be changed dynamically
+ * (e.g. encourage deeper sleeps to conserve battery life when
+ * not on AC).
+ */
 static int acpi_processor_set_power_policy(struct acpi_processor *pr)
 {
-	unsigned int i;
-	unsigned int state_is_set = 0;
-	struct acpi_processor_cx *lower = NULL;
-	struct acpi_processor_cx *higher = NULL;
-	struct acpi_processor_cx *cx;
+	int i;
 
 	ACPI_FUNCTION_TRACE("acpi_processor_set_power_policy");
 
-	if (!pr)
-		return_VALUE(-EINVAL);
-
-	/*
-	 * This function sets the default Cx state policy (OS idle handler).
-	 * Our scheme is to promote quickly to C2 but more conservatively
-	 * to C3.  We're favoring C2  for its characteristics of low latency
-	 * (quick response), good power savings, and ability to allow bus
-	 * mastering activity.  Note that the Cx state policy is completely
-	 * customizable and can be altered dynamically.
-	 */
-
-	/* startup state */
-	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
-		cx = &pr->power.states[i];
-		if (!cx->valid)
-			continue;
-
-		if (!state_is_set)
-			pr->power.state = cx;
-		state_is_set++;
-		break;
-	}
-
-	if (!state_is_set)
-		return_VALUE(-ENODEV);
+	down(&cstate_policy_lock);
+	i = current_policy->init(pr);
+	up(&cstate_policy_lock);
 
-	/* demotion */
-	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
-		cx = &pr->power.states[i];
-		if (!cx->valid)
-			continue;
-
-		if (lower) {
-			cx->demotion.state = lower;
-			cx->demotion.threshold.ticks = cx->latency_ticks;
-			cx->demotion.threshold.count = 1;
-			if (cx->type == ACPI_STATE_C3)
-				cx->demotion.threshold.bm = bm_history;
-		}
-
-		lower = cx;
-	}
-
-	/* promotion */
-	for (i = (ACPI_PROCESSOR_MAX_POWER - 1); i > 0; i--) {
-		cx = &pr->power.states[i];
-		if (!cx->valid)
-			continue;
+	return_VALUE(i);
+}
 
-		if (higher) {
-			cx->promotion.state = higher;
-			cx->promotion.threshold.ticks = cx->latency_ticks;
-			if (cx->type >= ACPI_STATE_C2)
-				cx->promotion.threshold.count = 4;
-			else
-				cx->promotion.threshold.count = 10;
-			if (higher->type == ACPI_STATE_C3)
-				cx->promotion.threshold.bm = bm_history;
-		}
+static int
+acpi_processor_update_power_policy (
+	struct acpi_processor	*pr)
+{
+	int i;
+ 	ACPI_FUNCTION_TRACE("acpi_processor_update_power_policy");
+ 
+	down(&cstate_policy_lock);
+ 	i = current_policy->update(pr);
+	up(&cstate_policy_lock);
+	return_VALUE(i);
+}
 
-		higher = cx;
-	}
+static void
+acpi_processor_unset_power_policy (
+	struct acpi_processor	*pr)
+{
+ 	ACPI_FUNCTION_TRACE("acpi_processor_unset_power_policy");
 
-	return_VALUE(0);
+	down(&cstate_policy_lock);
+ 	current_policy->exit(pr);
+	up(&cstate_policy_lock);
 }
 
 static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
@@ -885,18 +734,6 @@ static int acpi_processor_get_power_info
 		result = acpi_processor_get_power_info_default_c1(pr);
 
 	/*
-	 * Set Default Policy
-	 * ------------------
-	 * Now that we know which states are supported, set the default
-	 * policy.  Note that this policy can be changed dynamically
-	 * (e.g. encourage deeper sleeps to conserve battery life when
-	 * not on AC).
-	 */
-	result = acpi_processor_set_power_policy(pr);
-	if (result)
-		return_VALUE(result);
-
-	/*
 	 * if one state of type C2 or C3 is available, mark this
 	 * CPU as being "idle manageable"
 	 */
@@ -933,6 +770,7 @@ int acpi_processor_cst_has_changed(struc
 
 	pr->flags.power = 0;
 	result = acpi_processor_get_power_info(pr);
+	acpi_processor_update_power_policy(pr);
 	if ((pr->flags.power == 1) && (pr->flags.power_setup_done))
 		pm_idle = acpi_processor_idle;
 
@@ -984,16 +822,16 @@ static int acpi_processor_power_seq_show
 			break;
 		}
 
-		if (pr->power.states[i].promotion.state)
+		if (pr->power.states[i].prom_state)
 			seq_printf(seq, "promotion[C%zd] ",
-				   (pr->power.states[i].promotion.state -
+				   (pr->power.states[i].prom_state -
 				    pr->power.states));
 		else
 			seq_puts(seq, "promotion[--] ");
 
-		if (pr->power.states[i].demotion.state)
+		if (pr->power.states[i].demo_state)
 			seq_printf(seq, "demotion[C%zd] ",
-				   (pr->power.states[i].demotion.state -
+				   (pr->power.states[i].demo_state -
 				    pr->power.states));
 		else
 			seq_puts(seq, "demotion[--] ");
@@ -1054,6 +892,7 @@ int acpi_processor_power_init(struct acp
 	acpi_processor_power_init_pdc(&(pr->power), pr->id);
 	acpi_processor_set_pdc(pr, pr->power.pdc);
 	acpi_processor_get_power_info(pr);
+	acpi_processor_set_power_policy(pr);
 
 	/*
 	 * Install the idle handler if processor power management is supported.
@@ -1097,6 +936,7 @@ int acpi_processor_power_exit(struct acp
 {
 	ACPI_FUNCTION_TRACE("acpi_processor_power_exit");
 
+	/* FIXME: we have trouble in MP case here */
 	pr->flags.power_setup_done = 0;
 
 	if (acpi_device_dir(device))
@@ -1115,5 +955,373 @@ int acpi_processor_power_exit(struct acp
 		cpu_idle_wait();
 	}
 
+	/* after the CPU exit idle */
+	acpi_processor_unset_power_policy(pr);
+
 	return_VALUE(0);
 }
+
+/* default c-state policy */
+struct acpi_processor_dfl_cx_policy_state {
+	u32 count;
+	struct {
+		u32 time;
+		u32 ticks;
+		u32 count;
+		u32 bm;
+	} threshold;
+};
+
+struct acpi_processor_dfl_cx_policy_data {
+	unsigned long bm_check_timestamp;
+	struct {
+		struct acpi_processor_dfl_cx_policy_state promotion;
+		struct acpi_processor_dfl_cx_policy_state demotion;
+	} policy[ACPI_PROCESSOR_MAX_POWER];
+};
+
+static int init_dfl_cstate_policy(struct acpi_processor *pr)
+{
+	struct acpi_processor_dfl_cx_policy_data *p;
+	unsigned int i;
+	struct acpi_processor_cx *cx;
+	int lower = 0, higher = 0;
+	int state_is_set = 0;
+
+	ACPI_FUNCTION_TRACE("init_dfl_cstate_policy");
+
+	if (pr->power.policy_data) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+					"Other policies are busy\n"));
+		return_VALUE(-EBUSY);
+	}
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+					"Out of memory\n"));
+		return_VALUE(-ENOMEM);
+	}
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
+	if (!state_is_set) {
+		kfree(p);
+		return_VALUE(-ENODEV);
+	}
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
+	/* demotion */
+	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
+		cx = &pr->power.states[i];
+		if (!cx->valid)
+			continue;
+
+		if (lower) {
+			pr->power.states[i].demo_state = &pr->power.states[lower];
+			p->policy[i].demotion.threshold.ticks = cx->latency_ticks;
+			p->policy[i].demotion.threshold.count = 1;
+			if (cx->type == ACPI_STATE_C3)
+				p->policy[i].demotion.threshold.bm = bm_history;
+		}
+
+		lower = i;
+	}
+
+	/* promotion */
+	for (i = (ACPI_PROCESSOR_MAX_POWER - 1); i > 0; i--) {
+		cx = &pr->power.states[i];
+		if (!cx->valid)
+			continue;
+
+		if (higher) {
+			pr->power.states[i].prom_state = &pr->power.states[higher];
+			p->policy[i].promotion.threshold.ticks = cx->latency_ticks;
+			if (cx->type >= ACPI_STATE_C2)
+				p->policy[i].promotion.threshold.count = 4;
+			else
+				p->policy[i].promotion.threshold.count = 10;
+			if (pr->power.states[higher].type == ACPI_STATE_C3)
+				p->policy[i].promotion.threshold.bm = bm_history;
+		}
+
+		higher = i;
+	}
+	pr->power.policy_data = p;
+	return_VALUE(0);
+}
+
+static int exit_dfl_cstate_policy(struct acpi_processor *pr)
+{
+	struct acpi_processor_dfl_cx_policy_data *p;
+
+	ACPI_FUNCTION_TRACE("exit_dfl_cstate_policy");
+
+	if (!pr->power.policy_data) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Policy data is invalid\n"));
+		return_VALUE(-EINVAL);
+	}
+
+	p = pr->power.policy_data;
+	pr->power.policy_data = NULL;
+	kfree(p);
+
+	return_VALUE(0);
+}
+
+static struct acpi_processor_cx* dfl_cstate_pre_cx(struct acpi_processor *pr)
+{
+	struct acpi_processor_cx *next_state;
+	struct acpi_processor_dfl_cx_policy_data *p;
+	int index;
+
+	p = pr->power.policy_data;
+	index = pr->power.state - pr->power.states;
+	next_state = pr->power.state;
+	/*
+	 * Check BM Activity
+	 * -----------------
+	 * Check for bus mastering activity (if required), record, and check
+	 * for demotion.
+	 */
+	if (pr->flags.bm_check) {
+		u32		bm_status = 0;
+		unsigned long	diff = jiffies - p->bm_check_timestamp;
+
+		if (diff > 32)
+			diff = 32;
+
+		while (diff) {
+			/* if we didn't get called, assume there was busmaster activity */
+			diff--;
+			if (diff)
+				pr->power.bm_activity |= 0x1;
+			pr->power.bm_activity <<= 1;
+		}
+
+		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
+			&bm_status, ACPI_MTX_DO_NOT_LOCK);
+		if (bm_status) {
+			pr->power.bm_activity++;
+			acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
+				1, ACPI_MTX_DO_NOT_LOCK);
+		}
+		/*
+		 * PIIX4 Erratum #18: Note that BM_STS doesn't always reflect
+		 * the true state of bus mastering activity; forcing us to
+		 * manually check the BMIDEA bit of each IDE channel.
+		 */
+		else if (errata.piix4.bmisx) {
+			if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
+				|| (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
+				pr->power.bm_activity++;
+		}
+
+		p->bm_check_timestamp = jiffies;
+
+		/*
+		 * Apply bus mastering demotion policy.  Automatically demote
+		 * to avoid a faulty transition.  Note that the processor
+		 * won't enter a low-power state during this call (to this
+		 * funciton) but should upon the next.
+		 *
+		 * TBD: A better policy might be to fallback to the demotion
+		 *      state (use it for this quantum only) istead of
+		 *      demoting -- and rely on duration as our sole demotion
+		 *      qualification.  This may, however, introduce DMA
+		 *      issues (e.g. floppy DMA transfer overrun/underrun).
+		 */
+		if (pr->power.bm_activity & p->policy[index].demotion.threshold.bm)
+			next_state = pr->power.states[index].demo_state;
+	}
+	if (next_state != pr->power.state) {
+		if (pr->power.state)
+			p->policy[index].promotion.count = 0;
+
+		index = next_state - pr->power.states;
+		p->policy[index].demotion.count = 0;
+	}
+
+	return next_state;
+}
+
+
+static struct acpi_processor_cx* dfl_cstate_post_cx(struct acpi_processor *pr,
+	int sleep_ticks)
+{
+	struct acpi_processor_cx *next_state;
+	struct acpi_processor_dfl_cx_policy_data *p;
+	int index;
+	struct acpi_processor_dfl_cx_policy_state *pro, *dem;
+	struct acpi_processor_cx *pro_cx, *dem_cx;
+
+	p = pr->power.policy_data;
+	index = pr->power.state - pr->power.states;
+	next_state = pr->power.state;
+
+	pro = &p->policy[index].promotion;
+	dem = &p->policy[index].demotion;
+	pro_cx = pr->power.state->prom_state;
+	dem_cx = pr->power.state->demo_state;
+	/*
+	 * Promotion?
+	 * ----------
+	 * Track the number of longs (time asleep is greater than threshold)
+	 * and promote when the count threshold is reached.  Note that bus
+	 * mastering activity may prevent promotions.
+	 * Do not promote above max_cstate.
+	 */
+	if (pro_cx && ((pro_cx - pr->power.states) <= max_cstate)) {
+		if (sleep_ticks > pro->threshold.ticks) {
+			pro->count++;
+			dem->count = 0;
+			if (pro->count >= pro->threshold.count) {
+				if (pr->flags.bm_check) {
+					if (!(pr->power.bm_activity & pro->threshold.bm)) {
+						next_state = pro_cx;
+						goto end;
+					}
+				} else {
+					next_state = pro_cx;
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
+	if (dem_cx && (sleep_ticks < dem->threshold.ticks)) {
+		dem->count++;
+		pro->count = 0;
+		if (dem->count >= dem->threshold.count) {
+			next_state = dem_cx;
+			goto end;
+		}
+	}
+
+end:
+	/*
+	 * Demote if current state exceeds max_cstate
+	 */
+	if ((pr->power.state - pr->power.states) > max_cstate) {
+		if (dem_cx)
+			next_state = dem_cx;
+	}
+
+	if (next_state != pr->power.state) {
+		if (pr->power.state)
+			p->policy[index].promotion.count = 0;
+
+		index = next_state - pr->power.states;
+		p->policy[index].demotion.count = 0;
+	}
+
+	return next_state;
+}
+
+static int dfl_cstate_update(struct acpi_processor *pr)
+{
+	/* default policy hasn't any state preserved */
+	exit_dfl_cstate_policy(pr);
+	init_dfl_cstate_policy(pr);
+	return 0;
+}
+
+static struct acpi_processor_cstate_policy cstate_dfl_policy = {
+	.init = init_dfl_cstate_policy,
+	.exit = exit_dfl_cstate_policy,
+	.update = dfl_cstate_update,
+	.pre_cx = dfl_cstate_pre_cx,
+	.post_cx = dfl_cstate_post_cx,
+};
+
+int register_acpi_cstate_policy(struct acpi_processor_cstate_policy *p)
+{
+	struct acpi_processor *pr;
+	int i;
+
+	lock_cpu_hotplug();
+	down(&cstate_policy_lock);
+	/* FIXME: we currently only support one extra policy */
+	if (current_policy != &cstate_dfl_policy) {
+		up(&cstate_policy_lock);
+		unlock_cpu_hotplug();
+		return -EBUSY;
+	}
+	pm_idle = pm_idle_save;
+	cpu_idle_wait();
+
+	for_each_online_cpu(i) {
+		pr = processors[i];
+		if (!pr || !pr->power.policy_data)
+			continue;
+		current_policy->exit(pr);
+		p->init(pr);
+	}
+
+	current_policy = p;
+	pm_idle = acpi_processor_idle;
+
+	up(&cstate_policy_lock);
+	unlock_cpu_hotplug();
+	return 0;
+}
+EXPORT_SYMBOL(register_acpi_cstate_policy);
+
+int unregister_acpi_cstate_policy(struct acpi_processor_cstate_policy *p)
+{
+	struct acpi_processor *pr;
+	int i;
+
+	if (p == &cstate_dfl_policy)
+		return 0;
+
+	lock_cpu_hotplug();
+	down(&cstate_policy_lock);
+	if (current_policy != p) {
+		up(&cstate_policy_lock);
+		unlock_cpu_hotplug();
+		return -EINVAL;
+	}
+	pm_idle = pm_idle_save;
+	cpu_idle_wait();
+
+	for_each_online_cpu(i) {
+		pr = processors[i];
+		if (!pr || !pr->power.policy_data)
+			continue;
+		current_policy->exit(pr);
+		cstate_dfl_policy.init(pr);
+	}
+
+	current_policy = &cstate_dfl_policy;
+	pm_idle = acpi_processor_idle;
+
+	up(&cstate_policy_lock);
+	unlock_cpu_hotplug();
+	return 0;
+}
+EXPORT_SYMBOL(unregister_acpi_cstate_policy);
diff -puN include/acpi/processor.h~cstate-policy include/acpi/processor.h
--- linux-2.6.15-rc7/include/acpi/processor.h~cstate-policy	2006-01-09 11:03:29.000000000 +0800
+++ linux-2.6.15-rc7-root/include/acpi/processor.h	2006-01-09 11:25:55.000000000 +0800
@@ -20,8 +20,6 @@
 
 /* Power Management */
 
-struct acpi_processor_cx;
-
 struct acpi_power_register {
 	u8 descriptor;
 	u16 length;
@@ -32,17 +30,6 @@ struct acpi_power_register {
 	u64 address;
 } __attribute__ ((packed));
 
-struct acpi_processor_cx_policy {
-	u32 count;
-	struct acpi_processor_cx *state;
-	struct {
-		u32 time;
-		u32 ticks;
-		u32 count;
-		u32 bm;
-	} threshold;
-};
-
 struct acpi_processor_cx {
 	u8 valid;
 	u8 type;
@@ -51,8 +38,9 @@ struct acpi_processor_cx {
 	u32 latency_ticks;
 	u32 power;
 	u32 usage;
-	struct acpi_processor_cx_policy promotion;
-	struct acpi_processor_cx_policy demotion;
+	struct acpi_processor_cx *prom_state;
+	struct acpi_processor_cx *demo_state;
+	u64 time; /* in pm ticks */
 };
 
 struct acpi_processor_power {
@@ -62,6 +50,7 @@ struct acpi_processor_power {
 	u32 bm_activity;
 	int count;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
+	void *policy_data; /* policy specific */
 
 	/* the _PDC objects passed by the driver, if any */
 	struct acpi_object_list *pdc;
diff -puN /dev/null include/acpi/processor_cstate_policy.h
--- /dev/null	2006-01-05 19:58:28.436640750 +0800
+++ linux-2.6.15-rc7-root/include/acpi/processor_cstate_policy.h	2006-01-09 11:26:41.000000000 +0800
@@ -0,0 +1,37 @@
+#ifndef PROCESSOR_CSTATE_POLICY_H
+#define PROCESSOR_CSTATE_POLICY_H
+
+#include <acpi/processor.h>
+
+#define US_TO_PM_TIMER_TICKS(t)		((t * (PM_TIMER_FREQUENCY/1000)) / 1000)
+#define C2_OVERHEAD			4	/* 1us (3.579 ticks per us) */
+#define C3_OVERHEAD			4	/* 1us (3.579 ticks per us) */
+
+static inline u32 read_acpi_pmtimer(void)
+{
+	return inl(acpi_fadt.xpm_tmr_blk.address);
+}
+
+static inline u32
+ticks_elapsed(u32 t1, u32 t2)
+{
+	if (t2 >= t1)
+		return (t2 - t1);
+	else if (!acpi_fadt.tmr_val_ext)
+		return (((0x00FFFFFF - t1) + t2) & 0x00FFFFFF);
+	else
+		return ((0xFFFFFFFF - t1) + t2);
+}
+
+struct acpi_processor_cstate_policy {
+	int (*init)(struct acpi_processor *pr);
+	int (*exit)(struct acpi_processor *pr);
+	int (*update)(struct acpi_processor *pr);
+	struct acpi_processor_cx* (*pre_cx)(struct acpi_processor *pr);
+	struct acpi_processor_cx* (*post_cx)(struct acpi_processor *pr,
+			int sleep_ticks);
+};
+
+int register_acpi_cstate_policy(struct acpi_processor_cstate_policy *p);
+int unregister_acpi_cstate_policy(struct acpi_processor_cstate_policy *p);
+#endif
_


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
