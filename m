From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/98] ACPI: pci_link: remove unnecessary casts and
 initializations
Date: Sat, 28 Mar 2009 00:30:43 -0400
Message-ID: <c9d6244329c8149312dba27e78dc4a83b35a6ae5.1238214617.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:49505 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbZC1Ecb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:31 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700JFH8M2X3VU@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:27 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Remove unnecessary casts and initializations.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_link.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 19bc3bc..b59f59e 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -109,7 +109,7 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
 						void *context)
 {
 	struct acpi_pci_link *link = context;
-	u32 i = 0;
+	u32 i;
 
 	switch (resource->type) {
 	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
@@ -199,7 +199,7 @@ static int acpi_pci_link_get_possible(struct acpi_pci_link *link)
 static acpi_status acpi_pci_link_check_current(struct acpi_resource *resource,
 					       void *context)
 {
-	int *irq = (int *)context;
+	int *irq = context;
 
 	switch (resource->type) {
 	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
@@ -256,7 +256,7 @@ static acpi_status acpi_pci_link_check_current(struct acpi_resource *resource,
 static int acpi_pci_link_get_current(struct acpi_pci_link *link)
 {
 	int result = 0;
-	acpi_status status = AE_OK;
+	acpi_status status;
 	int irq = 0;
 
 	if (!link)
@@ -306,8 +306,8 @@ static int acpi_pci_link_get_current(struct acpi_pci_link *link)
 
 static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
 {
-	int result = 0;
-	acpi_status status = AE_OK;
+	int result;
+	acpi_status status;
 	struct {
 		struct acpi_resource res;
 		struct acpi_resource end;
@@ -485,9 +485,9 @@ static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
 
 int __init acpi_irq_penalty_init(void)
 {
-	struct list_head *node = NULL;
-	struct acpi_pci_link *link = NULL;
-	int i = 0;
+	struct list_head *node;
+	struct acpi_pci_link *link;
+	int i;
 
 	/*
 	 * Update penalties to facilitate IRQ balancing.
@@ -602,9 +602,9 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
 			       int *polarity, char **name)
 {
-	int result = 0;
-	struct acpi_device *device = NULL;
-	struct acpi_pci_link *link = NULL;
+	int result;
+	struct acpi_device *device;
+	struct acpi_pci_link *link;
 
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
@@ -656,8 +656,8 @@ int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
  */
 int acpi_pci_link_free_irq(acpi_handle handle)
 {
-	struct acpi_device *device = NULL;
-	struct acpi_pci_link *link = NULL;
+	struct acpi_device *device;
+	struct acpi_pci_link *link;
 	acpi_status result;
 
 	result = acpi_bus_get_device(handle, &device);
@@ -707,9 +707,9 @@ int acpi_pci_link_free_irq(acpi_handle handle)
 
 static int acpi_pci_link_add(struct acpi_device *device)
 {
-	int result = 0;
-	struct acpi_pci_link *link = NULL;
-	int i = 0;
+	int result;
+	struct acpi_pci_link *link;
+	int i;
 	int found = 0;
 
 	if (!device)
@@ -777,8 +777,8 @@ static int acpi_pci_link_resume(struct acpi_pci_link *link)
 
 static int irqrouter_resume(struct sys_device *dev)
 {
-	struct list_head *node = NULL;
-	struct acpi_pci_link *link = NULL;
+	struct list_head *node;
+	struct acpi_pci_link *link;
 
 	list_for_each(node, &acpi_link.entries) {
 		link = list_entry(node, struct acpi_pci_link, node);
@@ -793,7 +793,7 @@ static int irqrouter_resume(struct sys_device *dev)
 
 static int acpi_pci_link_remove(struct acpi_device *device, int type)
 {
-	struct acpi_pci_link *link = NULL;
+	struct acpi_pci_link *link;
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
-- 
1.6.0.6

