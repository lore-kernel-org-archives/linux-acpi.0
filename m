From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
Date: Tue,  3 Jul 2018 14:52:40 +0530
Message-ID: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org, lenb@kernel.org, andy.shevchenko@gmail.com
Cc: ray.jui@broadcom.com, vladimir.olovyannikov@broadcom.com, vikram.prakash@broadcom.com, scott.branden@broadcom.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Srinath Mannam <srinath.mannam@broadcom.com>
List-Id: linux-acpi@vger.kernel.org

This patch provides a function, to get of_device_id after
matching with ACPI device _DSD object compatible property
in the case driver does not contain acpi_device_id list
and driver probe called for ACPI device ID PRP0001 with
compatible property match with of_device_id compatible.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/acpi/bus.c   | 23 +++++++++++++++++++++++
 include/linux/acpi.h | 10 ++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 84b4a62..e676bf7 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -830,6 +830,29 @@ const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 }
 EXPORT_SYMBOL_GPL(acpi_match_device);
 
+/**
+ * acpi_match_of_device_id - Match a struct device in given of_device_id list
+ * @ids: Array of struct of_device_id object to match against.
+ * @dev: The device structure to match.
+ *
+ * Check if @dev has a valid ACPI handle and if there is a struct acpi_device
+ * object for that handle and use that object to match against a given list of
+ * device IDs.
+ *
+ * Return a pointer to the first matching ID on success or %NULL on failure.
+ */
+const
+struct of_device_id *acpi_match_of_device_id(const struct of_device_id *ids,
+					     const struct device *dev)
+{
+	const struct of_device_id *id = NULL;
+
+	__acpi_match_device(acpi_companion_match(dev), NULL, ids, NULL, &id);
+	return id;
+}
+EXPORT_SYMBOL_GPL(acpi_match_of_device_id);
+
+
 const void *acpi_device_get_match_data(const struct device *dev)
 {
 	const struct acpi_device_id *match;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4b35a66..2f24800 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -589,6 +589,10 @@ extern int acpi_nvs_for_each_region(int (*func)(__u64, __u64, void *),
 const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 					       const struct device *dev);
 
+const
+struct of_device_id *acpi_match_of_device_id(const struct of_device_id *ids,
+					     const struct device *dev);
+
 const void *acpi_device_get_match_data(const struct device *dev);
 extern bool acpi_driver_match_device(struct device *dev,
 				     const struct device_driver *drv);
@@ -775,6 +779,12 @@ static inline const struct acpi_device_id *acpi_match_device(
 	return NULL;
 }
 
+static inline const struct of_device_id *acpi_match_of_device_id(
+	const struct of_device_id *ids, const struct device *dev)
+{
+	return NULL;
+}
+
 static inline const void *acpi_device_get_match_data(const struct device *dev)
 {
 	return NULL;
-- 
2.7.4
