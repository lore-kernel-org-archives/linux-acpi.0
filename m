From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 27/33] asus-laptop: add Lenovo SL hotkey support
Date: Thu,  3 Dec 2009 08:45:11 +0100
Message-ID: <1259826317-18809-28-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-6-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-7-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-8-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-9-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-10-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-11-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-12-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-13-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-14-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-15-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-16-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-17-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-18-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-19-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-20-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-21-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-22-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-23-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-24-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-25-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-26-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-27-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44220 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754467AbZLCHoi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:38 -0500
In-Reply-To: <1259826317-18809-27-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Ike Panhc <ike.pan@canonical.com>

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
1.6.5.3

