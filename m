From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: simplify buffer management for acpi_pci_bind() etc.
Date: Tue, 30 Dec 2008 23:15:37 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812302313300.17126@localhost.localdomain>
References: <20081209042833.26415.24906.stgit@bob.kio>
 <20081209043015.26415.63813.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:41385 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbYLaEPk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Dec 2008 23:15:40 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KCQ00FQ73U2S4G3@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 30 Dec 2008 22:15:39 -0600 (CST)
In-reply-to: <20081209043015.26415.63813.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

From: Len Brown <len.brown@intel.com>
Date: Tue, 30 Dec 2008 22:44:33 -0500

use ACPI_ALLOCATE_BUFFER to remove the allocations
within acpi_pci_bind(), acpi_pci_unbind() and acpi_pci_bind_root().
While there, delete some unnecessary param inits from those routines.

Delete concept of ACPI_PATHNAME_MAX, since this was the last use.

Signed-off-by: Len Brown <len.brown@intel.com>
---

Bjorn,
That patch was such a good idea, I just had to do the
same thing over in pci_bind.c:-)

cheers,
-Len


 drivers/acpi/pci_bind.c         |   80 ++++++++++++++++-----------------------
 include/acpi/platform/aclinux.h |    3 -
 2 files changed, 33 insertions(+), 50 deletions(-)

diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index 53f502d..95650f8 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -111,12 +111,11 @@ EXPORT_SYMBOL(acpi_get_pci_id);
 int acpi_pci_bind(struct acpi_device *device)
 {
 	int result = 0;
-	acpi_status status = AE_OK;
-	struct acpi_pci_data *data = NULL;
-	struct acpi_pci_data *pdata = NULL;
-	char *pathname = NULL;
-	struct acpi_buffer buffer = { 0, NULL };
-	acpi_handle handle = NULL;
+	acpi_status status;
+	struct acpi_pci_data *data;
+	struct acpi_pci_data *pdata;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_handle handle;
 	struct pci_dev *dev;
 	struct pci_bus *bus;
 
@@ -124,21 +123,18 @@ int acpi_pci_bind(struct acpi_device *device)
 	if (!device || !device->parent)
 		return -EINVAL;
 
-	pathname = kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
-	if (!pathname)
-		return -ENOMEM;
-	buffer.length = ACPI_PATHNAME_MAX;
-	buffer.pointer = pathname;
-
 	data = kzalloc(sizeof(struct acpi_pci_data), GFP_KERNEL);
-	if (!data) {
-		kfree(pathname);
+	if (!data)
 		return -ENOMEM;
+
+	status = acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
+	if (ACPI_FAILURE(status)) {
+		kfree(data);
+		return -ENODEV;
 	}
 
-	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Binding PCI device [%s]...\n",
-			  pathname));
+			  (char *)buffer.pointer));
 
 	/* 
 	 * Segment & Bus
@@ -262,7 +258,7 @@ int acpi_pci_bind(struct acpi_device *device)
 	}
 
       end:
-	kfree(pathname);
+	kfree(buffer.pointer);
 	if (result)
 		kfree(data);
 
@@ -272,25 +268,21 @@ int acpi_pci_bind(struct acpi_device *device)
 static int acpi_pci_unbind(struct acpi_device *device)
 {
 	int result = 0;
-	acpi_status status = AE_OK;
-	struct acpi_pci_data *data = NULL;
-	char *pathname = NULL;
-	struct acpi_buffer buffer = { 0, NULL };
+	acpi_status status;
+	struct acpi_pci_data *data;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 
 	if (!device || !device->parent)
 		return -EINVAL;
 
-	pathname = kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
-	if (!pathname)
-		return -ENOMEM;
+	status = acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
 
-	buffer.length = ACPI_PATHNAME_MAX;
-	buffer.pointer = pathname;
-	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Unbinding PCI device [%s]...\n",
-			  pathname));
-	kfree(pathname);
+			  (char *) buffer.pointer));
+	kfree(buffer.pointer);
 
 	status =
 	    acpi_get_data(device->handle, acpi_pci_data_handler,
@@ -322,50 +314,44 @@ acpi_pci_bind_root(struct acpi_device *device,
 		   struct acpi_pci_id *id, struct pci_bus *bus)
 {
 	int result = 0;
-	acpi_status status = AE_OK;
+	acpi_status status;
 	struct acpi_pci_data *data = NULL;
-	char *pathname = NULL;
-	struct acpi_buffer buffer = { 0, NULL };
-
-	pathname = kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
-	if (!pathname)
-		return -ENOMEM;
-
-	buffer.length = ACPI_PATHNAME_MAX;
-	buffer.pointer = pathname;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 	if (!device || !id || !bus) {
-		kfree(pathname);
 		return -EINVAL;
 	}
 
 	data = kzalloc(sizeof(struct acpi_pci_data), GFP_KERNEL);
-	if (!data) {
-		kfree(pathname);
+	if (!data)
 		return -ENOMEM;
-	}
 
 	data->id = *id;
 	data->bus = bus;
 	device->ops.bind = acpi_pci_bind;
 	device->ops.unbind = acpi_pci_unbind;
 
-	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
+	status = acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
+	if (ACPI_FAILURE(status)) {
+		kfree (data);
+		return -ENODEV;
+	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Binding PCI root bridge [%s] to "
-			  "%04x:%02x\n", pathname, id->segment, id->bus));
+			"%04x:%02x\n", (char *)buffer.pointer,
+			id->segment, id->bus));
 
 	status = acpi_attach_data(device->handle, acpi_pci_data_handler, data);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status,
 				"Unable to attach ACPI-PCI context to device %s",
-				pathname));
+				(char *)buffer.pointer));
 		result = -ENODEV;
 		goto end;
 	}
 
       end:
-	kfree(pathname);
+	kfree(buffer.pointer);
 	if (result != 0)
 		kfree(data);
 
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 0515e75..9116c98 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -70,9 +70,6 @@
 #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
 #define strtoul                     simple_strtoul
 
-/* Full namespace pathname length limit - arbitrary */
-#define ACPI_PATHNAME_MAX              256
-
 #else				/* !__KERNEL__ */
 
 #include <stdarg.h>
-- 
1.6.1.28.gc32f76

