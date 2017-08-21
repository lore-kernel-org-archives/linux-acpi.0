From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Mon, 21 Aug 2017 11:29:32 +0200
Message-ID: <20170821092932.vlyhg7ckfigpc26n@pd.tnic>
References: <20170814203942.6t3mrq3hc324blab@pd.tnic>
 <1502810766.2042.149.camel@hpe.com>
 <20170815154815.wy3dqwb4yi3feahg@intel.com>
 <20170816082931.p6rpvtlxwt5nccxr@pd.tnic>
 <1502896578.2042.155.camel@hpe.com>
 <20170816164234.mgwapenb7fpym6nk@pd.tnic>
 <1502903940.2042.157.camel@hpe.com>
 <20170816174028.dqfvubjigvwtcbcy@pd.tnic>
 <1502905904.2042.159.camel@hpe.com>
 <1503003532.2042.161.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503003532.2042.161.camel@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "mchehab@kernel.org" <mchehab@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 17, 2017 at 09:08:40PM +0000, Kani, Toshimitsu wrote:
> 1. It creates mc0 and mc1.  
> I think this is because you called edac_mc_alloc() with mc_num 1.

Fixed, see below.

> 
> 2. 'ras-mc-ctl --layout' does not show all DIMMs.

Yap, that's strange.

$ grep . /sys/devices/system/edac/mc/mc0/dimm*/size
/sys/devices/system/edac/mc/mc0/dimm10/size:2048
/sys/devices/system/edac/mc/mc0/dimm11/size:2048
/sys/devices/system/edac/mc/mc0/dimm12/size:2048
/sys/devices/system/edac/mc/mc0/dimm13/size:2048
/sys/devices/system/edac/mc/mc0/dimm14/size:2048
/sys/devices/system/edac/mc/mc0/dimm15/size:2048
/sys/devices/system/edac/mc/mc0/dimm8/size:2048
/sys/devices/system/edac/mc/mc0/dimm9/size:2048
$ ras-mc-ctl --layout
         +-----------+
         |    mc0    |
---------+-----------+
memory9: |  2048 MB  |
memory8: |  2048 MB  |
---------+-----------+
memory7: |     0 MB  |
memory6: |     0 MB  |
---------+-----------+
memory5: |     0 MB  |
memory4: |     0 MB  |
---------+-----------+
memory3: |     0 MB  |
memory2: |     0 MB  |
---------+-----------+
memory1: |     0 MB  |
memory0: |     0 MB  |
---------+-----------+

the driver detects them correctly though:

[    7.900694] ghes_edac: This system has 16 DIMM sockets.
[    7.911366] EDAC DEBUG: ghes_edac_dmidecode: DIMM8: Unbuffered DDR3 RAM size = 2048 MB(ECC)
[    7.928437] EDAC DEBUG: ghes_edac_dmidecode:         type 24, detail 0x80, width 72(total 64)
[    7.944628] EDAC DEBUG: ghes_edac_dmidecode: DIMM9: Unbuffered DDR3 RAM size = 2048 MB(ECC)
[    7.961683] EDAC DEBUG: ghes_edac_dmidecode:         type 24, detail 0x80, width 72(total 64)
[    7.977871] EDAC DEBUG: ghes_edac_dmidecode: DIMM10: Unbuffered DDR3 RAM size = 2048 MB(ECC)
[    7.995105] EDAC DEBUG: ghes_edac_dmidecode:         type 24, detail 0x80, width 72(total 64)
[    8.011291] EDAC DEBUG: ghes_edac_dmidecode: DIMM11: Unbuffered DDR3 RAM size = 2048 MB(ECC)
[    8.028524] EDAC DEBUG: ghes_edac_dmidecode:         type 24, detail 0x80, width 72(total 64)
[    8.044712] EDAC DEBUG: ghes_edac_dmidecode: DIMM12: Unbuffered DDR3 RAM size = 2048 MB(ECC)
[    8.061942] EDAC DEBUG: ghes_edac_dmidecode:         type 24, detail 0x80, width 72(total 64)
[    8.078129] EDAC DEBUG: ghes_edac_dmidecode: DIMM13: Unbuffered DDR3 RAM size = 2048 MB(ECC)
[    8.095360] EDAC DEBUG: ghes_edac_dmidecode:         type 24, detail 0x80, width 72(total 64)
[    8.111547] EDAC DEBUG: ghes_edac_dmidecode: DIMM14: Unbuffered DDR3 RAM size = 2048 MB(ECC)
[    8.161703] EDAC DEBUG: ghes_edac_dmidecode:         type 24, detail 0x80, width 72(total 64)
[    8.177904] EDAC DEBUG: ghes_edac_dmidecode: DIMM15: Unbuffered DDR3 RAM size = 2048 MB(ECC)
[    8.195132] EDAC DEBUG: ghes_edac_dmidecode:         type 24, detail 0x80, width 72(total 64)
[    8.211321] EDAC DEBUG: edac_mc_add_mc_with_groups: 
[    8.221456] EDAC DEBUG: edac_create_sysfs_mci_device: creating bus mc0
[    8.234736] EDAC DEBUG: edac_create_sysfs_mci_device: creating device mc0
[    8.248545] EDAC DEBUG: edac_create_sysfs_mci_device: creating dimm8, located at memory 8 
[    8.265457] EDAC DEBUG: edac_create_dimm_object: creating rank/dimm device dimm8
[    8.280601] EDAC DEBUG: edac_create_sysfs_mci_device: creating dimm9, located at memory 9 
[    8.297503] EDAC DEBUG: edac_create_dimm_object: creating rank/dimm device dimm9
[    8.312650] EDAC DEBUG: edac_create_sysfs_mci_device: creating dimm10, located at memory 10 
[    8.329900] EDAC DEBUG: edac_create_dimm_object: creating rank/dimm device dimm10
[    8.345220] EDAC DEBUG: edac_create_sysfs_mci_device: creating dimm11, located at memory 11 
[    8.362470] EDAC DEBUG: edac_create_dimm_object: creating rank/dimm device dimm11
[    8.377789] EDAC DEBUG: edac_create_sysfs_mci_device: creating dimm12, located at memory 12 
[    8.395039] EDAC DEBUG: edac_create_dimm_object: creating rank/dimm device dimm12
[    8.410358] EDAC DEBUG: edac_create_sysfs_mci_device: creating dimm13, located at memory 13 
[    8.427608] EDAC DEBUG: edac_create_dimm_object: creating rank/dimm device dimm13
[    8.442928] EDAC DEBUG: edac_create_sysfs_mci_device: creating dimm14, located at memory 14 
[    8.460194] EDAC DEBUG: edac_create_dimm_object: creating rank/dimm device dimm14
[    8.475517] EDAC DEBUG: edac_create_sysfs_mci_device: creating dimm15, located at memory 15 
[    8.492768] EDAC DEBUG: edac_create_dimm_object: creating rank/dimm device dimm15

