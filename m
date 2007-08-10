From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC] [PATCH V2 1/3] ACPI video hotkey: add new input key codes
	for ACPI video hotkey events
Date: Sat, 11 Aug 2007 05:07:21 +0800
Message-ID: <1186780041.6830.57.camel@rzhang-asus.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13319 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756763AbXHJVGQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Aug 2007 17:06:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, mjg59@srcf.ucam.org, dmitry.torokhov@gmail.com, hmh@hmh.eng.hr, hughsient@gmail.com, luming.yu@intel.com

From: Yu Luming <luming.yu@intel.com>

Add keycode for ACPI video hotkey event.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 include/linux/input.h |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6.23-rc2/include/linux/input.h
===================================================================
--- linux-2.6.23-rc2.orig/include/linux/input.h
+++ linux-2.6.23-rc2/include/linux/input.h
@@ -553,6 +553,11 @@ struct input_absinfo {
 #define KEY_BRL_DOT7		0x1f7
 #define KEY_BRL_DOT8		0x1f8
 
+#define KEY_VIDEO_NEXT		0x1f9
+#define KEY_VIDEO_PREV		0x1fa
+#define KEY_BRIGHTNESS_ZERO	0x1fb
+#define KEY_BRIGHTNESS_OFF	0x1fc
+
 /* We avoid low common keys in module aliases so they don't get huge. */
 #define KEY_MIN_INTERESTING	KEY_MUTE
 #define KEY_MAX			0x1ff
