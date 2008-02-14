From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/11] ACPI, cpuidle: Clarify C-state description in sysfs
Date: Thu, 14 Feb 2008 02:02:23 -0500
Message-ID: <4fcb2fcd4d0678b8ae103d257dcb28074cbfc7fa.1202972422.git.len.brown@intel.com>
References: <1202972552-17953-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:3160 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755681AbYBNHKn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Feb 2008 02:10:43 -0500
In-Reply-To: <1202972552-17953-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
References: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Add a new sysfs entry under cpuidle states. desc - can be used by driver to
communicate to userspace any specific information about the state.
This helps in identifying the exact hardware C-states behind the ACPI C-state
definition.

Idea is to export this through powertop, which will help to map the C-state
reported by powertop to actual hardware C-state.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/cstate.c |    2 ++
 drivers/acpi/processor_idle.c |   11 +++++++++++
 drivers/cpuidle/cpuidle.c     |    3 ++-
 drivers/cpuidle/sysfs.c       |   14 +++++++++++---
 include/acpi/processor.h      |    9 ++++++---
 include/linux/cpuidle.h       |    2 ++
 6 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 10b6717..8ca3557 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -126,6 +126,8 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 		printk(KERN_DEBUG "Monitor-Mwait will be used to enter C-%d "
 		       "state\n", cx->type);
 	}
+	snprintf(cx->desc, ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
+		 cx->address);
 
 out:
 	set_cpus_allowed(current, saved_mask);
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 32003fd..baa389b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -945,11 +945,16 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 				 * Otherwise, ignore this info and continue.
 				 */
 				cx.entry_method = ACPI_CSTATE_HALT;
+				snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI HLT");
 			} else {
 				continue;
 			}
+		} else {
+			snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI IOPORT 0x%x",
+				 cx.address);
 		}
 
+
 		obj = &(element->package.elements[2]);
 		if (obj->type != ACPI_TYPE_INTEGER)
 			continue;
@@ -1643,6 +1648,11 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 		return -EINVAL;
 	}
 
+	for (i = 0; i < CPUIDLE_STATE_MAX; i++) {
+		dev->states[i].name[0] = '\0';
+		dev->states[i].desc[0] = '\0';
+	}
+
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++) {
 		cx = &pr->power.states[i];
 		state = &dev->states[count];
@@ -1659,6 +1669,7 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 		cpuidle_set_statedata(state, cx);
 
 		snprintf(state->name, CPUIDLE_NAME_LEN, "C%d", i);
+		strncpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
 		state->exit_latency = cx->latency;
 		state->target_residency = cx->latency * latency_factor;
 		state->power_usage = cx->power;
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 60f71e6..d73663a 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -219,7 +219,8 @@ static void poll_idle_init(struct cpuidle_device *dev)
 
 	cpuidle_set_statedata(state, NULL);
 
-	snprintf(state->name, CPUIDLE_NAME_LEN, "C0 (poll idle)");
+	snprintf(state->name, CPUIDLE_NAME_LEN, "C0");
+	snprintf(state->desc, CPUIDLE_DESC_LEN, "CPUIDLE CORE POLL IDLE");
 	state->exit_latency = 0;
 	state->target_residency = 0;
 	state->power_usage = -1;
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 088ea74..69102ca 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -218,16 +218,23 @@ static ssize_t show_state_##_name(struct cpuidle_state *state, char *buf) \
 	return sprintf(buf, "%u\n", state->_name);\
 }
 
-static ssize_t show_state_name(struct cpuidle_state *state, char *buf)
-{
-	return sprintf(buf, "%s\n", state->name);
+#define define_show_state_str_function(_name) \
+static ssize_t show_state_##_name(struct cpuidle_state *state, char *buf) \
+{ \
+	if (state->_name[0] == '\0')\
+		return sprintf(buf, "<null>\n");\
+	return sprintf(buf, "%s\n", state->_name);\
 }
 
 define_show_state_function(exit_latency)
 define_show_state_function(power_usage)
 define_show_state_function(usage)
 define_show_state_function(time)
+define_show_state_str_function(name)
+define_show_state_str_function(desc)
+
 define_one_state_ro(name, show_state_name);
+define_one_state_ro(desc, show_state_desc);
 define_one_state_ro(latency, show_state_exit_latency);
 define_one_state_ro(power, show_state_power_usage);
 define_one_state_ro(usage, show_state_usage);
@@ -235,6 +242,7 @@ define_one_state_ro(time, show_state_time);
 
 static struct attribute *cpuidle_state_default_attrs[] = {
 	&attr_name.attr,
+	&attr_desc.attr,
 	&attr_latency.attr,
 	&attr_power.attr,
 	&attr_usage.attr,
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index cdc8004..06480bc 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -32,9 +32,11 @@
 #define DOMAIN_COORD_TYPE_SW_ANY	0xfd
 #define DOMAIN_COORD_TYPE_HW_ALL	0xfe
 
-#define ACPI_CSTATE_SYSTEMIO	(0)
-#define ACPI_CSTATE_FFH		(1)
-#define ACPI_CSTATE_HALT	(2)
+#define ACPI_CSTATE_SYSTEMIO	0
+#define ACPI_CSTATE_FFH		1
+#define ACPI_CSTATE_HALT	2
+
+#define ACPI_CX_DESC_LEN	32
 
 /* Power Management */
 
@@ -74,6 +76,7 @@ struct acpi_processor_cx {
 	u64 time;
 	struct acpi_processor_cx_policy promotion;
 	struct acpi_processor_cx_policy demotion;
+	char desc[ACPI_CX_DESC_LEN];
 };
 
 struct acpi_processor_power {
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 385d45b..6b72a45 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -19,6 +19,7 @@
 
 #define CPUIDLE_STATE_MAX	8
 #define CPUIDLE_NAME_LEN	16
+#define CPUIDLE_DESC_LEN	32
 
 struct cpuidle_device;
 
@@ -29,6 +30,7 @@ struct cpuidle_device;
 
 struct cpuidle_state {
 	char		name[CPUIDLE_NAME_LEN];
+	char		desc[CPUIDLE_DESC_LEN];
 	void		*driver_data;
 
 	unsigned int	flags;
-- 
1.5.4.1.122.gaa8d