Mauro?

---
From: Borislav Petkov <bp@suse.de>
Date: Wed, 16 Aug 2017 10:33:44 +0200
Subject: [PATCH] EDAC, ghes: Model a single, logical memory controller

We're enumerating the DIMMs through a DMI walk and since we can't get
any more detailed topological information about which DIMMs belong to
which memory controller, convert it to a single, logical controller
which contains all the DIMMs.

The error reporting path from GHES ghes_edac_report_mem_error() doesn't
get called in NMI context but add a warning about it to catch any
changes in the future as if so, our locking scheme will be insufficient
then.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/ghes_edac.c | 116 +++++++++++++++++++++--------------------------
 1 file changed, 51 insertions(+), 65 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 6f80eb65c26c..e790d64b8edd 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -28,10 +28,15 @@ struct ghes_edac_pvt {
 	char msg[80];
 };
 
-static LIST_HEAD(ghes_reglist);
-static DEFINE_MUTEX(ghes_edac_lock);
-static int ghes_edac_mc_num;
+static atomic_t ghes_init = ATOMIC_INIT(0);
+static struct ghes_edac_pvt *ghes_pvt;
 
+/*
+ * Sync with other, potentially concurrent callers of
+ * ghes_edac_report_mem_error(). We don't know what the
+ * "inventive" firmware would do.
+ */
+static DEFINE_SPINLOCK(ghes_lock);
 
 /* Memory Device - Type 17 of SMBIOS spec */
 struct memdev_dmi_entry {
@@ -169,18 +174,26 @@ void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
 	enum hw_event_mc_err_type type;
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
-	struct ghes_edac_pvt *pvt = NULL;
+	struct ghes_edac_pvt *pvt = ghes_pvt;
+	unsigned long flags;
 	char *p;
 	u8 grain_bits;
 
-	list_for_each_entry(pvt, &ghes_reglist, list) {
-		if (ghes == pvt->ghes)
-			break;
-	}
 	if (!pvt) {
 		pr_err("Internal error: Can't find EDAC structure\n");
 		return;
 	}
+
+	/*
+	 * We can do the locking below because GHES defers error processing
+	 * from NMI to IRQ context. Whenever that changes, we'd at least
+	 * know.
+	 */
+	if (WARN_ON_ONCE(in_nmi()))
+		return;
+
+	spin_lock_irqsave(&ghes_lock, flags);
+
 	mci = pvt->mci;
 	e = &mci->error_desc;
 
@@ -398,8 +411,8 @@ void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
 		       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
 		       grain_bits, e->syndrome, pvt->detail_location);
 
-	/* Report the error via EDAC API */
 	edac_raw_mc_handle_error(type, mci, e);
+	spin_unlock_irqrestore(&ghes_lock, flags);
 }
 EXPORT_SYMBOL_GPL(ghes_edac_report_mem_error);
 
@@ -409,9 +422,14 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	int rc, num_dimm = 0;
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[1];
-	struct ghes_edac_pvt *pvt;
 	struct ghes_edac_dimm_fill dimm_fill;
 
