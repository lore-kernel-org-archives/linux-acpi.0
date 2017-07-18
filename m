From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Tue, 18 Jul 2017 08:00:07 +0200
Message-ID: <20170718060007.GB8736@nazgul.tnic>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170717215912.26070-4-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>, Tony Luck <tony.luck@intel.com>
Cc: rjw@rjwysocki.net, mchehab@kernel.org, tglx@linutronix.de, srinivas.pandruvada@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 17, 2017 at 03:59:12PM -0600, Toshi Kani wrote:
> The ghes_edac driver was introduced in 2013 [1], but it has not
> been enabled by any distro yet.  This driver obtains error info
> from firmware interfaces, which are not properly implemented on
> many platforms, as the driver always emits the messages below:
> 
>  This EDAC driver relies on BIOS to enumerate memory and get error reports.
>  Unfortunately, not all BIOSes reflect the memory layout correctly
>  So, the end result of using this driver varies from vendor to vendor
>  If you find incorrect reports, please contact your hardware vendor
>  to correct its BIOS.
> 
> To get out from this situation, add a platform type check to
> selectively enable the driver on the platforms that are known to
> have proper firmware implementation.  Platform vendors can add
> their platforms to the list when they support ghes_edac.

So maintaining whitelists for things has always been a PITA and we
should try to avoid it, if possible. (We can always do it if nothing
saner comes along.)

Now, below is a dirty patch converting ghes_edac to a normal module.
On systems where we have GHES, the firmware generally disables the
detection of the presence of ECC hardware, thus preventing the platform
EDAC driver from loading.

Let me clarify: I have an AMD HP box which, when GHES is enabled in
the BIOS, says that ECC is disabled in the memory controller and the
amd64_edac driver doesn't load for that memory controller.

And I think we should try this first: have the firmware disable
detection methods so that the platform drivers don't load.

Then, ghes_edac can be a simple module and no other driver would attempt
loading.

The question is: does the platform do this disabling now?

Tony, I'm looking at sb_edac and there we don't do something like that
or maybe I'm missing it.

Hmmm.

---
From: Borislav Petkov <bp@suse.de>
Date: Thu, 29 Jun 2017 10:28:32 +0200
Subject: [PATCH] WIP

Not-Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/acpi/apei/ghes.c |  32 ++++++-----
 drivers/edac/Kconfig     |   4 +-
 drivers/edac/edac_mc.h   |   3 ++
 drivers/edac/ghes_edac.c | 137 ++++++++++++++++++++++++-----------------------
 include/acpi/ghes.h      |  27 +---------
 5 files changed, 98 insertions(+), 105 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d661d452b238..37cd698cacd2 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -140,6 +140,20 @@ static atomic_t ghes_estatus_cache_alloced;
 
 static int ghes_panic_timeout __read_mostly = 30;
 
