From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [resend PATCH] driver core: property: support for generic property
Date: Sat, 14 Mar 2015 02:09:06 +0100
Message-ID: <1615473.geXTLLKD0n@vostro.rjw.lan>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com> <CACxGe6tCJAPJc=Pj7vYiJ-cakvL9EsexGMpOD_G0DEPF3iTguQ@mail.gmail.com> <2794681.zGttLrs2tn@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57883 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750818AbbCNApV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Mar 2015 20:45:21 -0400
In-Reply-To: <2794681.zGttLrs2tn@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@linaro.org>
Cc: Grant Likely <grant.likely@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Friday, March 13, 2015 04:24:11 PM Arnd Bergmann wrote:
> On Friday 13 March 2015 15:10:38 Grant Likely wrote:
> > On Thu, Mar 12, 2015 at 1:41 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > On Monday, January 26, 2015 03:17:40 PM Heikki Krogerus wrote:
> > > That doesn't seem to go in the right direction to be honest.
> > >
> > > Actually, having introduced struct fwnode_handle, we should perhaps try to
> > > replace both of_node and acpi_node with a single struct fwnode_handle pointer
> > > and then add a new fwnode_type for the "pdata" stuff.
> > 
> > I agree on this, but it will be a lot of work to convert...
> > 
> > > If you don't want to deal with of_node, which I can understand easily, it
> > > may be worth trying with acpi_node alone at this point and once you have
> > > the fwnode_handle pointer, you might use it for both ACPI and "pdata"?
> > >
> > > Grant, Arnd, I wonder what you think?
> > 
> > That makes sense, and we can populate the fwnode_handle even when
> > using DT. That will allow a transition period to move everyone over to
> > the fwnode_handle.
> 
> Agreed on both as well.

OK

So below is what it takes to use struct fwnode_handle to represent ACPI
companions.

Rafael


---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: driver core / ACPI: Represent ACPI companions using fwnode_handle

Now that we have struct fwnode_handle, we can use that to point to
ACPI companions from struct device objects instead of pointing to
struct acpi_device directly.

There are two benefits from that.  First, the somewhat ugly and
hackish struct acpi_dev_node can be dropped and, second, the same
struct fwnode_handle pointer can be used in the future to point
to other (non-ACPI) firmware device node types.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_platform.c    |    2 +-
 drivers/acpi/dock.c             |    2 +-
 drivers/base/platform.c         |    2 +-
 drivers/i2c/i2c-core.c          |    4 ++--
 include/acpi/acpi_bus.h         |    3 ++-
 include/linux/acpi.h            |    7 ++++---
 include/linux/device.h          |   13 +++----------
 include/linux/fwnode.h          |   25 +++++++++++++++++++++++++
 include/linux/i2c.h             |    4 ++--
 include/linux/platform_device.h |    2 +-
 include/linux/property.h        |   11 +----------
 11 files changed, 43 insertions(+), 32 deletions(-)

Index: linux-pm/include/linux/device.h
===================================================================
--- linux-pm.orig/include/linux/device.h
+++ linux-pm/include/linux/device.h
@@ -38,6 +38,7 @@ struct class;
 struct subsys_private;
 struct bus_type;
 struct device_node;
+struct fwnode_handle;
 struct iommu_ops;
 struct iommu_group;
 
@@ -650,14 +651,6 @@ struct device_dma_parameters {
 	unsigned long segment_boundary_mask;
 };
 
-struct acpi_device;
-
-struct acpi_dev_node {
-#ifdef CONFIG_ACPI
-	struct acpi_device *companion;
-#endif
-};
-
 /**
  * struct device - The basic device structure
  * @parent:	The device's "parent" device, the device to which it is attached.
@@ -703,7 +696,7 @@ struct acpi_dev_node {
  * @cma_area:	Contiguous memory area for dma allocations
  * @archdata:	For arch-specific additions.
  * @of_node:	Associated device tree node.
- * @acpi_node:	Associated ACPI device node.
+ * @fwnode:	Associated device node supplied by platform firmware.
  * @devt:	For creating the sysfs "dev".
  * @id:		device instance
  * @devres_lock: Spinlock to protect the resource of the device.
@@ -779,7 +772,7 @@ struct device {
 	struct dev_archdata	archdata;
 
 	struct device_node	*of_node; /* associated device tree node */
