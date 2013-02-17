From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/7] ACPI / scan: Introduce acpi_scan_match_handler()
Date: Sun, 17 Feb 2013 16:20:10 +0100
Message-ID: <1836700.AtGyOWmaVR@vostro.rjw.lan>
References: <3260206.bhaAobGhpZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3260206.bhaAobGhpZ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Jiang Liu <liuj97@gmail.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce helper routine acpi_scan_match_handler() that will find the
ACPI scan handler matching a given device ID, if there is one, and
rework acpi_scan_attach_handler() to use the new routine (that
routine will also be useful for other purposes going forward).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   53 +++++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

Index: test/drivers/acpi/scan.c
===================================================================
--- test.orig/drivers/acpi/scan.c
+++ test/drivers/acpi/scan.c
@@ -1529,6 +1529,25 @@ static int acpi_bus_type_and_status(acpi
 	return 0;
 }
 
+static struct acpi_scan_handler *acpi_scan_match_handler(char *idstr,
+					const struct acpi_device_id **matchid)
+{
+	struct acpi_scan_handler *handler;
+
+	list_for_each_entry(handler, &acpi_scan_handlers_list, list_node) {
+		const struct acpi_device_id *devid;
+
+		for (devid = handler->ids; devid->id[0]; devid++)
+			if (!strcmp((char *)devid->id, idstr)) {
+				if (matchid)
+					*matchid = devid;
+
+				return handler;
+			}
+	}
+	return NULL;
+}
+
 static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl_not_used,
 				      void *not_used, void **return_value)
 {
@@ -1576,42 +1595,26 @@ static acpi_status acpi_bus_check_add(ac
 	return AE_OK;
 }
 
-static int acpi_scan_do_attach_handler(struct acpi_device *device, char *id)
+static int acpi_scan_attach_handler(struct acpi_device *device)
 {
-	struct acpi_scan_handler *handler;
+	struct acpi_hardware_id *hwid;
+	int ret = 0;
 
-	list_for_each_entry(handler, &acpi_scan_handlers_list, list_node) {
+	list_for_each_entry(hwid, &device->pnp.ids, list) {
 		const struct acpi_device_id *devid;
+		struct acpi_scan_handler *handler;
 
-		for (devid = handler->ids; devid->id[0]; devid++) {
-			int ret;
-
-			if (strcmp((char *)devid->id, id))
-				continue;
-
+		handler = acpi_scan_match_handler(hwid->id, &devid);
+		if (handler) {
 			ret = handler->attach(device, devid);
 			if (ret > 0) {
 				device->handler = handler;
-				return ret;
+				break;
 			} else if (ret < 0) {
-				return ret;
+				break;
 			}
 		}
 	}
-	return 0;
-}
-
-static int acpi_scan_attach_handler(struct acpi_device *device)
-{
-	struct acpi_hardware_id *hwid;
-	int ret = 0;
-
-	list_for_each_entry(hwid, &device->pnp.ids, list) {
-		ret = acpi_scan_do_attach_handler(device, hwid->id);
-		if (ret)
-			break;
-
-	}
 	return ret;
 }
 