+static ATOMIC_NOTIFIER_HEAD(ghes_edac_chain);
+
+void ghes_register_edac_chain(struct notifier_block *nb)
+{
+	atomic_notifier_chain_register(&ghes_edac_chain, nb);
+}
+EXPORT_SYMBOL_GPL(ghes_register_edac_chain);
+
+void ghes_unregister_edac_chain(struct notifier_block *nb)
+{
+	atomic_notifier_chain_unregister(&ghes_edac_chain, nb);
+}
+EXPORT_SYMBOL_GPL(ghes_unregister_edac_chain);
+
 static int ghes_ioremap_init(void)
 {
 	ghes_ioremap_area = __get_vm_area(PAGE_SIZE * GHES_IOREMAP_PAGES,
@@ -461,11 +475,11 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
-	int sev, sec_sev;
 	struct acpi_hest_generic_data *gdata;
 	guid_t *sec_type;
 	guid_t *fru_id = &NULL_UUID_LE;
 	char *fru_text = "";
+	int sev, sec_sev;
 
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
@@ -480,7 +494,8 @@ static void ghes_do_proc(struct ghes *ghes,
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
 			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
 
-			ghes_edac_report_mem_error(ghes, sev, mem_err);
+
+			atomic_notifier_call_chain(&ghes_edac_chain, sev, &mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
 			ghes_handle_memory_failure(gdata, sev);
@@ -1139,10 +1154,6 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		goto err;
 	}
 
-	rc = ghes_edac_register(ghes, &ghes_dev->dev);
-	if (rc < 0)
-		goto err;
-
 	switch (generic->notify.type) {
 	case ACPI_HEST_NOTIFY_POLLED:
 		setup_deferrable_timer(&ghes->timer, ghes_poll_func,
@@ -1155,13 +1166,13 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		if (rc) {
 			pr_err(GHES_PFX "Failed to map GSI to IRQ for generic hardware error source: %d\n",
 			       generic->header.source_id);
-			goto err_edac_unreg;
+			goto err;
 		}
 		rc = request_irq(ghes->irq, ghes_irq_func, 0, "GHES IRQ", ghes);
 		if (rc) {
 			pr_err(GHES_PFX "Failed to register IRQ for generic hardware error source: %d\n",
 			       generic->header.source_id);
-			goto err_edac_unreg;
+			goto err;
 		}
 		break;
 
@@ -1190,8 +1201,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	ghes_proc(ghes);
 
 	return 0;
-err_edac_unreg:
-	ghes_edac_unregister(ghes);
+
 err:
 	if (ghes) {
 		ghes_fini(ghes);
@@ -1241,8 +1251,6 @@ static int ghes_remove(struct platform_device *ghes_dev)
 
 	ghes_fini(ghes);
 
-	ghes_edac_unregister(ghes);
-
 	kfree(ghes);
 
 	platform_set_drvdata(ghes_dev, NULL);
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 96afb2aeed18..fdd8278ca89a 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -53,8 +53,8 @@ config EDAC_DECODE_MCE
 	  has been initialized.
 
 config EDAC_GHES
-	bool "Output ACPI APEI/GHES BIOS detected errors via EDAC"
-	depends on ACPI_APEI_GHES && (EDAC=y)
+	tristate "Output ACPI APEI/GHES BIOS detected errors via EDAC"
+	depends on ACPI_APEI_GHES
 	help
 	  Not all machines support hardware-driven error report. Some of those
 	  provide a BIOS-driven error report mechanism via ACPI, using the
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 5357800e418d..6d46f30dc657 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -60,6 +60,9 @@
 #define edac_pci_printk(ctl, level, fmt, arg...) \
 	printk(level "EDAC PCI%d: " fmt, ctl->pci_idx, ##arg)
 
+#define edac_pr_err(fmt, arg...)	edac_printk(KERN_ERR, "", fmt, ##arg)
+#define edac_pr_info(fmt, arg...)	edac_printk(KERN_INFO, "", fmt, ##arg)
+
 /* prefixes for edac_printk() and edac_mc_printk() */
 #define EDAC_MC "MC"
 #define EDAC_PCI "PCI"
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 4e61a6229dd2..20fafc55eb2d 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -5,6 +5,9 @@
  * License version 2.
  *
  * Copyright (c) 2013 by Mauro Carvalho Chehab
+ *	     (c) 2017 Borislav Petkov
+ *
+ * Borislav Petkov: turn it into a proper module.
  *
  * Red Hat Inc. http://www.redhat.com
  */
@@ -17,7 +20,14 @@
 #include "edac_module.h"
 #include <ras/ras_event.h>
 
-#define GHES_EDAC_REVISION " Ver: 1.0.0"
+#define GHES_EDAC_REVISION " Ver: 2.0.0"
+
+/*
+ * Hand it into EDAC's core so that we have a device to operate on.
+ */
+static struct device dummy_dev;
+
+struct ghes_edac_pvt *ghes_pvt;
 
 struct ghes_edac_pvt {
 	struct list_head list;
@@ -30,11 +40,6 @@ struct ghes_edac_pvt {
 	char msg[80];
 };
 
-static LIST_HEAD(ghes_reglist);
-static DEFINE_MUTEX(ghes_edac_lock);
-static int ghes_edac_mc_num;
-
-
 /* Memory Device - Type 17 of SMBIOS spec */
 struct memdev_dmi_entry {
 	u8 type;
@@ -165,24 +170,21 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 	}
 }
 
-void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
-				struct cper_sec_mem_err *mem_err)
+static int report_mem_error(struct notifier_block *nb, unsigned long sev, void *data)
 {
+	struct cper_sec_mem_err *mem_err = data;
 	enum hw_event_mc_err_type type;
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
-	struct ghes_edac_pvt *pvt = NULL;
-	char *p;
+	struct ghes_edac_pvt *pvt = ghes_pvt;
 	u8 grain_bits;
+	char *p;
 
-	list_for_each_entry(pvt, &ghes_reglist, list) {
-		if (ghes == pvt->ghes)
-			break;
-	}
 	if (!pvt) {
-		pr_err("Internal error: Can't find EDAC structure\n");
-		return;
+		edac_pr_err("Internal error: Can't find EDAC structure\n");
+		return NOTIFY_DONE;
 	}
+
 	mci = pvt->mci;
 	e = &mci->error_desc;
 
@@ -402,23 +404,40 @@ void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
 
 	/* Report the error via EDAC API */
 	edac_raw_mc_handle_error(type, mci, e);
+
+	return NOTIFY_DONE;
 }
-EXPORT_SYMBOL_GPL(ghes_edac_report_mem_error);
 
-int ghes_edac_register(struct ghes *ghes, struct device *dev)
+static struct notifier_block ghes_nb = {
+	.notifier_call  = report_mem_error,
+};
+
+static const char * const fake_msg =
+"This EDAC driver relies on BIOS to enumerate memory and get error reports.\n"
+"Unfortunately, not all BIOSes reflect the memory layout correctly.\n"
+"So, the end result of using this driver varies from vendor to vendor.\n"
+"If you find incorrect reports, please contact your hardware vendor\n"
+"to correct its BIOS.";
+
+static const char * const super_crap_msg =
+"This system has a very crappy BIOS: It doesn't even list the DIMMS.\n"
+"Its SMBIOS info is wrong. It is doubtful that the error report would\n"
+"work on such system. Use this driver with caution.";
+
+static int __init ghes_edac_register(void)
 {
+	struct ghes_edac_pvt *pvt = ghes_pvt;
 	bool fake = false;
 	int rc, num_dimm = 0;
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[1];
-	struct ghes_edac_pvt *pvt;
 	struct ghes_edac_dimm_fill dimm_fill;
 
 	/* Get the number of DIMMs */
 	dmi_walk(ghes_edac_count_dimms, &num_dimm);
 
 	/* Check if we've got a bogus BIOS */
-	if (num_dimm == 0) {
+	if (!num_dimm) {
 		fake = true;
 		num_dimm = 1;
 	}
@@ -431,21 +450,17 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	 * We need to serialize edac_mc_alloc() and edac_mc_add_mc(),
 	 * to avoid duplicated memory controller numbers
 	 */
-	mutex_lock(&ghes_edac_lock);
-	mci = edac_mc_alloc(ghes_edac_mc_num, ARRAY_SIZE(layers), layers,
-			    sizeof(*pvt));
+	mci = edac_mc_alloc(1, ARRAY_SIZE(layers), layers, sizeof(*pvt));
 	if (!mci) {
-		pr_info("Can't allocate memory for EDAC data\n");
-		mutex_unlock(&ghes_edac_lock);
+		edac_pr_err("Can't allocate memory for EDAC data\n");
 		return -ENOMEM;
 	}
 
 	pvt = mci->pvt_info;
 	memset(pvt, 0, sizeof(*pvt));
-	list_add_tail(&pvt->list, &ghes_reglist);
-	pvt->ghes = ghes;
 	pvt->mci  = mci;
-	mci->pdev = dev;
+
+	mci->pdev = &dummy_dev;
 
 	mci->mtype_cap = MEM_FLAG_EMPTY;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE;
@@ -455,21 +470,12 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
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
-	}
+	if (!fake)
+		edac_pr_info("%s\n", fake_msg);
+	else
+		edac_pr_info("%s\n", super_crap_msg);
+
+	edac_pr_info("This system has %d DIMM sockets.\n", num_dimm);
 
 	if (!fake) {
 		/*
@@ -478,13 +484,11 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		 * Keep it in blank for the other memory controllers, as
 		 * there's no reliable way to properly credit each DIMM to
 		 * the memory controller, as different BIOSes fill the
-		 * DMI bank location fields on different ways
+		 * DMI bank location fields in different ways.
 		 */
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
@@ -498,30 +502,31 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 
 	rc = edac_mc_add_mc(mci);
 	if (rc < 0) {
-		pr_info("Can't register at EDAC core\n");
+		edac_pr_err("Can't register with EDAC core\n");
 		edac_mc_free(mci);
-		mutex_unlock(&ghes_edac_lock);
 		return -ENODEV;
 	}
 
-	ghes_edac_mc_num++;
-	mutex_unlock(&ghes_edac_lock);
+	ghes_register_edac_chain(&ghes_nb);
+
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ghes_edac_register);
+module_init(ghes_edac_register);
 
-void ghes_edac_unregister(struct ghes *ghes)
+static void __exit ghes_edac_unregister(void)
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
+	ghes_unregister_edac_chain(&ghes_nb);
+
+	mci = find_mci_by_dev(&dummy_dev);
+	WARN_ON(!mci);
+
+	edac_mc_del_mc(mci->pdev);
+	edac_mc_free(mci);
+
 }
-EXPORT_SYMBOL_GPL(ghes_edac_unregister);
+module_exit(ghes_edac_unregister);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("GHES error decoding module - " GHES_EDAC_REVISION);
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 9f26e01186ae..c02b8eb91bd6 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -51,31 +51,8 @@ enum {
 	GHES_SEV_PANIC = 0x3,
 };
 
-/* From drivers/edac/ghes_edac.c */
-
-#ifdef CONFIG_EDAC_GHES
-void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
-				struct cper_sec_mem_err *mem_err);
-
-int ghes_edac_register(struct ghes *ghes, struct device *dev);
-
-void ghes_edac_unregister(struct ghes *ghes);
-
-#else
-static inline void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
-				       struct cper_sec_mem_err *mem_err)
-{
-}
-
-static inline int ghes_edac_register(struct ghes *ghes, struct device *dev)
-{
-	return 0;
-}
-
-static inline void ghes_edac_unregister(struct ghes *ghes)
-{
-}
-#endif
+void ghes_register_edac_chain(struct notifier_block *nb);
+void ghes_unregister_edac_chain(struct notifier_block *nb);
 
 static inline int acpi_hest_get_version(struct acpi_hest_generic_data *gdata)
 {
-- 
2.14.0.rc0


-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
