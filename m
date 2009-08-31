From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v2 1/8] ACPI: fix synthetic HID for \_SB_
Date: Mon, 31 Aug 2009 16:46:50 -0600
Message-ID: <20090831224650.12236.40364.stgit@bob.kio>
References: <20090831224535.12236.61350.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:32102 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbZHaWqn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Aug 2009 18:46:43 -0400
In-Reply-To: <20090831224535.12236.61350.stgit@bob.kio>
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
index 54f5514..1b656a5 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1095,6 +1095,12 @@ static void acpi_device_set_id(struct acpi_device *device)
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
 
 		status = acpi_get_object_info(device->handle, &info);
@@ -1144,18 +1150,6 @@ static void acpi_device_set_id(struct acpi_device *device)
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
 		device->pnp.hardware_id = ACPI_ALLOCATE_ZEROED(strlen (hid) + 1);
 		if (device->pnp.hardware_id) {

