From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 18/24] asus-laptop: set maximum led brightness
Date: Fri, 28 Aug 2009 14:56:49 +0200
Message-ID: <1251464215-6540-19-git-send-email-corentincj@iksaif.net>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-2-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-3-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-4-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-5-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-6-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-7-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-8-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-9-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-10-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-11-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-12-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-13-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-14-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-15-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-16-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-17-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-18-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.11]:60848 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbZH1NDk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:40 -0400
In-Reply-To: <1251464215-6540-18-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

Set the right maximum brightness which is one, because
they can only be on or off.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/asus-laptop.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 410e545..652902e 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -243,7 +243,7 @@ static struct backlight_ops asusbl_ops = {
  * potentially bad time, such as a timer interrupt. */
 static struct workqueue_struct *led_workqueue;
 
-#define ASUS_LED(object, ledname)					\
+#define ASUS_LED(object, ledname, max)					\
 	static void object##_led_set(struct led_classdev *led_cdev,	\
 				     enum led_brightness value);	\
 	static enum led_brightness object##_led_get(			\
@@ -255,13 +255,14 @@ static struct workqueue_struct *led_workqueue;
 		.name           = "asus::" ledname,			\
 		.brightness_set = object##_led_set,			\
 		.brightness_get = object##_led_get,			\
+		.max_brightness = max					\
 	}
 
-ASUS_LED(mled, "mail");
-ASUS_LED(tled, "touchpad");
-ASUS_LED(rled, "record");
-ASUS_LED(pled, "phone");
-ASUS_LED(gled, "gaming");
+ASUS_LED(mled, "mail", 1);
+ASUS_LED(tled, "touchpad", 1);
+ASUS_LED(rled, "record", 1);
+ASUS_LED(pled, "phone", 1);
+ASUS_LED(gled, "gaming", 1);
 
 struct key_entry {
 	char type;
-- 
1.6.4


