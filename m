From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 20/53] PNP: remove unused interfaces using pnp_resource_table
Date: Fri, 18 Apr 2008 14:50:15 -0600
Message-ID: <20080418205051.261247348@ldl.fc.hp.com>
References: <20080418204955.342963315@ldl.fc.hp.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762906AbYDRVBw@vger.kernel.org>
Content-Disposition: inline; filename=pnp-remove-unused-interfaces
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

Rene Herman <rene.herman@gmail.com> recently removed the only in-tree
driver uses of:

    pnp_init_resource_table()
    pnp_manual_config_dev()
    pnp_resource_change()

in this change:

    http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=109c53f840e551d6e99ecfd8b0131a968332c89f

These are no longer used in the PNP core either, so we can just remove
them completely.

It's possible that there are out-of-tree drivers that use these
interfaces.  They should be changed to either (1) use PNP quirks
to work around broken hardware or firmware, or (2) use the sysfs
interfaces to control resource usage from userspace.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-By: Rene Herman <rene.herman@gmail.com>

---
 drivers/pnp/manager.c |   78 +-------------------------------------------------
 include/linux/pnp.h   |    9 -----
 2 files changed, 3 insertions(+), 84 deletions(-)

Index: work8/include/linux/pnp.h
===================================================================
--- work8.orig/include/linux/pnp.h	2008-04-10 16:47:25.000000000 -0600
+++ work8/include/linux/pnp.h	2008-04-10 16:48:34.000000000 -0600
@@ -387,18 +387,14 @@
 int pnp_register_port_resource(struct pnp_option *option,
 			       struct pnp_port *data);
 int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data);
-void pnp_init_resource_table(struct pnp_resource_table *table);
 void pnp_init_resources(struct pnp_dev *dev);
-int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res,
-			  int mode);
 int pnp_auto_config_dev(struct pnp_dev *dev);
 int pnp_validate_config(struct pnp_dev *dev);
 int pnp_start_dev(struct pnp_dev *dev);
 int pnp_stop_dev(struct pnp_dev *dev);
 int pnp_activate_dev(struct pnp_dev *dev);
 int pnp_disable_dev(struct pnp_dev *dev);
-void pnp_resource_change(struct resource *resource, resource_size_t start,
-			 resource_size_t size);
+
 
 /* protocol helpers */
 int pnp_is_active(struct pnp_dev *dev);
@@ -435,16 +431,13 @@
 static inline int pnp_register_dma_resource(struct pnp_option *option, struct pnp_dma *data) { return -ENODEV; }
 static inline int pnp_register_port_resource(struct pnp_option *option, struct pnp_port *data) { return -ENODEV; }
 static inline int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data) { return -ENODEV; }
-static inline void pnp_init_resource_table(struct pnp_resource_table *table) { }
 static inline void pnp_init_resources(struct pnp_dev *dev) { }
-static inline int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode) { return -ENODEV; }
 static inline int pnp_auto_config_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_validate_config(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_start_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_stop_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
-static inline void pnp_resource_change(struct resource *resource, resource_size_t start, resource_size_t size) { }
 
 /* protocol helpers */
 static inline int pnp_is_active(struct pnp_dev *dev) { return 0; }
Index: work8/drivers/pnp/manager.c
===================================================================
--- work8.orig/drivers/pnp/manager.c	2008-04-10 16:47:29.000000000 -0600
+++ work8/drivers/pnp/manager.c	2008-04-10 16:48:34.000000000 -0600
@@ -204,8 +204,9 @@
  * pnp_init_resources - Resets a resource table to default values.
  * @table: pointer to the desired resource table
  */
-void pnp_init_resource_table(struct pnp_resource_table *table)
+void pnp_init_resources(struct pnp_dev *dev)
 {
+	struct pnp_resource_table *table = &dev->res;
 	int idx;
 
 	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
@@ -238,11 +239,6 @@
 	}
 }
 
-void pnp_init_resources(struct pnp_dev *dev)
-{
-	pnp_init_resource_table(&dev->res);
-}
-
 /**
  * pnp_clean_resources - clears resources that were not manually set
  * @res: the resources to clean
@@ -383,59 +379,6 @@
 }
 
 /**
- * pnp_manual_config_dev - Disables Auto Config and Manually sets the resource table
- * @dev: pointer to the desired device
- * @res: pointer to the new resource config
- * @mode: 0 or PNP_CONFIG_FORCE
- *
- * This function can be used by drivers that want to manually set thier resources.
- */
-int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res,
-			  int mode)
-{
-	int i;
-	struct pnp_resource_table *bak;
-
-	if (!pnp_can_configure(dev))
-		return -ENODEV;
-	bak = pnp_alloc(sizeof(struct pnp_resource_table));
-	if (!bak)
-		return -ENOMEM;
-	*bak = dev->res;
-
-	mutex_lock(&pnp_res_mutex);
-	dev->res = *res;
-	if (!(mode & PNP_CONFIG_FORCE)) {
-		for (i = 0; i < PNP_MAX_PORT; i++) {
-			if (!pnp_check_port(dev, i))
-				goto fail;
-		}
-		for (i = 0; i < PNP_MAX_MEM; i++) {
-			if (!pnp_check_mem(dev, i))
-				goto fail;
-		}
-		for (i = 0; i < PNP_MAX_IRQ; i++) {
-			if (!pnp_check_irq(dev, i))
-				goto fail;
-		}
-		for (i = 0; i < PNP_MAX_DMA; i++) {
-			if (!pnp_check_dma(dev, i))
-				goto fail;
-		}
-	}
-	mutex_unlock(&pnp_res_mutex);
-
-	kfree(bak);
-	return 0;
-
-fail:
-	dev->res = *bak;
-	mutex_unlock(&pnp_res_mutex);
-	kfree(bak);
-	return -EINVAL;
-}
-
-/**
  * pnp_auto_config_dev - automatically assigns resources to a device
  * @dev: pointer to the desired device
  */
@@ -561,24 +504,7 @@
 	return 0;
 }
 
-/**
- * pnp_resource_change - change one resource
- * @resource: pointer to resource to be changed
- * @start: start of region
- * @size: size of region
- */
-void pnp_resource_change(struct resource *resource, resource_size_t start,
-			 resource_size_t size)
-{
-	resource->flags &= ~(IORESOURCE_AUTO | IORESOURCE_UNSET);
-	resource->start = start;
-	resource->end = start + size - 1;
-}
-
-EXPORT_SYMBOL(pnp_manual_config_dev);
 EXPORT_SYMBOL(pnp_start_dev);
 EXPORT_SYMBOL(pnp_stop_dev);
 EXPORT_SYMBOL(pnp_activate_dev);
 EXPORT_SYMBOL(pnp_disable_dev);
-EXPORT_SYMBOL(pnp_resource_change);
-EXPORT_SYMBOL(pnp_init_resource_table);

-- 
