From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 7/7] v4l2-async: Make fwnode const
Date: Mon, 22 May 2017 12:07:42 +0300
Message-ID: <1495444062-23867-8-git-send-email-sakari.ailus@linux.intel.com>
References: <1495444062-23867-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495444062-23867-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It can be const now.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 include/media/v4l2-async.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index c69d8c8..056cae0 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -55,7 +55,7 @@ struct v4l2_async_subdev {
 	enum v4l2_async_match_type match_type;
 	union {
 		struct {
-			struct fwnode_handle *fwnode;
+			const struct fwnode_handle *fwnode;
 		} fwnode;
 		struct {
 			const char *name;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
