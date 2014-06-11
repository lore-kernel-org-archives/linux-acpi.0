From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 7/7] RAS, extlog: Adjust init flow
Date: Wed, 11 Jun 2014 04:34:51 -0400
Message-ID: <1402475691-30045-8-git-send-email-gong.chen@linux.intel.com>
References: <1402475691-30045-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47285 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755855AbaFKJDz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Jun 2014 05:03:55 -0400
In-Reply-To: <1402475691-30045-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com, rostedt@goodmis.org
Cc: linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>

Unless the platform has eMCA related capability, don't
need to check if there is conflict with EDAC driver.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index a99d4a6..0ad6f38 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -223,19 +223,16 @@ static int __init extlog_init(void)
 	u64 cap;
 	int rc;
 
+	rdmsrl(MSR_IA32_MCG_CAP, cap);
+
+	if (!(cap & MCG_ELOG_P) || !extlog_get_l1addr())
+		return -ENODEV;
+
 	if (get_edac_report_status() == EDAC_REPORTING_FORCE) {
 		pr_warn("Not loading eMCA, error reporting force-enabled through EDAC.\n");
 		return -EPERM;
 	}
 
-	rc = -ENODEV;
-	rdmsrl(MSR_IA32_MCG_CAP, cap);
-	if (!(cap & MCG_ELOG_P))
-		return rc;
-
-	if (!extlog_get_l1addr())
-		return rc;
-
 	rc = -EINVAL;
 	/* get L1 header to fetch necessary information */
 	l1_hdr_size = sizeof(struct extlog_l1_head);
-- 
2.0.0.rc2

