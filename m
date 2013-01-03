From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / scan: Do not use dummy HID for system bus ACPI nodes
Date: Thu, 03 Jan 2013 02:52:33 +0100
Message-ID: <3202600.6sHYvcf502@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

At one point acpi_device_set_id() checks if acpi_device_hid(device)
returns NULL, but that never happens, so system bus devices with an
empty list of PNP IDs are given the dummy HID ("device") instead of
the "system bus HID" ("LNXSYBUS").  Fix the code to use the right
check.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/acpi/scan.c
===================================================================
--- linux.orig/drivers/acpi/scan.c
+++ linux/drivers/acpi/scan.c
@@ -1398,7 +1398,7 @@ static void acpi_device_set_id(struct ac
 			acpi_add_id(device, ACPI_DOCK_HID);
 		else if (!acpi_ibm_smbus_match(device))
 			acpi_add_id(device, ACPI_SMBUS_IBM_HID);
-		else if (!acpi_device_hid(device) &&
+		else if (list_empty(&device->pnp.ids) &&
 			 ACPI_IS_ROOT_DEVICE(device->parent)) {
 			acpi_add_id(device, ACPI_BUS_HID); /* \_SB, LNXSYBUS */
 			strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
