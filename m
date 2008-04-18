From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 18/53] PNP: add pnp_init_resources(struct pnp_dev *) interface
Date: Fri, 18 Apr 2008 14:50:13 -0600
Message-ID: <20080418205050.861008468@ldl.fc.hp.com>
References: <20080418204955.342963315@ldl.fc.hp.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762573AbYDRVBO@vger.kernel.org>
Content-Disposition: inline; filename=pnp-remove-pnp_resource_table-from-init
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

Add pnp_init_resources(struct pnp_dev *) to replace
pnp_init_resource_table(), which takes a pointer to the
pnp_resource_table itself.  Passing only the pnp_dev * reduces
the possibility for error in the caller and removes the
pnp_resource_table implementation detail from the interface.

Even though pnp_init_resource_table() is exported, I did not
export pnp_init_resources() because it is used only by the PNP
core.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-By: Rene Herman <rene.herman@gmail.com>

---
 drivers/pnp/interface.c        |    6 +++---
 drivers/pnp/isapnp/core.c      |    4 ++--
 drivers/pnp/manager.c          |    5 +++++
 drivers/pnp/pnpacpi/core.c     |    2 +-
 drivers/pnp/pnpacpi/rsparser.c |    3 +--
 drivers/pnp/pnpbios/core.c     |    2 +-
 drivers/pnp/pnpbios/rsparser.c |    3 +--
 include/linux/pnp.h            |    2 ++
 8 files changed, 16 insertions(+), 11 deletions(-)

Index: work7/include/linux/pnp.h
===================================================================
--- work7.orig/include/linux/pnp.h	2008-03-31 17:10:39.000000000 -0600
+++ work7/include/linux/pnp.h	2008-03-31 17:10:48.000000000 -0600
@@ -388,6 +388,7 @@
 			       struct pnp_port *data);
 int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data);
 void pnp_init_resource_table(struct pnp_resource_table *table);
+void pnp_init_resources(struct pnp_dev *dev);
 int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res,
 			  int mode);
 int pnp_auto_config_dev(struct pnp_dev *dev);
@@ -435,6 +436,7 @@
 static inline int pnp_register_port_resource(struct pnp_option *option, struct pnp_port *data) { return -ENODEV; }
 static inline int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data) { return -ENODEV; }
 static inline void pnp_init_resource_table(struct pnp_resource_table *table) { }
+static inline void pnp_init_resources(struct pnp_dev *dev) { }
 static inline int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode) { return -ENODEV; }
 static inline int pnp_auto_config_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_validate_config(struct pnp_dev *dev) { return -ENODEV; }
Index: work7/drivers/pnp/manager.c
===================================================================
--- work7.orig/drivers/pnp/manager.c	2008-03-31 17:10:39.000000000 -0600
+++ work7/drivers/pnp/manager.c	2008-03-31 17:10:48.000000000 -0600
@@ -238,6 +238,11 @@
 	}
 }
 
+void pnp_init_resources(struct pnp_dev *dev)
+{
+	pnp_init_resource_table(&dev->res);
+}
+
 /**
  * pnp_clean_resources - clears resources that were not manually set
  * @res: the resources to clean
Index: work7/drivers/pnp/interface.c
===================================================================
--- work7.orig/drivers/pnp/interface.c	2008-03-31 17:10:39.000000000 -0600
+++ work7/drivers/pnp/interface.c	2008-03-31 17:10:48.000000000 -0600
@@ -351,14 +351,14 @@
 	if (!strnicmp(buf, "auto", 4)) {
 		if (dev->active)
 			goto done;
-		pnp_init_resource_table(&dev->res);
+		pnp_init_resources(dev);
 		retval = pnp_auto_config_dev(dev);
 		goto done;
 	}
 	if (!strnicmp(buf, "clear", 5)) {
 		if (dev->active)
 			goto done;
-		pnp_init_resource_table(&dev->res);
+		pnp_init_resources(dev);
 		goto done;
 	}
 	if (!strnicmp(buf, "get", 3)) {
@@ -373,7 +373,7 @@
 		if (dev->active)
 			goto done;
 		buf += 3;
-		pnp_init_resource_table(&dev->res);
+		pnp_init_resources(dev);
 		mutex_lock(&pnp_res_mutex);
 		while (1) {
 			while (isspace(*buf))
Index: work7/drivers/pnp/isapnp/core.c
===================================================================
--- work7.orig/drivers/pnp/isapnp/core.c	2008-03-31 17:10:45.000000000 -0600
+++ work7/drivers/pnp/isapnp/core.c	2008-03-31 17:10:48.000000000 -0600
@@ -424,7 +424,7 @@
 	dev->capabilities |= PNP_READ;
 	dev->capabilities |= PNP_WRITE;
 	dev->capabilities |= PNP_DISABLE;
-	pnp_init_resource_table(&dev->res);
+	pnp_init_resources(dev);
 	return dev;
 }
 
@@ -972,7 +972,7 @@
 {
 	int ret;
 
-	pnp_init_resource_table(&dev->res);
+	pnp_init_resources(dev);
 	isapnp_cfg_begin(dev->card->number, dev->number);
 	ret = isapnp_read_resources(dev);
 	isapnp_cfg_end();
Index: work7/drivers/pnp/pnpacpi/core.c
===================================================================
--- work7.orig/drivers/pnp/pnpacpi/core.c	2008-03-31 17:10:45.000000000 -0600
+++ work7/drivers/pnp/pnpacpi/core.c	2008-03-31 17:10:48.000000000 -0600
@@ -210,7 +210,7 @@
 
 	/* clear out the damaged flags */
 	if (!dev->active)
-		pnp_init_resource_table(&dev->res);
+		pnp_init_resources(dev);
 	pnp_add_device(dev);
 	num++;
 
Index: work7/drivers/pnp/pnpbios/core.c
===================================================================
--- work7.orig/drivers/pnp/pnpbios/core.c	2008-03-31 17:10:45.000000000 -0600
+++ work7/drivers/pnp/pnpbios/core.c	2008-03-31 17:10:48.000000000 -0600
@@ -345,7 +345,7 @@
 
 	/* clear out the damaged flags */
 	if (!dev->active)
-		pnp_init_resource_table(&dev->res);
+		pnp_init_resources(dev);
 
 	pnp_add_device(dev);
 	pnpbios_interface_attach_device(node);
Index: work7/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work7.orig/drivers/pnp/pnpacpi/rsparser.c	2008-03-31 17:10:45.000000000 -0600
+++ work7/drivers/pnp/pnpacpi/rsparser.c	2008-03-31 17:10:48.000000000 -0600
@@ -406,8 +406,7 @@
 {
 	acpi_handle handle = dev->data;
 
-	/* Blank the resource table values */
-	pnp_init_resource_table(&dev->res);
+	pnp_init_resources(dev);
 
 	return acpi_walk_resources(handle, METHOD_NAME__CRS,
 				   pnpacpi_allocated_resource, dev);
Index: work7/drivers/pnp/pnpbios/rsparser.c
===================================================================
--- work7.orig/drivers/pnp/pnpbios/rsparser.c	2008-03-31 17:10:45.000000000 -0600
+++ work7/drivers/pnp/pnpbios/rsparser.c	2008-03-31 17:10:48.000000000 -0600
@@ -143,8 +143,7 @@
 	if (!p)
 		return NULL;
 
-	/* Blank the resource table values */
-	pnp_init_resource_table(&dev->res);
+	pnp_init_resources(dev);
 
 	while ((char *)p < (char *)end) {
 

-- 
