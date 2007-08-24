From: Len Brown <len.brown@intel.com>
Subject: [PATCH 10/25] ACPI: video: Add keycode for ACPI video driver hotkey events.
Date: Fri, 24 Aug 2007 03:20:57 -0400
Message-ID: <1187940086685-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
 <11879400802531-git-send-email-len.brown@intel.com>
 <11879400812208-git-send-email-len.brown@intel.com>
 <11879400823500-git-send-email-len.brown@intel.com>
 <11879400841550-git-send-email-len.brown@intel.com>
 <1187940085345-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17416 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754686AbXHXHV1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:27 -0400
In-Reply-To: <1187940085345-git-send-email-len.brown@intel.com>
Message-Id: <a7ecd1ea913346a72f41a002c365882dc05c9bd5.1187939442.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Yu Luming <luming.yu@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Yu Luming <luming.yu@intel.com>

Signed-off-by: Luming Yu <luming.yu@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/input.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index e02c6a6..cf2b561 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -363,6 +363,12 @@ struct input_absinfo {
 
 #define KEY_UNKNOWN		240
 
+#define KEY_VIDEO_NEXT		241	/* drive next video source */
+#define KEY_VIDEO_PREV		242	/* drive previous video source */
+#define KEY_BRIGHTNESS_CYCLE	243	/* brightness up, after max is min */
+#define KEY_BRIGHTNESS_ZERO	244	/* brightness off, use ambient */
+#define KEY_DISPLAY_OFF		245	/* display device to off state */
+
 #define BTN_MISC		0x100
 #define BTN_0			0x100
 #define BTN_1			0x101
-- 
1.5.3.rc6.17.g1911