-	struct acpi_dev_node	acpi_node; /* associated ACPI device node */
+	struct fwnode_handle	*fwnode; /* firmware device node */
 
 	dev_t			devt;	/* dev_t, creates the sysfs "dev" */
 	u32			id;	/* device instance */
Index: linux-pm/include/linux/fwnode.h
===================================================================
--- /dev/null
+++ linux-pm/include/linux/fwnode.h
@@ -0,0 +1,25 @@
+/*
+ * fwnode.h - Firmware device node object handle type definition.
+ *
+ * Copyright (C) 2015, Intel Corporation
+ * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _LINUX_FWNODE_H_
+#define _LINUX_FWNODE_H_
+
+enum fwnode_type {
+	FWNODE_INVALID = 0,
+	FWNODE_OF,
+	FWNODE_ACPI,
+};
+
+struct fwnode_handle {
+	enum fwnode_type type;
+};
+
+#endif
Index: linux-pm/include/linux/property.h
===================================================================
--- linux-pm.orig/include/linux/property.h
+++ linux-pm/include/linux/property.h
@@ -13,6 +13,7 @@
 #ifndef _LINUX_PROPERTY_H_
 #define _LINUX_PROPERTY_H_
 
+#include <linux/fwnode.h>
 #include <linux/types.h>
 
 struct device;
@@ -40,16 +41,6 @@ int device_property_read_string_array(st
 int device_property_read_string(struct device *dev, const char *propname,
 				const char **val);
 
-enum fwnode_type {
-	FWNODE_INVALID = 0,
-	FWNODE_OF,
-	FWNODE_ACPI,
-};
-
-struct fwnode_handle {
-	enum fwnode_type type;
-};
-
 bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname);
 int fwnode_property_read_u8_array(struct fwnode_handle *fwnode,
 				  const char *propname, u8 *val,
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -386,7 +386,8 @@ static inline bool is_acpi_node(struct f
 
 static inline struct acpi_device *acpi_node(struct fwnode_handle *fwnode)
 {
-	return fwnode ? container_of(fwnode, struct acpi_device, fwnode) : NULL;
+	return is_acpi_node(fwnode) ?
+		container_of(fwnode, struct acpi_device, fwnode) : NULL;
 }
 
 static inline struct fwnode_handle *acpi_fwnode_handle(struct acpi_device *adev)
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -29,7 +29,7 @@
 #include <linux/ioport.h>	/* for struct resource */
 #include <linux/resource_ext.h>
 #include <linux/device.h>
-#include <linux/property.h>
+#include <linux/fwnode.h>
 
 #ifndef _LINUX
 #define _LINUX
@@ -53,8 +53,9 @@ static inline acpi_handle acpi_device_ha
 	return adev ? adev->handle : NULL;
 }
 
