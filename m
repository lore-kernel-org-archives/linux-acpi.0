From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 6/7] v4l: fwnode: Constify fwnode endpoints
Date: Mon, 22 May 2017 12:07:41 +0300
Message-ID: <1495444062-23867-7-git-send-email-sakari.ailus@linux.intel.com>
References: <1495444062-23867-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:59439 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757679AbdEVJJ2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 May 2017 05:09:28 -0400
In-Reply-To: <1495444062-23867-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

Make the fwnode arguments to V4L2 fwnode API const as this is now
possible.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 12 ++++++------
 include/media/v4l2-fwnode.h           |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 153c53c..a68ed05 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -28,8 +28,8 @@
 
 #include <media/v4l2-fwnode.h>
 
-static int v4l2_fwnode_endpoint_parse_csi_bus(struct fwnode_handle *fwnode,
-					      struct v4l2_fwnode_endpoint *vep)
+static int v4l2_fwnode_endpoint_parse_csi_bus(
+	const struct fwnode_handle *fwnode, struct v4l2_fwnode_endpoint *vep)
 {
 	struct v4l2_fwnode_bus_mipi_csi2 *bus = &vep->bus.mipi_csi2;
 	bool have_clk_lane = false;
@@ -97,7 +97,7 @@ static int v4l2_fwnode_endpoint_parse_csi_bus(struct fwnode_handle *fwnode,
 }
 
 static void v4l2_fwnode_endpoint_parse_parallel_bus(
-	struct fwnode_handle *fwnode, struct v4l2_fwnode_endpoint *vep)
+	const struct fwnode_handle *fwnode, struct v4l2_fwnode_endpoint *vep)
 {
 	struct v4l2_fwnode_bus_parallel *bus = &vep->bus.parallel;
 	unsigned int flags = 0;
@@ -165,7 +165,7 @@ static void v4l2_fwnode_endpoint_parse_parallel_bus(
  *
  * Return: 0 on success or a negative error code on failure.
  */
-int v4l2_fwnode_endpoint_parse(struct fwnode_handle *fwnode,
+int v4l2_fwnode_endpoint_parse(const struct fwnode_handle *fwnode,
 			       struct v4l2_fwnode_endpoint *vep)
 {
 	int rval;
@@ -232,7 +232,7 @@ EXPORT_SYMBOL_GPL(v4l2_fwnode_endpoint_free);
  * on error.
  */
 struct v4l2_fwnode_endpoint *v4l2_fwnode_endpoint_alloc_parse(
-	struct fwnode_handle *fwnode)
+	const struct fwnode_handle *fwnode)
 {
 	struct v4l2_fwnode_endpoint *vep;
 	int rval;
@@ -291,7 +291,7 @@ EXPORT_SYMBOL_GPL(v4l2_fwnode_endpoint_alloc_parse);
  * Return: 0 on success, or -ENOLINK if the remote endpoint fwnode can't be
  * found.
  */
-int v4l2_fwnode_parse_link(struct fwnode_handle *__fwnode,
+int v4l2_fwnode_parse_link(const struct fwnode_handle *__fwnode,
 			   struct v4l2_fwnode_link *link)
 {
 	const char *port_prop = is_of_node(__fwnode) ? "reg" : "port";
diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
index ecc1233..bdbd785 100644
--- a/include/media/v4l2-fwnode.h
+++ b/include/media/v4l2-fwnode.h
@@ -92,12 +92,12 @@ struct v4l2_fwnode_link {
 	unsigned int remote_port;
 };
 
-int v4l2_fwnode_endpoint_parse(struct fwnode_handle *fwnode,
+int v4l2_fwnode_endpoint_parse(const struct fwnode_handle *fwnode,
 			       struct v4l2_fwnode_endpoint *vep);
 struct v4l2_fwnode_endpoint *v4l2_fwnode_endpoint_alloc_parse(
-	struct fwnode_handle *fwnode);
+	const struct fwnode_handle *fwnode);
 void v4l2_fwnode_endpoint_free(struct v4l2_fwnode_endpoint *vep);
-int v4l2_fwnode_parse_link(struct fwnode_handle *fwnode,
+int v4l2_fwnode_parse_link(const struct fwnode_handle *fwnode,
 			   struct v4l2_fwnode_link *link);
 void v4l2_fwnode_put_link(struct v4l2_fwnode_link *link);
 
-- 
2.7.4

