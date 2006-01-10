From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC 2/2] new C-state policy
Date: Tue, 10 Jan 2006 12:12:56 +0800
Message-ID: <1136866376.5750.29.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ACPI-ML <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pallipadi Venkatesh <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a new C-state policy, based on Thomas's one.
http://lkml.org/lkml/2005/4/19/96

Enhancements:
1. it does all policy calculation before going into idle, so other tasks
can be quickly scheduled after idle.
2. it works w/wo dyntick feature.
3. more tunning parameters and hopefully better policy
4. using pm timer for time accounting, so jiffy doesn't impact the
policy.

Now we use below rules:
1. if cpu activity is high, use C1.
2. if average sleeping time is above or below threshold, do
promotion/demotion.
3. bm activity calculation is similar with current one, but slightly
changed to work with dyntick feature.

It's still not very good. Comments/suggestions are highly appreciated.

Thanks,
Shaohua
---

 linux-2.6.15-rc7-root/drivers/acpi/Kconfig                |    7 
 linux-2.6.15-rc7-root/drivers/acpi/Makefile               |    1 
 linux-2.6.15-rc7-root/drivers/acpi/processor_cstate_new.c |  373 ++++++++++++++
 3 files changed, 381 insertions(+)

diff -puN drivers/acpi/Kconfig~new-policy drivers/acpi/Kconfig
--- linux-2.6.15-rc7/drivers/acpi/Kconfig~new-policy	2006-01-09 13:28:20.000000000 +0800
+++ linux-2.6.15-rc7-root/drivers/acpi/Kconfig	2006-01-09 13:28:20.000000000 +0800
@@ -143,6 +143,13 @@ config ACPI_PROCESSOR
 	  support it.  It is required by several flavors of cpufreq
 	  Performance-state drivers.
 
+config ACPI_NEW_CSTATE_POLICY
+	tristate "New C-state policy"
+	depends on ACPI_PROCESSOR && EXPERIMENTAL
+	default m
+	help
+	 New policy for ACPI C-state. It's friendly with dyn-HZ.
+
 config ACPI_HOTPLUG_CPU
 	bool
 	depends on ACPI_PROCESSOR && HOTPLUG_CPU
diff -puN drivers/acpi/Makefile~new-policy drivers/acpi/Makefile
--- linux-2.6.15-rc7/drivers/acpi/Makefile~new-policy	2006-01-09 13:28:20.000000000 +0800
+++ linux-2.6.15-rc7-root/drivers/acpi/Makefile	2006-01-09 13:28:20.000000000 +0800
@@ -47,6 +47,7 @@ obj-$(CONFIG_ACPI_HOTKEY)	+= hotkey.o
 obj-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
 obj-$(CONFIG_ACPI_POWER)	+= power.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
+obj-$(CONFIG_ACPI_NEW_CSTATE_POLICY) += processor_cstate_new.o
 obj-$(CONFIG_ACPI_CONTAINER)	+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
 obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