-#define ACPI_COMPANION(dev)		((dev)->acpi_node.companion)
-#define ACPI_COMPANION_SET(dev, adev)	ACPI_COMPANION(dev) = (adev)
+#define ACPI_COMPANION(dev)		acpi_node((dev)->fwnode)
+#define ACPI_COMPANION_SET(dev, adev)	(dev)->fwnode = (adev) ? \
+	acpi_fwnode_handle(adev) : NULL
 #define ACPI_HANDLE(dev)		acpi_device_handle(ACPI_COMPANION(dev))
 
 static inline void acpi_preset_companion(struct device *dev,
Index: linux-pm/include/linux/platform_device.h
===================================================================
--- linux-pm.orig/include/linux/platform_device.h
+++ linux-pm/include/linux/platform_device.h
@@ -59,7 +59,7 @@ extern int platform_add_devices(struct p
 
 struct platform_device_info {
 		struct device *parent;
-		struct acpi_dev_node acpi_node;
+		struct fwnode_handle *fwnode;
 
 		const char *name;
 		int id;
Index: linux-pm/drivers/acpi/dock.c
===================================================================
--- linux-pm.orig/drivers/acpi/dock.c
+++ linux-pm/drivers/acpi/dock.c
@@ -615,7 +615,7 @@ void acpi_dock_add(struct acpi_device *a
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 	pdevinfo.name = "dock";
 	pdevinfo.id = dock_station_count;
-	pdevinfo.acpi_node.companion = adev;
+	pdevinfo.fwnode = acpi_fwnode_handle(adev);
 	pdevinfo.data = &ds;
 	pdevinfo.size_data = sizeof(ds);
 	dd = platform_device_register_full(&pdevinfo);
Index: linux-pm/drivers/acpi/acpi_platform.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_platform.c
+++ linux-pm/drivers/acpi/acpi_platform.c
@@ -102,7 +102,7 @@ struct platform_device *acpi_create_plat
 	pdevinfo.id = -1;
 	pdevinfo.res = resources;
 	pdevinfo.num_res = count;
-	pdevinfo.acpi_node.companion = adev;
+	pdevinfo.fwnode = acpi_fwnode_handle(adev);
 	pdevinfo.dma_mask = DMA_BIT_MASK(32);
 	pdev = platform_device_register_full(&pdevinfo);
 	if (IS_ERR(pdev))
Index: linux-pm/drivers/base/platform.c
===================================================================
--- linux-pm.orig/drivers/base/platform.c
+++ linux-pm/drivers/base/platform.c
@@ -454,7 +454,7 @@ struct platform_device *platform_device_
 		goto err_alloc;
 
 	pdev->dev.parent = pdevinfo->parent;
-	ACPI_COMPANION_SET(&pdev->dev, pdevinfo->acpi_node.companion);
+	pdev->dev.fwnode = pdevinfo->fwnode;
 
 	if (pdevinfo->dma_mask) {
 		/*
Index: linux-pm/drivers/i2c/i2c-core.c
===================================================================
--- linux-pm.orig/drivers/i2c/i2c-core.c
+++ linux-pm/drivers/i2c/i2c-core.c
@@ -133,7 +133,7 @@ static acpi_status acpi_i2c_add_device(a
 		return AE_OK;
 
 	memset(&info, 0, sizeof(info));
-	info.acpi_node.companion = adev;
+	info.fwnode = acpi_fwnode_handle(adev);
 	info.irq = -1;
 
 	INIT_LIST_HEAD(&resource_list);
@@ -974,7 +974,7 @@ i2c_new_device(struct i2c_adapter *adap,
 	client->dev.bus = &i2c_bus_type;
 	client->dev.type = &i2c_client_type;
 	client->dev.of_node = info->of_node;
-	ACPI_COMPANION_SET(&client->dev, info->acpi_node.companion);
+	client->dev.fwnode = info->fwnode;
 
 	i2c_dev_set_name(adap, client);
 	status = device_register(&client->dev);
Index: linux-pm/include/linux/i2c.h
===================================================================
--- linux-pm.orig/include/linux/i2c.h
+++ linux-pm/include/linux/i2c.h
@@ -278,7 +278,7 @@ static inline int i2c_slave_event(struct
  * @platform_data: stored in i2c_client.dev.platform_data
  * @archdata: copied into i2c_client.dev.archdata
  * @of_node: pointer to OpenFirmware device node
- * @acpi_node: ACPI device node
+ * @fwnode: device node supplied by the platform firmware
  * @irq: stored in i2c_client.irq
  *
  * I2C doesn't actually support hardware probing, although controllers and
@@ -299,7 +299,7 @@ struct i2c_board_info {
 	void		*platform_data;
 	struct dev_archdata	*archdata;
 	struct device_node *of_node;
-	struct acpi_dev_node acpi_node;
+	struct fwnode_handle *fwnode;
 	int		irq;
 };
 

