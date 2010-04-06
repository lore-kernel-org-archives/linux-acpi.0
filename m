From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/12] ACPI: use _HID when supplied by root-level devices
Date: Tue, 06 Apr 2010 03:06:17 -0400
Message-ID: <b7b30de53aef6ce773d34837ba7d8422bd3baeec.1270537380.git.len.brown@intel.com>
References: <1270537583-8756-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:48943 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757361Ab0DFHGp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2010 03:06:45 -0400
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L0G00FL612S7LV6@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 06 Apr 2010 02:06:34 -0500 (CDT)
In-reply-to: <1270537583-8756-1-git-send-email-lenb@kernel.org>
In-reply-to: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
References: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 189cbc2..95c90ff 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1080,12 +1080,6 @@ static void acpi_device_set_id(struct acpi_device *device)
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
@@ -1120,6 +1114,12 @@ static void acpi_device_set_id(struct acpi_device *device)
 			acpi_add_id(device, ACPI_DOCK_HID);
 		else if (!acpi_ibm_smbus_match(device))
 			acpi_add_id(device, ACPI_SMBUS_IBM_HID);
+		else if (!acpi_device_hid(device) &&
+			 ACPI_IS_ROOT_DEVICE(device->parent)) {
+			acpi_add_id(device, ACPI_BUS_HID); /* \_SB, LNXSYBUS */
+			strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
+			strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
+		}
 
 		break;
 	case ACPI_BUS_TYPE_POWER:
-- 
1.6.0.6

