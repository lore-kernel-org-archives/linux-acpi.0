From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v4 3/5] ghes_edac: add platform check to enable ghes_edac
Date: Wed, 23 Aug 2017 16:54:45 -0600
Message-ID: <20170823225447.15608-4-toshi.kani@hpe.com>
References: <20170823225447.15608-1-toshi.kani@hpe.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823225447.15608-1-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, bp@alien8.de
Cc: mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>
List-Id: linux-acpi@vger.kernel.org

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

"ghes_edac.force_load=1" skips this platform check.

[1]: https://lwn.net/Articles/538438/
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/ghes_edac.c |   29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 8d904df..0030a09 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -38,6 +38,10 @@ static struct ghes_edac_pvt *ghes_pvt;
  */
 static DEFINE_SPINLOCK(ghes_lock);
 
+/* Set 1 to skip the platform check */
+static bool __read_mostly ghes_edac_force_load;
+module_param_named(force_load, ghes_edac_force_load, bool, 0);
+
 /* Memory Device - Type 17 of SMBIOS spec */
 struct memdev_dmi_entry {
 	u8 type;
@@ -415,6 +419,15 @@ void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
 	spin_unlock_irqrestore(&ghes_lock, flags);
 }
 
+/*
+ * Known systems that are safe to enable this module.
+ * "ghes_edac.force_load=1" skips this check if necessary.
+ */
+static struct acpi_platform_list plat_list[] = {
+	{"HPE   ", "Server  ", 0, ACPI_SIG_FADT, all_versions},
+	{ } /* End */
+};
+
 int ghes_edac_register(struct ghes *ghes, struct device *dev)
 {
 	bool fake = false;
@@ -422,6 +435,12 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[1];
 	struct ghes_edac_dimm_fill dimm_fill;
+	int idx;
+
+	/* Check if safe to enable on this system */
+	idx = acpi_match_platform_list(plat_list);
+	if (!ghes_edac_force_load && idx < 0)
+		return 0;
 
 	/*
 	 * We have only one logical memory controller to which all DIMMs belong.
@@ -460,17 +479,17 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	mci->ctl_name = "ghes_edac";
 	mci->dev_name = "ghes";
 
-	if (!fake) {
+	if (fake) {
+		pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
+		pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
+		pr_info("work on such system. Use this driver with caution\n");
+	} else if (idx < 0) {
 		pr_info("This EDAC driver relies on BIOS to enumerate memory and get error reports.\n");
 		pr_info("Unfortunately, not all BIOSes reflect the memory layout correctly.\n");
 		pr_info("So, the end result of using this driver varies from vendor to vendor.\n");
 		pr_info("If you find incorrect reports, please contact your hardware vendor\n");
 		pr_info("to correct its BIOS.\n");
 		pr_info("This system has %d DIMM sockets.\n", num_dimm);
-	} else {
-		pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
-		pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
-		pr_info("work on such system. Use this driver with caution\n");
 	}
 
 	if (!fake) {
