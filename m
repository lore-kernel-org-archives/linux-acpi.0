From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v10 04/24] v4l: async: Add V4L2 async documentation to the documentation build
Date: Mon, 11 Sep 2017 10:59:48 +0300
Message-ID: <20170911080008.21208-5-sakari.ailus@linux.intel.com>
References: <20170911080008.21208-1-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170911080008.21208-1-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The V4L2 async wasn't part of the documentation build. Fix this.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Acked-by: Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 Documentation/media/kapi/v4l2-async.rst | 3 +++
 Documentation/media/kapi/v4l2-core.rst  | 1 +
 2 files changed, 4 insertions(+)
 create mode 100644 Documentation/media/kapi/v4l2-async.rst

diff --git a/Documentation/media/kapi/v4l2-async.rst b/Documentation/media/kapi/v4l2-async.rst
new file mode 100644
index 000000000000..523ff9eb09a0
--- /dev/null
+++ b/Documentation/media/kapi/v4l2-async.rst
@@ -0,0 +1,3 @@
+V4L2 async kAPI
+^^^^^^^^^^^^^^^
+.. kernel-doc:: include/media/v4l2-async.h
diff --git a/Documentation/media/kapi/v4l2-core.rst b/Documentation/media/kapi/v4l2-core.rst
index c7434f38fd9c..5cf292037a48 100644
--- a/Documentation/media/kapi/v4l2-core.rst
+++ b/Documentation/media/kapi/v4l2-core.rst
@@ -19,6 +19,7 @@ Video4Linux devices
     v4l2-mc
     v4l2-mediabus
     v4l2-mem2mem
+    v4l2-async
     v4l2-fwnode
     v4l2-rect
     v4l2-tuner
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
