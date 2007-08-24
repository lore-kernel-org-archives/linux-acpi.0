From: Len Brown <len.brown@intel.com>
Subject: [PATCH 23/25] PNP: remove null pointer checks
Date: Fri, 24 Aug 2007 03:21:10 -0400
Message-ID: <11879401002195-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
 <11879400802531-git-send-email-len.brown@intel.com>
 <11879400812208-git-send-email-len.brown@intel.com>
 <11879400823500-git-send-email-len.brown@intel.com>
 <11879400841550-git-send-email-len.brown@intel.com>
 <1187940085345-git-send-email-len.brown@intel.com>
 <1187940086685-git-send-email-len.brown@intel.com>
 <11879400872911-git-send-email-len.brown@intel.com>
 <11879400882727-git-send-email-len.brown@intel.com>
 <11879400892741-git-send-email-len.brown@intel.com>
 <11879400903190-git-send-email-len.brown@intel.com>
 <11879400911609-git-send-email-len.brown@intel.com>
 <11879400921598-git-send-email-len.brown@intel.com>
 <11879400933976-git-send-email-len.brown@intel.com>
 <1187940094867-git-send-email-len.brown@intel.com>
 <11879400951708-git-send-email-len.brown@intel.com>
 <11879400963954-git-send-email-len.brown@intel.com>
 <11879400972603-git-send-email-len.brown@intel.com>
 <11879400984017-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61132 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763654AbXHXHVl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:41 -0400
In-Reply-To: <11879400984017-git-send-email-len.brown@intel.com>
Message-Id: <b173491339b9ae7f1322241ce6228c1268513a39.1187939443.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Remove some null pointer checks.  Null pointers in these areas indicate
programming errors, and I think it's better to oops immediately rather
than return an error that is easily ignored.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Adam Belay <abelay@novell.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/core.c        |    7 +------
 drivers/pnp/driver.c      |    4 ----
 drivers/pnp/isapnp/core.c |    2 +-
 drivers/pnp/manager.c     |   23 -----------------------
 drivers/pnp/resource.c    |   26 --------------------------
 5 files changed, 2 insertions(+), 60 deletions(-)

diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
index 61066fd..d5964fe 100644
--- a/drivers/pnp/core.c
+++ b/drivers/pnp/core.c
@@ -52,9 +52,6 @@ int pnp_register_protocol(struct pnp_protocol *protocol)
 	int nodenum;
 	struct list_head *pos;
 
-	if (!protocol)
-		return -EINVAL;
-
 	INIT_LIST_HEAD(&protocol->devices);
 	INIT_LIST_HEAD(&protocol->cards);
 	nodenum = 0;
@@ -94,8 +91,6 @@ static void pnp_free_ids(struct pnp_dev *dev)
 	struct pnp_id *id;
 	struct pnp_id *next;
 
