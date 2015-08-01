From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / bus: Move duplicate code to a separate new function
Date: Sat, 01 Aug 2015 02:39:43 +0200
Message-ID: <4854608.nIfMTUvZQu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57461 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751272AbbHAAMp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2015 20:12:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After merging commit 712e960f0ee9 (ACPI / PM: Attach ACPI power
domain only once) with commit 1dcc3d3362b0 (ACPI / bus: Move ACPI
bus type registration) there is some duplicate code in
acpi_device_is_first_physical_node() and acpi_companion_match()
that can be moved to a separate routine and called from both
places.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of linux-pm.git/linux-next.

---
 drivers/acpi/bus.c |   51 ++++++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -482,6 +482,26 @@ static void acpi_device_remove_notify_ha
                              Device Matching
    -------------------------------------------------------------------------- */
 
+static struct acpi_device *acpi_primary_dev_companion(struct acpi_device *adev,
+						      const struct device *dev)
+{
+	struct mutex *physical_node_lock = &adev->physical_node_lock;
+
+	mutex_lock(physical_node_lock);
+	if (list_empty(&adev->physical_node_list)) {
+		adev = NULL;
+	} else {
+		const struct acpi_device_physical_node *node;
+
+		node = list_first_entry(&adev->physical_node_list,
+					struct acpi_device_physical_node, node);
+		if (node->dev != dev)
+			adev = NULL;
+	}
+	mutex_unlock(physical_node_lock);
+	return adev;
+}
+
 /**
  * acpi_device_is_first_physical_node - Is given dev first physical node
  * @adev: ACPI companion device
@@ -496,19 +516,7 @@ static void acpi_device_remove_notify_ha
 bool acpi_device_is_first_physical_node(struct acpi_device *adev,
 					const struct device *dev)
 {
-	bool ret = false;
-
-	mutex_lock(&adev->physical_node_lock);
-	if (!list_empty(&adev->physical_node_list)) {
-		const struct acpi_device_physical_node *node;
-
-		node = list_first_entry(&adev->physical_node_list,
-					struct acpi_device_physical_node, node);
-		ret = node->dev == dev;
-	}
-	mutex_unlock(&adev->physical_node_lock);
-
-	return ret;
+	return !!acpi_primary_dev_companion(adev, dev);
 }
 
 /*
@@ -535,7 +543,6 @@ bool acpi_device_is_first_physical_node(
 struct acpi_device *acpi_companion_match(const struct device *dev)
 {
 	struct acpi_device *adev;
-	struct mutex *physical_node_lock;
 
 	adev = ACPI_COMPANION(dev);
 	if (!adev)
@@ -544,21 +551,7 @@ struct acpi_device *acpi_companion_match
 	if (list_empty(&adev->pnp.ids))
 		return NULL;
 
-	physical_node_lock = &adev->physical_node_lock;
-	mutex_lock(physical_node_lock);
-	if (list_empty(&adev->physical_node_list)) {
-		adev = NULL;
-	} else {
-		const struct acpi_device_physical_node *node;
-
-		node = list_first_entry(&adev->physical_node_list,
-					struct acpi_device_physical_node, node);
-		if (node->dev != dev)
-			adev = NULL;
-	}
-	mutex_unlock(physical_node_lock);
-
-	return adev;
+	return acpi_primary_dev_companion(adev, dev);
 }
 
 /**

