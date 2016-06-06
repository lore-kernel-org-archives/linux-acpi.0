From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [RFC 1/2] acpi: Expose acpi_of_match_device
Date: Mon, 6 Jun 2016 23:09:21 +0300
Message-ID: <d2ef6a46-e8e2-c903-1229-7ff6c0ccdac8@intel.com>
References: <cover.1465242308.git.leonard.crestez@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58943 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbcFFUJr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Jun 2016 16:09:47 -0400
In-Reply-To: <cover.1465242308.git.leonard.crestez@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This can be used by device drivers as the equivalent of of_match_device
when they are instantiated through ACPI using devicetree IDs. This is
described in Documentation/acpi/enumeration.txt

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/acpi/bus.c   | 13 +++++++------
 include/linux/acpi.h |  8 ++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

Sending the actual patches separately to linux-acpi@vger.kernel.org
because I used --cc-cover without --to-cover.

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 27367d4..b366bb2 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -574,18 +574,18 @@ struct acpi_device *acpi_companion_match(const
struct device *dev)
  * identifiers and a _DSD object with the "compatible" property, use that
  * property to match against the given list of identifiers.
  */
-static bool acpi_of_match_device(struct acpi_device *adev,
-				 const struct of_device_id *of_match_table)
+const struct of_device_id* acpi_of_match_device(const struct
acpi_device *adev,
+						const struct of_device_id *of_match_table)
 {
 	const union acpi_object *of_compatible, *obj;
 	int i, nval;
  	if (!adev)
-		return false;
+		return NULL;
  	of_compatible = adev->data.of_compatible;
 	if (!of_match_table || !of_compatible)
-		return false;
+		return NULL;
  	if (of_compatible->type == ACPI_TYPE_PACKAGE) {
 		nval = of_compatible->package.count;
@@ -600,11 +600,12 @@ static bool acpi_of_match_device(struct
acpi_device *adev,
  		for (id = of_match_table; id->compatible[0]; id++)
 			if (!strcasecmp(obj->string.pointer, id->compatible))
-				return true;
+				return id;
 	}
 -	return false;
+	return NULL;
 }
+EXPORT_SYMBOL(acpi_of_match_device);
  static bool __acpi_match_device_cls(const struct acpi_device_id *id,
 				    struct acpi_hardware_id *hwid)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d4a3cb2..b8cefca 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -524,6 +524,8 @@ extern int acpi_nvs_for_each_region(int
(*func)(__u64, __u64, void *),
  const struct acpi_device_id *acpi_match_device(const struct
acpi_device_id *ids,
 					       const struct device *dev);
+const struct of_device_id *acpi_of_match_device(const struct
acpi_device *dev,
+						const struct of_device_id *ids);
  extern bool acpi_driver_match_device(struct device *dev,
 				     const struct device_driver *drv);
@@ -649,6 +651,12 @@ static inline const struct acpi_device_id
*acpi_match_device(
 	return NULL;
 }
 +const struct of_device_id *acpi_of_match_device(const struct
acpi_device *dev,
+						const struct acpi_device_id *ids);
+{
+	return NULL;
+}
+
 static inline bool acpi_driver_match_device(struct device *dev,
 					    const struct device_driver *drv)
 {
-- 
2.5.5

