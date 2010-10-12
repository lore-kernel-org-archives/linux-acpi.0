From: yakui.zhao@intel.com
Subject: [RFC PATCH 2/4] IPMI: Remove the redundant definition of ipmi_addr_src
Date: Tue, 12 Oct 2010 15:47:08 +0800
Message-ID: <1286869630-18695-3-git-send-email-yakui.zhao@intel.com>
References: <1286869630-18695-1-git-send-email-yakui.zhao@intel.com>
 <1286869630-18695-2-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59991 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756973Ab0JLHvt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Oct 2010 03:51:49 -0400
In-Reply-To: <1286869630-18695-2-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: openipmi-developer@lists.sourceforge.net, linux-acpi@vger.kernel.org
Cc: minyard@acm.org, lenb@kernel.org, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

The ipmi_addr_src is defined twice. One is in ipmi_smi_info and the other
is in generic smi_info. Remove the redunant definition in smi_info.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/char/ipmi/ipmi_si_intf.c |   36 +++++++++++++++++-------------------
 1 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 4885709..996a62a 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -193,7 +193,6 @@ struct smi_info {
 	int (*irq_setup)(struct smi_info *info);
 	void (*irq_cleanup)(struct smi_info *info);
 	unsigned int io_size;
-	enum ipmi_addr_src addr_source; /* ACPI, PCI, SMBIOS, hardcode, etc. */
 	void (*addr_source_cleanup)(struct smi_info *info);
 	void *addr_source_data;
 
@@ -1191,12 +1190,11 @@ static int get_smi_info(void *send_info,
 	struct smi_info *new_smi = send_info;
 	struct ipmi_smi_info *smi_data = &new_smi->smi_data;
 
-	if (new_smi->addr_source != type)
+	if (smi_data->addr_src != type)
 		return -EINVAL;
 
 	get_device(new_smi->dev);
 	memcpy(data, smi_data, sizeof(*smi_data));
-	smi_data->addr_src = type;
 	smi_data->dev = new_smi->dev;
 
 	return 0;
@@ -1810,7 +1808,7 @@ static int hotmod_handler(const char *val, struct kernel_param *kp)
 				goto out;
 			}
 
-			info->addr_source = SI_HOTMOD;
+			info->smi_data.addr_src = SI_HOTMOD;
 			info->si_type = si_type;
 			info->io.addr_data = addr;
 			info->io.addr_type = addr_space;
@@ -1873,7 +1871,7 @@ static __devinit void hardcode_find_bmc(void)
 		if (!info)
 			return;
 
-		info->addr_source = SI_HARDCODED;
+		info->smi_data.addr_src = SI_HARDCODED;
 		printk(KERN_INFO PFX "probing via hardcoded address\n");
 
 		if (!si_type[i] || strcmp(si_type[i], "kcs") == 0) {
@@ -2059,7 +2057,7 @@ static __devinit int try_init_spmi(struct SPMITable *spmi)
 		return -ENOMEM;
 	}
 
-	info->addr_source = SI_SPMI;
+	info->smi_data.addr_src = SI_SPMI;
 	printk(KERN_INFO PFX "probing via SPMI\n");
 
 	/* Figure out the interface type. */
@@ -2167,7 +2165,7 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 	if (!info)
 		return -ENOMEM;
 
-	info->addr_source = SI_ACPI;
+	info->smi_data.addr_src = SI_ACPI;
 	info->smi_data.smi_info.acpi_info.acpi_handle =
 				acpi_dev->handle;
 	printk(KERN_INFO PFX "probing via ACPI\n");
@@ -2352,7 +2350,7 @@ static __devinit void try_init_dmi(struct dmi_ipmi_data *ipmi_data)
 		return;
 	}
 
