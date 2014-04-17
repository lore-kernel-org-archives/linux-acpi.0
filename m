From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 3/5 v2] trace, RAS: Add eMCA trace event interface
Date: Thu, 17 Apr 2014 02:28:37 -0400
Message-ID: <1397716119-6164-4-git-send-email-gong.chen@linux.intel.com>
References: <1397716119-6164-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30938 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbaDQGyH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Apr 2014 02:54:07 -0400
In-Reply-To: <1397716119-6164-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com
Cc: rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com, "Chen, Gong" <gong.chen@linux.intel.com>

Add trace interface to elaborate all H/W error related information.

v2 -> v1: spinlock is not needed anymore.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/Kconfig       |  3 ++-
 drivers/acpi/Makefile      |  1 +
 drivers/acpi/acpi_extlog.c | 53 +++++++++++++++++++++++++++++++++++++---
 drivers/ras/Kconfig        |  2 +-
 drivers/ras/ras-traces.c   |  1 +
 include/ras/ras_event.h    | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ab686b3..0023668 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -367,6 +367,7 @@ config ACPI_EXTLOG
 
 	  Enhanced MCA Logging allows firmware to provide additional error
 	  information to system software, synchronous with MCE or CMCI. This
-	  driver adds support for that functionality.
+	  driver adds support for that functionality with corresponding
+	  tracepoint which carries that information to userspace.
 
 endif	# ACPI
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 0331f91..f6abc4a 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -82,4 +82,5 @@ obj-$(CONFIG_ACPI_PROCESSOR_AGGREGATOR) += acpi_pad.o
 
 obj-$(CONFIG_ACPI_APEI)		+= apei/
 
+CFLAGS_acpi_extlog.o := -I$(src)
 obj-$(CONFIG_ACPI_EXTLOG)	+= acpi_extlog.o
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index c4a5d87..6192ec1 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -16,6 +16,7 @@
 #include <asm/mce.h>
 
 #include "apei/apei-internal.h"
+#include <ras/ras_event.h>
 
 #define EXT_ELOG_ENTRY_MASK	GENMASK_ULL(51, 0) /* elog entry address mask */
 
@@ -43,7 +44,11 @@ struct extlog_l1_head {
 
 static int old_edac_report_status;
 
+static char mem_location[CPER_REC_LEN];
+static char dimm_location[CPER_REC_LEN];
+
 static u8 extlog_dsm_uuid[] __initdata = "663E35AF-CC10-41A4-88EA-5470AF055295";
+static const uuid_le invalid_uuid = NULL_UUID_LE;
 
 /* L1 table related physical address */
 static u64 elog_base;
@@ -69,6 +74,28 @@ static u32 l1_percpu_entry;
 #define ELOG_ENTRY_ADDR(phyaddr) \
 	(phyaddr - elog_base + (u8 *)elog_addr)
 
+static void __trace_mem_error(const uuid_le *fru_id, char *fru_text,
+			       u64 err_count, u32 severity,
+			       struct cper_sec_mem_err *mem)
+{
+	u32 etype = ~0U;
+	u64 phy_addr = ~0ull;
+
+	if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE)
+		etype = mem->error_type;
+
+	if (mem->validation_bits & CPER_MEM_VALID_PA) {
+		phy_addr = mem->physical_addr;
+		if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
+			phy_addr &= mem->physical_addr_mask;
+	}
+
+	cper_mem_err_location(mem, mem_location);
+	cper_dimm_err_location(mem, dimm_location);
+	trace_extlog_mem_event(etype, dimm_location, fru_id, fru_text,
+			       err_count, severity, phy_addr, mem_location);
+}
+
 static struct acpi_generic_status *extlog_elog_entry_check(int cpu, int bank)
 {
 	int idx;
@@ -137,8 +164,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	struct mce *mce = (struct mce *)data;
 	int	bank = mce->bank;
 	int	cpu = mce->extcpu;
-	struct acpi_generic_status *estatus;
-	int rc;
+	struct acpi_generic_status *estatus, *tmp;
+	struct acpi_generic_data *gdata;
+	const uuid_le *fru_id = &invalid_uuid;
+	char *fru_text = "";
+	uuid_le *sec_type;
+	static u64 err_count;
 
 	estatus = extlog_elog_entry_check(cpu, bank);
 	if (estatus == NULL)
@@ -148,7 +179,23 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
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
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index 63e76a7..81cf0b2 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -32,6 +32,6 @@ menuconfig RAS
 if RAS
 config RAS_TRACE
 	def_bool y
-	depends on EDAC_MM_EDAC
+	depends on EDAC_MM_EDAC || ACPI_EXTLOG
 
 endif # RAS
diff --git a/drivers/ras/ras-traces.c b/drivers/ras/ras-traces.c
index b0c6ed1..197b1ea 100644
--- a/drivers/ras/ras-traces.c
+++ b/drivers/ras/ras-traces.c
@@ -9,4 +9,5 @@
 #define TRACE_INCLUDE_PATH ../../include/ras
 #include <ras/ras_event.h>
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(extlog_mem_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(mc_event);
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 21cdb0b..dfda854 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -8,6 +8,66 @@
 #include <linux/tracepoint.h>
 #include <linux/edac.h>
 #include <linux/ktime.h>
+#include <linux/cper.h>
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
+		 char *dimm_info,
+		 const uuid_le *fru_id,
+		 char *fru_text,
+		 u64 error_count,
+		 u32 severity,
+		 u64 phy_addr,
+		 char *mem_loc),
+
+	TP_ARGS(etype, dimm_info, fru_id, fru_text, error_count, severity,
+		phy_addr, mem_loc),
+
+	TP_STRUCT__entry(
+		__field(u32, etype)
+		__dynamic_array(char, dimm_info, CPER_REC_LEN)
+		__field(u64, error_count)
+		__field(u32, severity)
+		__field(u64, paddr)
+		__string(mem_loc, mem_loc)
+		__dynamic_array(char, fru, CPER_REC_LEN)
+	),
+
+	TP_fast_assign(
+		__entry->error_count = error_count;
+		__entry->severity = severity;
+		__entry->etype = etype;
+		if (dimm_info[0] != '\0')
+			snprintf(__get_dynamic_array(dimm_info),
+				 CPER_REC_LEN - 1, "%s", dimm_info);
+		else
+			__assign_str(dimm_info, "");
+		__entry->paddr = phy_addr;
+		__assign_str(mem_loc, mem_loc);
+		snprintf(__get_dynamic_array(fru), CPER_REC_LEN - 1,
+			 "FRU: %pUl %.20s", fru_id, fru_text);
+	),
+
+	TP_printk("%llu %s error%s: %s %s physical addr: 0x%016llx%s %s",
+		  __entry->error_count,
+		  cper_severity_str(__entry->severity),
+		  __entry->error_count > 1 ? "s" : "",
+		  cper_mem_err_type_str(__entry->etype),
+		  __get_str(dimm_info),
+		  __entry->paddr,
+		  __get_str(mem_loc),
+		  __get_str(fru))
+);
 
 /*
  * Hardware Events Report
-- 
1.9.0

