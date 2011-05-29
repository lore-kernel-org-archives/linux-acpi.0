From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/18] ACPI: processor: fix processor_physically_present in UP
 kernel
Date: Sun, 29 May 2011 05:44:11 -0400
Message-ID: <932df7414336a00f45e5aec62724cf736b0bcfd4.1306662156.git.len.brown@intel.com>
References: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:55532 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160Ab1E2J55 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 May 2011 05:57:57 -0400
Received: from arrandale.kernel.org ([unknown] [65.175.202.181])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLY0094DBOGA0E2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 29 May 2011 04:57:56 -0500 (CDT)
In-reply-to: <1306662253-11071-1-git-send-email-lenb@kernel.org>
In-reply-to: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
References: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Usually, there are multiple processors defined in ACPI table, for
example

    Scope (_PR)
    {
        Processor (CPU0, 0x00, 0x00000410, 0x06) {}
        Processor (CPU1, 0x01, 0x00000410, 0x06) {}
        Processor (CPU2, 0x02, 0x00000410, 0x06) {}
        Processor (CPU3, 0x03, 0x00000410, 0x06) {}
    }

processor_physically_present(...) will be called to check whether those
processors are physically present.

Currently we have below codes in processor_physically_present,

cpuid = acpi_get_cpuid(...);
if ((cpuid == -1) && (num_possible_cpus() > 1))
        return false;
return true;

In UP kernel, acpi_get_cpuid(...) always return -1 and
num_possible_cpus() always return 1, so
processor_physically_present(...) always returns true for all passed in
processor handles.

This is wrong for UP processor or SMP processor running UP kernel.

This patch removes the !SMP version of acpi_get_cpuid(), so both UP and
SMP kernel use the same acpi_get_cpuid function.

And for UP kernel, only processor 0 is valid.

https://bugzilla.kernel.org/show_bug.cgi?id=16548
https://bugzilla.kernel.org/show_bug.cgi?id=16357

Tested-by: Anton Kochkov <anton.kochkov@gmail.com>
Tested-by: Ambroz Bizjak <ambrop7@gmail.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |   12 +++++++++---
 include/acpi/processor.h      |    7 -------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 25bf17d..02d2a4c 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -37,7 +37,6 @@ static struct dmi_system_id __initdata processor_idle_dmi_table[] = {
 	{},
 };
 
-#ifdef CONFIG_SMP
 static int map_lapic_id(struct acpi_subtable_header *entry,
 		 u32 acpi_id, int *apic_id)
 {
@@ -165,7 +164,9 @@ exit:
 
 int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
 {
+#ifdef CONFIG_SMP
 	int i;
+#endif
 	int apic_id = -1;
 
 	apic_id = map_mat_entry(handle, type, acpi_id);
@@ -174,14 +175,19 @@ int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
 	if (apic_id == -1)
 		return apic_id;
 
+#ifdef CONFIG_SMP
 	for_each_possible_cpu(i) {
 		if (cpu_physical_id(i) == apic_id)
 			return i;
 	}
+#else
+	/* In UP kernel, only processor 0 is valid */
+	if (apic_id == 0)
+		return apic_id;
+#endif
 	return -1;
 }
 EXPORT_SYMBOL_GPL(acpi_get_cpuid);
-#endif
 
 static bool __init processor_physically_present(acpi_handle handle)
 {
@@ -217,7 +223,7 @@ static bool __init processor_physically_present(acpi_handle handle)
 	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
 	cpuid = acpi_get_cpuid(handle, type, acpi_id);
 
-	if ((cpuid == -1) && (num_possible_cpus() > 1))
+	if (cpuid == -1)
 		return false;
 
 	return true;
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 55192ac..ba4928c 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -310,14 +310,7 @@ static inline int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
 
 /* in processor_core.c */
 void acpi_processor_set_pdc(acpi_handle handle);
-#ifdef CONFIG_SMP
 int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
-#else
-static inline int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
-{
-	return -1;
-}
-#endif
 
 /* in processor_throttling.c */
 int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
-- 
1.7.5.3.367.ga9930.dirty

