From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 1/4] ACPI / bus: Do not traverse through non-existed device table
Date: Fri,  9 Feb 2018 17:38:33 +0200
Message-ID: <20180209153836.19302-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:25602 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbeBIPik (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Feb 2018 10:38:40 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

When __acpi_match_device() is called it would be possible to have
ACPI ID table a NULL pointer. To avoid potential dereference,
check for this before traverse.

While here, remove redundant 'else'.

Note, this patch implies a bit of refactoring acpi_of_match_device()
to return pointer to OF ID when matched followed by refactoring
__acpi_match_device() to return either ACPI or OF ID when matches.

Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/bus.c | 63 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 676c9788e1c8..f1384e107eed 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -660,13 +660,15 @@ struct acpi_device *acpi_companion_match(const struct device *dev)
  * acpi_of_match_device - Match device object using the "compatible" property.
  * @adev: ACPI device object to match.
  * @of_match_table: List of device IDs to match against.
+ * @of_id: OF ID if matched
  *
  * If @dev has an ACPI companion which has ACPI_DT_NAMESPACE_HID in its list of
  * identifiers and a _DSD object with the "compatible" property, use that
  * property to match against the given list of identifiers.
  */
 static bool acpi_of_match_device(struct acpi_device *adev,
-				 const struct of_device_id *of_match_table)
+				 const struct of_device_id *of_match_table,
+				 const struct of_device_id **of_id)
 {
 	const union acpi_object *of_compatible, *obj;
 	int i, nval;
@@ -690,8 +692,11 @@ static bool acpi_of_match_device(struct acpi_device *adev,
 		const struct of_device_id *id;
 
 		for (id = of_match_table; id->compatible[0]; id++)
-			if (!strcasecmp(obj->string.pointer, id->compatible))
+			if (!strcasecmp(obj->string.pointer, id->compatible)) {
+				if (of_id)
+					*of_id = id;
 				return true;
+			}
 	}
 
 	return false;
@@ -762,10 +767,11 @@ static bool __acpi_match_device_cls(const struct acpi_device_id *id,
 	return true;
 }
 
-static const struct acpi_device_id *__acpi_match_device(
-	struct acpi_device *device,
-	const struct acpi_device_id *ids,
-	const struct of_device_id *of_ids)
+static bool __acpi_match_device(struct acpi_device *device,
+				const struct acpi_device_id *acpi_ids,
+				const struct of_device_id *of_ids,
+				const struct acpi_device_id **acpi_id,
+				const struct of_device_id **of_id)
 {
 	const struct acpi_device_id *id;
 	struct acpi_hardware_id *hwid;
@@ -775,30 +781,32 @@ static const struct acpi_device_id *__acpi_match_device(
 	 * driver for it.
 	 */
 	if (!device || !device->status.present)
-		return NULL;
+		return false;
 
 	list_for_each_entry(hwid, &device->pnp.ids, list) {
 		/* First, check the ACPI/PNP IDs provided by the caller. */
-		for (id = ids; id->id[0] || id->cls; id++) {
-			if (id->id[0] && !strcmp((char *) id->id, hwid->id))
-				return id;
-			else if (id->cls && __acpi_match_device_cls(id, hwid))
-				return id;
+		if (acpi_ids) {
+			for (id = acpi_ids; id->id[0] || id->cls; id++) {
+				if (id->id[0] && !strcmp((char *)id->id, hwid->id))
+					goto out_acpi_match;
+				if (id->cls && __acpi_match_device_cls(id, hwid))
+					goto out_acpi_match;
+			}
 		}
 
 		/*
 		 * Next, check ACPI_DT_NAMESPACE_HID and try to match the
 		 * "compatible" property if found.
-		 *
-		 * The id returned by the below is not valid, but the only
-		 * caller passing non-NULL of_ids here is only interested in
-		 * whether or not the return value is NULL.
 		 */
-		if (!strcmp(ACPI_DT_NAMESPACE_HID, hwid->id)
-		    && acpi_of_match_device(device, of_ids))
-			return id;
+		if (!strcmp(ACPI_DT_NAMESPACE_HID, hwid->id))
+			return acpi_of_match_device(device, of_ids, of_id);
 	}
-	return NULL;
+	return false;
+
+out_acpi_match:
+	if (acpi_id)
+		*acpi_id = id;
+	return true;
 }
 
 /**
@@ -815,7 +823,10 @@ static const struct acpi_device_id *__acpi_match_device(
 const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 					       const struct device *dev)
 {
-	return __acpi_match_device(acpi_companion_match(dev), ids, NULL);
+	const struct acpi_device_id *id = NULL;
+
+	__acpi_match_device(acpi_companion_match(dev), ids, NULL, &id, NULL);
+	return id;
 }
 EXPORT_SYMBOL_GPL(acpi_match_device);
 
@@ -840,7 +851,7 @@ EXPORT_SYMBOL_GPL(acpi_get_match_data);
 int acpi_match_device_ids(struct acpi_device *device,
 			  const struct acpi_device_id *ids)
 {
-	return __acpi_match_device(device, ids, NULL) ? 0 : -ENOENT;
+	return __acpi_match_device(device, ids, NULL, NULL, NULL) ? 0 : -ENOENT;
 }
 EXPORT_SYMBOL(acpi_match_device_ids);
 
@@ -849,10 +860,12 @@ bool acpi_driver_match_device(struct device *dev,
 {
 	if (!drv->acpi_match_table)
 		return acpi_of_match_device(ACPI_COMPANION(dev),
-					    drv->of_match_table);
+					    drv->of_match_table,
+					    NULL);
 
-	return !!__acpi_match_device(acpi_companion_match(dev),
-				     drv->acpi_match_table, drv->of_match_table);
+	return __acpi_match_device(acpi_companion_match(dev),
+				   drv->acpi_match_table, drv->of_match_table,
+				   NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(acpi_driver_match_device);
 
-- 
2.15.1