+	/*
+	 * We have only one logical memory controller to which all DIMMs belong.
+	 */
+	if (atomic_inc_return(&ghes_init) > 1)
+		return 0;
+
 	/* Get the number of DIMMs */
 	dmi_walk(ghes_edac_count_dimms, &num_dimm);
 
@@ -425,26 +443,17 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	layers[0].size = num_dimm;
 	layers[0].is_virt_csrow = true;
 
-	/*
-	 * We need to serialize edac_mc_alloc() and edac_mc_add_mc(),
-	 * to avoid duplicated memory controller numbers
-	 */
-	mutex_lock(&ghes_edac_lock);
-	mci = edac_mc_alloc(ghes_edac_mc_num, ARRAY_SIZE(layers), layers,
-			    sizeof(*pvt));
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_edac_pvt));
 	if (!mci) {
 		pr_info("Can't allocate memory for EDAC data\n");
-		mutex_unlock(&ghes_edac_lock);
 		return -ENOMEM;
 	}
 
-	pvt = mci->pvt_info;
-	memset(pvt, 0, sizeof(*pvt));
-	list_add_tail(&pvt->list, &ghes_reglist);
-	pvt->ghes = ghes;
-	pvt->mci  = mci;
-	mci->pdev = dev;
+	ghes_pvt	= mci->pvt_info;
+	ghes_pvt->ghes	= ghes;
+	ghes_pvt->mci	= mci;
 
+	mci->pdev = dev;
 	mci->mtype_cap = MEM_FLAG_EMPTY;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE;
 	mci->edac_cap = EDAC_FLAG_NONE;
@@ -452,36 +461,23 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	mci->ctl_name = "ghes_edac";
 	mci->dev_name = "ghes";
 
-	if (!ghes_edac_mc_num) {
-		if (!fake) {
-			pr_info("This EDAC driver relies on BIOS to enumerate memory and get error reports.\n");
-			pr_info("Unfortunately, not all BIOSes reflect the memory layout correctly.\n");
-			pr_info("So, the end result of using this driver varies from vendor to vendor.\n");
-			pr_info("If you find incorrect reports, please contact your hardware vendor\n");
-			pr_info("to correct its BIOS.\n");
-			pr_info("This system has %d DIMM sockets.\n",
-				num_dimm);
-		} else {
-			pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
-			pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
-			pr_info("work on such system. Use this driver with caution\n");
-		}
+	if (!fake) {
+		pr_info("This EDAC driver relies on BIOS to enumerate memory and get error reports.\n");
+		pr_info("Unfortunately, not all BIOSes reflect the memory layout correctly.\n");
+		pr_info("So, the end result of using this driver varies from vendor to vendor.\n");
+		pr_info("If you find incorrect reports, please contact your hardware vendor\n");
+		pr_info("to correct its BIOS.\n");
+		pr_info("This system has %d DIMM sockets.\n", num_dimm);
+	} else {
+		pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
+		pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
+		pr_info("work on such system. Use this driver with caution\n");
 	}
 
 	if (!fake) {
-		/*
-		 * Fill DIMM info from DMI for the memory controller #0
-		 *
-		 * Keep it in blank for the other memory controllers, as
-		 * there's no reliable way to properly credit each DIMM to
-		 * the memory controller, as different BIOSes fill the
-		 * DMI bank location fields on different ways
-		 */
-		if (!ghes_edac_mc_num) {
-			dimm_fill.count = 0;
-			dimm_fill.mci = mci;
-			dmi_walk(ghes_edac_dmidecode, &dimm_fill);
-		}
+		dimm_fill.count = 0;
+		dimm_fill.mci = mci;
+		dmi_walk(ghes_edac_dmidecode, &dimm_fill);
 	} else {
 		struct dimm_info *dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms,
 						       mci->n_layers, 0, 0, 0);
@@ -497,12 +493,8 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	if (rc < 0) {
 		pr_info("Can't register at EDAC core\n");
 		edac_mc_free(mci);
-		mutex_unlock(&ghes_edac_lock);
 		return -ENODEV;
 	}
-
-	ghes_edac_mc_num++;
-	mutex_unlock(&ghes_edac_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ghes_edac_register);
@@ -510,15 +502,9 @@ EXPORT_SYMBOL_GPL(ghes_edac_register);
 void ghes_edac_unregister(struct ghes *ghes)
 {
 	struct mem_ctl_info *mci;
-	struct ghes_edac_pvt *pvt, *tmp;
-
-	list_for_each_entry_safe(pvt, tmp, &ghes_reglist, list) {
-		if (ghes == pvt->ghes) {
-			mci = pvt->mci;
-			edac_mc_del_mc(mci->pdev);
-			edac_mc_free(mci);
-			list_del(&pvt->list);
-		}
-	}
+
+	mci = ghes_pvt->mci;
+	edac_mc_del_mc(mci->pdev);
+	edac_mc_free(mci);
 }
 EXPORT_SYMBOL_GPL(ghes_edac_unregister);
-- 
2.13.0


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
