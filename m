From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v5 5/5] device property: Add FW type agnostic fwnode_graph_get_remote_node
Date: Thu,  4 May 2017 10:14:11 +0300
Message-ID: <1493882051-28814-6-git-send-email-sakari.ailus@linux.intel.com>
References: <1493882051-28814-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26588 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751784AbdEDHPX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 May 2017 03:15:23 -0400
In-Reply-To: <1493882051-28814-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

Add fwnode_graph_get_remote_node() function which is equivalent to
of_graph_get_remote_node() on OF.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c  | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index ad0de38..5914156 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1215,6 +1215,43 @@ fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
 
 /**
+ * fwnode_graph_get_remote_node - get remote parent node for given port/endpoint
+ * @fwnode: pointer to parent fwnode_handle containing graph port/endpoint
+ * @port_id: identifier of the parent port node
+ * @endpoint_id: identifier of the endpoint node
+ *
+ * Return: Remote fwnode handle associated with remote endpoint node linked
+ *	   to @node. Use fwnode_node_put() on it when done.
+ */
+struct fwnode_handle *fwnode_graph_get_remote_node(
+	struct fwnode_handle *fwnode, u32 port_id, u32 endpoint_id)
+{
+	struct fwnode_handle *endpoint = NULL;
+
+	while ((endpoint = fwnode_graph_get_next_endpoint(fwnode, endpoint))) {
+		struct fwnode_endpoint fwnode_ep;
+		struct fwnode_handle *remote;
+		int ret;
+
+		ret = fwnode_graph_parse_endpoint(endpoint, &fwnode_ep);
+		if (ret < 0)
+			continue;
+
+		if (fwnode_ep.port != port_id || fwnode_ep.id != endpoint_id)
+			continue;
+
+		remote = fwnode_graph_get_remote_port_parent(endpoint);
+		if (!remote)
+			return NULL;
+
+		return fwnode_device_is_available(remote) ? remote : NULL;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_node);
+
+/**
  * fwnode_graph_parse_endpoint - parse common endpoint node properties
  * @fwnode: pointer to endpoint fwnode_handle
  * @endpoint: pointer to the fwnode endpoint data structure
diff --git a/include/linux/property.h b/include/linux/property.h
index 7be014a..b9f4838 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -281,6 +281,8 @@ struct fwnode_handle *fwnode_graph_get_remote_port(
 	struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_graph_get_remote_endpoint(
 	struct fwnode_handle *fwnode);
+struct fwnode_handle *fwnode_graph_get_remote_node(
+	struct fwnode_handle *fwnode, u32 port, u32 endpoint);
 
 int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
 				struct fwnode_endpoint *endpoint);
-- 
2.7.4

