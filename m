From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] ACPI: Delete the IRQ operation in throttling controll via PTC
Date: Sun,  2 Dec 2007 14:48:44 -0500
Message-ID: <1196624925-17220-2-git-send-email-lenb@kernel.org>
References: <1196624925-17220-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:60075 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752957AbXLBT4C (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Dec 2007 14:56:02 -0500
In-Reply-To: <1196624925-17220-1-git-send-email-lenb@kernel.org>
Message-Id: <357dc4c3f13cb5c1e3b40a09cbe6ff1b0df2c7c3.1196624815.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

The IRQ operation(enable/disable) should be avoided when throttling is
controlled via PTC method. It is replaced by the migration of task.

This fixes an oops on T61 -- a regression due to
f79f06ab9f86 b/c FixedHW support tried to read remote MSR with interrupts disabled.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |   36 +++++++++++++++++++++++++++-------
 1 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index c26c61f..6742d7b 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -29,6 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/sched.h>
 #include <linux/cpufreq.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -413,7 +414,7 @@ static int acpi_throttling_rdmsr(struct acpi_processor *pr,
 	} else {
 		msr_low = 0;
 		msr_high = 0;
-		rdmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL,
+		rdmsr_safe(MSR_IA32_THERM_CONTROL,
 			(u32 *)&msr_low , (u32 *) &msr_high);
 		msr = (msr_high << 32) | msr_low;
 		*value = (acpi_integer) msr;
@@ -438,7 +439,7 @@ static int acpi_throttling_wrmsr(struct acpi_processor *pr, acpi_integer value)
 			"HARDWARE addr space,NOT supported yet\n");
 	} else {
 		msr = value;
-		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL,
+		wrmsr_safe(MSR_IA32_THERM_CONTROL,
 			msr & 0xffffffff, msr >> 32);
 		ret = 0;
 	}
@@ -572,21 +573,32 @@ static int acpi_processor_get_throttling_ptc(struct acpi_processor *pr)
 		return -ENODEV;
 
 	pr->throttling.state = 0;
-	local_irq_disable();
+
 	value = 0;
 	ret = acpi_read_throttling_status(pr, &value);
 	if (ret >= 0) {
 		state = acpi_get_throttling_state(pr, value);
 		pr->throttling.state = state;
 	}
-	local_irq_enable();
 
 	return 0;
 }
 
 static int acpi_processor_get_throttling(struct acpi_processor *pr)
 {
-	return pr->throttling.acpi_processor_get_throttling(pr);
+	cpumask_t saved_mask;
+	int ret;
+
+	/*
+	 * Migrate task to the cpu pointed by pr.
+	 */
+	saved_mask = current->cpus_allowed;
+	set_cpus_allowed(current, cpumask_of_cpu(pr->id));
+	ret = pr->throttling.acpi_processor_get_throttling(pr);
+	/* restore the previous state */
+	set_cpus_allowed(current, saved_mask);
+
+	return ret;
 }
 
 static int acpi_processor_get_fadt_info(struct acpi_processor *pr)
@@ -717,21 +729,29 @@ static int acpi_processor_set_throttling_ptc(struct acpi_processor *pr,
 	if (state < pr->throttling_platform_limit)
 		return -EPERM;
 
-	local_irq_disable();
 	value = 0;
 	ret = acpi_get_throttling_value(pr, state, &value);
 	if (ret >= 0) {
 		acpi_write_throttling_state(pr, value);
 		pr->throttling.state = state;
 	}
-	local_irq_enable();
 
 	return 0;
 }
 
 int acpi_processor_set_throttling(struct acpi_processor *pr, int state)
 {
-	return pr->throttling.acpi_processor_set_throttling(pr, state);
+	cpumask_t saved_mask;
+	int ret;
+	/*
+	 * Migrate task to the cpu pointed by pr.
+	 */
+	saved_mask = current->cpus_allowed;
+	set_cpus_allowed(current, cpumask_of_cpu(pr->id));
+	ret = pr->throttling.acpi_processor_set_throttling(pr, state);
+	/* restore the previous state */
+	set_cpus_allowed(current, saved_mask);
+	return ret;
 }
 
 int acpi_processor_get_throttling_info(struct acpi_processor *pr)
-- 
1.5.3.7.949.g2221a6
