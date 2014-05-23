From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/7 v4] CPER: Adjust code flow of some functions
Date: Fri, 23 May 2014 12:11:43 +0200
Message-ID: <20140523101143.GC21332@pd.tnic>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-4-git-send-email-gong.chen@linux.intel.com>
 <20140521110521.GF21205@pd.tnic>
 <20140521235159.GB1644@gchen.bj.intel.com>
 <20140522105242.GG4383@pd.tnic>
 <20140523014910.GB16945@gchen.bj.intel.com>
 <20140523093703.GB21332@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:54749 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbaEWKLt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 May 2014 06:11:49 -0400
Content-Disposition: inline
In-Reply-To: <20140523093703.GB21332@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org

On Fri, May 23, 2014 at 11:37:03AM +0200, Borislav Petkov wrote:
> Or if you don't wanna, I can do it instead - it'll be much easier for
> me than reviewing it again.

Here's a version with the suggested changes incorporated that builds
fine here:

--
Index: linux/drivers/acpi/Kconfig
===================================================================
--- linux.orig/drivers/acpi/Kconfig	2014-05-23 11:14:33.856625534 +0200
+++ linux/drivers/acpi/Kconfig	2014-05-23 11:14:33.840625534 +0200
@@ -370,6 +370,7 @@ config ACPI_EXTLOG
 	tristate "Extended Error Log support"
 	depends on X86_MCE && X86_LOCAL_APIC
 	select UEFI_CPER
+	select RAS_TRACE
 	default n
 	help
 	  Certain usages such as Predictive Failure Analysis (PFA) require
@@ -384,6 +385,7 @@ config ACPI_EXTLOG
 
 	  Enhanced MCA Logging allows firmware to provide additional error
 	  information to system software, synchronous with MCE or CMCI. This
-	  driver adds support for that functionality.
+	  driver adds support for that functionality with corresponding
+	  tracepoint which carries that information to userspace.
 
 endif	# ACPI
Index: linux/drivers/acpi/acpi_extlog.c
===================================================================
--- linux.orig/drivers/acpi/acpi_extlog.c	2014-05-23 11:14:33.856625534 +0200
+++ linux/drivers/acpi/acpi_extlog.c	2014-05-23 12:09:56.000000000 +0200
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
@@ -69,6 +73,30 @@ static u32 l1_percpu_entry;
 #define ELOG_ENTRY_ADDR(phyaddr) \
 	(phyaddr - elog_base + (u8 *)elog_addr)
 
+static void __trace_mem_error(const uuid_le *fru_id, char *fru_text,
+			       u64 err_count, u32 severity,
+			       struct cper_sec_mem_err *mem)
+{
+	u8 etype = -1, pa_mask_lsb = 0;
+	u64 pa = 0;
+
+	if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE)
+		etype = mem->error_type;
+
+	if (mem->validation_bits & CPER_MEM_VALID_PA)
+		pa = mem->physical_addr;
+
+	if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
+		pa_mask_lsb = (u8)__ffs64(mem->physical_addr_mask);
+
+	memset(mem_location, 0, CPER_REC_LEN);
+	cper_mem_err_location(mem, mem_location);
+	memset(dimm_location, 0, CPER_REC_LEN);
+	cper_dimm_err_location(mem, dimm_location);
+	trace_extlog_mem_event(err_count, etype, severity, pa, pa_mask_lsb,
+			       fru_id, dimm_location, mem_location, fru_text);
+}
+
 static struct acpi_generic_status *extlog_elog_entry_check(int cpu, int bank)
 {
 	int idx;
@@ -137,8 +165,12 @@ static int extlog_print(struct notifier_
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
@@ -148,7 +180,23 @@ static int extlog_print(struct notifier_
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
Index: linux/drivers/ras/ras.c
===================================================================
--- linux.orig/drivers/ras/ras.c	2014-05-23 11:14:33.856625534 +0200
+++ linux/drivers/ras/ras.c	2014-05-23 11:14:33.840625534 +0200
@@ -23,4 +23,5 @@ static int __init ras_init(void)
 }
 subsys_initcall(ras_init);
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(extlog_mem_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(mc_event);
Index: linux/include/ras/ras_event.h
===================================================================
--- linux.orig/include/ras/ras_event.h	2014-05-23 11:14:33.856625534 +0200
+++ linux/include/ras/ras_event.h	2014-05-23 12:10:45.252569816 +0200
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
+ */
+
+TRACE_EVENT(extlog_mem_event,
+	TP_PROTO(u32 error_number,
+		 u8 etype,
+		 u8 severity,
+		 u64 pa,
+		 u8 pa_mask_lsb,
+		 const uuid_le *fru_id,
+		 const char *dimm_info,
+		 const char *mem_loc,
+		 const char *fru_text),
+
+	TP_ARGS(error_number, etype, severity, pa, pa_mask_lsb,
+		fru_id, dimm_info, mem_loc, fru_text),
+
+	TP_STRUCT__entry(
+		__field(u32, error_number)
+		__field(u8, etype)
+		__field(u8, severity)
+		__field(u64, pa)
+		__field(u8, pa_mask_lsb)
+		__string(dimm_info, dimm_info)
+		__string(mem_loc, mem_loc)
+		__dynamic_array(char, fru, CPER_REC_LEN)
+	),
+
+	TP_fast_assign(
+		__entry->error_number = error_number;
+		__entry->etype = etype;
+		__entry->severity = severity;
+		__entry->pa = pa;
+		__entry->pa_mask_lsb = pa_mask_lsb;
+		__assign_str(dimm_info, dimm_info);
+		__assign_str(mem_loc, mem_loc);
+		snprintf(__get_dynamic_array(fru), CPER_REC_LEN - 1,
+			 "FRU: %pUl %.20s", fru_id, fru_text);
+	),
+
+	TP_printk("%d %s error: %s %s %llx (mask lsb: %x), %s%s",
+		  __entry->error_number,
+		  cper_severity_str(__entry->severity),
+		  cper_mem_err_type_str(__entry->etype),
+		  __get_str(dimm_info),
+		  __entry->pa,
+		  __entry->pa_mask_lsb,
+		  __get_str(mem_loc),
+		  __get_str(fru))
+);
 
 /*
  * Hardware Events Report

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
