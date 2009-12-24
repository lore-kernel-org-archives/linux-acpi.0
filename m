From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/34] ACPI: processor: factor out common _PDC settings
Date: Thu, 24 Dec 2009 01:23:41 -0500
Message-ID: <08ea48a326d8030ef5b7fb02292faf5a53c95e0a.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:52417 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904AbZLXGY1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 01:24:27 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV50099Y8GHDMP4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 00:24:18 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

Both x86 and ia64 initialize _PDC with mostly common bit settings.

Factor out the common settings and leave the arch-specific ones alone.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/kernel/acpi-processor.c |   10 +---------
 arch/x86/kernel/acpi/processor.c  |   10 +---------
 drivers/acpi/processor_pdc.c      |   11 +++++++++++
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/ia64/kernel/acpi-processor.c b/arch/ia64/kernel/acpi-processor.c
index ab72d46..ebe23f5 100644
--- a/arch/ia64/kernel/acpi-processor.c
+++ b/arch/ia64/kernel/acpi-processor.c
@@ -18,15 +18,7 @@ static void init_intel_pdc(struct acpi_processor *pr)
 {
 	u32 *buf = (u32 *)pr->pdc->pointer->buffer.pointer;
 
-	buf[0] = ACPI_PDC_REVISION_ID;
-	buf[1] = 1;
-	buf[2] = ACPI_PDC_EST_CAPABILITY_SMP;
-	/*
-	 * The default of PDC_SMP_T_SWCOORD bit is set for IA64 cpu so
-	 * that OSPM is capable of native ACPI throttling software
-	 * coordination using BIOS supplied _TSD info.
-	 */
-	buf[2] |= ACPI_PDC_SMP_T_SWCOORD;
+	buf[2] |= ACPI_PDC_EST_CAPABILITY_SMP;
 
 	return;
 }
diff --git a/arch/x86/kernel/acpi/processor.c b/arch/x86/kernel/acpi/processor.c
index 967860b..d722ca8 100644
--- a/arch/x86/kernel/acpi/processor.c
+++ b/arch/x86/kernel/acpi/processor.c
@@ -16,16 +16,8 @@ static void init_intel_pdc(struct acpi_processor *pr, struct cpuinfo_x86 *c)
 {
 	u32 *buf = (u32 *)pr->pdc->pointer->buffer.pointer;
 
-	buf[0] = ACPI_PDC_REVISION_ID;
-	buf[1] = 1;
-	buf[2] = ACPI_PDC_C_CAPABILITY_SMP;
+	buf[2] |= ACPI_PDC_C_CAPABILITY_SMP;
 
-	/*
-	 * The default of PDC_SMP_T_SWCOORD bit is set for intel x86 cpu so
-	 * that OSPM is capable of native ACPI throttling software
-	 * coordination using BIOS supplied _TSD info.
-	 */
-	buf[2] |= ACPI_PDC_SMP_T_SWCOORD;
 	if (cpu_has(c, X86_FEATURE_EST))
 		buf[2] |= ACPI_PDC_EST_CAPABILITY_SWSMP;
 
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 87946b6..ccda7c9 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -33,6 +33,15 @@ static struct dmi_system_id __cpuinitdata processor_idle_dmi_table[] = {
 	{},
 };
 
+static void acpi_set_pdc_bits(u32 *buf)
+{
+	buf[0] = ACPI_PDC_REVISION_ID;
+	buf[1] = 1;
+
+	/* Enable coordination with firmware's _TSD info */
+	buf[2] = ACPI_PDC_SMP_T_SWCOORD;
+}
+
 static void acpi_processor_init_pdc(struct acpi_processor *pr)
 {
 	struct acpi_object_list *obj_list;
@@ -63,6 +72,8 @@ static void acpi_processor_init_pdc(struct acpi_processor *pr)
 		return;
 	}
 
+	acpi_set_pdc_bits(buf);
+
 	obj->type = ACPI_TYPE_BUFFER;
 	obj->buffer.length = 12;
 	obj->buffer.pointer = (u8 *) buf;
-- 
1.6.0.6

