From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/4] ACPI: pci_link: remove unnecessary casts and
	initializations
Date: Tue, 17 Feb 2009 14:00:45 -0700
Message-ID: <20090217210045.4506.46493.stgit@bob.kio>
References: <20090217205906.4506.95815.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:41951 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbZBQVAq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Feb 2009 16:00:46 -0500
In-Reply-To: <20090217205906.4506.95815.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Remove unnecessary casts and initializations.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
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

