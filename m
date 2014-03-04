From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 2/2] trace, RAS: Add eMCA trace event interface
Date: Tue,  4 Mar 2014 04:23:17 -0500
Message-ID: <1393924997-8992-3-git-send-email-gong.chen@linux.intel.com>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34685 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756410AbaCDJpw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Mar 2014 04:45:52 -0500
In-Reply-To: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com
Cc: arozansk@redhat.com, linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>

Add trace interface to elaborate all H/W error related information.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/Kconfig        |   3 +-
 drivers/acpi/Makefile       |   1 +
 drivers/acpi/acpi_extlog.c  | 131 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/efi/cper.c |  13 ++++-
 include/linux/cper.h        |   2 +
 include/ras/ras_event.h     |  62 +++++++++++++++++++++
 kernel/trace/ras-traces.c   |   1 +
 7 files changed, 208 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 4770de5..3e569d4 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -363,6 +363,7 @@ config ACPI_EXTLOG
 
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
index c4a5d87..fbdebad 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -14,8 +14,10 @@
 #include <linux/edac.h>
 #include <asm/cpu.h>
 #include <asm/mce.h>
+#include <linux/dmi.h>
 
 #include "apei/apei-internal.h"
+#include <ras/ras_event.h>
 
 #define EXT_ELOG_ENTRY_MASK	GENMASK_ULL(51, 0) /* elog entry address mask */
 
@@ -44,6 +46,11 @@ struct extlog_l1_head {
 static int old_edac_report_status;
 
 static u8 extlog_dsm_uuid[] __initdata = "663E35AF-CC10-41A4-88EA-5470AF055295";
+static const uuid_le invalid_uuid = NULL_UUID_LE;
+
+static DEFINE_RAW_SPINLOCK(trace_lock);
+static char mem_location[LOC_LEN];
+static char dimm_location[LOC_LEN];
 
 /* L1 table related physical address */
 static u64 elog_base;
@@ -69,6 +76,106 @@ static u32 l1_percpu_entry;
 #define ELOG_ENTRY_ADDR(phyaddr) \
 	(phyaddr - elog_base + (u8 *)elog_addr)
 
+static void mem_err_location(struct cper_sec_mem_err *mem)
+{
+	char *p;
+	u32 n = 0;
+
+	memset(mem_location, 0, LOC_LEN);
+	p = mem_location;
+	if (mem->validation_bits & CPER_MEM_VALID_NODE)
+		n += sprintf(p + n, " node: %d", mem->node);
+	if (n >= LOC_LEN)
+		goto end;
+	if (mem->validation_bits & CPER_MEM_VALID_CARD)
+		n += sprintf(p + n, " card: %d", mem->card);
+	if (n >= LOC_LEN)
+		goto end;
+	if (mem->validation_bits & CPER_MEM_VALID_MODULE)
+		n += sprintf(p + n, " module: %d", mem->module);
+	if (n >= LOC_LEN)
+		goto end;
+	if (mem->validation_bits & CPER_MEM_VALID_RANK_NUMBER)
+		n += sprintf(p + n, " rank: %d", mem->rank);
+	if (n >= LOC_LEN)
+		goto end;
+	if (mem->validation_bits & CPER_MEM_VALID_BANK)
+		n += sprintf(p + n, " bank: %d", mem->bank);
+	if (n >= LOC_LEN)
+		goto end;
+	if (mem->validation_bits & CPER_MEM_VALID_DEVICE)
+		n += sprintf(p + n, " device: %d", mem->device);
+	if (n >= LOC_LEN)
+		goto end;
+	if (mem->validation_bits & CPER_MEM_VALID_ROW)
+		n += sprintf(p + n, " row: %d", mem->row);
+	if (n >= LOC_LEN)
+		goto end;
+	if (mem->validation_bits & CPER_MEM_VALID_COLUMN)
+		n += sprintf(p + n, " column: %d", mem->column);
+	if (n >= LOC_LEN)
+		goto end;
+	if (mem->validation_bits & CPER_MEM_VALID_BIT_POSITION)
+		n += sprintf(p + n, " bit_position: %d", mem->bit_pos);
+	if (n >= LOC_LEN)
+		goto end;
+	if (mem->validation_bits & CPER_MEM_VALID_REQUESTOR_ID)
+		n += sprintf(p + n, " requestor_id: 0x%016llx",
+				mem->requestor_id);
+	if (n >= LOC_LEN)
+		goto end;
+	if (mem->validation_bits & CPER_MEM_VALID_RESPONDER_ID)
+		n += sprintf(p + n, " responder_id: 0x%016llx",
+				mem->responder_id);
+	if (n >= LOC_LEN)
+		goto end;
+	if (mem->validation_bits & CPER_MEM_VALID_TARGET_ID)
+		n += sprintf(p + n, " target_id: 0x%016llx", mem->target_id);
+end:
+	return;
+}
+
+static void dimm_err_location(struct cper_sec_mem_err *mem)
+{
+	const char *bank = NULL, *device = NULL;
+
+	memset(dimm_location, 0, LOC_LEN);
+	if (!(mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE))
+		return;
+
+	dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
+	if (bank != NULL && device != NULL)
+		snprintf(dimm_location, LOC_LEN - 1, "%s %s", bank, device);
+	else
+		snprintf(dimm_location, LOC_LEN - 1, "DMI handle: 0x%.4x",
+			 mem->mem_dev_handle);
+}
+
+static void trace_mem_error(const uuid_le *fru_id, char *fru_text,
+			    u64 err_count, u32 severity,
+			    struct cper_sec_mem_err *mem)
+{
+	u32 etype = ~0U;
+	u64 phy_addr = ~0ull;
+	unsigned long flags;
+
+	if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE)
+		etype = mem->error_type;
+	if (mem->validation_bits & CPER_MEM_VALID_PA) {
+		phy_addr = mem->physical_addr;
+		if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
+			phy_addr &= mem->physical_addr_mask;
+	}
+
+	raw_spin_lock_irqsave(&trace_lock, flags);
+	mem_err_location(mem);
+	dimm_err_location(mem);
+
+	trace_extlog_mem_event(etype, dimm_location, fru_id, fru_text,
+			       err_count, severity, phy_addr, mem_location);
+	raw_spin_unlock_irqrestore(&trace_lock, flags);
+}
+
 static struct acpi_generic_status *extlog_elog_entry_check(int cpu, int bank)
 {
 	int idx;
@@ -137,7 +244,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	struct mce *mce = (struct mce *)data;
 	int	bank = mce->bank;
 	int	cpu = mce->extcpu;
-	struct acpi_generic_status *estatus;
+	struct acpi_generic_status *estatus, *tmp;
+	struct acpi_generic_data *gdata;
+	const uuid_le *fru_id = &invalid_uuid;
+	char *fru_text = "";
+	uuid_le *sec_type;
+	static u64 err_count;
 	int rc;
 
 	estatus = extlog_elog_entry_check(cpu, bank);
@@ -149,6 +261,23 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	estatus->block_status = 0;
 
 	rc = print_extlog_rcd(NULL, (struct acpi_generic_status *)elog_buf, cpu);
+	tmp = (struct acpi_generic_status *)elog_buf;
+	gdata = (struct acpi_generic_data *)(tmp + 1);
+	rc = print_extlog_rcd(NULL, tmp, cpu);
+
+	/* trace extended error log */
+	err_count++;
+	if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
+		fru_id = (uuid_le *)gdata->fru_id;
+	if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
+		fru_text = gdata->fru_text;
+	sec_type = (uuid_le *)gdata->section_type;
+	if (!uuid_le_cmp(*sec_type, CPER_SEC_PLATFORM_MEM)) {
+		struct cper_sec_mem_err *mem_err = (void *)(gdata + 1);
+		if (gdata->error_data_length >= sizeof(*mem_err))
+			trace_mem_error(fru_id, fru_text, err_count,
+					gdata->error_severity, mem_err);
+	}
 
 	return NOTIFY_STOP;
 }
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 1491dd4..9d3e2c4 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -57,11 +57,12 @@ static const char *cper_severity_strs[] = {
 	"info",
 };
 
