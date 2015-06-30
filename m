From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v1 04/10] device property: add fwnode_get_parent()
Date: Tue, 30 Jun 2015 16:55:02 +0200
Message-ID: <1435676108-20590-5-git-send-email-tomeu.vizoso@collabora.com>
References: <1435676108-20590-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435676108-20590-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

So we can query the parent of a fwnode without having to resort to API
that is specific to a firmware data format.

Also adds a acpi_get_parent_dev() function to retrieve the parent
of an acpi_device. acpi_get_parent() already existed but it works with
acpi_handles.

The interface covers both ACPI and Device Trees.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/base/property.c  | 23 +++++++++++++++++++++++
 include/acpi/acpi_bus.h  |  5 +++++
 include/linux/acpi.h     |  5 +++++
 include/linux/property.h |  2 ++
 4 files changed, 35 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f3f6d16..a7fb46b 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -533,3 +533,26 @@ bool device_dma_is_coherent(struct device *dev)
 	return coherent;
 }
 EXPORT_SYMBOL_GPL(device_dma_is_coherent);
+
+/**
+ * fwnode_get_parent - return the parent node of a device node
+ * @fwnode: Device node to find the parent node of
+ */
+struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode)
+{
+	if (is_of_node(fwnode)) {
+		struct device_node *node = to_of_node(fwnode);
+
+		if (node->parent)
+			return &node->parent->fwnode;
+	} else if (is_acpi_node(fwnode)) {
+		struct acpi_device *node;
+
+		node = acpi_get_parent_dev(to_acpi_node(fwnode));
+		if (node)
+			return acpi_fwnode_handle(node);
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_parent);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 83061ca..93c42a6 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -436,6 +436,11 @@ static inline void *acpi_driver_data(struct acpi_device *d)
 	return d->driver_data;
 }
 
+static inline struct acpi_device *acpi_get_parent_dev(struct acpi_device *adev)
+{
+	return adev->parent;
+}
+
 #define to_acpi_device(d)	container_of(d, struct acpi_device, dev)
 #define to_acpi_driver(d)	container_of(d, struct acpi_driver, drv)
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ed79b06..fc84e42 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -804,6 +804,11 @@ static inline struct acpi_device *acpi_get_next_child(struct device *dev,
 	return NULL;
 }
 
+static inline struct acpi_device *acpi_get_parent_dev(struct acpi_device *adev)
+{
+	return NULL;
+}
+
 #endif
 
 #endif	/*_LINUX_ACPI_H*/
diff --git a/include/linux/property.h b/include/linux/property.h
index 76ebde9..f47092d 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -63,6 +63,8 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
 struct fwnode_handle *device_get_next_child_node(struct device *dev,
 						 struct fwnode_handle *child);
 
+struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode);
+
 #define device_for_each_child_node(dev, child) \
 	for (child = device_get_next_child_node(dev, NULL); child; \
 	     child = device_get_next_child_node(dev, child))
-- 
2.4.1
