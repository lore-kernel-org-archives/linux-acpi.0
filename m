From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/4] device property: Constify device_get_match_data()
Date: Wed, 31 Jan 2018 23:29:59 +0200
Message-ID: <20180131212959.68766-4-andriy.shevchenko@linux.intel.com>
References: <20180131212959.68766-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:48950 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752758AbeAaVaE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 Jan 2018 16:30:04 -0500
In-Reply-To: <20180131212959.68766-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmaengine <dmaengine@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

Constify device_get_match_data() as OF and ACPI variants return
constant value.

Fixes: 80212a162329 ("ACPI / bus: Introduce acpi_get_match_data() function")
Fixes: b283f157611f ("device property: Introduce a common API to fetch device match data")
Fixes: 146b4dbb0eef ("ACPI: properties: Implement get_match_data() callback")
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/bus.c       | 4 ++--
 drivers/acpi/property.c  | 2 +-
 drivers/base/property.c  | 5 ++---
 drivers/of/property.c    | 4 ++--
 include/linux/acpi.h     | 4 ++--
 include/linux/fwnode.h   | 4 ++--
 include/linux/property.h | 2 +-
 7 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index da29c103f76a..f4bba5b03843 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -785,7 +785,7 @@ const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 }
 EXPORT_SYMBOL_GPL(acpi_match_device);
 
-void *acpi_device_get_match_data(const struct device *dev)
+const void *acpi_device_get_match_data(const struct device *dev)
 {
 	const struct acpi_device_id *match;
 
@@ -793,7 +793,7 @@ void *acpi_device_get_match_data(const struct device *dev)
 	if (!match)
 		return NULL;
 
-	return (void *)match->driver_data;
+	return (const void *)match->driver_data;
 }
 EXPORT_SYMBOL_GPL(acpi_device_get_match_data);
 
diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index f9b5fa230a86..5815356ea6ad 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1271,7 +1271,7 @@ static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
-static void *
+static const void *
 acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 				  const struct device *dev)
 {
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 302236281d83..8f205f6461ed 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1410,9 +1410,8 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
 
-void *device_get_match_data(struct device *dev)
+const void *device_get_match_data(struct device *dev)
 {
-	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data,
-				  dev);
+	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
 }
 EXPORT_SYMBOL_GPL(device_get_match_data);
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 36ed84e26d9c..f46828e3b082 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -977,11 +977,11 @@ static int of_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
-static void *
+static const void *
 of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 				const struct device *dev)
 {
-	return (void *)of_device_get_match_data(dev);
+	return of_device_get_match_data(dev);
 }
 
 const struct fwnode_operations of_fwnode_ops = {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d0cbbbd88e0e..9a618204aba4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -587,7 +587,7 @@ extern int acpi_nvs_for_each_region(int (*func)(__u64, __u64, void *),
 const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 					       const struct device *dev);
 
-void *acpi_device_get_match_data(const struct device *dev);
+const void *acpi_device_get_match_data(const struct device *dev);
 extern bool acpi_driver_match_device(struct device *dev,
 				     const struct device_driver *drv);
 int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env *);
@@ -766,7 +766,7 @@ static inline const struct acpi_device_id *acpi_match_device(
 	return NULL;
 }
 
-static inline void *acpi_device_get_match_data(const struct device *dev)
+static inline const void *acpi_device_get_match_data(const struct device *dev)
 {
 	return NULL;
 }
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 4fa1a489efe4..4fe8f289b3f6 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -73,8 +73,8 @@ struct fwnode_operations {
 	struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
 	void (*put)(struct fwnode_handle *fwnode);
 	bool (*device_is_available)(const struct fwnode_handle *fwnode);
-	void *(*device_get_match_data)(const struct fwnode_handle *fwnode,
-				       const struct device *dev);
+	const void *(*device_get_match_data)(const struct fwnode_handle *fwnode,
+					     const struct device *dev);
 	bool (*property_present)(const struct fwnode_handle *fwnode,
 				 const char *propname);
 	int (*property_read_int_array)(const struct fwnode_handle *fwnode,
diff --git a/include/linux/property.h b/include/linux/property.h
index 769d372c1edf..2eea4b310fc2 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -283,7 +283,7 @@ bool device_dma_supported(struct device *dev);
 
 enum dev_dma_attr device_get_dma_attr(struct device *dev);
 
-void *device_get_match_data(struct device *dev);
+const void *device_get_match_data(struct device *dev);
 
 int device_get_phy_mode(struct device *dev);
 
-- 
2.15.1