-static const char *cper_severity_str(unsigned int severity)
+const char *cper_severity_str(unsigned int severity)
 {
 	return severity < ARRAY_SIZE(cper_severity_strs) ?
 		cper_severity_strs[severity] : "unknown";
 }
+EXPORT_SYMBOL_GPL(cper_severity_str);
 
 /*
  * cper_print_bits - print strings for set bits
@@ -196,6 +197,13 @@ static const char *cper_mem_err_type_strs[] = {
 	"physical memory map-out event",
 };
 
+const char *cper_mem_err_type_str(unsigned int etype)
+{
+	return etype < ARRAY_SIZE(cper_mem_err_type_strs) ?
+		cper_mem_err_type_strs[etype] : "unknown";
+}
+EXPORT_SYMBOL_GPL(cper_mem_err_type_str);
+
 static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem)
 {
 	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
@@ -233,8 +241,7 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem)
 	if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE) {
 		u8 etype = mem->error_type;
 		printk("%s""error_type: %d, %s\n", pfx, etype,
-		       etype < ARRAY_SIZE(cper_mem_err_type_strs) ?
-		       cper_mem_err_type_strs[etype] : "unknown");
+			cper_mem_err_type_str(etype));
 	}
 	if (mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
 		const char *bank = NULL, *device = NULL;
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 2fc0ec3..c6d87fc 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -395,6 +395,8 @@ struct cper_sec_pcie {
 #pragma pack()
 
 u64 cper_next_record_id(void);
+const char *cper_severity_str(unsigned int);
+const char *cper_mem_err_type_str(unsigned int);
 void cper_print_bits(const char *prefix, unsigned int bits,
 		     const char * const strs[], unsigned int strs_size);
 
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 21cdb0b..97f2192 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -8,6 +8,68 @@
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
+#define LOC_LEN		512
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
+		__dynamic_array(char, dimm_info, LOC_LEN)
+		__field(u64, error_count)
+		__field(u32, severity)
+		__field(u64, paddr)
+		__string(mem_loc, mem_loc)
+		__dynamic_array(char, fru, LOC_LEN)
+	),
+
+	TP_fast_assign(
+		__entry->error_count = error_count;
+		__entry->severity = severity;
+		__entry->etype = etype;
+		if (dimm_info[0] != '\0')
+			snprintf(__get_dynamic_array(dimm_info), LOC_LEN - 1,
+				 "%s", dimm_info);
+		else
+			__assign_str(dimm_info, "");
+		__entry->paddr = phy_addr;
+		__assign_str(mem_loc, mem_loc);
+		snprintf(__get_dynamic_array(fru), LOC_LEN - 1,
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
diff --git a/kernel/trace/ras-traces.c b/kernel/trace/ras-traces.c
index b0c6ed1..197b1ea 100644
--- a/kernel/trace/ras-traces.c
+++ b/kernel/trace/ras-traces.c
@@ -9,4 +9,5 @@
 #define TRACE_INCLUDE_PATH ../../include/ras
 #include <ras/ras_event.h>
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(extlog_mem_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(mc_event);
-- 
1.8.4.3

