From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/4] ACPI / scan: Generalize of_compatible matching
Date: Thu, 09 Apr 2015 02:19:46 +0200
Message-ID: <11437744.VKNlyABKHa@vostro.rjw.lan>
References: <4378053.gHTT51U7FJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4378053.gHTT51U7FJ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Redefine the function used for matching the device's "compatible"
property against a given list of "compatible" strings to take
a pointer to that list instead of a driver object pointer to
make it more general.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -953,9 +953,17 @@ int acpi_match_device_ids(struct acpi_de
 }
 EXPORT_SYMBOL(acpi_match_device_ids);
 
-/* Performs match against special "PRP0001" shoehorn ACPI ID */
-static bool acpi_of_driver_match_device(struct device *dev,
-					const struct device_driver *drv)
+/**
+ * acpi_of_match_device - Match device using the "compatible" property.
+ * @dev: Device to match.
+ * @of_match_table: List of device IDs to match against.
+ *
+ * If @dev has an ACPI companion which has the special PRP0001 device ID in its
+ * list of identifiers and a _DSD object with the "compatible" property, use
+ * that property to match against the given list of identifiers.
+ */
+static bool acpi_of_match_device(struct device *dev,
+				 const struct of_device_id *of_match_table)
 {
 	const union acpi_object *of_compatible, *obj;
 	struct acpi_device *adev;
@@ -966,7 +974,7 @@ static bool acpi_of_driver_match_device(
 		return false;
 
 	of_compatible = adev->data.of_compatible;
-	if (!drv->of_match_table || !of_compatible)
+	if (!of_match_table || !of_compatible)
 		return false;
 
 	if (of_compatible->type == ACPI_TYPE_PACKAGE) {
@@ -980,7 +988,7 @@ static bool acpi_of_driver_match_device(
 	for (i = 0; i < nval; i++, obj++) {
 		const struct of_device_id *id;
 
-		for (id = drv->of_match_table; id->compatible[0]; id++)
+		for (id = of_match_table; id->compatible[0]; id++)
 			if (!strcasecmp(obj->string.pointer, id->compatible))
 				return true;
 	}
@@ -992,7 +1000,7 @@ bool acpi_driver_match_device(struct dev
 			      const struct device_driver *drv)
 {
 	if (!drv->acpi_match_table)
-		return acpi_of_driver_match_device(dev, drv);
+		return acpi_of_match_device(dev, drv->of_match_table);
 
 	return !!acpi_match_device(drv->acpi_match_table, dev);
 }
