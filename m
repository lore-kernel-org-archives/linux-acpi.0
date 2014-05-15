From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 5/7 v5] trace, RAS: Add eMCA trace event interface
Date: Thu, 15 May 2014 04:30:44 -0400
Message-ID: <1400142646-10127-6-git-send-email-gong.chen@linux.intel.com>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7844 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbaEOJDn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 May 2014 05:03:43 -0400
In-Reply-To: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com
Cc: linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>

Add trace interface to elaborate all H/W error related information.

v5 -> v4: Add physical mask(LSB) in trace.
v4 -> v3: change ras trace dependency rule.
v3 -> v2: minor adjustment according to the suggestion from Boris.
v2 -> v1: spinlock is not needed anymore.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/Kconfig       |  4 +++-
 drivers/acpi/acpi_extlog.c | 58 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/ras/ras.c          |  1 +
 include/ras/ras_event.h    | 57 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ab686b3..5af6013 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -353,6 +353,7 @@ config ACPI_EXTLOG
 	tristate "Extended Error Log support"
 	depends on X86_MCE && X86_LOCAL_APIC
 	select UEFI_CPER
+	select RAS_TRACE
 	default n
 	help
 	  Certain usages such as Predictive Failure Analysis (PFA) require
@@ -367,6 +368,7 @@ config ACPI_EXTLOG
 
 	  Enhanced MCA Logging allows firmware to provide additional error
 	  information to system software, synchronous with MCE or CMCI. This
-	  driver adds support for that functionality.
+	  driver adds support for that functionality with corresponding
+	  tracepoint which carries that information to userspace.
 
 endif	# ACPI
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index c4a5d87..b1dcb5b 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -16,6 +16,7 @@
 #include <asm/mce.h>
 
 #include "apei/apei-internal.h"
+#include <ras/ras_event.h>
 
 #define EXT_ELOG_ENTRY_MASK	GENMASK_ULL(51, 0) /* elog entry address mask */
 
