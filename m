From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Thu,  3 Aug 2017 15:57:50 -0600
Message-ID: <20170803215753.30553-5-toshi.kani@hpe.com>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170803215753.30553-1-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, bp@alien8.de
Cc: mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>
List-Id: linux-acpi@vger.kernel.org

ghes_edac_register() is called for each GHES platform device
instantiated per a GHES entry in ACPI HEST table.  dmi_walk()
counts the number of DIMMs on the system, and there is no need
to call it multiple times.

Change ghes_edac_register() to call dmi_walk() only when
'num_dimm' is uninitialized.

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/edac/ghes_edac.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 4e61a62..2e9ce9c 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -407,15 +407,18 @@ EXPORT_SYMBOL_GPL(ghes_edac_report_mem_error);
 
 int ghes_edac_register(struct ghes *ghes, struct device *dev)
 {
-	bool fake = false;
-	int rc, num_dimm = 0;
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[1];
 	struct ghes_edac_pvt *pvt;
 	struct ghes_edac_dimm_fill dimm_fill;
+	int rc;
+
+	static int num_dimm;
+	static bool fake;
 
 	/* Get the number of DIMMs */
-	dmi_walk(ghes_edac_count_dimms, &num_dimm);
+	if (num_dimm == 0)
+		dmi_walk(ghes_edac_count_dimms, &num_dimm);
 
 	/* Check if we've got a bogus BIOS */
 	if (num_dimm == 0) {
