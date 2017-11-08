From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH V3 2/2] acpi: apei: call into AER handling regardless of severity
Date: Wed,  8 Nov 2017 12:13:12 -0700
Message-ID: <1510168392-30114-3-git-send-email-tbaicar@codeaurora.org>
References: <1510168392-30114-1-git-send-email-tbaicar@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510168392-30114-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tony.luck@intel.com, bp@alien8.de, bp@suse.de, will.deacon@arm.com, james.morse@arm.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tyler Baicar <tbaicar@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

Currently the GHES code only calls into the AER driver for
recoverable type errors. This is incorrect because errors of
other severities do not get logged by the AER driver and do not
get exposed to user space via the AER trace event. So, call
into the AER driver for PCIe errors regardless of the severity

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 drivers/acpi/apei/ghes.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 839c3d5..bb65fa6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -458,14 +458,12 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
 #endif
 }
 
-static void ghes_handle_aer(struct acpi_hest_generic_data *gdata, int sev, int sec_sev)
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
@@ -519,7 +517,7 @@ static void ghes_do_proc(struct ghes *ghes,
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