diff -puN /dev/null drivers/acpi/processor_cstate_new.c
--- /dev/null	2006-01-05 19:58:28.436640750 +0800
+++ linux-2.6.15-rc7-root/drivers/acpi/processor_cstate_new.c	2006-01-10 11:36:40.000000000 +0800
@@ -0,0 +1,373 @@
+/*
+ *  Copyright (C) 2005  Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ *			Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/moduleparam.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/processor.h>
+#include <acpi/processor_cstate_policy.h>
+
+#define ACPI_PROCESSOR_COMPONENT        0x01000000
+#define _COMPONENT              ACPI_PROCESSOR_COMPONENT
+ACPI_MODULE_NAME                ("acpi_processor")
+
+#define MAX_TICK_COUNT 10
+#define PM_TICKS_PER_MS 3579 /* 3.579 ticks per us*/
+
+/* cpu activity threshold */
+static unsigned int cpu_activity = PM_TICKS_PER_MS * 20;
+module_param(cpu_activity, uint, 0644);
+
+/*
+ * bm_history -- bit-mask with a bit per ms of bus-master activity
+ * reduce history for more aggressive entry into C3
+ */
+static unsigned int bm_history = 0xFF;
+module_param(bm_history, uint, 0644);
+static uint bm_activity_measure_time = PM_TICKS_PER_MS * 4; /* 4ms*/
+module_param(bm_activity_measure_time, uint, 0644);
+
+static int param_set_count(const char *val, struct kernel_param *kp)
+{
+	char *endp;
+	uint l;
+
+	if (!val)
+		return -EINVAL;
+
+	l = simple_strtoul(val, &endp, 0);
+	if (endp == val)
+		return -EINVAL;
+	if (l > MAX_TICK_COUNT ) {
+		printk("%s should be <= %d\n",
+			kp->name, MAX_TICK_COUNT);
+		return -EINVAL;
+	}
+	*((uint *)kp->arg) = l;
+	return 0;
+}
+/* promotion to C2 history count */
+static unsigned int promote_c2_count = 4;
+module_param_call(promote_c2_count, param_set_count, param_get_uint,
+	&promote_c2_count, 0644);
+/* promotion to C3 history count */
+static unsigned int promote_c3_count = 10;
+module_param_call(promote_c3_count, param_set_count, param_get_uint,
+	&promote_c3_count, 0644);
+/* demotion history count */
+static unsigned int demote_count = 1;
+module_param_call(demote_count, param_set_count, param_get_uint,
+	&demote_count, 0644);
+
+struct acpi_processor_threshold {
+	u32 time;
+	u32 ticks; /* threshold ticks */
+	uint *count; /* threshold count */
+	uint bm; /* if need bm check? */
+};
+
+struct acpi_processor_sleep {
+	u32 sleep_ticks[MAX_TICK_COUNT];
+	int current_index;
+	struct acpi_processor_threshold prom;
+	struct acpi_processor_threshold demo;
+};
+
+struct acpi_processor_policy_data {
+	u32 active_timestamp;
+	u32 bm_check_timestamp;
+	struct acpi_processor_sleep sleep[ACPI_PROCESSOR_MAX_POWER];
+};
+
+static int calculate_sleep_average(struct acpi_processor_sleep *p, int c)
+{
+	int i = p->current_index - 1, j;
+	u32 avg = 0;
+	for (j = c; j > 0; j --) {
+		if (i < 0)
+			i = MAX_TICK_COUNT - 1;
+		avg += p->sleep_ticks[i];
+		i --;
+	}
+	return avg/c;
+}
+
+static int calculate_bm(struct acpi_processor *pr)
+{
+	u32 bm_status = 0;
+	u32 diff;
+	struct acpi_processor_policy_data *p = pr->power.policy_data;
+
+	diff = ticks_elapsed(p->bm_check_timestamp, read_acpi_pmtimer());
+	diff /= bm_activity_measure_time;
+	if (diff > 32)
+		diff = 32;
+	acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
+			&bm_status, ACPI_MTX_DO_NOT_LOCK);
+	/* no busmaster in last interval */
+	if (!bm_status) {
+		pr->power.bm_activity <<= diff;
+		diff = 0;
+	}
+	while (diff) {
+		/* if we didn't get called, assume there was busmaster activity */
+		diff --;
+		if (diff)
+			pr->power.bm_activity |= 0x1;
+		pr->power.bm_activity <<= 1;
+	}
+
+	if (bm_status) {
+		pr->power.bm_activity++;
+		acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
+				1, ACPI_MTX_DO_NOT_LOCK);
+	}
+
+	p->bm_check_timestamp = read_acpi_pmtimer();
+	return pr->power.bm_activity & bm_history;
+}
+
+static int init_this_policy(struct acpi_processor *pr)
+{
+	struct acpi_processor_policy_data *p;
+	unsigned int i;
+	struct acpi_processor_cx *cx;
+	int lower = 0, higher = 0;
+	int state_is_set = 0;
+
+	ACPI_FUNCTION_TRACE("init_this_policy");
+
+	if (pr->power.policy_data) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Other policies are busy\n"));
+		return_VALUE(-EBUSY);
+	}
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Out of memory\n"));
+		return_VALUE(-ENOMEM);
+	}
+
+	/* startup state */
+	for (i=1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
+		cx = &pr->power.states[i];
+		if (!cx->valid)
+			continue;
+
+		if (!state_is_set)
+			pr->power.state = cx;
+		state_is_set++;
+		break;
+ 	}
+
+	if (!state_is_set) {
+		kfree(p);
+		return_VALUE(-ENODEV);
+	}
+
+	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
+		cx = &pr->power.states[i];
+		if (!cx->valid)
+			continue;
+
+		if (lower) {
+			pr->power.states[i].demo_state = &pr->power.states[lower];
+			p->sleep[i].demo.ticks = cx->latency_ticks;
+			p->sleep[i].demo.count = &demote_count;
+			if (cx->type == ACPI_STATE_C3)
+				p->sleep[i].demo.bm = 1;
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
+			pr->power.states[i].prom_state  = &pr->power.states[higher];
+			p->sleep[i].prom.ticks = cx->latency_ticks;
+			if (cx->type < ACPI_STATE_C2)
+				p->sleep[i].prom.count = &promote_c2_count;
+			else
+				p->sleep[i].prom.count = &promote_c3_count;
+			if (pr->power.states[higher].type == ACPI_STATE_C3)
+				p->sleep[i].prom.bm = 1;
+		}
+
+		higher = i;
+	}
+	pr->power.bm_activity = 0;
+	pr->power.policy_data = p;
+	return_VALUE(0);
+}
+
+static int exit_this_policy(struct acpi_processor *pr)
+{
+	struct acpi_processor_policy_data *p;
+
+	ACPI_FUNCTION_TRACE("exit_this_policy");
+
+	if (!pr->power.policy_data) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Policy data is invalid\n"));
+		return_VALUE(-EINVAL);
+	}
+	p = pr->power.policy_data;
+	pr->power.policy_data = NULL;
+	kfree(p);
+
+	pr->power.bm_activity = 0;
+	return_VALUE(0);
+}
+
+static struct acpi_processor_cx* pre_cx_this_policy(struct acpi_processor *pr)
+{
+	u32 active_diff;
+	struct acpi_processor_cx *next_state;
+	struct acpi_processor_policy_data *p;
+	int index;
+	struct acpi_processor_cx *pro_cx, *dem_cx;
+	struct acpi_processor_sleep *sleep_data;
+	int sleep_ticks;
+	int bm_activity = 0;
+
+	p = pr->power.policy_data;
+	index = pr->power.state - pr->power.states;
+	next_state = pr->power.state;
+
+	/* too many cpu activity, uses C1 */
+	active_diff = ticks_elapsed(p->active_timestamp, read_acpi_pmtimer());
+	if (active_diff > cpu_activity) {
+		next_state = &pr->power.states[ACPI_STATE_C1];
+		goto end;
+	}
+
+	/* bm activity? Demote to bm non-sensitive state */
+	if (pr->flags.bm_check) {
+		bm_activity = calculate_bm(pr);
+		/* this works for both bm activity algorithms */
+		while (p->sleep[index].demo.bm && bm_activity) {
+			next_state = pr->power.states[index].demo_state;
+			index = next_state - pr->power.states;
+		}
+		if (next_state != pr->power.state)
+			goto end;
+	}
+
+	local_irq_enable();
+
+	pro_cx = pr->power.states[index].prom_state;
+	dem_cx = pr->power.states[index].demo_state;
+	sleep_data = &p->sleep[index];
+	/* last sleep time */
+	sleep_ticks = sleep_data->sleep_ticks[sleep_data->current_index - 1 < 0 ?
+		MAX_TICK_COUNT -1 : sleep_data->current_index - 1];
+
+	if (pro_cx && ((pro_cx - pr->power.states) <= max_cstate) &&
+		(sleep_ticks > sleep_data->prom.ticks) &&
+		(calculate_sleep_average(sleep_data, *sleep_data->prom.count) >
+			sleep_data->prom.ticks)) {
+			if (!pr->flags.bm_check || !((sleep_data->prom.bm) && bm_activity))
+				next_state = pro_cx;
+			goto end;
+	}
+
+	if (dem_cx && (sleep_ticks < sleep_data->demo.ticks)) {
+		if (calculate_sleep_average(sleep_data, *sleep_data->demo.count)
+			< sleep_data->demo.ticks) {
+			next_state = dem_cx;
+		}
+	}
+
+end:
+	/* Clean previous state's statistics */
+	if (next_state != pr->power.state) {
+		index = pr->power.state - pr->power.states;
+		memset(p->sleep[index].sleep_ticks, 0,
+			sizeof(p->sleep[index].sleep_ticks));
+	}
+
+	local_irq_disable();
+	return next_state;
+}
+
+static struct acpi_processor_cx* post_cx_this_policy(struct acpi_processor *pr,
+	int sleep_ticks)
+{
+	struct acpi_processor_cx *next_state;
+	struct acpi_processor_policy_data *p;
+	int index;
+	struct acpi_processor_sleep *sleep_data;
+
+	next_state = pr->power.state;
+	p = pr->power.policy_data;
+	index = pr->power.state - pr->power.states;
+	sleep_data = &p->sleep[index];
+
+	sleep_data->sleep_ticks[sleep_data->current_index ++] = sleep_ticks;
+	sleep_data->current_index %= MAX_TICK_COUNT;
+
+	p->active_timestamp = read_acpi_pmtimer();
+	return next_state;
+}
+
+static int update_this_policy(struct acpi_processor *pr)
+{
+	exit_this_policy(pr);
+	init_this_policy(pr);
+	return 0;
+}
+
+static struct acpi_processor_cstate_policy this_policy = {
+	.init = init_this_policy,
+	.exit = exit_this_policy,
+	.update = update_this_policy,
+	.pre_cx = pre_cx_this_policy,
+	.post_cx = post_cx_this_policy,
+};
+
+static int __init policy_init(void)
+{
+	return register_acpi_cstate_policy(&this_policy);
+}
+
+static void __exit policy_exit(void)
+{
+	unregister_acpi_cstate_policy(&this_policy);
+}
+module_init(policy_init);
+module_exit(policy_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
_


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
