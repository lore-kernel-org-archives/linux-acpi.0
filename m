From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH v2, 4/7] ACPI / scan: Introduce acpi_scan_handler_matching()
Date: Tue, 26 Feb 2013 23:47:58 +0100
Message-ID: <1779230.yDM7NrbqCq@vostro.rjw.lan>
References: <3260206.bhaAobGhpZ@vostro.rjw.lan> <3171747.TOMjvVkWL1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3171747.TOMjvVkWL1@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Jiang Liu <liuj97@gmail.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce new helper routine acpi_scan_handler_matching() for
checking if the given ACPI scan handler matches a given device ID
and rework acpi_scan_match_handler() to use the new routine (that
routine will also be useful for other purposes in the future).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
---
 drivers/acpi/scan.c |   30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

Index: test/drivers/acpi/scan.c
===================================================================
--- test.orig/drivers/acpi/scan.c
+++ test/drivers/acpi/scan.c
@@ -1673,22 +1673,32 @@ static int acpi_bus_type_and_status(acpi
 	return 0;
 }
 
+static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
+				       char *idstr,
+				       const struct acpi_device_id **matchid)
+{
+	const struct acpi_device_id *devid;
+
+	for (devid = handler->ids; devid->id[0]; devid++)
+		if (!strcmp((char *)devid->id, idstr)) {
+			if (matchid)
+				*matchid = devid;
+
+			return true;
+		}
+
+	return false;
+}
+
 static struct acpi_scan_handler *acpi_scan_match_handler(char *idstr,
 					const struct acpi_device_id **matchid)
 {
 	struct acpi_scan_handler *handler;
 
-	list_for_each_entry(handler, &acpi_scan_handlers_list, list_node) {
-		const struct acpi_device_id *devid;
+	list_for_each_entry(handler, &acpi_scan_handlers_list, list_node)
+		if (acpi_scan_handler_matching(handler, idstr, matchid))
+			return handler;
 
-		for (devid = handler->ids; devid->id[0]; devid++)
-			if (!strcmp((char *)devid->id, idstr)) {
-				if (matchid)
-					*matchid = devid;
-
-				return handler;
-			}
-	}
 	return NULL;
 }
 
