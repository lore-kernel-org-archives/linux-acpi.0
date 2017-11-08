From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH 1/2] acpi: apei: handle PCIe AER errors in separate function
Date: Wed,  8 Nov 2017 12:13:11 -0700
Message-ID: <1510168392-30114-2-git-send-email-tbaicar@codeaurora.org>
References: <1510168392-30114-1-git-send-email-tbaicar@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55396 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbdKHTNT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Nov 2017 14:13:19 -0500
In-Reply-To: <1510168392-30114-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, tony.luck@intel.com, bp@alien8.de, bp@suse.de, will.deacon@arm.com, james.morse@arm.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tyler Baicar <tbaicar@codeaurora.org>

Move PCIe AER error handling code into a separate function.

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 drivers/acpi/apei/ghes.c | 64 +++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3c3a37b..839c3d5 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -458,6 +458,39 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
 #endif
 }
 
+static void ghes_handle_aer(struct acpi_hest_generic_data *gdata, int sev, int sec_sev)
+{
+#ifdef CONFIG_ACPI_APEI_PCIEAER
+	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
+
+	if (sev == GHES_SEV_RECOVERABLE &&
+	    sec_sev == GHES_SEV_RECOVERABLE &&
+	    pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
+	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
+		unsigned int devfn;
+		int aer_severity;
+
+		devfn = PCI_DEVFN(pcie_err->device_id.device,
+				  pcie_err->device_id.function);
+		aer_severity = cper_severity_to_aer(gdata->error_severity);
+
+		/*
+		 * If firmware reset the component to contain
+		 * the error, we must reinitialize it before
+		 * use, so treat it as a fatal AER error.
+		 */
+		if (gdata->flags & CPER_SEC_RESET)
+			aer_severity = AER_FATAL;
+
+		aer_recover_queue(pcie_err->device_id.segment,
+				  pcie_err->device_id.bus,
+				  devfn, aer_severity,
+				  (struct aer_capability_regs *)
+				  pcie_err->aer_info);
+	}
+#endif
+}
+
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -485,38 +518,9 @@ static void ghes_do_proc(struct ghes *ghes,
 			arch_apei_report_mem_error(sev, mem_err);
 			ghes_handle_memory_failure(gdata, sev);
 		}
-#ifdef CONFIG_ACPI_APEI_PCIEAER
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
-			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
-
-			if (sev == GHES_SEV_RECOVERABLE &&
-			    sec_sev == GHES_SEV_RECOVERABLE &&
-			    pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
-			    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
-				unsigned int devfn;
-				int aer_severity;
-
-				devfn = PCI_DEVFN(pcie_err->device_id.device,
-						  pcie_err->device_id.function);
-				aer_severity = cper_severity_to_aer(gdata->error_severity);
-
-				/*
-				 * If firmware reset the component to contain
-				 * the error, we must reinitialize it before
-				 * use, so treat it as a fatal AER error.
-				 */
-				if (gdata->flags & CPER_SEC_RESET)
-					aer_severity = AER_FATAL;
-
-				aer_recover_queue(pcie_err->device_id.segment,
-						  pcie_err->device_id.bus,
-						  devfn, aer_severity,
-						  (struct aer_capability_regs *)
-						  pcie_err->aer_info);
-			}
-
+			ghes_handle_aer(gdata, sev, sec_sev);
 		}
-#endif
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

