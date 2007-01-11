From: Len Brown <len.brown@intel.com>
Subject: [PATCH 3/7] ACPI: rename cstate_entry_s to cstate_entry
Date: Thu, 11 Jan 2007 04:11:44 -0500
Message-ID: <11685067113037-git-send-email-len.brown@intel.com>
References: <11685067081383-git-send-email-len.brown@intel.com> <11685067091916-git-send-email-len.brown@intel.com> <11685067101245-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7019 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030247AbXAKJLx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jan 2007 04:11:53 -0500
In-Reply-To: <11685067101245-git-send-email-len.brown@intel.com>
Message-Id: <5d65131fa8d333d4575e7dfe5a05d3a9fa4a687e.1168506584.git.len.brown@intel.com>
In-Reply-To: <3948ec9406f9a60a43d63f23f6f5284db6529b9c.1168506584.git.len.brown@intel.com>
References: <3948ec9406f9a60a43d63f23f6f5284db6529b9c.1168506584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

style change only.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/kernel/acpi/cstate.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/i386/kernel/acpi/cstate.c b/arch/i386/kernel/acpi/cstate.c
index 12e937c..2d39f55 100644
--- a/arch/i386/kernel/acpi/cstate.c
+++ b/arch/i386/kernel/acpi/cstate.c
@@ -47,13 +47,13 @@ EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
 
 /* The code below handles cstate entry with monitor-mwait pair on Intel*/
 
-struct cstate_entry_s {
+struct cstate_entry {
 	struct {
 		unsigned int eax;
 		unsigned int ecx;
 	} states[ACPI_PROCESSOR_MAX_POWER];
 };
-static struct cstate_entry_s *cpu_cstate_entry;	/* per CPU ptr */
+static struct cstate_entry *cpu_cstate_entry;	/* per CPU ptr */
 
 static short mwait_supported[ACPI_PROCESSOR_MAX_POWER];
 
@@ -71,7 +71,7 @@ static short mwait_supported[ACPI_PROCESSOR_MAX_POWER];
 int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 		struct acpi_processor_cx *cx, struct acpi_power_register *reg)
 {
-	struct cstate_entry_s *percpu_entry;
+	struct cstate_entry *percpu_entry;
 	struct cpuinfo_x86 *c = cpu_data + cpu;
 
 	cpumask_t saved_mask;
@@ -136,7 +136,7 @@ EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
 void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
 {
 	unsigned int cpu = smp_processor_id();
-	struct cstate_entry_s *percpu_entry;
+	struct cstate_entry *percpu_entry;
 
 	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
 	mwait_idle_with_hints(percpu_entry->states[cx->index].eax,
@@ -150,7 +150,7 @@ static int __init ffh_cstate_init(void)
 	if (c->x86_vendor != X86_VENDOR_INTEL)
 		return -1;
 
-	cpu_cstate_entry = alloc_percpu(struct cstate_entry_s);
+	cpu_cstate_entry = alloc_percpu(struct cstate_entry);
 	return 0;
 }
 
-- 
1.4.4.4.ge05d
