From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Wed, 16 Aug 2017 10:29:31 +0200
Message-ID: <20170816082931.p6rpvtlxwt5nccxr@pd.tnic>
References: <1502732561.2042.141.camel@hpe.com>
 <20170814180526.wtfjzgc6uye2qtx6@pd.tnic>
 <1502734083.2042.143.camel@hpe.com>
 <20170814183551.sgk2i7lxpmpyodhv@pd.tnic>
 <1502736750.2042.145.camel@hpe.com>
 <20170814193432.mjldfhfal5ba5dt7@pd.tnic>
 <1502741290.2042.147.camel@hpe.com>
 <20170814203942.6t3mrq3hc324blab@pd.tnic>
 <1502810766.2042.149.camel@hpe.com>
 <20170815154815.wy3dqwb4yi3feahg@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:39020 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbdHPI3i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Aug 2017 04:29:38 -0400
Content-Disposition: inline
In-Reply-To: <20170815154815.wy3dqwb4yi3feahg@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Tue, Aug 15, 2017 at 08:48:16AM -0700, Luck, Tony wrote:
> Won't the user see all their DIMMs reported for each memory controller
> under /sys/devices/system/edac/mc/mc*/dimm* ?
> 
> That sounds confusing.

Right, and adding the locking was really easy. If only people would
debate less and actually try to do what they're being advised to.
But not really: if you wanna have something done, you have to do it
yourself.

Anyway, I think I have a box to run it to, lemme go find it.

Steve, pls check my locking. It looks straightforward to me but I might
be missing some corner case.

Thx.

---
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 6f80eb65c26c..a22fabef4791 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -28,10 +28,14 @@ struct ghes_edac_pvt {
 	char msg[80];
 };
 
-static LIST_HEAD(ghes_reglist);
-static DEFINE_MUTEX(ghes_edac_lock);
-static int ghes_edac_mc_num;
+static struct ghes_edac_pvt *ghes_pvt;
 
+/*
+ * Sync with other, potentially concurrent callers of
+ * ghes_edac_report_mem_error(). We don't know what the
+ * "inventive" firmware would do.
+ */
+static DEFINE_SPINLOCK(ghes_lock);
 
 /* Memory Device - Type 17 of SMBIOS spec */
 struct memdev_dmi_entry {
@@ -169,14 +173,11 @@ void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
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
@@ -398,8 +399,16 @@ void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
 		       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
 		       grain_bits, e->syndrome, pvt->detail_location);
 
-	/* Report the error via EDAC API */
+	/*
+	 * We can do the locking below because GHES defers error processing
+	 * from NMI to IRQ context. Whenever that changes, we'd at least
+	 * know.
+	 */
+	WARN_ON_ONCE(in_nmi());
+
+	spin_lock_irqsave(&ghes_lock, flags);
 	edac_raw_mc_handle_error(type, mci, e);
+	spin_unlock_irqrestore(&ghes_lock, flags);
 }
 EXPORT_SYMBOL_GPL(ghes_edac_report_mem_error);
 
@@ -409,9 +418,14 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	int rc, num_dimm = 0;
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[1];
-	struct ghes_edac_pvt *pvt;
 	struct ghes_edac_dimm_fill dimm_fill;
 
+	/*
+	 * We have only one logical memory controller to which all DIMMs belong.
+	 */
+	if (ghes_pvt)
+		return 0;
+
 	/* Get the number of DIMMs */
 	dmi_walk(ghes_edac_count_dimms, &num_dimm);
 
@@ -425,26 +439,17 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	layers[0].size = num_dimm;
 	layers[0].is_virt_csrow = true;
 
-	/*
-	 * We need to serialize edac_mc_alloc() and edac_mc_add_mc(),
-	 * to avoid duplicated memory controller numbers
-	 */
-	mutex_lock(&ghes_edac_lock);
-	mci = edac_mc_alloc(ghes_edac_mc_num, ARRAY_SIZE(layers), layers,
-			    sizeof(*pvt));
+	mci = edac_mc_alloc(1, ARRAY_SIZE(layers), layers, sizeof(struct ghes_edac_pvt));
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
@@ -452,36 +457,23 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
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
@@ -497,12 +489,8 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
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
@@ -510,15 +498,9 @@ EXPORT_SYMBOL_GPL(ghes_edac_register);
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
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
