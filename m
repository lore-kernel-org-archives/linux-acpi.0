From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH v2 2/2] ACPI, APEI, GHES: Cleanup ghes codes for memory error handling
Date: Mon, 25 Nov 2013 02:15:01 -0500
Message-ID: <1385363701-12387-2-git-send-email-gong.chen@linux.intel.com>
References: <1385363701-12387-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55528 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051Ab3KYHcN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Nov 2013 02:32:13 -0500
In-Reply-To: <1385363701-12387-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, naveen.n.rao@linux.vnet.ibm.com
Cc: linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>

Cleanup the logic for function ghes_handle_memory_failure. Just
make it simpler and cleaner.

v2 -> v1: fix a compile error & some minor changes.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/apei/ghes.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ce3683d..46766ef 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -413,27 +413,31 @@ static void ghes_handle_memory_failure(struct acpi_generic_data *gdata, int sev)
 {
 #ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
 	unsigned long pfn;
+	int flags = -1;
 	int sec_sev = ghes_severity(gdata->error_severity);
 	struct cper_sec_mem_err *mem_err;
 	mem_err = (struct cper_sec_mem_err *)(gdata + 1);
 
-	if (sec_sev == GHES_SEV_CORRECTED &&
-	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED) &&
-	    (mem_err->validation_bits & CPER_MEM_VALID_PA)) {
-		pfn = mem_err->physical_addr >> PAGE_SHIFT;
-		if (pfn_valid(pfn))
-			memory_failure_queue(pfn, 0, MF_SOFT_OFFLINE);
-		else if (printk_ratelimit())
-			pr_warn(FW_WARN GHES_PFX
-			"Invalid address in generic error data: %#llx\n",
-			mem_err->physical_addr);
-	}
-	if (sev == GHES_SEV_RECOVERABLE &&
-	    sec_sev == GHES_SEV_RECOVERABLE &&
-	    mem_err->validation_bits & CPER_MEM_VALID_PA) {
-		pfn = mem_err->physical_addr >> PAGE_SHIFT;
-		memory_failure_queue(pfn, 0, 0);
+	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
+		return;
+
+	pfn = mem_err->physical_addr >> PAGE_SHIFT;
+	if (!pfn_valid(pfn)) {
+		pr_warn_ratelimited(FW_WARN GHES_PFX
+		"Invalid address in generic error data: %#llx\n",
+		mem_err->physical_addr);
+		return;
 	}
+
+	/* iff following two events can be handled properly by now */
+	if (sec_sev == GHES_SEV_CORRECTED &&
+	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
+		flags = MF_SOFT_OFFLINE;
+	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
+		flags = 0;
+
+	if (flags != -1)
+		memory_failure_queue(pfn, 0, flags);
 #endif
 }
 
-- 
1.8.4.3

