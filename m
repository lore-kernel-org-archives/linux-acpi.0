From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2 1/4] device property: Introduce fwnode_get_name()
Date: Thu,  8 Nov 2018 19:51:53 +0300
Message-ID: <20181108165156.60073-2-heikki.krogerus@linux.intel.com>
References: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This helper returns the name of the node. The name is
primarily expected to be returned from a new fwnode
operation meant for this purpose, but when no name is
returned, the helper will also attempt to read a device
property "name".

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/property.c  | 25 +++++++++++++++++++++++++
 include/linux/fwnode.h   |  3 +++
 include/linux/property.h |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 240ab5230ff6..4db710e2ce34 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1156,6 +1156,31 @@ void fwnode_handle_put(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_handle_put);
 
+/**
+ * fwnode_get_name - Read the name of a node
+ * @fwnode: Pointer to the node.
+ * @buf: Buffer where the name is copied to
+ *
+ * Reads the node name of @fwnode with get_name fwnode op. If get_name op fails,
+ * the routine attempts to also read a property "name".
+ */
+int fwnode_get_name(const struct fwnode_handle *fwnode, char *buf)
+{
+	const char *name;
+	int ret;
+
+	if (!fwnode_call_int_op(fwnode, get_name, buf))
+		return 0;
+
+	ret = fwnode_call_int_op(fwnode, property_read_string_array,
+				 "name", &name, 1);
+	if (!ret)
+		sprintf(buf, "%s", name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_name);
+
 /**
  * fwnode_device_is_available - check if a device is available for use
  * @fwnode: Pointer to the fwnode of the device.
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index faebf0ca0686..cc234f5d2b40 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -48,6 +48,8 @@ struct fwnode_reference_args {
 	u64 args[NR_FWNODE_REFERENCE_ARGS];
 };
 
+#define FWNODE_NAME_MAX_SIZE		32
+
 /**
  * struct fwnode_operations - Operations for fwnode interface
  * @get: Get a reference to an fwnode.
@@ -72,6 +74,7 @@ struct fwnode_reference_args {
 struct fwnode_operations {
 	struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
 	void (*put)(struct fwnode_handle *fwnode);
+	int (*get_name)(const struct fwnode_handle *fwnode, char *buf);
 	bool (*device_is_available)(const struct fwnode_handle *fwnode);
 	const void *(*device_get_match_data)(const struct fwnode_handle *fwnode,
 					     const struct device *dev);
diff --git a/include/linux/property.h b/include/linux/property.h
index ac8a1ebc4c1b..da37bdebf7ab 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -109,6 +109,8 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
 struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
+int fwnode_get_name(const struct fwnode_handle *fwnode, char *name);
+
 int fwnode_irq_get(struct fwnode_handle *fwnode, unsigned int index);
 
 unsigned int device_get_child_node_count(struct device *dev);
-- 
2.19.1
