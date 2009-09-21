From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v3 02/17] ACPI: add debug for device addition
Date: Mon, 21 Sep 2009 13:28:54 -0600
Message-ID: <20090921192854.21322.14281.stgit@bob.kio>
References: <20090921192656.21322.23072.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:31273 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbZIUT2v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 15:28:51 -0400
In-Reply-To: <20090921192656.21322.23072.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Add debug output for adding an ACPI device.  Enable this with
"acpi.debug_layer=0x00010000" (ACPI_BUS_COMPONENT).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 408ebde..75b7c57 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1230,6 +1230,7 @@ acpi_add_single_object(struct acpi_device **child,
 {
 	int result = 0;
 	struct acpi_device *device = NULL;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 
 	if (!child)
@@ -1355,9 +1356,16 @@ acpi_add_single_object(struct acpi_device **child,
 	}
 
 end:
-	if (!result)
+	if (!result) {
+		acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"Adding %s [%s] parent %s\n", dev_name(&device->dev),
+			 (char *) buffer.pointer,
+			 device->parent ? dev_name(&device->parent->dev) :
+					  "(null)"));
+		kfree(buffer.pointer);
 		*child = device;
-	else
+	} else
 		acpi_device_release(&device->dev);
 
 	return result;

