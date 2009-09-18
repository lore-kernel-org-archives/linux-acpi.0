From: akpm@linux-foundation.org
Subject: [patch 3/8] acerhdf: convert to dev_pm_ops
Date: Fri, 18 Sep 2009 12:41:05 -0700
Message-ID: <200909181941.n8IJf666002441@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47491 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757996AbZIRTmh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Sep 2009 15:42:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, petkovbb@gmail.com, andi@lisas.de, dtor@mail.ru, peter@piie.net

From: Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Peter Feuerer <peter@piie.net>
Cc: Andreas Mohr <andi@lisas.de>
Cc: Len Brown <lenb@kernel.org>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/acerhdf.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff -puN drivers/platform/x86/acerhdf.c~acerhdf-convert-to-dev_pm_ops drivers/platform/x86/acerhdf.c
--- a/drivers/platform/x86/acerhdf.c~acerhdf-convert-to-dev_pm_ops
+++ a/drivers/platform/x86/acerhdf.c
@@ -52,7 +52,7 @@
  */
 #undef START_IN_KERNEL_MODE
 
-#define DRV_VER "0.5.16"
+#define DRV_VER "0.5.17"
 
 /*
  * According to the Atom N270 datasheet,
@@ -435,7 +435,7 @@ struct thermal_cooling_device_ops acerhd
 };
 
 /* suspend / resume functionality */
-static int acerhdf_suspend(struct platform_device *dev, pm_message_t state)
+static int acerhdf_suspend(struct device *dev)
 {
 	if (kernelmode)
 		acerhdf_change_fanstate(ACERHDF_FAN_AUTO);
@@ -446,14 +446,6 @@ static int acerhdf_suspend(struct platfo
 	return 0;
 }
 
-static int acerhdf_resume(struct platform_device *device)
-{
-	if (verbose)
-		pr_notice("resuming\n");
-
-	return 0;
-}
-
 static int __devinit acerhdf_probe(struct platform_device *device)
 {
 	return 0;
@@ -464,15 +456,19 @@ static int acerhdf_remove(struct platfor
 	return 0;
 }
 
+static struct dev_pm_ops acerhdf_pm_ops = {
+	.suspend = acerhdf_suspend,
+	.freeze  = acerhdf_suspend,
+};
+
 static struct platform_driver acerhdf_driver = {
 	.driver = {
-		.name = "acerhdf",
+		.name  = "acerhdf",
 		.owner = THIS_MODULE,
+		.pm    = &acerhdf_pm_ops,
 	},
 	.probe = acerhdf_probe,
 	.remove = acerhdf_remove,
-	.suspend = acerhdf_suspend,
-	.resume = acerhdf_resume,
 };
 
 
_
