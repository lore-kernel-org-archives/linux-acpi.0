From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 16/24] asus-laptop: Add *_led_get() functions
Date: Fri, 28 Aug 2009 14:56:47 +0200
Message-ID: <1251464215-6540-17-git-send-email-corentincj@iksaif.net>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.11]:60844 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbZH1NDk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:40 -0400
In-Reply-To: <1251464215-6540-16-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

Add support for getting led brightness directly from
the hardware. Currently we don't need it, but it is needed
to support keyboard backlight/led.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/asus-laptop.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 2344950..88cc9a1 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -246,12 +246,15 @@ static struct workqueue_struct *led_workqueue;
 #define ASUS_LED(object, ledname)					\
 	static void object##_led_set(struct led_classdev *led_cdev,	\
 				     enum led_brightness value);	\
+	static enum led_brightness object##_led_get(			\
+		struct led_classdev *led_cdev);				\
 	static void object##_led_update(struct work_struct *ignored);	\
 	static int object##_led_wk;					\
 	static DECLARE_WORK(object##_led_work, object##_led_update);	\
 	static struct led_classdev object##_led = {			\
 		.name           = "asus::" ledname,			\
 		.brightness_set = object##_led_set,			\
+		.brightness_get = object##_led_get,			\
 	}
 
 ASUS_LED(mled, "mail");
@@ -399,6 +402,11 @@ static void write_status(acpi_handle handle, int out, int mask)
 	{								\
 		int value = object##_led_wk;				\
 		write_status(object##_set_handle, value, (mask));	\
+	}								\
+	static enum led_brightness object##_led_get(			\
+		struct led_classdev *led_cdev)				\
+	{								\
+		return led_cdev->brightness;				\
 	}
 
 ASUS_LED_HANDLER(mled, MLED_ON);
-- 
1.6.4


