From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v16 11/32] omap3isp: Fix check for our own sub-devices
Date: Thu, 26 Oct 2017 10:53:21 +0300
Message-ID: <20171026075342.5760-12-sakari.ailus@linux.intel.com>
References: <20171026075342.5760-1-sakari.ailus@linux.intel.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20171026075342.5760-1-sakari.ailus@linux.intel.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: niklas.soderlund@ragnatech.se, maxime.ripard@free-electrons.com, hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com, pavel@ucw.cz, sre@kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

We only want to link sub-devices that were bound to the async notifier the
isp driver registered but there may be other sub-devices in the
v4l2_device as well. Check for the correct async notifier.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/media/platform/omap3isp/isp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index 97a5206b6ddc..4afd7ba4fad6 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -2155,7 +2155,7 @@ static int isp_subdev_notifier_complete(struct v4l2_async_notifier *async)
 		return ret;
 
 	list_for_each_entry(sd, &v4l2_dev->subdevs, list) {
-		if (!sd->asd)
+		if (sd->notifier != &isp->notifier)
 			continue;
 
 		ret = isp_link_entity(isp, &sd->entity,
-- 
2.11.0
