From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 5/7] docs-rst: media: Sort topic list alphabetically
Date: Mon, 10 Apr 2017 16:02:54 +0300
Message-ID: <1491829376-14791-6-git-send-email-sakari.ailus@linux.intel.com>
References: <1491829376-14791-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491829376-14791-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Bring some order by alphabetically ordering the list of topics.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 Documentation/media/kapi/v4l2-core.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/media/kapi/v4l2-core.rst b/Documentation/media/kapi/v4l2-core.rst
index d8f6c46..2fbf532 100644
--- a/Documentation/media/kapi/v4l2-core.rst
+++ b/Documentation/media/kapi/v4l2-core.rst
@@ -4,23 +4,23 @@ Video4Linux devices
 .. toctree::
     :maxdepth: 1
 
-    v4l2-intro
+    v4l2-clocks
+    v4l2-common
+    v4l2-controls
     v4l2-dev
     v4l2-device
-    v4l2-fh
-    v4l2-subdev
-    v4l2-event
-    v4l2-controls
-    v4l2-videobuf
-    v4l2-videobuf2
-    v4l2-clocks
     v4l2-dv-timings
+    v4l2-event
+    v4l2-fh
     v4l2-flash-led-class
+    v4l2-intro
     v4l2-mc
     v4l2-mediabus
     v4l2-mem2mem
     v4l2-of
     v4l2-rect
+    v4l2-subdev
     v4l2-tuner
-    v4l2-common
     v4l2-tveeprom
+    v4l2-videobuf
+    v4l2-videobuf2
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
