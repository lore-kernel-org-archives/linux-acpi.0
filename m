From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH V2 2/2] acpi: apei: send correct severity to calculate AER severity
Date: Wed, 14 Sep 2016 15:14:46 -0600
Message-ID: <1473887686-24420-3-git-send-email-tbaicar@codeaurora.org>
References: <1473887686-24420-1-git-send-email-tbaicar@codeaurora.org>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1473887686-24420-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com, paul.gortmaker@windriver.com, sudipm.mukherjee@gmail.com, axboe@fb.com, izumi.taku@jp.fujitsu.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: bp@suse.de, Tyler Baicar <tbaicar@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

Currently the AER severity is calculated by calling
cper_severity_to_aer(), but the parameter sent is actually the
GHES severity. This causes the AER severity to be incorrect.
Fix the parameter to be the CPER severity instead of the GHES
severity.

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 drivers/acpi/apei/ghes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 60746ef..f0a029e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -457,7 +457,7 @@ static void ghes_do_proc(struct ghes *ghes,
 
 				devfn = PCI_DEVFN(pcie_err->device_id.device,
 						  pcie_err->device_id.function);
-				aer_severity = cper_severity_to_aer(sev);
+				aer_severity = cper_severity_to_aer(gdata->error_severity);
 
 				/*
 				 * If firmware reset the component to contain
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
