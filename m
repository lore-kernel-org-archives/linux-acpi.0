From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 03/10] ACPI: fix synthetic HID for \_SB_
Date: Mon, 24 Aug 2009 10:38:45 -0600
Message-ID: <20090824163845.28131.71462.stgit@bob.kio>
References: <20090824163659.28131.96400.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:46984 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbZHXQik (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2009 12:38:40 -0400
In-Reply-To: <20090824163659.28131.96400.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Lin Ming <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This makes \_SB_ show up as /sys/devices/LNXSYSTM:00/LNXSYBUS:00
rather than "device:00".  This has been broken for a loooong time
(at least since 2.6.13) because device->parent is an acpi_device
pointer, not a handle.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a253373..6de6b11 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1038,6 +1038,12 @@ static void acpi_device_set_id(struct acpi_device *device)
 		if (ACPI_IS_ROOT_DEVICE(device)) {
 			hid = ACPI_SYSTEM_HID;
 			break;
+		} else if (ACPI_IS_ROOT_DEVICE(device->parent)) {
+			/* \_SB_, the only root-level namespace device */
+			hid = ACPI_BUS_HID;
+			strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
+			strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
+			break;
 		}
 
 		status = acpi_get_object_info(device->handle, &buffer);
@@ -1088,18 +1094,6 @@ static void acpi_device_set_id(struct acpi_device *device)
 		break;
 	}
 
-	/*
-	 * \_SB
-	 * ----
-	 * Fix for the system root bus device -- the only root-level device.
-	 */
-	if (((acpi_handle)device->parent == ACPI_ROOT_OBJECT) &&
-	     (device->device_type == ACPI_BUS_TYPE_DEVICE)) {
-		hid = ACPI_BUS_HID;
-		strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
-		strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
-	}
-
 	if (hid) {
 		strcpy(device->pnp.hardware_id, hid);
 		device->flags.hardware_id = 1;

