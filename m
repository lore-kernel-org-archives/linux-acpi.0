From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 4/5] ACPI: pci_root: simplify list traversals
Date: Thu, 18 Jun 2009 14:47:02 -0600
Message-ID: <20090618204702.15850.43213.stgit@bob.kio>
References: <20090618203916.15850.7977.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:7828 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbZFRUrA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2009 16:47:00 -0400
In-Reply-To: <20090618203916.15850.7977.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alex Chiang <achiang@hp.com>

Using list_for_each_entry() makes traversing the root list easier.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Reviewed-by: Alex Chiang <achiang@hp.com>
---
 drivers/acpi/pci_root.c |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index e490a2e..d9d34e2 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -82,7 +82,7 @@ static DEFINE_MUTEX(osc_lock);
 int acpi_pci_register_driver(struct acpi_pci_driver *driver)
 {
 	int n = 0;
-	struct list_head *entry;
+	struct acpi_pci_root *root;
 
 	struct acpi_pci_driver **pptr = &sub_driver;
 	while (*pptr)
@@ -92,9 +92,7 @@ int acpi_pci_register_driver(struct acpi_pci_driver *driver)
 	if (!driver->add)
 		return 0;
 
-	list_for_each(entry, &acpi_pci_roots) {
-		struct acpi_pci_root *root;
-		root = list_entry(entry, struct acpi_pci_root, node);
+	list_for_each_entry(root, &acpi_pci_roots, node) {
 		driver->add(root->device->handle);
 		n++;
 	}
@@ -106,7 +104,7 @@ EXPORT_SYMBOL(acpi_pci_register_driver);
 
 void acpi_pci_unregister_driver(struct acpi_pci_driver *driver)
 {
-	struct list_head *entry;
+	struct acpi_pci_root *root;
 
 	struct acpi_pci_driver **pptr = &sub_driver;
 	while (*pptr) {
@@ -120,23 +118,19 @@ void acpi_pci_unregister_driver(struct acpi_pci_driver *driver)
 	if (!driver->remove)
 		return;
 
-	list_for_each(entry, &acpi_pci_roots) {
-		struct acpi_pci_root *root;
-		root = list_entry(entry, struct acpi_pci_root, node);
+	list_for_each_entry(root, &acpi_pci_roots, node)
 		driver->remove(root->device->handle);
-	}
 }
 
 EXPORT_SYMBOL(acpi_pci_unregister_driver);
 
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int seg, unsigned int bus)
 {
-	struct acpi_pci_root *tmp;
+	struct acpi_pci_root *root;
 	
-	list_for_each_entry(tmp, &acpi_pci_roots, node) {
-		if ((tmp->id.segment == (u16) seg) && (tmp->id.bus == (u16) bus))
-			return tmp->device->handle;
-	}
+	list_for_each_entry(root, &acpi_pci_roots, node)
+		if ((root->id.segment == (u16) seg) && (root->id.bus == (u16) bus))
+			return root->device->handle;
 	return NULL;		
 }
 
@@ -325,6 +319,7 @@ static acpi_status acpi_pci_osc_support(struct acpi_pci_root *root, u32 flags)
 static struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
 {
 	struct acpi_pci_root *root;
+
 	list_for_each_entry(root, &acpi_pci_roots, node) {
 		if (root->device->handle == handle)
 			return root;

