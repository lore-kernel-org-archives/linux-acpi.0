From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v16 07/32] v4l: async: Add V4L2 async documentation to the documentation build
Date: Thu, 26 Oct 2017 10:53:17 +0300
Message-ID: <20171026075342.5760-8-sakari.ailus@linux.intel.com>
References: <20171026075342.5760-1-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20171026075342.5760-1-sakari.ailus@linux.intel.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: niklas.soderlund@ragnatech.se, maxime.ripard@free-electrons.com, hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com, pavel@ucw.cz, sre@kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The V4L2 async wasn't part of the documentation build. Fix this.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
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
