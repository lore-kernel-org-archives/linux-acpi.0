From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/4] ACPI / scan: Take PRP0001 in _CID lists into account too
Date: Thu, 09 Apr 2015 02:21:26 +0200
Message-ID: <2280561.LoyzmKRjsh@vostro.rjw.lan>
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

If the special PRP0001 device ID is present in a device's _CID list,
it should be treated the same way as for the _HID case.  That is,
if none of the IDs preceding it in the device's PNP/ACPI IDs list
matches the IDs recognized by the driver, the driver's list of
"compatible" IDs should be matched against the device's "compatible"
property, if present.

To make that happen, rework acpi_driver_match_device() to do the
"compatible" property check even if acpi_match_table is present
for the given driver.

That will also cover cases in which drivers provide both
acpi_match_table and of_match_table (which is perfectly valid) at the
same time.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |  115 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 50 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -899,8 +899,51 @@ static void acpi_device_remove_files(str
 			ACPI Bus operations
    -------------------------------------------------------------------------- */
 
+/**
+ * acpi_of_match_device - Match device object using the "compatible" property.
+ * @adev: ACPI device object to match.
+ * @of_match_table: List of device IDs to match against.
+ *
+ * If @dev has an ACPI companion which has the special PRP0001 device ID in its
+ * list of identifiers and a _DSD object with the "compatible" property, use
+ * that property to match against the given list of identifiers.
+ */
+static bool acpi_of_match_device(struct acpi_device *adev,
+				 const struct of_device_id *of_match_table)
+{
+	const union acpi_object *of_compatible, *obj;
+	int i, nval;
+
+	if (!adev)
+		return false;
+
+	of_compatible = adev->data.of_compatible;
+	if (!of_match_table || !of_compatible)
+		return false;
+
+	if (of_compatible->type == ACPI_TYPE_PACKAGE) {
+		nval = of_compatible->package.count;
+		obj = of_compatible->package.elements;
+	} else { /* Must be ACPI_TYPE_STRING. */
+		nval = 1;
+		obj = of_compatible;
+	}
+	/* Now we can look for the driver DT compatible strings */
+	for (i = 0; i < nval; i++, obj++) {
+		const struct of_device_id *id;
+
+		for (id = of_match_table; id->compatible[0]; id++)
+			if (!strcasecmp(obj->string.pointer, id->compatible))
+				return true;
+	}
+
+	return false;
+}
+
 static const struct acpi_device_id *__acpi_match_device(
-	struct acpi_device *device, const struct acpi_device_id *ids)
+	struct acpi_device *device,
+	const struct acpi_device_id *ids,
+	const struct of_device_id *of_ids)
 {
 	const struct acpi_device_id *id;
 	struct acpi_hardware_id *hwid;
@@ -912,11 +955,24 @@ static const struct acpi_device_id *__ac
 	if (!device || !device->status.present)
 		return NULL;
 
-	for (id = ids; id->id[0]; id++)
-		list_for_each_entry(hwid, &device->pnp.ids, list)
+	list_for_each_entry(hwid, &device->pnp.ids, list) {
+		/* First, check the ACPI/PNP IDs provided by the caller. */
+		for (id = ids; id->id[0]; id++)
 			if (!strcmp((char *) id->id, hwid->id))
 				return id;
 
+		/*
+		 * Next, check the special "PRP0001" ID and try to match the
+		 * "compatible" property if found.
+		 *
+		 * The id returned by the below is not valid, but the only
+		 * caller passing non-NULL of_ids here is only interested in
+		 * whether or not the return value is NULL.
+		 */
+		if (!strcmp("PRP0001", hwid->id)
+		    && acpi_of_match_device(device, of_ids))
+			return id;
+	}
 	return NULL;
 }
 
@@ -934,67 +990,26 @@ static const struct acpi_device_id *__ac
 const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 					       const struct device *dev)
 {
-	return __acpi_match_device(acpi_companion_match(dev), ids);
+	return __acpi_match_device(acpi_companion_match(dev), ids, NULL);
 }
 EXPORT_SYMBOL_GPL(acpi_match_device);
 
 int acpi_match_device_ids(struct acpi_device *device,
 			  const struct acpi_device_id *ids)
 {
-	return __acpi_match_device(device, ids) ? 0 : -ENOENT;
+	return __acpi_match_device(device, ids, NULL) ? 0 : -ENOENT;
 }
 EXPORT_SYMBOL(acpi_match_device_ids);
 
-/**
- * acpi_of_match_device - Match device using the "compatible" property.
- * @dev: Device to match.
- * @of_match_table: List of device IDs to match against.
- *
- * If @dev has an ACPI companion which has the special PRP0001 device ID in its
- * list of identifiers and a _DSD object with the "compatible" property, use
- * that property to match against the given list of identifiers.
- */
-static bool acpi_of_match_device(struct device *dev,
-				 const struct of_device_id *of_match_table)
-{
-	const union acpi_object *of_compatible, *obj;
-	struct acpi_device *adev;
-	int i, nval;
-
-	adev = ACPI_COMPANION(dev);
-	if (!adev)
-		return false;
-
-	of_compatible = adev->data.of_compatible;
-	if (!of_match_table || !of_compatible)
-		return false;
-
-	if (of_compatible->type == ACPI_TYPE_PACKAGE) {
-		nval = of_compatible->package.count;
-		obj = of_compatible->package.elements;
-	} else { /* Must be ACPI_TYPE_STRING. */
-		nval = 1;
-		obj = of_compatible;
-	}
-	/* Now we can look for the driver DT compatible strings */
-	for (i = 0; i < nval; i++, obj++) {
-		const struct of_device_id *id;
-
-		for (id = of_match_table; id->compatible[0]; id++)
-			if (!strcasecmp(obj->string.pointer, id->compatible))
-				return true;
-	}
-
-	return false;
-}
-
 bool acpi_driver_match_device(struct device *dev,
 			      const struct device_driver *drv)
 {
 	if (!drv->acpi_match_table)
-		return acpi_of_match_device(dev, drv->of_match_table);
+		return acpi_of_match_device(ACPI_COMPANION(dev),
+					    drv->of_match_table);
 
-	return !!acpi_match_device(drv->acpi_match_table, dev);
+	return !!__acpi_match_device(acpi_companion_match(dev),
+				     drv->acpi_match_table, drv->of_match_table);
 }
 EXPORT_SYMBOL_GPL(acpi_driver_match_device);
 
