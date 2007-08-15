From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 6/6] PNP: remove null pointer checks
Date: Wed, 15 Aug 2007 10:32:13 -0600
Message-ID: <20070815163433.147757546@ldl.fc.hp.com>
References: <20070815163207.062263984@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:44946 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761529AbXHOQft (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Aug 2007 12:35:49 -0400
Content-Disposition: inline; filename=pnp-remove-null-pointer-checks
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Remove some null pointer checks.  Null pointers in these areas indicate
programming errors, and I think it's better to oops immediately rather
than return an error that is easily ignored.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/pnp/core.c
===================================================================
--- w.orig/drivers/pnp/core.c	2007-08-14 11:46:03.000000000 -0600
+++ w/drivers/pnp/core.c	2007-08-15 09:52:21.000000000 -0600
@@ -52,9 +52,6 @@
 	int nodenum;
 	struct list_head *pos;
 
-	if (!protocol)
-		return -EINVAL;
-
 	INIT_LIST_HEAD(&protocol->devices);
 	INIT_LIST_HEAD(&protocol->cards);
 	nodenum = 0;
@@ -94,8 +91,6 @@
 	struct pnp_id *id;
 	struct pnp_id *next;
 
-	if (!dev)
-		return;
 	id = dev->id;
 	while (id) {
 		next = id->next;
@@ -143,7 +138,7 @@
  */
 int pnp_add_device(struct pnp_dev *dev)
 {
-	if (!dev || !dev->protocol || dev->card)
+	if (dev->card)
 		return -EINVAL;
 	dev->dev.parent = &dev->protocol->dev;
 	sprintf(dev->dev.bus_id, "%02x:%02x", dev->protocol->number,
Index: w/drivers/pnp/driver.c
===================================================================
--- w.orig/drivers/pnp/driver.c	2007-08-15 09:47:42.000000000 -0600
+++ w/drivers/pnp/driver.c	2007-08-15 09:52:21.000000000 -0600
@@ -232,10 +232,6 @@
 {
 	struct pnp_id *ptr;
 
-	if (!id)
-		return -EINVAL;
-	if (!dev)
-		return -EINVAL;
 	id->next = NULL;
 	ptr = dev->id;
 	while (ptr && ptr->next)
Index: w/drivers/pnp/manager.c
===================================================================
--- w.orig/drivers/pnp/manager.c	2007-08-15 09:47:42.000000000 -0600
+++ w/drivers/pnp/manager.c	2007-08-15 09:52:21.000000000 -0600
@@ -21,9 +21,6 @@
 	resource_size_t *start, *end;
 	unsigned long *flags;
 
-	if (!dev || !rule)
-		return -EINVAL;
-
 	if (idx >= PNP_MAX_PORT) {
 		pnp_err
 		    ("More than 4 ports is incompatible with pnp specifications.");
@@ -66,9 +63,6 @@
 	resource_size_t *start, *end;
 	unsigned long *flags;
 
-	if (!dev || !rule)
-		return -EINVAL;
-
 	if (idx >= PNP_MAX_MEM) {
 		pnp_err
 		    ("More than 8 mems is incompatible with pnp specifications.");
@@ -127,9 +121,6 @@
 		5, 10, 11, 12, 9, 14, 15, 7, 3, 4, 13, 0, 1, 6, 8, 2
 	};
 
-	if (!dev || !rule)
-		return -EINVAL;
-
 	if (idx >= PNP_MAX_IRQ) {
 		pnp_err
 		    ("More than 2 irqs is incompatible with pnp specifications.");
@@ -181,9 +172,6 @@
 		1, 3, 5, 6, 7, 0, 2, 4
 	};
 
-	if (!dev || !rule)
-		return -EINVAL;
-
 	if (idx >= PNP_MAX_DMA) {
 		pnp_err
 		    ("More than 2 dmas is incompatible with pnp specifications.");
@@ -410,8 +398,6 @@
 	int i;
 	struct pnp_resource_table *bak;
 
-	if (!dev || !res)
-		return -EINVAL;
 	if (!pnp_can_configure(dev))
 		return -ENODEV;
 	bak = pnp_alloc(sizeof(struct pnp_resource_table));
@@ -460,9 +446,6 @@
 	struct pnp_option *dep;
 	int i = 1;
 
-	if (!dev)
-		return -EINVAL;
-
 	if (!pnp_can_configure(dev)) {
 		pnp_dbg("Device %s does not support resource configuration.",
 			dev->dev.bus_id);
@@ -541,8 +524,6 @@
 {
 	int error;
 
-	if (!dev)
-		return -EINVAL;
 	if (dev->active)
 		return 0;	/* the device is already active */
 
@@ -568,8 +549,6 @@
 {
 	int error;
 
-	if (!dev)
-		return -EINVAL;
 	if (!dev->active)
 		return 0;	/* the device is already disabled */
 
@@ -596,8 +575,6 @@
 void pnp_resource_change(struct resource *resource, resource_size_t start,
 			 resource_size_t size)
 {
-	if (resource == NULL)
-		return;
 	resource->flags &= ~(IORESOURCE_AUTO | IORESOURCE_UNSET);
 	resource->start = start;
 	resource->end = start + size - 1;
Index: w/drivers/pnp/resource.c
===================================================================
--- w.orig/drivers/pnp/resource.c	2007-08-14 11:46:03.000000000 -0600
+++ w/drivers/pnp/resource.c	2007-08-15 09:52:21.000000000 -0600
@@ -47,9 +47,6 @@
 {
 	struct pnp_option *option;
 
-	if (!dev)
-		return NULL;
-
 	option = pnp_build_option(PNP_RES_PRIORITY_PREFERRED);
 
 	/* this should never happen but if it does we'll try to continue */
@@ -64,9 +61,6 @@
 {
 	struct pnp_option *option;
 
-	if (!dev)
-		return NULL;
-
 	option = pnp_build_option(priority);
 
 	if (dev->dependent) {
@@ -83,11 +77,6 @@
 {
 	struct pnp_irq *ptr;
 
-	if (!option)
-		return -EINVAL;
-	if (!data)
-		return -EINVAL;
-
 	ptr = option->irq;
 	while (ptr && ptr->next)
 		ptr = ptr->next;
@@ -112,11 +101,6 @@
 {
 	struct pnp_dma *ptr;
 
-	if (!option)
-		return -EINVAL;
-	if (!data)
-		return -EINVAL;
-
 	ptr = option->dma;
 	while (ptr && ptr->next)
 		ptr = ptr->next;
@@ -132,11 +116,6 @@
 {
 	struct pnp_port *ptr;
 
-	if (!option)
-		return -EINVAL;
-	if (!data)
-		return -EINVAL;
-
 	ptr = option->port;
 	while (ptr && ptr->next)
 		ptr = ptr->next;
@@ -152,11 +131,6 @@
 {
 	struct pnp_mem *ptr;
 
-	if (!option)
-		return -EINVAL;
-	if (!data)
-		return -EINVAL;
-
 	ptr = option->mem;
 	while (ptr && ptr->next)
 		ptr = ptr->next;
Index: w/drivers/pnp/isapnp/core.c
===================================================================
--- w.orig/drivers/pnp/isapnp/core.c	2007-08-15 09:51:17.000000000 -0600
+++ w/drivers/pnp/isapnp/core.c	2007-08-15 09:52:21.000000000 -0600
@@ -1040,7 +1040,7 @@
 
 static int isapnp_disable_resources(struct pnp_dev *dev)
 {
-	if (!dev || !dev->active)
+	if (!dev->active)
 		return -EINVAL;
 	isapnp_cfg_begin(dev->card->number, dev->number);
 	isapnp_deactivate(dev->number);

--
