From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v2 5/7] ghes_edac: add platform check to enable ghes_edac
Date: Thu,  3 Aug 2017 15:57:51 -0600
Message-ID: <20170803215753.30553-6-toshi.kani@hpe.com>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:52133 "EHLO
        g2t2354.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752041AbdHCWHd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2017 18:07:33 -0400
In-Reply-To: <20170803215753.30553-1-toshi.kani@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, bp@alien8.de
Cc: mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>

The ghes_edac driver was introduced in 2013 [1], but it has not
been enabled by any distro yet.  This driver obtains error info
from firmware interfaces, which are not properly implemented on
many platforms, as the driver always emits the messages below:

 This EDAC driver relies on BIOS to enumerate memory and get error reports.
 Unfortunately, not all BIOSes reflect the memory layout correctly
 So, the end result of using this driver varies from vendor to vendor
 If you find incorrect reports, please contact your hardware vendor
 to correct its BIOS.

To get out from this situation, add a platform check to selectively
enable the driver on the platforms that are known to have proper
firmware implementation.  Platform vendors can add their platforms
to the list when they support ghes_edac.

"ghes_edac.any_oem=1" skips this platform check.

[1]: https://lwn.net/Articles/538438/
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/ghes_edac.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 2e9ce9c..72bab02 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -34,6 +34,9 @@ static LIST_HEAD(ghes_reglist);
 static DEFINE_MUTEX(ghes_edac_lock);
 static int ghes_edac_mc_num;
 
+/* Set 1 to skip the platform check */
+static bool __read_mostly ghes_edac_any_oem;
+module_param_named(any_oem, ghes_edac_any_oem, bool, 0);
 
 /* Memory Device - Type 17 of SMBIOS spec */
 struct memdev_dmi_entry {
@@ -405,17 +408,31 @@ void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
 }
 EXPORT_SYMBOL_GPL(ghes_edac_report_mem_error);
 
+/*
+ * Known systems that are safe to enable this module.
+ * "ghes_edac.any_oem=1" skips this check if necessary.
+ */
+static struct acpi_oemlist oemlist[] = {
+	{"HPE   ", "Server  ", 0, ACPI_SIG_FADT, all_versions},
+	{ } /* End */
+};
+
 int ghes_edac_register(struct ghes *ghes, struct device *dev)
 {
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[1];
 	struct ghes_edac_pvt *pvt;
 	struct ghes_edac_dimm_fill dimm_fill;
-	int rc;
+	int rc, idx;
 
 	static int num_dimm;
 	static bool fake;
 
+	/* Check if safe to enable on this system */
+	idx = acpi_match_oemlist(oemlist);
+	if (!ghes_edac_any_oem && idx < 0)
+		return 0;
+
 	/* Get the number of DIMMs */
 	if (num_dimm == 0)
 		dmi_walk(ghes_edac_count_dimms, &num_dimm);
@@ -459,7 +476,11 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	mci->dev_name = "ghes";
 
 	if (!ghes_edac_mc_num) {
-		if (!fake) {
+		if (fake) {
+			pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
+			pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
+			pr_info("work on such system. Use this driver with caution\n");
+		} else if (idx < 0) {
 			pr_info("This EDAC driver relies on BIOS to enumerate memory and get error reports.\n");
 			pr_info("Unfortunately, not all BIOSes reflect the memory layout correctly.\n");
 			pr_info("So, the end result of using this driver varies from vendor to vendor.\n");
@@ -467,10 +488,6 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 			pr_info("to correct its BIOS.\n");
 			pr_info("This system has %d DIMM sockets.\n",
 				num_dimm);
-		} else {
-			pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
-			pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
-			pr_info("work on such system. Use this driver with caution\n");
 		}
 	}
 