@@ -43,6 +44,9 @@ struct extlog_l1_head {
 
 static int old_edac_report_status;
 
+static char mem_location[CPER_REC_LEN];
+static char dimm_location[CPER_REC_LEN];
+
 static u8 extlog_dsm_uuid[] __initdata = "663E35AF-CC10-41A4-88EA-5470AF055295";
 
 /* L1 table related physical address */
@@ -69,6 +73,34 @@ static u32 l1_percpu_entry;
 #define ELOG_ENTRY_ADDR(phyaddr) \
 	(phyaddr - elog_base + (u8 *)elog_addr)
 
+static void __trace_mem_error(const uuid_le *fru_id, char *fru_text,
+			       u64 err_count, u32 severity,
+			       struct cper_sec_mem_err *mem)
+{
+	u32 etype = ~0U;
+	char pa_info[64];
+	u8 n = 0;
+
+	if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE)
+		etype = mem->error_type;
+
+	memset(pa_info, 0, 64);
+	if (mem->validation_bits & CPER_MEM_VALID_PA)
+		n = snprintf(pa_info, 63, "physical addr: 0x%016llx ",
+			     mem->physical_addr);
+
+	if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
+		snprintf(pa_info + n, 63 - n, "addr LSB: 0x%x ",
+			 (u8)__ffs64(mem->physical_addr_mask));
+
+	memset(mem_location, 0, CPER_REC_LEN);
+	cper_mem_err_location(mem, mem_location);
+	memset(dimm_location, 0, CPER_REC_LEN);
+	cper_dimm_err_location(mem, dimm_location);
+	trace_extlog_mem_event(etype, fru_id, err_count, severity,
+			       dimm_location, pa_info, mem_location, fru_text);
+}
+
 static struct acpi_generic_status *extlog_elog_entry_check(int cpu, int bank)
 {
 	int idx;
@@ -137,8 +169,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	struct mce *mce = (struct mce *)data;
 	int	bank = mce->bank;
 	int	cpu = mce->extcpu;
-	struct acpi_generic_status *estatus;
-	int rc;
+	struct acpi_generic_status *estatus, *tmp;
+	struct acpi_generic_data *gdata;
+	const uuid_le *fru_id = &NULL_UUID_LE;
+	char *fru_text = "";
+	uuid_le *sec_type;
+	static u64 err_count;
 
 	estatus = extlog_elog_entry_check(cpu, bank);
 	if (estatus == NULL)
@@ -148,7 +184,23 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	/* clear record status to enable BIOS to update it again */
 	estatus->block_status = 0;
 
-	rc = print_extlog_rcd(NULL, (struct acpi_generic_status *)elog_buf, cpu);
+	tmp = (struct acpi_generic_status *)elog_buf;
+	print_extlog_rcd(NULL, tmp, cpu);
+
+	/* log event via trace */
+	err_count++;
+	gdata = (struct acpi_generic_data *)(tmp + 1);
+	if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
+		fru_id = (uuid_le *)gdata->fru_id;
+	if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
+		fru_text = gdata->fru_text;
+	sec_type = (uuid_le *)gdata->section_type;
+	if (!uuid_le_cmp(*sec_type, CPER_SEC_PLATFORM_MEM)) {
+		struct cper_sec_mem_err *mem_err = (void *)(gdata + 1);
+		if (gdata->error_data_length >= sizeof(*mem_err))
+			__trace_mem_error(fru_id, fru_text, err_count,
+					  gdata->error_severity, mem_err);
+	}
 
 	return NOTIFY_STOP;
 }
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 4cac43a..da227a3 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -23,4 +23,5 @@ static int __init ras_init(void)
 }
 subsys_initcall(ras_init);
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(extlog_mem_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(mc_event);
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index acbcbb8..ac6e6d1 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -9,6 +9,63 @@
 #include <linux/edac.h>
 #include <linux/ktime.h>
 #include <linux/aer.h>
+#include <linux/cper.h>
+
+
+/*
+ * MCE Extended Error Log trace event
+ *
+ * These events are generated when hardware detects a corrected or
+ * uncorrected event.
+ *
+ */
+
+/* memory trace event */
+
+TRACE_EVENT(extlog_mem_event,
+	TP_PROTO(u32 etype,
+		 const uuid_le *fru_id,
+		 u64 error_count,
+		 u32 severity,
+		 char *dimm_info,
+		 char *pa_info,
+		 char *mem_loc,
+		 char *fru_text),
+
+	TP_ARGS(etype, fru_id, error_count, severity, dimm_info, pa_info,
+		mem_loc, fru_text),
+
+	TP_STRUCT__entry(
+		__field(u32, etype)
+		__field(u64, error_count)
+		__field(u32, severity)
+		__string(dimm_info, dimm_info)
+		__string(pa_info, pa_info)
+		__string(mem_loc, mem_loc)
+		__dynamic_array(char, fru, CPER_REC_LEN)
+	),
+
+	TP_fast_assign(
+		__entry->error_count = error_count;
+		__entry->severity = severity;
+		__entry->etype = etype;
+		__assign_str(dimm_info, dimm_info);
+		__assign_str(pa_info, pa_info);
+		__assign_str(mem_loc, mem_loc);
+		snprintf(__get_dynamic_array(fru), CPER_REC_LEN - 1,
+			 "FRU: %pUl %.20s", fru_id, fru_text);
+	),
+
+	TP_printk("%llu %s error%s: %s %s%s%s%s",
+		  __entry->error_count,
+		  cper_severity_str(__entry->severity),
+		  __entry->error_count > 1 ? "s" : "",
+		  cper_mem_err_type_str(__entry->etype),
+		  __get_str(dimm_info),
+		  __get_str(pa_info),
+		  __get_str(mem_loc),
+		  __get_str(fru))
+);
 
 /*
  * Hardware Events Report
-- 
2.0.0.rc0

