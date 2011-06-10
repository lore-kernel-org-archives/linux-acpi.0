From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2.6.32] ACPI: use _HID when supplied by root-level devices
Date: Fri, 10 Jun 2011 15:52:36 +0200
Message-ID: <201106101552.37056.trenn@suse.de>
References: <201106101549.36559.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:56191 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757313Ab1FJNwj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Jun 2011 09:52:39 -0400
In-Reply-To: <201106101549.36559.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org, bjorn@helgaas.com

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Git-commit: b7b30de53aef6ce773d34837ba7d8422bd3baeec

trenn: This one also solves the problem of not registered
processor devices declared with _HID("ACPI0007") in _PR scope
(which is handled at this place as if the device is declared
under ROOT scope).

Previously, we assumed the only Device object immediately below the root
was the \_SB Scope (which the ACPI CA treats as a Device), so we forced
the HID of all such objects to ACPI_BUS_HID ("LNXSYBUS").

However, there are DSDTs that supply root-level Device objects with _HIDs.
This patch makes us pay attention to those _HIDs and only add the 
synthetic
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
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Renninger <trenn@suse.de>
Tested-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/scan.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.32-SLE11-SP1/drivers/acpi/scan.c
===================================================================
--- linux-2.6.32-SLE11-SP1.orig/drivers/acpi/scan.c
+++ linux-2.6.32-SLE11-SP1/drivers/acpi/scan.c
@@ -1046,12 +1046,6 @@ static void acpi_device_set_id(struct ac
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
@@ -1089,6 +1083,12 @@ static void acpi_device_set_id(struct ac
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
