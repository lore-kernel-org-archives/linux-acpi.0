From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 2/5 v2] CPER: Adjust code flow of some functions
Date: Thu, 17 Apr 2014 02:28:36 -0400
Message-ID: <1397716119-6164-3-git-send-email-gong.chen@linux.intel.com>
References: <1397716119-6164-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42569 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbaDQGyD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Apr 2014 02:54:03 -0400
In-Reply-To: <1397716119-6164-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com
Cc: rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com, "Chen, Gong" <gong.chen@linux.intel.com>

Some codes can be reorganzied as a common function for
other usages.

v2 -> v1: Use scnprintf to simplify codes.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 drivers/firmware/efi/cper.c | 116 +++++++++++++++++++++++++++++++-------------
 include/linux/cper.h        |  12 +++++
 2 files changed, 95 insertions(+), 33 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 1491dd4..951049b 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -34,6 +34,10 @@
 #include <linux/aer.h>
 
 #define INDENT_SP	" "
+
+static char mem_location[CPER_REC_LEN];
+static char dimm_location[CPER_REC_LEN];
+
 /*
  * CPER record ID need to be unique even after reboot, because record
  * ID is used as index for ERST storage, while CPER records from
@@ -57,11 +61,12 @@ static const char *cper_severity_strs[] = {
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
@@ -196,55 +201,100 @@ static const char *cper_mem_err_type_strs[] = {
 	"physical memory map-out event",
 };
 
-static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem)
+const char *cper_mem_err_type_str(unsigned int etype)
 {
-	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
-		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
-	if (mem->validation_bits & CPER_MEM_VALID_PA)
-		printk("%s""physical_address: 0x%016llx\n",
-		       pfx, mem->physical_addr);
-	if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
-		printk("%s""physical_address_mask: 0x%016llx\n",
-		       pfx, mem->physical_addr_mask);
+	return etype < ARRAY_SIZE(cper_mem_err_type_strs) ?
+		cper_mem_err_type_strs[etype] : "unknown";
+}
+EXPORT_SYMBOL_GPL(cper_mem_err_type_str);
+
+void cper_mem_err_location(const struct cper_sec_mem_err *mem, char *msg)
+{
+	u32 n = 0, len;
+
+	if (!msg)
+		return;
+
+	len = strlen(msg);
+	memset(msg, 0, len);
+
 	if (mem->validation_bits & CPER_MEM_VALID_NODE)
-		pr_debug("node: %d\n", mem->node);
+		n += scnprintf(msg + n, len - n - 1, " node: %d", mem->node);
 	if (mem->validation_bits & CPER_MEM_VALID_CARD)
-		pr_debug("card: %d\n", mem->card);
+		n += scnprintf(msg + n, len - n - 1, " card: %d", mem->card);
 	if (mem->validation_bits & CPER_MEM_VALID_MODULE)
-		pr_debug("module: %d\n", mem->module);
+		n += scnprintf(msg + n, len - n - 1, " module: %d",
+			       mem->module);
 	if (mem->validation_bits & CPER_MEM_VALID_RANK_NUMBER)
-		pr_debug("rank: %d\n", mem->rank);
+		n += scnprintf(msg + n, len - n - 1, " rank: %d", mem->rank);
 	if (mem->validation_bits & CPER_MEM_VALID_BANK)
-		pr_debug("bank: %d\n", mem->bank);
+		n += scnprintf(msg + n, len - n - 1, " bank: %d", mem->bank);
 	if (mem->validation_bits & CPER_MEM_VALID_DEVICE)
-		pr_debug("device: %d\n", mem->device);
+		n += scnprintf(msg + n, len - n - 1, " device: %d",
+			       mem->device);
 	if (mem->validation_bits & CPER_MEM_VALID_ROW)
-		pr_debug("row: %d\n", mem->row);
+		n += scnprintf(msg + n, len - n - 1, " row: %d", mem->row);
 	if (mem->validation_bits & CPER_MEM_VALID_COLUMN)
-		pr_debug("column: %d\n", mem->column);
+		n += scnprintf(msg + n, len - n - 1, " column: %d",
+			       mem->column);
 	if (mem->validation_bits & CPER_MEM_VALID_BIT_POSITION)
-		pr_debug("bit_position: %d\n", mem->bit_pos);
+		n += scnprintf(msg + n, len - n - 1, " bit_position: %d",
+			       mem->bit_pos);
 	if (mem->validation_bits & CPER_MEM_VALID_REQUESTOR_ID)
-		pr_debug("requestor_id: 0x%016llx\n", mem->requestor_id);
+		n += scnprintf(msg + n, len - n - 1,
+			       " requestor_id: 0x%016llx", mem->requestor_id);
 	if (mem->validation_bits & CPER_MEM_VALID_RESPONDER_ID)
-		pr_debug("responder_id: 0x%016llx\n", mem->responder_id);
+		n += scnprintf(msg + n, len - n - 1,
+			       " responder_id: 0x%016llx", mem->responder_id);
 	if (mem->validation_bits & CPER_MEM_VALID_TARGET_ID)
-		pr_debug("target_id: 0x%016llx\n", mem->target_id);
+		scnprintf(msg + n, len - n - 1, " target_id: 0x%016llx",
+			  mem->target_id);
+}
+EXPORT_SYMBOL_GPL(cper_mem_err_location);
+
+void cper_dimm_err_location(const struct cper_sec_mem_err *mem, char *msg)
+{
+	const char *bank = NULL, *device = NULL;
+	int len;
+
+	if (!msg)
+		return;
+
+	len = strlen(msg);
+	memset(msg, 0, len);
+
+	if (!(mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE))
+		return;
+
+	dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
+	if (bank && device)
+		snprintf(msg, len - 1, "DIMM location: %s %s", bank, device);
+	else
+		snprintf(msg, len - 1,
+			 "DIMM location: not present. DMI handle: 0x%.4x",
+			 mem->mem_dev_handle);
+}
+EXPORT_SYMBOL_GPL(cper_dimm_err_location);
+
+static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem)
+{
+	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
+		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
+	if (mem->validation_bits & CPER_MEM_VALID_PA)
+		printk("%s""physical_address: 0x%016llx\n",
+		       pfx, mem->physical_addr);
+	if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
+		printk("%s""physical_address_mask: 0x%016llx\n",
+		       pfx, mem->physical_addr_mask);
+	cper_mem_err_location(mem, mem_location);
+	pr_debug("%s", mem_location);
 	if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE) {
 		u8 etype = mem->error_type;
 		printk("%s""error_type: %d, %s\n", pfx, etype,
-		       etype < ARRAY_SIZE(cper_mem_err_type_strs) ?
-		       cper_mem_err_type_strs[etype] : "unknown");
-	}
-	if (mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
-		const char *bank = NULL, *device = NULL;
-		dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
-		if (bank != NULL && device != NULL)
-			printk("%s""DIMM location: %s %s", pfx, bank, device);
-		else
-			printk("%s""DIMM DMI handle: 0x%.4x",
-			       pfx, mem->mem_dev_handle);
+		       cper_mem_err_type_str(etype));
 	}
+	cper_dimm_err_location(mem, dimm_location);
+	printk("%s%s", pfx, dimm_location);
 }
 
 static const char *cper_pcie_port_type_strs[] = {
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 2fc0ec3..038cc11 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -23,6 +23,8 @@
 
 #include <linux/uuid.h>
 
+extern struct raw_spinlock cper_loc_lock;
+
 /* CPER record signature and the size */
 #define CPER_SIG_RECORD				"CPER"
 #define CPER_SIG_SIZE				4
@@ -36,6 +38,12 @@
 #define CPER_RECORD_REV				0x0100
 
 /*
+ * CPER record length is variable depending on differnet error type.
+ * By now it is mainly used for memory error type. 256 bytes should
+ * be enough. Increase this value once it is not enough.
+ */
+#define CPER_REC_LEN				256
+/*
  * Severity difinition for error_severity in struct cper_record_header
  * and section_severity in struct cper_section_descriptor
  */
@@ -395,7 +403,11 @@ struct cper_sec_pcie {
 #pragma pack()
 
 u64 cper_next_record_id(void);
+const char *cper_severity_str(unsigned int);
+const char *cper_mem_err_type_str(unsigned int);
 void cper_print_bits(const char *prefix, unsigned int bits,
 		     const char * const strs[], unsigned int strs_size);
+void cper_mem_err_location(const struct cper_sec_mem_err *mem, char *msg);
+void cper_dimm_err_location(const struct cper_sec_mem_err *mem, char *msg);
 
 #endif
-- 
1.9.0

