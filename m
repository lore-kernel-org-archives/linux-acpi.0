From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 16/37] PNP: remove pnp_resource_table from internal get/set interfaces
Date: Wed, 26 Mar 2008 11:11:14 -0600
Message-ID: <20080326171226.536434040@ldl.fc.hp.com>
References: <20080326171058.099442579@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:22034 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760778AbYCZRIu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 13:08:50 -0400
Content-Disposition: inline; filename=pnp-remove-pnp_resource_table-args-from-get-set
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

When we call protocol->get() and protocol->set() methods, we currently
supply pointers to both the pnp_dev and the pnp_resource_table even
though the pnp_resource_table should always be the one associated with
the pnp_dev.

This removes the pnp_resource_table arguments to make it clear that
these methods only operate on the specified pnp_dev.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

---
 include/linux/pnp.h        |    4 ++--
 drivers/pnp/interface.c    |    2 +-
 drivers/pnp/manager.c      |    2 +-
 drivers/pnp/isapnp/core.c  |   11 +++++------
 drivers/pnp/pnpacpi/core.c |    8 +++-----
 drivers/pnp/pnpbios/core.c |   10 ++++------
 6 files changed, 16 insertions(+), 21 deletions(-)

Index: work7/include/linux/pnp.h
===================================================================
--- work7.orig/include/linux/pnp.h	2008-03-25 14:48:32.000000000 -0600
+++ work7/include/linux/pnp.h	2008-03-25 14:48:39.000000000 -0600
@@ -328,8 +328,8 @@
 	char *name;
 
 	/* resource control functions */
-	int (*get) (struct pnp_dev *dev, struct pnp_resource_table *res);
-	int (*set) (struct pnp_dev *dev, struct pnp_resource_table *res);
+	int (*get) (struct pnp_dev *dev);
+	int (*set) (struct pnp_dev *dev);
 	int (*disable) (struct pnp_dev *dev);
 
 	/* protocol specific suspend/resume */
Index: work7/drivers/pnp/interface.c
===================================================================
--- work7.orig/drivers/pnp/interface.c	2008-03-25 14:48:21.000000000 -0600
+++ work7/drivers/pnp/interface.c	2008-03-25 14:48:39.000000000 -0600
@@ -364,7 +364,7 @@
 	if (!strnicmp(buf, "get", 3)) {
 		mutex_lock(&pnp_res_mutex);
 		if (pnp_can_read(dev))
-			dev->protocol->get(dev, &dev->res);
+			dev->protocol->get(dev);
 		mutex_unlock(&pnp_res_mutex);
 		goto done;
 	}
Index: work7/drivers/pnp/manager.c
===================================================================
--- work7.orig/drivers/pnp/manager.c	2008-03-25 14:48:21.000000000 -0600
+++ work7/drivers/pnp/manager.c	2008-03-25 14:48:39.000000000 -0600
@@ -473,7 +473,7 @@
 		return -EINVAL;
 	}
 
-	if (dev->protocol->set(dev, &dev->res) < 0) {
+	if (dev->protocol->set(dev) < 0) {
 		dev_err(&dev->dev, "activation failed\n");
 		return -EIO;
 	}
Index: work7/drivers/pnp/isapnp/core.c
===================================================================
--- work7.orig/drivers/pnp/isapnp/core.c	2008-03-25 14:48:35.000000000 -0600
+++ work7/drivers/pnp/isapnp/core.c	2008-03-25 14:48:39.000000000 -0600
@@ -978,21 +978,20 @@
 	return 0;
 }
 
-static int isapnp_get_resources(struct pnp_dev *dev,
-				struct pnp_resource_table *res)
+static int isapnp_get_resources(struct pnp_dev *dev)
 {
 	int ret;
 
-	pnp_init_resource_table(res);
+	pnp_init_resource_table(&dev->res);
 	isapnp_cfg_begin(dev->card->number, dev->number);
-	ret = isapnp_read_resources(dev, res);
+	ret = isapnp_read_resources(dev, &dev->res);
 	isapnp_cfg_end();
 	return ret;
 }
 
-static int isapnp_set_resources(struct pnp_dev *dev,
-				struct pnp_resource_table *res)
+static int isapnp_set_resources(struct pnp_dev *dev)
 {
+	struct pnp_resource_table *res = &dev->res;
 	int tmp;
 
 	isapnp_cfg_begin(dev->card->number, dev->number);
Index: work7/drivers/pnp/pnpacpi/core.c
===================================================================
--- work7.orig/drivers/pnp/pnpacpi/core.c	2008-03-25 14:48:38.000000000 -0600
+++ work7/drivers/pnp/pnpacpi/core.c	2008-03-25 14:48:39.000000000 -0600
@@ -73,8 +73,7 @@
 	return 1;
 }
 
-static int pnpacpi_get_resources(struct pnp_dev *dev,
-				 struct pnp_resource_table *res)
+static int pnpacpi_get_resources(struct pnp_dev *dev)
 {
 	acpi_status status;
 
@@ -83,8 +82,7 @@
 	return ACPI_FAILURE(status) ? -ENODEV : 0;
 }
 
-static int pnpacpi_set_resources(struct pnp_dev *dev,
-				 struct pnp_resource_table *res)
+static int pnpacpi_set_resources(struct pnp_dev *dev)
 {
 	acpi_handle handle = dev->data;
 	struct acpi_buffer buffer;
@@ -94,7 +92,7 @@
 	ret = pnpacpi_build_resource_template(dev, &buffer);
 	if (ret)
 		return ret;
-	ret = pnpacpi_encode_resources(res, &buffer);
+	ret = pnpacpi_encode_resources(&dev->res, &buffer);
 	if (ret) {
 		kfree(buffer.pointer);
 		return ret;
Index: work7/drivers/pnp/pnpbios/core.c
===================================================================
--- work7.orig/drivers/pnp/pnpbios/core.c	2008-03-25 14:48:31.000000000 -0600
+++ work7/drivers/pnp/pnpbios/core.c	2008-03-25 14:48:39.000000000 -0600
@@ -204,8 +204,7 @@
 
 #endif				/* CONFIG_HOTPLUG */
 
-static int pnpbios_get_resources(struct pnp_dev *dev,
-				 struct pnp_resource_table *res)
+static int pnpbios_get_resources(struct pnp_dev *dev)
 {
 	u8 nodenum = dev->number;
 	struct pnp_bios_node *node;
@@ -220,14 +219,13 @@
 		kfree(node);
 		return -ENODEV;
 	}
-	pnpbios_read_resources_from_node(res, node);
+	pnpbios_read_resources_from_node(&dev->res, node);
 	dev->active = pnp_is_active(dev);
 	kfree(node);
 	return 0;
 }
 
-static int pnpbios_set_resources(struct pnp_dev *dev,
-				 struct pnp_resource_table *res)
+static int pnpbios_set_resources(struct pnp_dev *dev)
 {
 	u8 nodenum = dev->number;
 	struct pnp_bios_node *node;
@@ -243,7 +241,7 @@
 		kfree(node);
 		return -ENODEV;
 	}
-	if (pnpbios_write_resources_to_node(res, node) < 0) {
+	if (pnpbios_write_resources_to_node(&dev->res, node) < 0) {
 		kfree(node);
 		return -1;
 	}

-- 
