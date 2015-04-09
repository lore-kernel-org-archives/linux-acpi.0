From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/4] ACPI / scan: Simplify acpi_match_device()
Date: Thu, 09 Apr 2015 02:20:51 +0200
Message-ID: <1745204.4cEygKHaXn@vostro.rjw.lan>
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

Redefine acpi_companion_match() to return an ACPI device object
pointer instead of a bool and use it to remove some redundant code
from acpi_match_device().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -194,7 +194,8 @@ static int create_modalias(struct acpi_d
  *
  * Check if the given device has an ACPI companion and if that companion has
  * a valid list of PNP IDs, and if the device is the first (primary) physical
- * device associated with it.
+ * device associated with it.  Return the companion pointer if that's the case
+ * or NULL otherwise.
  *
  * If multiple physical devices are attached to a single ACPI companion, we need
  * to be careful.  The usage scenario for this kind of relationship is that all
@@ -208,31 +209,31 @@ static int create_modalias(struct acpi_d
  * resources available from it but they will be matched normally using functions
  * provided by their bus types (and analogously for their modalias).
  */
-static bool acpi_companion_match(const struct device *dev)
+static struct acpi_device *acpi_companion_match(const struct device *dev)
 {
 	struct acpi_device *adev;
-	bool ret;
 
 	adev = ACPI_COMPANION(dev);
 	if (!adev)
-		return false;
+		return NULL;
 
 	if (list_empty(&adev->pnp.ids))
-		return false;
+		return NULL;
 
 	mutex_lock(&adev->physical_node_lock);
 	if (list_empty(&adev->physical_node_list)) {
-		ret = false;
+		adev = NULL;
 	} else {
 		const struct acpi_device_physical_node *node;
 
 		node = list_first_entry(&adev->physical_node_list,
 					struct acpi_device_physical_node, node);
-		ret = node->dev == dev;
+		if (node->dev != dev)
+			adev = NULL;
 	}
 	mutex_unlock(&adev->physical_node_lock);
 
-	return ret;
+	return adev;
 }
 
 /*
@@ -908,7 +909,7 @@ static const struct acpi_device_id *__ac
 	 * If the device is not present, it is unnecessary to load device
 	 * driver for it.
 	 */
-	if (!device->status.present)
+	if (!device || !device->status.present)
 		return NULL;
 
 	for (id = ids; id->id[0]; id++)
@@ -933,16 +934,7 @@ static const struct acpi_device_id *__ac
 const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 					       const struct device *dev)
 {
-	struct acpi_device *adev;
-	acpi_handle handle = ACPI_HANDLE(dev);
-
-	if (!ids || !handle || acpi_bus_get_device(handle, &adev))
-		return NULL;
-
-	if (!acpi_companion_match(dev))
-		return NULL;
-
-	return __acpi_match_device(adev, ids);
+	return __acpi_match_device(acpi_companion_match(dev), ids);
 }
 EXPORT_SYMBOL_GPL(acpi_match_device);
 
