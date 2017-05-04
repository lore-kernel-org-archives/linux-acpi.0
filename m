From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v5 1/5] of: Add of_graph_get_port_parent() to obtain a port's parent node
Date: Thu,  4 May 2017 10:14:07 +0300
Message-ID: <1493882051-28814-2-git-send-email-sakari.ailus@linux.intel.com>
References: <1493882051-28814-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:12025 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751491AbdEDHPL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 May 2017 03:15:11 -0400
In-Reply-To: <1493882051-28814-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

Split off obtaining a port's parent node. This will be soon needed for
implementing the fwnode ops.

Depends-on: ("of: Move OF property and graph API from base.c to property.c")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/of/property.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index e5d3e1f..cf704f4 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -681,6 +681,30 @@ struct device_node *of_graph_get_endpoint_by_regs(
 EXPORT_SYMBOL(of_graph_get_endpoint_by_regs);
 
 /**
+ * of_graph_get_port_parent() - get port's parent node
+ * @node: pointer to a port node
+ *
+ * Return: Device node which is the parent of the given port node
+ *	   @node. Use of_node_put() on it when done.
+ */
+static struct device_node *
+of_graph_get_port_parent(struct device_node *node)
+{
+	struct device_node *np;
+
+	/* Get the parent of the port */
+	np = of_get_next_parent(node);
+	if (!np)
+		return NULL;
+
+	/* Is there "ports" node? If not, return it. */
+	if (of_node_cmp(np->name, "ports"))
+		return np;
+
+	return of_get_next_parent(np);
+}
+
+/**
  * of_graph_get_remote_port_parent() - get remote port's parent node
  * @node: pointer to a local endpoint device_node
  *
@@ -691,18 +715,13 @@ struct device_node *of_graph_get_remote_port_parent(
 			       const struct device_node *node)
 {
 	struct device_node *np;
-	unsigned int depth;
 
 	/* Get remote endpoint node. */
 	np = of_parse_phandle(node, "remote-endpoint", 0);
+	if (!np)
+		return NULL;
 
-	/* Walk 3 levels up only if there is 'ports' node. */
-	for (depth = 3; depth && np; depth--) {
-		np = of_get_next_parent(np);
-		if (depth == 2 && of_node_cmp(np->name, "ports"))
-			break;
-	}
-	return np;
+	return of_graph_get_port_parent(of_get_next_parent(np));
 }
 EXPORT_SYMBOL(of_graph_get_remote_port_parent);
 
-- 
2.7.4

