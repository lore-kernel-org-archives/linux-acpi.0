From: Len Brown <lenb@kernel.org>
Subject: [PATCH 044/103] asus-laptop: add Lenovo SL hotkey support
Date: Wed, 16 Dec 2009 03:35:55 -0500
Message-ID: <14f8af311e7d3e4198cbaade84a34f86505dcb37.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41634 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760839AbZLPKGG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:06:06 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:55 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Ike Panhc <ike.pan@canonical.com>, Len Brown <len.brown@intel.com>

From: Ike Panhc <ike.pan@canonical.com>

Lenovo SL series laptop has a very similar DSDT with Asus laptops. We can
easily have the extra ACPI function support with little modification in
asus-laptop.c

Here is the hotkey enablement for Lenovo SL series laptop.

This patch will enable the following hotkey:
 - Volumn Up
 - Volumn Down
 - Mute
 - Screen Lock (Fn+F2)
 - Battery Status (Fn+F3)
 - WLAN switch (Fn+F5)
 - Video output switch (Fn+F7)
 - Touchpad switch (Fn+F8)
 - Screen Magnifier (Fn+Space)

The following function of Lenovo SL laptop is still need to be enabled:
 - Hotkey: KEY_SUSPEND (Fn+F4), KEY_SLEEP (Fn+F12), Dock Eject (Fn+F9)
 - Rfkill for bluetooth and wlan
 - LenovoCare LED
 - Hwmon for fan speed
 - Fingerprint scanner
 - Active Protection System

Signed-off-by: Ike Panhc <ike.pan@canonical.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/asus-laptop.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index e931e80..83948df 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -221,6 +221,7 @@ static struct asus_hotk *hotk;
  */
 static const struct acpi_device_id asus_device_ids[] = {
 	{"ATK0100", 0},
+	{"ATK0101", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, asus_device_ids);
@@ -294,6 +295,11 @@ struct key_entry {
 enum { KE_KEY, KE_END };
 
 static struct key_entry asus_keymap[] = {
+	{KE_KEY, 0x02, KEY_SCREENLOCK},
+	{KE_KEY, 0x05, KEY_WLAN},
+	{KE_KEY, 0x08, KEY_F13},
+	{KE_KEY, 0x17, KEY_ZOOM},
+	{KE_KEY, 0x1f, KEY_BATTERY},
 	{KE_KEY, 0x30, KEY_VOLUMEUP},
 	{KE_KEY, 0x31, KEY_VOLUMEDOWN},
 	{KE_KEY, 0x32, KEY_MUTE},
@@ -313,6 +319,8 @@ static struct key_entry asus_keymap[] = {
 	{KE_KEY, 0x5F, KEY_WLAN},
 	{KE_KEY, 0x60, KEY_SWITCHVIDEOMODE},
 	{KE_KEY, 0x61, KEY_SWITCHVIDEOMODE},
+	{KE_KEY, 0x62, KEY_SWITCHVIDEOMODE},
+	{KE_KEY, 0x63, KEY_SWITCHVIDEOMODE},
 	{KE_KEY, 0x6B, KEY_F13}, /* Lock Touchpad */
 	{KE_KEY, 0x82, KEY_CAMERA},
 	{KE_KEY, 0x8A, KEY_PROG1},
-- 
1.6.0.6

