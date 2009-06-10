From: Alex Chiang <achiang@hp.com>
Subject: [PATCH v3 04/12] ACPI: rearrange acpi_pci_bind/acpi_pci_unbind in
	pci_bind.c
Date: Wed, 10 Jun 2009 13:55:25 -0600
Message-ID: <20090610195525.28982.43678.stgit@bob.kio>
References: <20090610194714.28982.51363.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20090610194714.28982.51363.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This is a pure code movement patch that does $subject in order
to make the following patch easier to read and review.

No functional change.

Signed-off-by: Alex Chiang <achiang@hp.com>
---

 drivers/acpi/pci_bind.c |   90 ++++++++++++++++++++++++-----------------------
 1 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index 236765c..c283c29 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -109,6 +109,51 @@ acpi_status acpi_get_pci_id(acpi_handle handle, struct acpi_pci_id *id)
 
 EXPORT_SYMBOL(acpi_get_pci_id);
 
+static int acpi_pci_unbind(struct acpi_device *device)
+{
+	int result = 0;
+	acpi_status status;
+	struct acpi_pci_data *data;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+
+
+	if (!device || !device->parent)
+		return -EINVAL;
+
+	status = acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Unbinding PCI device [%s]...\n",
+			  (char *) buffer.pointer));
+	kfree(buffer.pointer);
+
+	status =
+	    acpi_get_data(device->handle, acpi_pci_data_handler,
+			  (void **)&data);
+	if (ACPI_FAILURE(status)) {
+		result = -ENODEV;
+		goto end;
+	}
+
+	status = acpi_detach_data(device->handle, acpi_pci_data_handler);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Unable to detach data from device %s",
+				acpi_device_bid(device)));
+		result = -ENODEV;
+		goto end;
+	}
+	if (data->dev->subordinate) {
+		acpi_pci_irq_del_prt(data->id.segment, data->bus->number);
+	}
+	pci_dev_put(data->dev);
+	kfree(data);
+
+      end:
+	return result;
+}
+
 static int acpi_pci_bind(struct acpi_device *device)
 {
 	int result = 0;
@@ -253,51 +298,6 @@ static int acpi_pci_bind(struct acpi_device *device)
 	return result;
 }
 
-static int acpi_pci_unbind(struct acpi_device *device)
-{
-	int result = 0;
-	acpi_status status;
-	struct acpi_pci_data *data;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-
-
-	if (!device || !device->parent)
-		return -EINVAL;
-
-	status = acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Unbinding PCI device [%s]...\n",
-			  (char *) buffer.pointer));
-	kfree(buffer.pointer);
-
-	status =
-	    acpi_get_data(device->handle, acpi_pci_data_handler,
-			  (void **)&data);
-	if (ACPI_FAILURE(status)) {
-		result = -ENODEV;
-		goto end;
-	}
-
-	status = acpi_detach_data(device->handle, acpi_pci_data_handler);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status,
-				"Unable to detach data from device %s",
-				acpi_device_bid(device)));
-		result = -ENODEV;
-		goto end;
-	}
-	if (data->dev->subordinate) {
-		acpi_pci_irq_del_prt(data->id.segment, data->bus->number);
-	}
-	pci_dev_put(data->dev);
-	kfree(data);
-
-      end:
-	return result;
-}
-
 int
 acpi_pci_bind_root(struct acpi_device *device,
 		   struct acpi_pci_id *id, struct pci_bus *bus)
