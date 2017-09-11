From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v10 13/24] v4l: async: Allow async notifier register call succeed with no subdevs
Date: Mon, 11 Sep 2017 10:59:57 +0300
Message-ID: <20170911080008.21208-14-sakari.ailus@linux.intel.com>
References: <20170911080008.21208-1-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170911080008.21208-1-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The information on how many async sub-devices would be bindable to a
notifier is typically dependent on information from platform firmware and
it's not driver's business to be aware of that.

Many V4L2 main drivers are perfectly usable (and useful) without async
sub-devices and so if there aren't any around, just proceed call the
notifier's complete callback immediately without registering the notifier
itself.

If a driver needs to check whether there are async sub-devices available,
it can be done by inspecting the notifier's num_subdevs field which tells
the number of async sub-devices.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/media/v4l2-core/v4l2-async.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 7b396ff4302b..9ebc2e079d03 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -170,10 +170,12 @@ int v4l2_async_notifier_register(struct v4l2_device *v4l2_dev,
 	struct v4l2_async_subdev *asd;
 	int i;
 
-	if (!v4l2_dev || !notifier->num_subdevs ||
-	    notifier->num_subdevs > V4L2_MAX_SUBDEVS)
+	if (!v4l2_dev || notifier->num_subdevs > V4L2_MAX_SUBDEVS)
 		return -EINVAL;
 
+	if (!notifier->num_subdevs)
+		return v4l2_async_notifier_call_complete(notifier);
+
 	notifier->v4l2_dev = v4l2_dev;
 	INIT_LIST_HEAD(&notifier->waiting);
 	INIT_LIST_HEAD(&notifier->done);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
