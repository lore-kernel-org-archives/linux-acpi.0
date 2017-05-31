From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v5 6/6] device property: Add fwnode_graph_get_port_parent
Date: Wed, 31 May 2017 14:52:12 +0300
Message-ID: <1496231532-23601-7-git-send-email-sakari.ailus@linux.intel.com>
References: <1496231532-23601-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35451 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbdEaLxg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 07:53:36 -0400
In-Reply-To: <1496231532-23601-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, kieran.bingham@ideasonboard.com, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Provide a helper to obtain the parent device fwnode without first
parsing the remote-endpoint as per fwnode_graph_get_remote_port_parent.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c  | 28 ++++++++++++++++++++++++----
 include/linux/property.h |  2 ++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 519d290..c2776d7 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1170,6 +1170,26 @@ fwnode_graph_get_next_endpoint(struct fwnode_handle *fwnode,
 EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
 
 /**
+ * fwnode_graph_get_port_parent - Return the device fwnode of a port endpoint
+ * @endpoint: Endpoint firmware node of the port
+ *
+ * Return: the firmware node of the device the @endpoint belongs to.
+ */
+struct fwnode_handle *
+fwnode_graph_get_port_parent(struct fwnode_handle *endpoint)
+{
+	struct fwnode_handle *port, *parent;
+
+	port = fwnode_get_parent(endpoint);
+	parent = fwnode_call_ptr_op(port, graph_get_port_parent);
+
+	fwnode_handle_put(port);
+
+	return parent;
+}
+EXPORT_SYMBOL_GPL(fwnode_graph_get_port_parent);
+
+/**
  * fwnode_graph_get_remote_port_parent - Return fwnode of a remote device
  * @fwnode: Endpoint firmware node pointing to the remote endpoint
  *
@@ -1178,12 +1198,12 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
 struct fwnode_handle *
 fwnode_graph_get_remote_port_parent(struct fwnode_handle *fwnode)
 {
-	struct fwnode_handle *port, *parent;
+	struct fwnode_handle *endpoint, *parent;
 
-	port = fwnode_graph_get_remote_port(fwnode);
-	parent = fwnode_call_ptr_op(port, graph_get_port_parent);
+	endpoint = fwnode_graph_get_remote_endpoint(fwnode);
+	parent = fwnode_graph_get_port_parent(endpoint);
 
-	fwnode_handle_put(port);
+	fwnode_handle_put(endpoint);
 
 	return parent;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index 0597a74..7e77039 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -275,6 +275,8 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen);
 
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	struct fwnode_handle *fwnode, struct fwnode_handle *prev);
+struct fwnode_handle *
+fwnode_graph_get_port_parent(struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_graph_get_remote_port_parent(
 	struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_graph_get_remote_port(
-- 
2.7.4

