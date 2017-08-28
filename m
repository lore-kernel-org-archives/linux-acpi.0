From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH] acpi: apei: call into AER handling regardless of severity
Date: Mon, 28 Aug 2017 11:11:54 -0600
Message-ID: <1503940314-29526-1-git-send-email-tbaicar@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50798 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbdH1RMA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Aug 2017 13:12:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, bp@suse.de, prarit@redhat.com, punit.agrawal@arm.com, shiju.jose@huawei.com, andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tyler Baicar <tbaicar@codeaurora.org>

Currently the GHES code only calls into the AER driver for
recoverable type errors. This is incorrect because errors of
other severities do not get logged by the AER driver and do not
get exposed to user space via the AER trace event. So, call
into the AER driver for PCIe errors regardless of the severity.

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 drivers/acpi/apei/ghes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d661d45..5cab238 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -489,9 +489,7 @@ static void ghes_do_proc(struct ghes *ghes,
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 
-			if (sev == GHES_SEV_RECOVERABLE &&
-			    sec_sev == GHES_SEV_RECOVERABLE &&
-			    pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
+			if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
 			    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
 				unsigned int devfn;
 				int aer_severity;
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

