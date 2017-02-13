From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 4/8] v4l2-async: Provide interoperability between OF and fwnode matching
Date: Mon, 13 Feb 2017 15:28:12 +0200
Message-ID: <1486992496-21078-5-git-send-email-sakari.ailus@linux.intel.com>
References: <1486992496-21078-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486992496-21078-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

OF and fwnode support are separated in V4L2 and individual drivers may
implement one of them. Sub-devices do not match with a notifier
expecting sub-devices with fwnodes, nor the other way around.

Fix this by checking for sub-device's of_node field in fwnode match and
fwnode field in OF match.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/media/v4l2-core/v4l2-async.c | 26 +++++++++++++++++++++++---
 include/media/v4l2-async.h           |  2 +-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 384ad5e..7f5d804 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -14,6 +14,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -40,15 +41,34 @@ static bool match_devname(struct v4l2_subdev *sd,
 	return !strcmp(asd->match.device_name.name, dev_name(sd->dev));
 }
 
+static bool fwnode_cmp(struct fwnode_handle *one,
+		       struct fwnode_handle *theother)
+{
+	if (!one || !theother)
+		return false;
+
+	if (one->type != theother->type)
+		return false;
+
+	if (is_of_node(one))
+		return !of_node_cmp(of_node_full_name(to_of_node(one)),
+				    of_node_full_name(to_of_node(theother)));
+	else
+		return one == theother;
+}
+
 static bool match_of(struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
 {
-	return !of_node_cmp(of_node_full_name(sd->of_node),
-			    of_node_full_name(asd->match.of.node));
+	return fwnode_cmp(sd->of_node ?
+			  of_fwnode_handle(sd->of_node) : sd->fwnode,
+			  of_fwnode_handle(asd->match.of.node));
 }
 
 static bool match_fwnode(struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
 {
-	return sd->fwnode == asd->match.fwnode.fwn;
+	return fwnode_cmp(sd->of_node ?
+			  of_fwnode_handle(sd->of_node) : sd->fwnode,
+					   asd->match.fwnode.fwn);
 }
 
 static bool match_custom(struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index 8f552d2..df8b682 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -57,7 +57,7 @@ struct v4l2_async_subdev {
 	enum v4l2_async_match_type match_type;
 	union {
 		struct {
-			const struct device_node *node;
+			struct device_node *node;
 		} of;
 		struct {
 			struct fwnode_handle *fwn;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
