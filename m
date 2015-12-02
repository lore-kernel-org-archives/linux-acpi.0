From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [RFC PATCH 1/4] acpi: property: Introduce helper acpi_dev_get_reference_device()
Date: Wed, 2 Dec 2015 17:09:25 +0800
Message-ID: <1449047368-5768-2-git-send-email-wangkefeng.wang@huawei.com>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:12367 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756878AbbLBJM3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2015 04:12:29 -0500
In-Reply-To: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kefeng Wang <wangkefeng.wang@huawei.com>

Like of_parse_phandle() helper function to read and parse a phandle property
and return a pointer to the resulting device_node, introduce helper function
acpi_dev_get_reference_device() to read and parse a device properties(used in
_DSD method) and return a pointer to the resulting acpi_device.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/acpi/property.c | 23 +++++++++++++++++++++++
 include/linux/acpi.h    |  7 +++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 88f4306..e2e7754 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -398,6 +398,29 @@ int acpi_dev_get_property(struct acpi_device *adev, const char *name,
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_property);
 
+/**
+ * acpi_dev_get_reference_device  - return the acpi_device referenced
+ * @adev: ACPI device to get the property from.
+ * @name: Name of the property.
+ * @index: Index of the reference to return
+ *
+ * Returns referenced ACPI device pointer, or NULL if not found
+ */
+struct acpi_device *acpi_dev_get_reference_device(struct acpi_device *adev,
+						  const char *name, size_t index)
+{
+	struct acpi_reference_args args;
+	int ret;
+
+	ret = acpi_node_get_property_reference(acpi_fwnode_handle(adev), name, index, &args);
+
+	if (ret)
+		return NULL;
+
+	return args.adev;
+}
+EXPORT_SYMBOL(acpi_dev_get_reference_device);
+
 static struct acpi_device_data *acpi_device_data_of_node(struct fwnode_handle *fwnode)
 {
 	if (fwnode->type == FWNODE_ACPI) {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 93811dc..d76a688 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -793,6 +793,8 @@ struct acpi_reference_args {
 #ifdef CONFIG_ACPI
 int acpi_dev_get_property(struct acpi_device *adev, const char *name,
 			  acpi_object_type type, const union acpi_object **obj);
+struct acpi_device *acpi_dev_get_reference_device(struct acpi_device *adev,
+						  const char *name, size_t index);
 int acpi_node_get_property_reference(struct fwnode_handle *fwnode,
 				     const char *name, size_t index,
 				     struct acpi_reference_args *args);
@@ -870,6 +872,11 @@ static inline int acpi_dev_get_property(struct acpi_device *adev,
 {
 	return -ENXIO;
 }
+static inline struct acpi_device *acpi_dev_get_reference_device(struct acpi_device *adev,
+						  const char *name, size_t index)
+{
+	return NULL;
+}
 
 static inline int acpi_node_get_property_reference(struct fwnode_handle *fwnode,
 				const char *name, const char *cells_name,
-- 
1.7.12.4