-	info->addr_source = SI_SMBIOS;
+	info->smi_data.addr_src = SI_SMBIOS;
 	printk(KERN_INFO PFX "probing via SMBIOS\n");
 
 	switch (ipmi_data->type) {
@@ -2457,7 +2455,7 @@ static int __devinit ipmi_pci_probe(struct pci_dev *pdev,
 	if (!info)
 		return -ENOMEM;
 
-	info->addr_source = SI_PCI;
+	info->smi_data.addr_src = SI_PCI;
 	dev_info(&pdev->dev, "probing via PCI");
 
 	switch (class_type) {
@@ -2603,7 +2601,7 @@ static int __devinit ipmi_of_probe(struct platform_device *dev,
 	}
 
 	info->si_type		= (enum si_type) match->data;
-	info->addr_source	= SI_DEVICETREE;
+	info->smi_data.addr_src	= SI_DEVICETREE;
 	info->irq_setup		= std_irq_setup;
 
 	if (resource.flags & IORESOURCE_IO) {
@@ -3045,7 +3043,7 @@ static __devinit void default_find_bmc(void)
 		if (!info)
 			return;
 
-		info->addr_source = SI_DEFAULT;
+		info->smi_data.addr_src = SI_DEFAULT;
 
 		info->si_type = ipmi_defaults[i].type;
 		info->io_setup = port_setup;
@@ -3092,7 +3090,7 @@ static int add_smi(struct smi_info *new_smi)
 	int rv = 0;
 
 	printk(KERN_INFO PFX "Adding %s-specified %s state machine",
-			ipmi_addr_src_to_str[new_smi->addr_source],
+			ipmi_addr_src_to_str[new_smi->smi_data.addr_src],
 			si_to_str[new_smi->si_type]);
 	mutex_lock(&smi_infos_lock);
 	if (!is_new_interface(new_smi)) {
@@ -3123,7 +3121,7 @@ static int try_smi_init(struct smi_info *new_smi)
 	printk(KERN_INFO PFX "Trying %s-specified %s state"
 	       " machine at %s address 0x%lx, slave address 0x%x,"
 	       " irq %d\n",
-	       ipmi_addr_src_to_str[new_smi->addr_source],
+	       ipmi_addr_src_to_str[new_smi->smi_data.addr_src],
 	       si_to_str[new_smi->si_type],
 	       addr_space_to_str[new_smi->io.addr_type],
 	       new_smi->io.addr_data,
@@ -3171,7 +3169,7 @@ static int try_smi_init(struct smi_info *new_smi)
 
 	/* Do low-level detection first. */
 	if (new_smi->handlers->detect(new_smi->si_sm)) {
-		if (new_smi->addr_source)
+		if (new_smi->smi_data.addr_src)
 			printk(KERN_INFO PFX "Interface detection failed\n");
 		rv = -ENODEV;
 		goto out_err;
@@ -3183,7 +3181,7 @@ static int try_smi_init(struct smi_info *new_smi)
 	 */
 	rv = try_get_dev_id(new_smi);
 	if (rv) {
-		if (new_smi->addr_source)
+		if (new_smi->smi_data.addr_src)
 			printk(KERN_INFO PFX "There appears to be no BMC"
 			       " at this location\n");
 		goto out_err;
@@ -3415,9 +3413,9 @@ static __devinit int init_ipmi_si(void)
 		/* Try to register a device if it has an IRQ and we either
 		   haven't successfully registered a device yet or this
 		   device has the same type as one we successfully registered */
-		if (e->irq && (!type || e->addr_source == type)) {
+		if (e->irq && (!type || e->smi_data.addr_src == type)) {
 			if (!try_smi_init(e)) {
-				type = e->addr_source;
+				type = e->smi_data.addr_src;
 			}
 		}
 	}
@@ -3431,9 +3429,9 @@ static __devinit int init_ipmi_si(void)
 	/* Fall back to the preferred device */
 
 	list_for_each_entry(e, &smi_infos, link) {
-		if (!e->irq && (!type || e->addr_source == type)) {
+		if (!e->irq && (!type || e->smi_data.addr_src == type)) {
 			if (!try_smi_init(e)) {
-				type = e->addr_source;
+				type = e->smi_data.addr_src;
 			}
 		}
 	}
-- 
1.5.4.5

