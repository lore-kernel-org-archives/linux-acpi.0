From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/6] ACPI / bus: Rename acpi_get_match_data() to acpi_device_get_match_data()
Date: Thu,  1 Feb 2018 22:20:10 +0200
Message-ID: <20180201202012.36524-4-andriy.shevchenko@linux.intel.com>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:38092 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754900AbeBAUUT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Feb 2018 15:20:19 -0500
In-Reply-To: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

Do the renaming to be consistent with its sibling, i.e.
of_device_get_match_data().

No functional change.

Fixes: 80212a162329 ("ACPI / bus: Introduce acpi_get_match_data() function")
Fixes: 146b4dbb0eef ("ACPI: properties: Implement get_match_data() callback")
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/bus.c      | 4 ++--
 drivers/acpi/property.c | 2 +-
 include/linux/acpi.h    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 413e4b1cb1be..0f3f38a4e0c5 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -787,7 +787,7 @@ const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 }
 EXPORT_SYMBOL_GPL(acpi_match_device);
 
-void *acpi_get_match_data(const struct device *dev)
+void *acpi_device_get_match_data(const struct device *dev)
 {
 	const struct acpi_device_id *match;
 
@@ -797,7 +797,7 @@ void *acpi_get_match_data(const struct device *dev)
 
 	return (void *)match->driver_data;
 }
-EXPORT_SYMBOL_GPL(acpi_get_match_data);
+EXPORT_SYMBOL_GPL(acpi_device_get_match_data);
 
 int acpi_match_device_ids(struct acpi_device *device,
 			  const struct acpi_device_id *ids)
diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 466d1503aba0..f9b5fa230a86 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1275,7 +1275,7 @@ static void *
 acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 				  const struct device *dev)
 {
-	return acpi_get_match_data(dev);
+	return acpi_device_get_match_data(dev);
 }
 
 #define DECLARE_ACPI_FWNODE_OPS(ops) \
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 246845da3f84..d0cbbbd88e0e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -587,7 +587,7 @@ extern int acpi_nvs_for_each_region(int (*func)(__u64, __u64, void *),
 const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 					       const struct device *dev);
 
-void *acpi_get_match_data(const struct device *dev);
+void *acpi_device_get_match_data(const struct device *dev);
 extern bool acpi_driver_match_device(struct device *dev,
 				     const struct device_driver *drv);
 int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env *);
@@ -766,7 +766,7 @@ static inline const struct acpi_device_id *acpi_match_device(
 	return NULL;
 }
 
-static inline void *acpi_get_match_data(const struct device *dev)
+static inline void *acpi_device_get_match_data(const struct device *dev)
 {
 	return NULL;
 }
-- 
2.15.1

