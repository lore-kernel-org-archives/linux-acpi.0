From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v16 04/32] v4l: async: Fix notifier complete callback error handling
Date: Thu, 26 Oct 2017 10:53:14 +0300
Message-ID: <20171026075342.5760-5-sakari.ailus@linux.intel.com>
References: <20171026075342.5760-1-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171026075342.5760-1-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The notifier complete callback may return an error. This error code was
simply returned to the caller but never handled properly.

Move calling the complete callback function to the caller from
v4l2_async_test_notify and undo the work that was done either in async
sub-device or async notifier registration.

Reported-by: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/media/v4l2-core/v4l2-async.c | 78 +++++++++++++++++++++++++++---------
 1 file changed, 60 insertions(+), 18 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index ca281438a0ae..4924481451ca 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -122,9 +122,6 @@ static int v4l2_async_test_notify(struct v4l2_async_notifier *notifier,
 	/* Move from the global subdevice list to notifier's done */
 	list_move(&sd->async_list, &notifier->done);
 
-	if (list_empty(&notifier->waiting) && notifier->complete)
-		return notifier->complete(notifier);
-
 	return 0;
 }
 
@@ -136,11 +133,27 @@ static void v4l2_async_cleanup(struct v4l2_subdev *sd)
 	sd->asd = NULL;
 }
 
+static void v4l2_async_notifier_unbind_all_subdevs(
+	struct v4l2_async_notifier *notifier)
+{
+	struct v4l2_subdev *sd, *tmp;
+
+	list_for_each_entry_safe(sd, tmp, &notifier->done, async_list) {
+		if (notifier->unbind)
+			notifier->unbind(notifier, sd, sd->asd);
+
+		v4l2_async_cleanup(sd);
+
+		list_move(&sd->async_list, &subdev_list);
+	}
+}
+
 int v4l2_async_notifier_register(struct v4l2_device *v4l2_dev,
 				 struct v4l2_async_notifier *notifier)
 {
 	struct v4l2_subdev *sd, *tmp;
 	struct v4l2_async_subdev *asd;
+	int ret;
 	int i;
 
 	if (!v4l2_dev || !notifier->num_subdevs ||
@@ -185,19 +198,30 @@ int v4l2_async_notifier_register(struct v4l2_device *v4l2_dev,
 		}
 	}
 
+	if (list_empty(&notifier->waiting) && notifier->complete) {
+		ret = notifier->complete(notifier);
+		if (ret)
+			goto err_complete;
+	}
+
 	/* Keep also completed notifiers on the list */
 	list_add(&notifier->list, &notifier_list);
 
 	mutex_unlock(&list_lock);
 
 	return 0;
+
+err_complete:
+	v4l2_async_notifier_unbind_all_subdevs(notifier);
+
+	mutex_unlock(&list_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL(v4l2_async_notifier_register);
 
 void v4l2_async_notifier_unregister(struct v4l2_async_notifier *notifier)
 {
-	struct v4l2_subdev *sd, *tmp;
-
 	if (!notifier->v4l2_dev)
 		return;
 
@@ -205,14 +229,7 @@ void v4l2_async_notifier_unregister(struct v4l2_async_notifier *notifier)
 
 	list_del(&notifier->list);
 
-	list_for_each_entry_safe(sd, tmp, &notifier->done, async_list) {
-		if (notifier->unbind)
-			notifier->unbind(notifier, sd, sd->asd);
-
-		v4l2_async_cleanup(sd);
-
-		list_move(&sd->async_list, &subdev_list);
-	}
+	v4l2_async_notifier_unbind_all_subdevs(notifier);
 
 	mutex_unlock(&list_lock);
 
@@ -223,6 +240,7 @@ EXPORT_SYMBOL(v4l2_async_notifier_unregister);
 int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 {
 	struct v4l2_async_notifier *notifier;
+	int ret;
 
 	/*
 	 * No reference taken. The reference is held by the device
@@ -238,19 +256,43 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 
 	list_for_each_entry(notifier, &notifier_list, list) {
 		struct v4l2_async_subdev *asd = v4l2_async_belongs(notifier, sd);
-		if (asd) {
-			int ret = v4l2_async_test_notify(notifier, sd, asd);
-			mutex_unlock(&list_lock);
-			return ret;
-		}
+		int ret;
+
+		if (!asd)
+			continue;
+
+		ret = v4l2_async_test_notify(notifier, sd, asd);
+		if (ret)
+			goto err_unlock;
+
+		if (!list_empty(&notifier->waiting) || !notifier->complete)
+			goto out_unlock;
+
+		ret = notifier->complete(notifier);
+		if (ret)
+			goto err_cleanup;
+
+		goto out_unlock;
 	}
 
 	/* None matched, wait for hot-plugging */
 	list_add(&sd->async_list, &subdev_list);
 
+out_unlock:
 	mutex_unlock(&list_lock);
 
 	return 0;
+
+err_cleanup:
+	if (notifier->unbind)
+		notifier->unbind(notifier, sd, sd->asd);
+
+	v4l2_async_cleanup(sd);
+
+err_unlock:
+	mutex_unlock(&list_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL(v4l2_async_register_subdev);
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
