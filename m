From: mochel@linux.intel.com
Subject: [PATCH 13/24] Remove unneeded debugging macros in drivers/acpi/pci_bind.c
Date: Mon, 17 Apr 2006 18:21:54 -0700
Message-ID: <1145323314724-git-send-email-mochel@linux.intel.com>
References: <114532331475-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:45213 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932121AbWDRBZZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:25 -0400
Received: from orsfmr100.jf.intel.com (orsfmr100.jf.intel.com [10.7.209.16])
	by orsfmr003.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PPer030525
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:25 GMT
In-Reply-To: <114532331475-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/pci_bind.c |   41 +++++++++++++++--------------------------
 1 files changed, 15 insertions(+), 26 deletions(-)

applies-to: a8e46bdcced6e4e56cabe4f8c4c58e76af3e9671
1a7ebc037b5c3f783c160fad42cf2d05ee5d8431
diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index 6d3e818..e4b6990 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -47,11 +47,8 @@ struct acpi_pci_data {
 static void acpi_pci_data_handler(acpi_handle handle, u32 function,
 				  void *context)
 {
-	ACPI_FUNCTION_TRACE("acpi_pci_data_handler");
-
 	/* TBD: Anything we need to do here? */
 
-	return_VOID;
 }
 
 /**
@@ -68,17 +65,15 @@ acpi_status acpi_get_pci_id(acpi_handle 
 	struct acpi_device *device = NULL;
 	struct acpi_pci_data *data = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_get_pci_id");
-
 	if (!id)
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
+		return AE_BAD_PARAMETER;
 
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
 		ACPI_ERROR((AE_INFO,
 			    "Invalid ACPI Bus context for device %s",
 			    acpi_device_bid(device)));
-		return_ACPI_STATUS(AE_NOT_EXIST);
+		return AE_NOT_EXIST;
 	}
 
 	status = acpi_get_data(handle, acpi_pci_data_handler, (void **)&data);
@@ -86,7 +81,7 @@ acpi_status acpi_get_pci_id(acpi_handle 
 		ACPI_EXCEPTION((AE_INFO, status,
 				"Invalid ACPI-PCI context for device %s",
 				acpi_device_bid(device)));
-		return_ACPI_STATUS(status);
+		return status;
 	}
 
 	*id = data->id;
@@ -103,7 +98,7 @@ acpi_status acpi_get_pci_id(acpi_handle 
 			  acpi_device_bid(device), id->segment, id->bus,
 			  id->device, id->function));
 
-	return_ACPI_STATUS(AE_OK);
+	return AE_OK;
 }
 
 EXPORT_SYMBOL(acpi_get_pci_id);
@@ -120,14 +115,12 @@ int acpi_pci_bind(struct acpi_device *de
 	struct pci_dev *dev;
 	struct pci_bus *bus;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_bind");
-
 	if (!device || !device->parent)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	pathname = kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(pathname, 0, ACPI_PATHNAME_MAX);
 	buffer.length = ACPI_PATHNAME_MAX;
 	buffer.pointer = pathname;
@@ -135,7 +128,7 @@ int acpi_pci_bind(struct acpi_device *de
 	data = kmalloc(sizeof(struct acpi_pci_data), GFP_KERNEL);
 	if (!data) {
 		kfree(pathname);
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	}
 	memset(data, 0, sizeof(struct acpi_pci_data));
 
@@ -269,7 +262,7 @@ int acpi_pci_bind(struct acpi_device *de
 	if (result)
 		kfree(data);
 
-	return_VALUE(result);
+	return result;
 }
 
 int acpi_pci_unbind(struct acpi_device *device)
@@ -280,14 +273,12 @@ int acpi_pci_unbind(struct acpi_device *
 	char *pathname = NULL;
 	struct acpi_buffer buffer = { 0, NULL };
 
-	ACPI_FUNCTION_TRACE("acpi_pci_unbind");
-
 	if (!device || !device->parent)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	pathname = (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(pathname, 0, ACPI_PATHNAME_MAX);
 
 	buffer.length = ACPI_PATHNAME_MAX;
@@ -322,7 +313,7 @@ int acpi_pci_unbind(struct acpi_device *
 	kfree(data);
 
       end:
-	return_VALUE(result);
+	return result;
 }
 
 int
@@ -335,11 +326,9 @@ acpi_pci_bind_root(struct acpi_device *d
 	char *pathname = NULL;
 	struct acpi_buffer buffer = { 0, NULL };
 
-	ACPI_FUNCTION_TRACE("acpi_pci_bind_root");
-
 	pathname = (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(pathname, 0, ACPI_PATHNAME_MAX);
 
 	buffer.length = ACPI_PATHNAME_MAX;
@@ -347,13 +336,13 @@ acpi_pci_bind_root(struct acpi_device *d
 
 	if (!device || !id || !bus) {
 		kfree(pathname);
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 	}
 
 	data = kmalloc(sizeof(struct acpi_pci_data), GFP_KERNEL);
 	if (!data) {
 		kfree(pathname);
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	}
 	memset(data, 0, sizeof(struct acpi_pci_data));
 
@@ -381,5 +370,5 @@ acpi_pci_bind_root(struct acpi_device *d
 	if (result != 0)
 		kfree(data);
 
-	return_VALUE(result);
+	return result;
 }
---
0.99.9.GIT


