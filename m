From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH V3 2/2] acpi: apei: call into AER handling regardless of severity
Date: Wed, 15 Nov 2017 08:14:27 -0700
Message-ID: <1510758867-15940-1-git-send-email-tbaicar@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46002 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754750AbdKOPOf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Nov 2017 10:14:35 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@suse.de, rjw@rjwysocki.net, tony.luck@intel.com, will.deacon@arm.com, james.morse@arm.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tyler Baicar <tbaicar@codeaurora.org>

Currently the GHES code only calls into the AER driver for
recoverable type errors. This is incorrect because errors of
other severities do not get logged by the AER driver and do not
get exposed to user space via the AER trace event. So, call
into the AER driver for PCIe errors regardless of the severity

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 drivers/acpi/apei/ghes.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 839c3d5..15dbf65 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -458,14 +458,26 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
 #endif
 }
 
-static void ghes_handle_aer(struct acpi_hest_generic_data *gdata, int sev, int sec_sev)
+/*
+ * PCIe AER errors need to be sent to the AER driver for reporting and
+ * recovery. The GHES severities map to the following AER severities and
+ * require the following handling:
+ *
+ * GHES_SEV_CORRECTABLE -> AER_CORRECTABLE
+ *     These need to be reported by the AER driver but no recovery is
+ *     necessary.
+ * GHES_SEV_RECOVERABLE -> AER_NONFATAL
+ * GHES_SEV_RECOVERABLE && CPER_SEC_RESET -> AER_FATAL
+ *     These both need to be reported and recovered from by the AER driver.
+ * GHES_SEV_PANIC does not make it to this handling since the kernel must
+ *     panic.
+ */
+static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 
-	if (sev == GHES_SEV_RECOVERABLE &&
-	    sec_sev == GHES_SEV_RECOVERABLE &&
-	    pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
+	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
 	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
 		unsigned int devfn;
 		int aer_severity;
@@ -519,7 +531,7 @@ static void ghes_do_proc(struct ghes *ghes,
 			ghes_handle_memory_failure(gdata, sev);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
-			ghes_handle_aer(gdata, sev, sec_sev);
+			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

