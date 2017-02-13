From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 6/8] v4l: media/drv-intf/soc_mediabus.h: include dependent header file
Date: Mon, 13 Feb 2017 15:28:14 +0200
Message-ID: <1486992496-21078-7-git-send-email-sakari.ailus@linux.intel.com>
References: <1486992496-21078-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1486992496-21078-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

media/drv-intf/soc_mediabus.h does depend on struct v4l2_mbus_config which
is defined in media/v4l2-mediabus.h. Include it.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/media/drv-intf/soc_mediabus.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/media/drv-intf/soc_mediabus.h b/include/media/drv-intf/soc_mediabus.h
index 2ff7737..0449788 100644
--- a/include/media/drv-intf/soc_mediabus.h
+++ b/include/media/drv-intf/soc_mediabus.h
@@ -14,6 +14,8 @@
 #include <linux/videodev2.h>
 #include <linux/v4l2-mediabus.h>
 
+#include <media/v4l2-mediabus.h>
+
 /**
  * enum soc_mbus_packing - data packing types on the media-bus
  * @SOC_MBUS_PACKING_NONE:	no packing, bit-for-bit transfer to RAM, one
-- 
2.7.4
