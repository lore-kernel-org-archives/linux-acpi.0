From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] ACPI: use _HID when supplied by root-level devices
Date: Wed, 24 Mar 2010 10:44:33 -0600
Message-ID: <20100324164433.31102.54541.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:25367 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808Ab0CXQog (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Mar 2010 12:44:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Yong Wang <yong.y.wang@intel.com>


Previously, we assumed the only Device object immediately below the root
was the \_SB Scope (which the ACPI CA treats as a Device), so we forced
the HID of all such objects to ACPI_BUS_HID ("LNXSYBUS").

However, there are DSDTs that supply root-level Device objects with _HIDs.
This patch makes us pay attention to those _HIDs and only add the synthetic
ACPI_BUS_HID for root-level objects that do not supply their own _HID.

For example, this DSDT: https://bugzilla.kernel.org/show_bug.cgi?id=15605
contains:

    Scope (_SB) {
	...
    }
    Device (AMW0) {
	Name (_HID, EisaId ("PNP0C14"))
	...
    }

and we should use "PNP0C14" for the AMW0 device, not "LNXSYBUS".

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Yong Wang <yong.y.wang@intel.com>
---

 drivers/acpi/scan.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb7fc24..1d42798 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1044,12 +1044,6 @@ static void acpi_device_set_id(struct acpi_device *device)
 		if (ACPI_IS_ROOT_DEVICE(device)) {
 			acpi_add_id(device, ACPI_SYSTEM_HID);
 			break;
-		} else if (ACPI_IS_ROOT_DEVICE(device->parent)) {
-			/* \_SB_, the only root-level namespace device */
-			acpi_add_id(device, ACPI_BUS_HID);
-			strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
-			strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
-			break;
 		}
 
 		status = acpi_get_object_info(device->handle, &info);
@@ -1082,6 +1076,12 @@ static void acpi_device_set_id(struct acpi_device *device)
 			acpi_add_id(device, ACPI_BAY_HID);
 		else if (ACPI_SUCCESS(acpi_dock_match(device)))
 			acpi_add_id(device, ACPI_DOCK_HID);
+		else if (!acpi_device_hid(device) &&
+			 ACPI_IS_ROOT_DEVICE(device->parent)) {
+			acpi_add_id(device, ACPI_BUS_HID); /* \_SB, LNXSYBUS */
+			strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
+			strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
+		}
 
 		break;
 	case ACPI_BUS_TYPE_POWER:

