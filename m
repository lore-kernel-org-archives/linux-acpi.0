From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v3 5/5] edac drivers: add MC owner check in init
Date: Fri, 18 Aug 2017 13:46:44 -0600
Message-ID: <20170818194644.14538-6-toshi.kani@hpe.com>
References: <20170818194644.14538-1-toshi.kani@hpe.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170818194644.14538-1-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, bp@alien8.de
Cc: mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>
List-Id: linux-acpi@vger.kernel.org

Change generic x86 edac drivers, which probe CPU type with
x86_match_cpu(), to verify the module owner at the beginning
of their module init functions.  This allows them to fail
their init immediately when ghes_edac is enabled.  Similar
change can be made to other edac drivers as necessary.

Also, remove ".c" from module names of pnp2_edac, sb_edac,
and skx_edac.

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/amd64_edac.c |    5 +++++
 drivers/edac/pnd2_edac.c  |    9 ++++++++-
 drivers/edac/sb_edac.c    |    9 +++++++--
 drivers/edac/skx_edac.c   |    8 +++++++-
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 3aea556..529bcbf 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3435,9 +3435,14 @@ MODULE_DEVICE_TABLE(x86cpu, amd64_cpuids);
 
 static int __init amd64_edac_init(void)
 {
+	const char *owner;
 	int err = -ENODEV;
 	int i;
 
+	owner = edac_get_owner();
+	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+		return -EBUSY;
+
 	if (!x86_match_cpu(amd64_cpuids))
 		return -ENODEV;
 
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 8e59949..6609041 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -45,6 +45,8 @@
 #include "edac_module.h"
 #include "pnd2_edac.h"
 
+#define EDAC_MOD_STR		"pnd2_edac"
+
 #define APL_NUM_CHANNELS	4
 #define DNV_NUM_CHANNELS	2
 #define DNV_MAX_DIMMS		2 /* Max DIMMs per channel */
@@ -1313,7 +1315,7 @@ static int pnd2_register_mci(struct mem_ctl_info **ppmci)
 	pvt = mci->pvt_info;
 	memset(pvt, 0, sizeof(*pvt));
 
-	mci->mod_name = "pnd2_edac.c";
+	mci->mod_name = EDAC_MOD_STR;
 	mci->dev_name = ops->name;
 	mci->ctl_name = "Pondicherry2";
 
@@ -1505,10 +1507,15 @@ MODULE_DEVICE_TABLE(x86cpu, pnd2_cpuids);
 static int __init pnd2_init(void)
 {
 	const struct x86_cpu_id *id;
+	const char *owner;
 	int rc;
 
 	edac_dbg(2, "\n");
 
+	owner = edac_get_owner();
+	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+		return -EBUSY;
+
 	id = x86_match_cpu(pnd2_cpuids);
 	if (!id)
 		return -ENODEV;
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 80d860c..d411aa5c 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -36,7 +36,7 @@ static LIST_HEAD(sbridge_edac_list);
  * Alter this version for the module when modifications are made
  */
 #define SBRIDGE_REVISION    " Ver: 1.1.2 "
-#define EDAC_MOD_STR      "sbridge_edac"
+#define EDAC_MOD_STR	    "sb_edac"
 
 /*
  * Debug macros
@@ -3124,7 +3124,7 @@ static int sbridge_register_mci(struct sbridge_dev *sbridge_dev, enum type type)
 		MEM_FLAG_DDR4 : MEM_FLAG_DDR3;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE;
 	mci->edac_cap = EDAC_FLAG_NONE;
-	mci->mod_name = "sb_edac.c";
+	mci->mod_name = EDAC_MOD_STR;
 	mci->mod_ver = SBRIDGE_REVISION;
 	mci->dev_name = pci_name(pdev);
 	mci->ctl_page_to_phys = NULL;
@@ -3372,10 +3372,15 @@ static void sbridge_remove(void)
 static int __init sbridge_init(void)
 {
 	const struct x86_cpu_id *id;
+	const char *owner;
 	int rc;
 
 	edac_dbg(2, "\n");
 
+	owner = edac_get_owner();
+	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+		return -EBUSY;
+
 	id = x86_match_cpu(sbridge_cpuids);
 	if (!id)
 		return -ENODEV;
diff --git a/drivers/edac/skx_edac.c b/drivers/edac/skx_edac.c
index 64bef6c9..17a2fbd 100644
--- a/drivers/edac/skx_edac.c
+++ b/drivers/edac/skx_edac.c
@@ -31,6 +31,7 @@
 
 #include "edac_module.h"
 
+#define EDAC_MOD_STR    "skx_edac"
 #define SKX_REVISION    " Ver: 1.0 "
 
 /*
@@ -471,7 +472,7 @@ static int skx_register_mci(struct skx_imc *imc)
 	mci->mtype_cap = MEM_FLAG_DDR4;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE;
 	mci->edac_cap = EDAC_FLAG_NONE;
-	mci->mod_name = "skx_edac.c";
+	mci->mod_name = EDAC_MOD_STR;
 	mci->dev_name = pci_name(imc->chan[0].cdev);
 	mci->mod_ver = SKX_REVISION;
 	mci->ctl_page_to_phys = NULL;
@@ -1042,12 +1043,17 @@ static int __init skx_init(void)
 {
 	const struct x86_cpu_id *id;
 	const struct munit *m;
+	const char *owner;
 	int rc = 0, i;
 	u8 mc = 0, src_id, node_id;
 	struct skx_dev *d;
 
 	edac_dbg(2, "\n");
 
+	owner = edac_get_owner();
+	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+		return -EBUSY;
+
 	id = x86_match_cpu(skx_cpuids);
 	if (!id)
 		return -ENODEV;
