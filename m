From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/12] acer-wmi: fix section mismatch warnings
Date: Tue, 11 Mar 2008 02:51:39 -0400
Message-ID: <7560e385651c60e5ffdf07cb94fa7d1658ab0b7a.1205217406.git.len.brown@intel.com>
References: <1205218309-19695-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:2378 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753082AbYCKGyx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 02:54:53 -0400
In-Reply-To: <1205218309-19695-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
References: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <len.brown@intel.com>

From: Sam Ravnborg <sam@ravnborg.org>

Fix following warnings:
WARNING: vmlinux.o(.text+0x672615): Section mismatch in reference from the function acer_platform_remove() to the function .exit.text:acer_backlight_exit()
WARNING: vmlinux.o(.devinit.text+0x1e859): Section mismatch in reference from the function acer_platform_probe() to the function .init.text:acer_led_init()
WARNING: vmlinux.o(.devinit.text+0x1e878): Section mismatch in reference from the function acer_platform_probe() to the function .init.text:acer_backlight_init()

Remove __exit annotation from acer_backlight_exit(). We cannot reference
a __exit annotated function from non __exit functions.

acer_led_init() and acer_backlight_init() where both annotated __init but
used from a __devinit function. This would result in an oops should
gcc drop their inlining and the module are hot plugged.

Fix by annotating acer_led_init() and acer_backlight_init() __devinit.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/acer-wmi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index d7aea93..cdc733b 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -756,7 +756,7 @@ static struct led_classdev mail_led = {
 	.brightness_set = mail_led_set,
 };
 
-static int __init acer_led_init(struct device *dev)
+static int __devinit acer_led_init(struct device *dev)
 {
 	return led_classdev_register(dev, &mail_led);
 }
@@ -789,7 +789,7 @@ static struct backlight_ops acer_bl_ops = {
 	.update_status = update_bl_status,
 };
 
-static int __init acer_backlight_init(struct device *dev)
+static int __devinit acer_backlight_init(struct device *dev)
 {
 	struct backlight_device *bd;
 
@@ -808,7 +808,7 @@ static int __init acer_backlight_init(struct device *dev)
 	return 0;
 }
 
-static void __exit acer_backlight_exit(void)
+static void acer_backlight_exit(void)
 {
 	backlight_device_unregister(acer_backlight_device);
 }
-- 
1.5.4.3.422.g34cd6

