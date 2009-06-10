From: Alex Chiang <achiang@hp.com>
Subject: [PATCH v3 10/12] ACPI: kill acpi_get_pci_id
Date: Wed, 10 Jun 2009 13:55:55 -0600
Message-ID: <20090610195555.28982.89651.stgit@bob.kio>
References: <20090610194714.28982.51363.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:32585 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761525AbZFJTzx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2009 15:55:53 -0400
In-Reply-To: <20090610194714.28982.51363.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

acpi_get_pci_dev() is better, and all callers have been converted, so
eliminate acpi_get_pci_id().

Signed-off-by: Alex Chiang <achiang@hp.com>
---

 drivers/acpi/pci_bind.c     |   71 -------------------------------------------
 include/acpi/acpi_drivers.h |    1 -
 2 files changed, 0 insertions(+), 72 deletions(-)

diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index a205769..a5a77b7 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -33,77 +33,6 @@
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME("pci_bind");
 
-struct acpi_pci_data {
-	struct acpi_pci_id id;
-	struct pci_bus *bus;
-	struct pci_dev *dev;
-};
-
-static int acpi_pci_bind(struct acpi_device *device);
-static int acpi_pci_unbind(struct acpi_device *device);
-
-static void acpi_pci_data_handler(acpi_handle handle, u32 function,
-				  void *context)
-{
-
-	/* TBD: Anything we need to do here? */
-
-	return;
-}
-
-/**
- * acpi_get_pci_id
- * ------------------
- * This function is used by the ACPI Interpreter (a.k.a. Core Subsystem)
- * to resolve PCI information for ACPI-PCI devices defined in the namespace.
- * This typically occurs when resolving PCI operation region information.
- */
-acpi_status acpi_get_pci_id(acpi_handle handle, struct acpi_pci_id *id)
-{
-	int result = 0;
-	acpi_status status = AE_OK;
-	struct acpi_device *device = NULL;
-	struct acpi_pci_data *data = NULL;
-
-
-	if (!id)
-		return AE_BAD_PARAMETER;
-
-	result = acpi_bus_get_device(handle, &device);
-	if (result) {
-		printk(KERN_ERR PREFIX
-			    "Invalid ACPI Bus context for device %s\n",
-			    acpi_device_bid(device));
-		return AE_NOT_EXIST;
-	}
-
-	status = acpi_get_data(handle, acpi_pci_data_handler, (void **)&data);
-	if (ACPI_FAILURE(status) || !data) {
-		ACPI_EXCEPTION((AE_INFO, status,
-				"Invalid ACPI-PCI context for device %s",
-				acpi_device_bid(device)));
-		return status;
-	}
-
-	*id = data->id;
-
-	/*
-	   id->segment = data->id.segment;
-	   id->bus = data->id.bus;
-	   id->device = data->id.device;
-	   id->function = data->id.function;
-	 */
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Device %s has PCI address %04x:%02x:%02x.%d\n",
-			  acpi_device_bid(device), id->segment, id->bus,
-			  id->device, id->function));
-
-	return AE_OK;
-}
-
-EXPORT_SYMBOL(acpi_get_pci_id);
-
 static int acpi_pci_unbind(struct acpi_device *device)
 {
 	struct pci_dev *dev;
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 12e99c3..f4906f6 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -98,7 +98,6 @@ void acpi_pci_irq_del_prt(struct pci_bus *bus);
 struct pci_bus;
 
 struct pci_dev *acpi_get_pci_dev(acpi_handle);
-acpi_status acpi_get_pci_id(acpi_handle handle, struct acpi_pci_id *id);
 int acpi_pci_bind_root(struct acpi_device *device);
 
 /* Arch-defined function to add a bus to the system */

