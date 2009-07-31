From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 04/19] ACPI: add debug for device addition
Date: Fri, 31 Jul 2009 15:36:53 -0600
Message-ID: <20090731213653.29930.6859.stgit@bob.kio>
References: <20090731213501.29930.39957.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:32379 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbZGaVg6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 17:36:58 -0400
In-Reply-To: <20090731213501.29930.39957.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Add debug output for adding an ACPI device.  Enable this with
"acpi.debug_layer=0x00010000" (ACPI_BUS_COMPONENT).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 652d104..92b4fe2 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1178,6 +1178,7 @@ acpi_add_single_object(struct acpi_device **child,
 {
 	int result = 0;
 	struct acpi_device *device = NULL;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 
 	if (!child)
@@ -1311,9 +1312,15 @@ acpi_add_single_object(struct acpi_device **child,
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
 		*child = device;
-	else {
+	} else {
 		kfree(device->pnp.cid_list);
 		kfree(device);
 	}