-	if (!dev)
-		return;
 	id = dev->id;
 	while (id) {
 		next = id->next;
@@ -143,7 +138,7 @@ int __pnp_add_device(struct pnp_dev *dev)
  */
 int pnp_add_device(struct pnp_dev *dev)
 {
-	if (!dev || !dev->protocol || dev->card)
+	if (dev->card)
 		return -EINVAL;
 	dev->dev.parent = &dev->protocol->dev;
 	sprintf(dev->dev.bus_id, "%02x:%02x", dev->protocol->number,
diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index 9be01b0..2fa64a6 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -232,10 +232,6 @@ int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev)
 {
 	struct pnp_id *ptr;
 
-	if (!id)
-		return -EINVAL;
-	if (!dev)
-		return -EINVAL;
 	id->next = NULL;
 	ptr = dev->id;
 	while (ptr && ptr->next)
diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index 1a0d33a..b035d60 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -1040,7 +1040,7 @@ static int isapnp_set_resources(struct pnp_dev *dev,
 
 static int isapnp_disable_resources(struct pnp_dev *dev)
 {
-	if (!dev || !dev->active)
+	if (!dev->active)
 		return -EINVAL;
 	isapnp_cfg_begin(dev->card->number, dev->number);
 	isapnp_deactivate(dev->number);
diff --git a/drivers/pnp/manager.c b/drivers/pnp/manager.c
index 329dc6c..0826287 100644
--- a/drivers/pnp/manager.c
+++ b/drivers/pnp/manager.c
@@ -21,9 +21,6 @@ static int pnp_assign_port(struct pnp_dev *dev, struct pnp_port *rule, int idx)
 	resource_size_t *start, *end;
 	unsigned long *flags;
 
-	if (!dev || !rule)
-		return -EINVAL;
-
 	if (idx >= PNP_MAX_PORT) {
 		pnp_err
 		    ("More than 4 ports is incompatible with pnp specifications.");
@@ -66,9 +63,6 @@ static int pnp_assign_mem(struct pnp_dev *dev, struct pnp_mem *rule, int idx)
 	resource_size_t *start, *end;
 	unsigned long *flags;
 
-	if (!dev || !rule)
-		return -EINVAL;
-
 	if (idx >= PNP_MAX_MEM) {
 		pnp_err
 		    ("More than 8 mems is incompatible with pnp specifications.");
@@ -127,9 +121,6 @@ static int pnp_assign_irq(struct pnp_dev *dev, struct pnp_irq *rule, int idx)
 		5, 10, 11, 12, 9, 14, 15, 7, 3, 4, 13, 0, 1, 6, 8, 2
 	};
 
-	if (!dev || !rule)
-		return -EINVAL;
-
 	if (idx >= PNP_MAX_IRQ) {
 		pnp_err
 		    ("More than 2 irqs is incompatible with pnp specifications.");
@@ -181,9 +172,6 @@ static int pnp_assign_dma(struct pnp_dev *dev, struct pnp_dma *rule, int idx)
 		1, 3, 5, 6, 7, 0, 2, 4
 	};
 
-	if (!dev || !rule)
-		return -EINVAL;
-
 	if (idx >= PNP_MAX_DMA) {
 		pnp_err
 		    ("More than 2 dmas is incompatible with pnp specifications.");
@@ -410,8 +398,6 @@ int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res,
 	int i;
 	struct pnp_resource_table *bak;
 
-	if (!dev || !res)
-		return -EINVAL;
 	if (!pnp_can_configure(dev))
 		return -ENODEV;
 	bak = pnp_alloc(sizeof(struct pnp_resource_table));
@@ -460,9 +446,6 @@ int pnp_auto_config_dev(struct pnp_dev *dev)
 	struct pnp_option *dep;
 	int i = 1;
 
-	if (!dev)
-		return -EINVAL;
-
 	if (!pnp_can_configure(dev)) {
 		pnp_dbg("Device %s does not support resource configuration.",
 			dev->dev.bus_id);
@@ -541,8 +524,6 @@ int pnp_activate_dev(struct pnp_dev *dev)
 {
 	int error;
 
-	if (!dev)
-		return -EINVAL;
 	if (dev->active)
 		return 0;	/* the device is already active */
 
@@ -568,8 +549,6 @@ int pnp_disable_dev(struct pnp_dev *dev)
 {
 	int error;
 
-	if (!dev)
-		return -EINVAL;
 	if (!dev->active)
 		return 0;	/* the device is already disabled */
 
@@ -596,8 +575,6 @@ int pnp_disable_dev(struct pnp_dev *dev)
 void pnp_resource_change(struct resource *resource, resource_size_t start,
 			 resource_size_t size)
 {
-	if (resource == NULL)
-		return;
 	resource->flags &= ~(IORESOURCE_AUTO | IORESOURCE_UNSET);
 	resource->start = start;
 	resource->end = start + size - 1;
diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index ea6ec14..ef12869 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -47,9 +47,6 @@ struct pnp_option *pnp_register_independent_option(struct pnp_dev *dev)
 {
 	struct pnp_option *option;
 
-	if (!dev)
-		return NULL;
-
 	option = pnp_build_option(PNP_RES_PRIORITY_PREFERRED);
 
 	/* this should never happen but if it does we'll try to continue */
@@ -64,9 +61,6 @@ struct pnp_option *pnp_register_dependent_option(struct pnp_dev *dev,
 {
 	struct pnp_option *option;
 
-	if (!dev)
-		return NULL;
-
 	option = pnp_build_option(priority);
 
 	if (dev->dependent) {
@@ -83,11 +77,6 @@ int pnp_register_irq_resource(struct pnp_option *option, struct pnp_irq *data)
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
@@ -112,11 +101,6 @@ int pnp_register_dma_resource(struct pnp_option *option, struct pnp_dma *data)
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
@@ -132,11 +116,6 @@ int pnp_register_port_resource(struct pnp_option *option, struct pnp_port *data)
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
@@ -152,11 +131,6 @@ int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data)
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
-- 
1.5.3.rc6.17.g1911
